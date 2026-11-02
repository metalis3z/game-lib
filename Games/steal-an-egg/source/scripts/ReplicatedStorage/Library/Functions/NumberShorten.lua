-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local FormatFiguresFloor = require(ReplicatedStorage.Library.Functions.FormatFiguresFloor)
local Commas = require(ReplicatedStorage.Library.Functions.Commas)
local NiceExp10 = require(ReplicatedStorage.Library.Functions.NiceExp10)
local t = {
	"",
	"k",
	"m",
	"b",
	"t",
	"q",
	"Qt",
	"Sx",
	"Sp",
	"o",
	"n",
	"d",
	"u",
	"Du",
	"Tr"
}

return function(p1, p2, p3, p4) --[[ Line: 24 | Upvalues: Commas (copy), t (copy), FormatFiguresFloor (copy), NiceExp10 (copy) ]]
	if p1 ~= p1 then
		return "NaN"
	end

	if p1 == (1 / 0) then
		return "Infinity"
	end

	if p1 == (-1 / 0) then
		return "-Infinity"
	end

	local v1 = if p4 == nil then true else p4
	local v3

	if p1 < 0 then
		p1 = -p1
		v3 = "-"
	else
		v3 = ""
	end

	local v4 = math.floor(p1)

	if not (v4 < (p3 or 1000)) then
		local v8 = math.clamp(math.floor(math.log10(v4) / 3) + 1, 1, #t)

		return v3 .. FormatFiguresFloor(NiceExp10(v4, (v8 - 1) * -3), 3, nil, v1) .. t[v8]
	end

	return v3 .. (v1 and Commas(v4) or tostring(v4))
end