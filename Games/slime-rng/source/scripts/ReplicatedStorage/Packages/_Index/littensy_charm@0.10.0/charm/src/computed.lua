-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: computed, time of decompilation: Sun May  3 10:10:41 2026 ]]
local atom = require(script.Parent.atom)
local store = require(script.Parent.store)

require(script.Parent.types)

return function(p1, p2) --[[ computed ]] -- line: 16
	-- upvalues: store (copy), atom (copy)
	local u5, u6 = store.capture(p1)
	local v7 = atom(u6, p2)
	local v8 = setmetatable({
		current = v7
	}, {
		__mode = "v"
	})

	local function listener() -- line: 21
		-- upvalues: v8 (copy), store (copy), u5 (ref), listener (copy), u6 (ref), p1 (copy)
		local current = v8.current

		if current then
			store.disconnect(u5, listener)

			local v11, v12 = store.capture(p1)

			u5 = v11
			u6 = v12
			store.connect(u5, listener, current)
			current(u6)
		end
	end

	store.connect(u5, listener, v7)

	return v7
end
