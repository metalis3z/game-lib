-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: subscribe, time of decompilation: Sun May  3 10:10:43 2026 ]]
local store = require(script.Parent.store)

require(script.Parent.types)

return function(p1, p2: ((...any) -> ...any)) --[[ subscribe ]] -- line: 14
	-- upvalues: store (copy)
	local u4, u5 = store.capture(p1)
	local u6 = false

	local function handler() -- line: 18
		-- upvalues: u5 (ref), store (copy), u4 (ref), handler (copy), p1 (copy), u6 (ref), p2 (copy)
		local v8 = u5

		store.disconnect(u4, handler)

		local v9, v10 = store.capture(p1)

		u4 = v9
		u5 = v10

		if not u6 then
			store.connect(u4, handler)
		end

		if v8 ~= u5 then
			p2(u5, v8)
		end
	end

	store.connect(u4, handler)

	return function() -- line: 35
		-- upvalues: u6 (ref), store (copy), u4 (ref), handler (copy)
		if not u6 then
			u6 = true
			store.disconnect(u4, handler)
		end
	end
end
