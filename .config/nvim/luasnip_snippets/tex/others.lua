return {
  -- Convert inline math to display math.
  s(
    {trig = "(.*)~?%$(%s*[^%$]*%s*)%$", regTrig = true},
    fmta(
      [[
        <before>
        \[
          <mathematics>
        \]
        <after>
        <afterwards>
      ]],
      {
        before      = f( function(_, snip) return snip.captures[1] end ),
        mathematics = f( function(_, snip) return snip.captures[2] end ),
        after       = f( function(_, snip) return snip.captures[3] end ),
        afterwards  = i(0)
      }
    )
  ),
  -- Basic sets.
  s(
    { trig = "set", desc = "\\{ \\}" },
    fmta(
      [[
        \{ <elements> \suchthat <condition> \}
      ]],
      {
        elements  = i(1, "elements"),
        condition = i(2, "condition"),
      }
    )
  ),
  -- Large sets.
  s(
    { trig = "bigset", desc = "\\{ \\}" },
    fmta(
      [[
        \{
          <elements>
        \suchthat
          <condition>
        \}
        <afterwards>
      ]],
      {
        elements   = i(1, "elements"),
        condition  = i(2, "condition"),
        afterwards = i(0),
      }
    )
  ),
  -- Multiple-line set descriptions.
  s(
    { trig = "multiset", desc = "multiline set descriptions" },
    fmta(
      [[
        \left\{
          <elements>
        \suchthat*
          \begin{tabular}{@{}@{}}
            <condition>
          \end{tabular}
        \right\}
        <afterwards>
      ]],
      {
        elements   = i(1, "elements"),
        condition  = i(2, "condition"),
        afterwards = i(0),
      }
    )
  ),
  -- Functions.
  s(
    { trig = "func", desc = "function definition" },
    fmta(
      [[
        \[
          <name>
          \colon
          <domain>
          \to
          <codomain> \,,
          \quad
          <input>
          \mapsto
          <output>
        \]
        <afterwards>
      ]],
      {
        name       = i(1, "name"),
        domain     = i(2, "domain"),
        codomain   = i(3, "codomain"),
        input      = i(4, "input"),
        output     = i(5, "output"),
        afterwards = i(0),
      }
    )
  ),
}
