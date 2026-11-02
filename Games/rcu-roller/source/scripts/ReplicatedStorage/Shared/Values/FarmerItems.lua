-- FarmerItems: returns farmer auto-collect items per hour
local Farms = require(game:GetService("ReplicatedStorage").Shared.List.Farms)
return function(player, data)
	if data.passes and data.passes.insaneFarmer then
		return 1000000000
	end
	if not data.farms or not data.farms.farmer then
		return 0
	end
	local stage = data.farms.farmer.stage or 0
	local upgrades = Farms.farmer.upgrades
	for i = #upgrades, 1, -1 do
		if upgrades[i].upgrade == "farmerItems" and stage >= i then
			return upgrades[i].amount
		end
	end
	return 0
end