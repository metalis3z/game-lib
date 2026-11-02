--credit to quartz games studio
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GardenSyncController = require(game.StarterPlayer.StarterPlayerScripts.Controllers.GardenSyncController)
local SeedData = require(ReplicatedStorage.SharedModules.SeedData)
local SellValueData = require(ReplicatedStorage.SharedModules.SellValueData)
local t = {}

for v1, v2 in SeedData do
	t[v2.SeedName or v2.PlantName] = v2
end

return function(p1) --[[ GetGenerationPerMinute | Line: 13 | Upvalues: Players (copy), GardenSyncController (copy), SellValueData (copy), t (copy) ]]
	local v2 = GardenSyncController:GetGarden(if p1 then p1.UserId else Players.LocalPlayer.UserId)

	if not (v2 and next(v2)) then
		return 0
	end

	local t2 = {}

	for v3, v4 in v2 do
		local PlantName = v4.PlantName

		if PlantName then
			local v5 = SellValueData[PlantName] or 0

			if not (v5 <= 0) then
				if t[PlantName] and t[PlantName].IsSingleHarvest then
					table.insert(t2, {
						isSingleHarvest = true,
						value = v5
					})

					continue
				end

				local MaxFruitSpawnLocations = v4.MaxFruitSpawnLocations

				if not MaxFruitSpawnLocations or MaxFruitSpawnLocations == 0 then
					MaxFruitSpawnLocations = 1
				end

				for i = 1, MaxFruitSpawnLocations do
					table.insert(t2, {
						isSingleHarvest = false,
						value = v5
					})
				end
			end
		end
	end

	table.sort(t2, function(p1, p2) --[[ Line: 50 ]]
		return p1.value > p2.value
	end)

	local v8 = 0

	for j = 1, math.min(#t2, 100) do
		local v9 = t2[j]

		v8 = if v9.isSingleHarvest then v8 + v9.value else v8 + v9.value * 6
	end

	return v8
end