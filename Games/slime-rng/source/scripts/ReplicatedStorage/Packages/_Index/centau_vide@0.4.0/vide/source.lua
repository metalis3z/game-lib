-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: source, time of decompilation: Sun May  3 10:09:45 2026 ]]
local graph = require("./graph")
local create_source_node = graph.create_source_node
local push_scope_as_child_of = graph.push_scope_as_child_of
local update_descendants = graph.update_descendants

return function(p1) --[[ source ]] -- line: 9
	-- upvalues: create_source_node (copy), push_scope_as_child_of (copy), update_descendants (copy)
	local v6 = create_source_node(p1)

	return function(...) --[[ update_source ]] -- line: 12
		-- upvalues: push_scope_as_child_of (copy), v6 (copy), update_descendants (copy)
		if select("#", ...) == 0 then
			push_scope_as_child_of(v6)

			return v6.cache
		end

		local v7 = ...

		if v7 == v6.cache and (type(v7) ~= "table" or table.isfrozen(v7)) then
			return v7
		end

		v6.cache = v7
		update_descendants(v6)

		return v7
	end
end
