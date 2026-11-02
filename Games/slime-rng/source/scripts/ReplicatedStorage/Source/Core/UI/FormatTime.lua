-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: FormatTime, time of decompilation: Sun May  3 10:10:56 2026 ]]
return function(n1: number) -- line: 1
	local v2 = math.max(0, n1)
	local v3 = v2 // 86400
	local v4 = v2 % 86400 // 3600
	local v5 = v2 % 3600 // 60
	local v6 = v2 % 60
	local s1 = ""

	if v3 > 0 then
		s1 ..= ("%*d "):format(v3)
	end

	if v4 > 0 then
		s1 ..= ("%*h "):format(v4)
	end

	if v5 > 0 then
		s1 ..= ("%*m "):format(v5)
	end

	if v6 > 0 and v3 == 0 and v4 == 0 then
		return s1 .. `{ v6 }s`
	end

	return (s1:sub(1, -2))
end
