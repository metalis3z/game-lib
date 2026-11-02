-- FarmCooldown: returns EFFECTIVE cooldown in seconds (base - reduction)
local Farms = require(game:GetService("ReplicatedStorage").Shared.List.Farms)
return function(player, data, farmId)
	local config = Farms[farmId]
	if not config then return 1800 end
	local base = config.cooldown or 1800
	if not data.farms or not data.farms[farmId] then return base end
	local stage = data.farms[farmId].stage or 0
	local reduction = 0
	local upgrades = config.upgrades
	for i = #upgrades, 1, -1 do
		if upgrades[i].upgrade == "cooldown" and stage >= i then
			reduction = upgrades[i].amount
			break
		end
	end
	return math.max(base - reduction, 60)
end