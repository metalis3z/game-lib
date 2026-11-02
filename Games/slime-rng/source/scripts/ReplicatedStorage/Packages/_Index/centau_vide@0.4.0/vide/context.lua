-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: context, time of decompilation: Sun May  3 10:09:39 2026 ]]
local graph = require("./graph")
local create_node = graph.create_node
local get_scope = graph.get_scope
local push_scope = graph.push_scope
local pop_scope = graph.pop_scope
local set_context = graph.set_context
local v7 = newproxy()
local n1 = 0

return function(...) --[[ context ]] -- line: 14
	-- upvalues: n1 (ref), get_scope (copy), v7 (copy), create_node (copy), set_context (copy), push_scope (copy), pop_scope (copy)
	n1 += 1

	local v9 = n1
	local v10 = select("#", ...) > 0
	local v11 = ...

	return function(...) -- line: 21
		-- upvalues: get_scope (copy), v9 (copy), v7 (copy), v10 (copy), v11 (copy), create_node (copy), set_context (copy), push_scope (copy), pop_scope (copy)
		local v12 = get_scope()

		if select("#", ...) == 0 then
			while v12 do
				local context = v12.context

				if context then
					local v14 = context[v9]

					if v14 == nil then
						v12 = v12.owner

						continue
					end

					if v14 ~= v7 then
						return v14
					end

					return nil
				end

				v12 = v12.owner
			end

			if v10 ~= nil then
				return v11
			end

			error("attempt to get context when no context is set and no default context is set", 0)

			return nil
		end

		if not v12 then
			return error("attempt to set context outside of a vide scope", 0)
		end

		local v15, v16 = ...
		local v17 = create_node(v12, false, false)

		set_context(v17, v9, if v15 ~= nil then v15 else v7)
		push_scope(v17)

		local ok, result = xpcall(v16, function(err: string) --[[ efn ]] -- line: 58
			return debug.traceback(err, 3)
		end)

		pop_scope()

		if not ok then
			error(`error while running context:\n\n{ result }`, 0)
		end

		return result
	end
end
