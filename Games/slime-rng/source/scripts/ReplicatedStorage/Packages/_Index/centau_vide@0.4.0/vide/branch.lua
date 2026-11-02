-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: branch, time of decompilation: Sun May  3 10:09:37 2026 ]]
local graph = require("./graph")
local create_node = graph.create_node
local push_scope = graph.push_scope
local pop_scope = graph.pop_scope
local destroy = graph.destroy
local get_scope = graph.get_scope

return function(p1: ((...any) -> ...any)) --[[ branch ]] -- line: 9
	-- upvalues: get_scope (copy), create_node (copy), destroy (copy), push_scope (copy), pop_scope (copy)
	local v8 = get_scope()

	if not v8 then
		error("cannot use branch() outside a stable or reactive scope", 0)
	end

	local owner = v8.owner

	if not owner or owner.effect then
		error("current scope is not owned by a stable scope", 0)
	end

	local v10 = create_node(owner, false, false)

	push_scope(v10)

	local ok, result = xpcall(p1, debug.traceback)

	pop_scope()

	if not ok then
		destroy(v10)
		error(`error while running branch():\n\n{ result }`, 0)
	end

	return function() -- line: 22
		-- upvalues: destroy (copy), v10 (copy)
		destroy(v10)
	end, result
end
