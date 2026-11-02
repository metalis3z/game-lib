-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: effect, time of decompilation: Sun May  3 10:10:42 2026 ]]
local store = require(script.Parent.store)

return function(p1: ((...any) -> ...any)) --[[ effect ]] -- line: 12
	-- upvalues: store (copy)
	local t1 = {}
	local u4 = nil
	local u5 = false
	local disconnect = nil

	local function listener() -- line: 18
		-- upvalues: u4 (ref), store (copy), t1 (ref), listener (copy), p1 (copy), disconnect (ref), u5 (ref)
		if u4 then
			u4()
		end

		store.disconnect(t1, listener)

		local v10, v11 = store.capture(p1, disconnect)

		t1 = v10
		u4 = v11

		if not u5 then
			store.connect(t1, listener)
		end
	end

	function disconnect() -- line: 31
		-- upvalues: u5 (ref), store (copy), t1 (ref), listener (copy), u4 (ref)
		if u5 then
			return
		end

		u5 = true
		store.disconnect(t1, listener)

		if u4 then
			u4()
		end
	end

	local v8, v9 = store.capture(p1, disconnect)

	t1 = v8
	u4 = v9

	if not u5 then
		store.connect(t1, listener)
	end

	return disconnect
end
