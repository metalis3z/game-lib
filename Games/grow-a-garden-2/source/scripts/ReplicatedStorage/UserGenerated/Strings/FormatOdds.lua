--credit to leon games studio
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local FormatAbbreviated = require(ReplicatedStorage.UserGenerated.Strings.FormatAbbreviated)

return function(p1) --[[ FormatOdds | Line: 24 | Upvalues: FormatAbbreviated (copy) ]]
	assert(type(p1) == "number")

	if p1 == 0 then
		return "0"
	end

	if p1 == (1 / 0) then
		return "Infinity"
	end

	if p1 == (-1 / 0) then
		return "-Infinity"
	end

	if p1 == p1 then
		return "1/" .. FormatAbbreviated(1 / p1)
	end

	return "NaN"
end