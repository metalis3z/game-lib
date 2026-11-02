-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: timeout, time of decompilation: Sun May  3 10:09:46 2026 ]]
local t1 = {}

local function timeout(n1: number, p1: ((...any) -> ...any)) -- line: 5
	-- upvalues: t1 (copy)
	local t2 = {
		cancel = false,
		t = n1,
		fn = p1
	}

	table.insert(t1, t2)

	return t2
end
local function update_timeouts(n2: number) -- line: 11
	-- upvalues: t1 (copy)
	for i = #t1, 1, -1 do
		local v9 = t1[i]

		v9.t = v9.t - n2

		if v9.cancel or v9.t <= 0 then
			t1[i] = t1[#t1]
			t1[#t1] = nil

			if not v9.cancel then
				v9.fn()
			end
		end
	end
end

return function() -- line: 27
	-- upvalues: timeout (copy), update_timeouts (copy)
	return timeout, update_timeouts
end
