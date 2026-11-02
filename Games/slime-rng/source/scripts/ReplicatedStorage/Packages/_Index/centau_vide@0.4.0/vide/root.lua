-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: root, time of decompilation: Sun May  3 10:09:43 2026 ]]
local graph = require("./graph")
local create_node = graph.create_node
local push_scope = graph.push_scope
local pop_scope = graph.pop_scope
local destroy = graph.destroy
local t1 = {}

return function(p1: ((...any) -> ...any)) --[[ root ]] -- line: 10
	-- upvalues: create_node (copy), t1 (copy), destroy (copy), push_scope (copy), pop_scope (copy)
	local v8 = create_node(false, false, false)

	t1[v8] = true

	local function v9() -- line: 15
		-- upvalues: t1 (copy), v8 (copy), destroy (copy)
		if not t1[v8] then
			error("root already destroyed")
		end

		t1[v8] = nil
		destroy(v8)
	end

	push_scope(v8)

	local t2 = { xpcall(p1, debug.traceback, v9) }

	pop_scope()

	if not t2[1] then
		if not t1[v8] then
			error("root already destroyed")
		end

		t1[v8] = nil
		destroy(v8)
		error(`error while running root():\n\n{ t2[2] }`, 0)
	end

	return v9, unpack(t2, 2)
end
