-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: FormatCurrency, time of decompilation: Sun May  3 10:10:56 2026 ]]
local Abbreviate = require(script.Parent.Abbreviate)

return function(n1: number, b1: boolean?) -- line: 2
	-- upvalues: Abbreviate (copy)
	local v4 = not b1 and "" or "$"

	if n1 >= 10000000 then
		return v4 .. Abbreviate(n1, 5)
	end

	local str = tostring((math.round(n1)))
	local s1 = ""

	if string.sub(str, 1, 1) == "-" then
		s1 = "-"
		str = string.sub(str, 2)
	end

	repeat
		local count

		str, count = str:gsub("^(%d+)(%d%d%d)", "%1,%2")
	until count == 0

	return s1 .. v4 .. str
end
