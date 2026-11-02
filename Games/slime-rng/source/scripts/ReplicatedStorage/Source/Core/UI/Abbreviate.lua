-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Abbreviate, time of decompilation: Sun May  3 10:10:55 2026 ]]
local Suffixes = require(script.Parent.Suffixes)

return function(n1: number, n2: number?) -- line: 4
	-- upvalues: Suffixes (copy)
	local s1 = ""
	local v5 = n2 or 3

	if n1 < 0 then
		n1 = math.abs(n1)
		s1 = "-"
	end

	local v6 = ("%.0f"):format(n1)
	local v7 = #v6

	if v7 <= 3 then
		return s1 .. v6
	end

	local v8 = Suffixes[math.ceil(v7 / 3)]
	local v9 = (v7 - 1) % 3 + 1

	if not v8 then
		v8 = "e" .. math.ceil((v7 - 3) / 3) * 3
	end

	local v10 = string.sub(v6, 1, v9)

	if v9 < v5 then
		v10 ..= "." .. string.sub(v6, v9 + 1, v5)
	end

	return s1 .. v10 .. v8
end
