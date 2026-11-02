local Upgrades = require(game:GetService("ReplicatedStorage").Shared.List.Upgrades)
return function(player, data)
	local lvl = data.upgrades and data.upgrades.epicClicks or 0
	if type(lvl) ~= "number" or lvl <= 0 then return 0 end
	local entry = Upgrades.epicClicks and Upgrades.epicClicks.upgrades[lvl]
	return entry and entry.value or 0
end