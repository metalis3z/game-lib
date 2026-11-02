--credit to quartz games studio
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local FormatFigures = require(ReplicatedStorage.UserGenerated.Strings.FormatFigures)

return function(p1) --[[ FormatPercent | Line: 24 | Upvalues: FormatFigures (copy) ]]
	return FormatFigures(p1 * 100, 4, 5) .. "%"
end