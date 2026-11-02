-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: effect, time of decompilation: Sun May  3 10:09:40 2026 ]]
local graph = require("./graph")
local create_node = graph.create_node
local assert_stable_scope = graph.assert_stable_scope
local evaluate_node = graph.evaluate_node

return function(p1: ((...any) -> ...any), p2) --[[ effect ]] -- line: 6
	-- upvalues: create_node (copy), assert_stable_scope (copy), evaluate_node (copy)
	local v7 = create_node(assert_stable_scope(), p1, p2)

	evaluate_node(v7)
end
