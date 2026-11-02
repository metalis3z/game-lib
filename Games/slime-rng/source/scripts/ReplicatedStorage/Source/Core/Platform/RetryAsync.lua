-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: RetryAsync, time of decompilation: Sun May  3 10:10:53 2026 ]]
return function(p1: ((...any) -> ...any), n1: number, n2: number?, n3: number?, p2: ((...any) -> ...any)?) --[[ RetryAsync ]] -- line: 13
	local v6 = n2 or 0
	local v7 = n3 or 0
	local v8 = p2 or pcall
	local n4 = 0
	local v10 = nil
	local t1 = nil

	while n4 < n1 do
		n4 += 1
		t1 = { v8(p1) }
		v10 = table.remove(t1, 1)

		if v10 then
			break
		end

		local v12 = v6 + v7 ^ n4

		if n4 < n1 then
			task.wait(v12)
		end
	end

	if v10 then
		return v10, table.unpack(t1)
	end

	return v10, not v10 and t1[1]
end
