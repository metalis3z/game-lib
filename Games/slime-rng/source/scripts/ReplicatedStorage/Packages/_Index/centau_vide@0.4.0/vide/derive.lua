-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: derive, time of decompilation: Sun May  3 10:09:40 2026 ]]
local graph = require("./graph")
local create_node = graph.create_node
local push_scope_as_child_of = graph.push_scope_as_child_of
local assert_stable_scope = graph.assert_stable_scope
local evaluate_node = graph.evaluate_node

return function(p1: ((...any) -> ...any)) --[[ derive ]] -- line: 7
	-- upvalues: create_node (copy), assert_stable_scope (copy), evaluate_node (copy), push_scope_as_child_of (copy)
	local v7 = create_node(assert_stable_scope(), p1, false)

	evaluate_node(v7)

	return function() -- line: 12
		-- upvalues: push_scope_as_child_of (copy), v7 (copy)
		push_scope_as_child_of(v7)

		return v7.cache
	end
end
