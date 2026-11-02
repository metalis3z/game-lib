-- FarmGoldenChance: returns golden item luck percentage
local Farms = require(game:GetService("ReplicatedStorage").Shared.List.Farms)
return function(player, data, farmId)
	local config = Farms[farmId]
	if not config then return 0 end
	if not data.farms or not data.farms[farmId] then return 0 end
	local stage = data.farms[farmId].stage or 0
	local upgrades = config.upgrades
	for i = #upgrades, 1, -1 do
		if upgrades[i].upgrade == "goldenLuck" and stage >= i then
			return upgrades[i].amount
		end
	end
	return 0
end