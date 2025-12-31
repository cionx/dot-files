# Auxiliary command that applies a closure (i.e., a function)
# to the values of a record. The keys remain unchanged.
export def map [closure: closure] {
	$in
	| transpose key value
	| insert newValue {|r| do $closure $r.value}
	| reject value
	| transpose --header-row --as-record
}
