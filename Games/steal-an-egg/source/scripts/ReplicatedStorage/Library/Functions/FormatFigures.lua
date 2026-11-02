-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RoundFigures = require(script.Parent.RoundFigures)
local Asserts = require(ReplicatedStorage.Library.Asserts)

function commasFull(p1) --[[ commasFull | Line: 13 | Upvalues: Asserts (copy) ]]
	Asserts.string(p1)

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
function formatFigures(p1, p2, p3) --[[ formatFigures | Line: 50 | Upvalues: Asserts (copy), RoundFigures (copy) ]]
	Asserts.number(p1)
	Asserts.optional.number(p2)
	Asserts.optional.number(p3)

	if p1 ~= p1 then
		return "NaN"
	end

	if p1 == (1 / 0) then
		return "Infinity"
	end

	if p1 == (-1 / 0) then
		return "-Infinity"
	end

	local v2, v3 = string.format("%f", (RoundFigures(p1, p2, p3))):match("([^%.]*)%.?(.*)")
	local v4 = commasFull(v2)

	if not v3 then
		return v4
	end

	local v5 = v3:gsub("0+$", "")

	if #v5 == 0 then
		return v4
	end

	return string.format("%s.%s", v4, v5)
end

return formatFigures