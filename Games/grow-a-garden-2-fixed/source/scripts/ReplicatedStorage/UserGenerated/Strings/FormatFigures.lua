--credit to quartz games studio
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RoundFigures = require(ReplicatedStorage.UserGenerated.Math.RoundFigures)
local Commas = require(ReplicatedStorage.UserGenerated.Strings.Commas)

return function(p1, p2, p3, p4) --[[ FormatFigures | Line: 44 | Upvalues: Commas (copy), RoundFigures (copy) ]]
	return Commas(RoundFigures(p1, p2, p3, p4))
end