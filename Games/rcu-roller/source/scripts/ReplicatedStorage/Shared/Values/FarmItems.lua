-- FarmItems: returns effective items per collect (base or upgraded amount)
local Farms = require(game:GetService("ReplicatedStorage").Shared.List.Farms)
return function(player, data, farmId)
	local config = Farms[farmId]
	if not config then return 1 end
	local base = config.items or 1
	if not data.farms or not data.farms[farmId] then return base end
	local stage = data.farms[farmId].stage or 0
	local upgrades = config.upgrades
	for i = #upgrades, 1, -1 do
		if upgrades[i].upgrade == "moreItems" and stage >= i then
			return upgrades[i].amount
		end
	end
	return base
end