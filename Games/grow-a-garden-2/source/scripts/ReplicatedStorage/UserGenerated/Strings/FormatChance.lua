--credit to prince games studio
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local FormatOdds = require(ReplicatedStorage.UserGenerated.Strings.FormatOdds)
local FormatPercent = require(ReplicatedStorage.UserGenerated.Strings.FormatPercent)

return function(p1, p2) --[[ FormatChance | Line: 31 | Upvalues: FormatOdds (copy), FormatPercent (copy) ]]
	assert(if type(p1) == "number" then true else false)
	assert(if p2 == nil then true elseif type(p2) == "number" then true else false)

	local v3 = math.clamp(p1, 0, 1)

	if v3 > 0 and (math.clamp(p2 or v3, 0, 1) <= 0.0002 and v3 <= 0.001) then
		return FormatOdds(v3)
	end

	return FormatPercent(v3)
end