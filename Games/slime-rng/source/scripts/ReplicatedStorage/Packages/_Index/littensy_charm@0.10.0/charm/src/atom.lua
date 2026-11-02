-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: atom, time of decompilation: Sun May  3 10:10:41 2026 ]]
local store = require(script.Parent.store)

require(script.Parent.types)

return function(p1, p2) --[[ atom ]] -- line: 13
	-- upvalues: store (copy)
	local v5 = p2 and p2.equals

	local function atom(...) -- line: 16
		-- upvalues: store (copy), atom (copy), p1 (ref), v5 (copy)
		if select("#", ...) == 0 then
			local index = store.capturing.index

			if index > 0 then
				store.capturing.stack[index][atom] = true
			end

			return p1
		end

		local v8 = store.peek(..., p1)

		if v8 ~= p1 and (not v5 or not v5(p1, v8)) then
			p1 = v8
			store.notify(atom)
		end

		return p1
	end

	store.listeners[atom] = setmetatable({}, {
		__mode = "v"
	})

	return atom
end
