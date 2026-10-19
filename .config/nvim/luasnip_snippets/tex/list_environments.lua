local function extended_list_env(snip_trigger, snip_desc, list_env_name, item_cmd_name, item_cmd_arg_names, item_desc)
  local item_string = "\\" .. item_cmd_name .. string.rep("{<>}", #item_cmd_arg_names)
  local item_insert_nodes = {}
  for position, name in ipairs(item_cmd_arg_names) do
    table.insert(item_insert_nodes, i(position, name))
  end
  local item_node = sn(1, fmta(item_string, item_insert_nodes))
  return
  s(
    { trig = snip_trigger, desc = snip_desc },
    fmta(
      [[
        \begin{<name>}
        
        <indent><item>
        <indent><indent><item_description>
        
        \end{<name>}
        <afterwards>
      ]],
      {
        name = t(list_env_name),
        indent = t("\t"),
        item = item_node,
        item_description = i(2, item_desc),
        afterwards = i(0)
      }
    )
  )
end


return {
  -- Standard list environments.
  extended_list_env("description", "description environment", "description", "item", {"description"}, "first item"),
  extended_list_env("enumerate",   "enumerate environment",   "enumerate",   "item", {},               "first item"),
  extended_list_env("itemize",     "itemize environment",     "itemize",     "item", {},               "first item"),
  -- Custom list environments.
  extended_list_env("casedistinction",  "case distinction environment",  "casedistinction",  "item",    {},             "first case"),
  extended_list_env("equivalenceslist", "equivalences list environment", "equivalenceslist", "item",    {},             "first statement"),
  extended_list_env("implicationslist", "implications list environment", "implicationslist", "impitem", {"from", "to"}, "first implication"),
}
