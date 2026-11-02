-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: VersionUtils, time of decompilation: Sun May  3 10:11:09 2026 ]]
local t1 = {
	getVersionParts = function(s1: string) --[[ getVersionParts ]] -- line: 3
		local v3, v4, v5 = string.match(s1, "(%d+)%.(%d+)%.(%d+)")

		return tonumber(v3), tonumber(v4), (tonumber(v5))
	end
}

function t1.newerThan(s2: string, s3: string) -- line: 8
	-- upvalues: t1 (copy)
	local v8, v9, v10 = t1.getVersionParts(s2)
	local v11, v12, v13 = t1.getVersionParts(s3)

	if v8 ~= v11 then
		return v11 < v8
	end

	if v9 ~= v12 then
		return v12 < v9
	end

	return v13 < v10
end
function t1.equal(s4: string, s5: string) -- line: 23
	return s4 == s5
end
function t1.olderThan(s6: string, s7: string) -- line: 27
	-- upvalues: t1 (copy)
	return not t1.newerThan(s6, s7) and not t1.equal(s6, s7)
end

return t1
