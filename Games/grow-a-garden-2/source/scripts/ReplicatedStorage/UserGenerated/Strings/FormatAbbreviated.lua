--credit to quartz games studio
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RoundFigures = require(ReplicatedStorage.UserGenerated.Math.RoundFigures)
local StableExp10 = require(ReplicatedStorage.UserGenerated.Math.StableExp10)
local TrimmedNumberString = require(ReplicatedStorage.UserGenerated.Strings.TrimmedNumberString)
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

return function(p1) --[[ FormatAbbreviated | Line: 53 | Upvalues: t (copy), StableExp10 (copy), RoundFigures (copy), TrimmedNumberString (copy) ]]
	assert(type(p1) == "number")

	if p1 ~= p1 then
		return "NaN"
	end

	if p1 == (1 / 0) then
		return "Infinity"
	end

	if p1 == (-1 / 0) then
		return "-Infinity"
	end

	local t2 = {}

	if p1 < 0 then
		table.insert(t2, "-")
		p1 = -p1
	end

	local v2 = math.floor(p1)

	if v2 >= 1000 then
		local v6 = math.clamp(math.floor(math.log10(v2) / 3) + 1, 1, #t)

		table.insert(t2, TrimmedNumberString((RoundFigures(StableExp10(v2, (v6 - 1) * -3), 3, nil, math.floor))))
		table.insert(t2, t[v6])
	else
		table.insert(t2, TrimmedNumberString(v2))
	end

	return table.concat(t2)
end