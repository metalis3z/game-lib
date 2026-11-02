-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local FloorFigures = require(script.Parent.FloorFigures)

local function insertCommas(p1) --[[ insertCommas | Line: 3 ]]
	local v1

	if p1:sub(1, 1) == "-" then
		p1, v1 = p1:sub(2), "-"
	else
		v1 = ""
	end

	local sum = 1
	local v3 = #p1 % 3

	if v3 > 0 then
		v1 = v1 .. p1:sub(sum, sum + v3 - 1)
		sum = sum + v3
	end

	while sum <= #p1 do
		if sum > 1 then
			v1 = v1 .. ","
		end

		v1 = v1 .. p1:sub(sum, sum + 2)
		sum = sum + 3
	end

	return v1
end

function FormatFiguresFloor(p1, p2, p3, p4) --[[ FormatFiguresFloor | Line: 28 | Upvalues: FloorFigures (copy), insertCommas (copy) ]]
	if p1 ~= p1 then
		return "NaN"
	end

	if p1 == (1 / 0) then
		return "Infinity"
	end

	if p1 == (-1 / 0) then
		return "-Infinity"
	end

	local v2, v3 = string.format("%f", (FloorFigures(p1, p2, p3))):match("([^%.]*)%.?(.*)")

	if p4 then
		v2 = insertCommas(v2)
	end

	if not v3 then
		return v2
	end

	local v5 = v3:gsub("0+$", "")

	if #v5 == 0 then
		return v2
	end

	return ("%s.%s"):format(v2, v5)
end

return FormatFiguresFloor