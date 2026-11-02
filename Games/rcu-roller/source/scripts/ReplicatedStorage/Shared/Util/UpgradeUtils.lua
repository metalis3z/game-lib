local module = {}

function module.getAllUpgradeMultipliers(data, upgradeName, options)
	options = options or {}
	local total = 0
	if options.achievements ~= false then
		total += module.getAchievementMultiplier(data, upgradeName)
	end
	if options.index ~= false then
		total += module.getIndexMultiplier(data, upgradeName)
	end
	if options.prestige ~= false then
		total += module.getPrestigeMultiplier(data, upgradeName)
	end
	if options.clan ~= false then
		total += module.getClanBuildingsMultiplier(data, upgradeName)
	end
	return total
end

local Achievements = require(game.ReplicatedStorage.Shared.List.Achievements)
function module.getAchievementMultiplier(data, upgradeName)
	local total = 0
	for category, categoryData in Achievements do
		if not categoryData.list then continue end
		for tier, tierData in categoryData.list do
			if not tierData.rewards then continue end
			for _, reward in tierData.rewards do
				if reward:getClass() == "upgrade" and reward:getName() == upgradeName
					and data.claimedAchievements and data.claimedAchievements[`{category}{tier}`] then
					total += reward:getAmount()
				end
			end
		end
	end
	return total
end

local IndexRewards = require(game.ReplicatedStorage.Shared.List.IndexRewards)
function module.getIndexMultiplier(data, upgradeName)
	local total = 0
	if not data.claimedIndexRewards then return 0 end
	for tier, tierData in IndexRewards do
		if table.find(data.claimedIndexRewards, tier) then
			if not tierData.rewards then continue end
			for _, reward in tierData.rewards do
				if reward:getClass() == "upgrade" and reward:getName() == upgradeName then
					total += reward:getAmount()
				end
			end
		end
	end
	return total
end

local Prestiges = require(game.ReplicatedStorage.Shared.List.Prestige.Prestiges)
function module.getPrestigeMultiplier(data, upgradeName)
	local total = 0
	for tier, tierData in Prestiges do
		if (data.prestige or 0) >= tier then
			if not tierData.rewards then continue end
			for _, reward in tierData.rewards do
				if reward:getClass() == "upgrade" and reward:getName() == upgradeName then
					total += reward:getAmount()
				end
			end
		end
	end
	return total
end

local Buildings = require(game.ReplicatedStorage.Shared.List.Clans.Buildings)
function module.getClanBuildingsMultiplier(data, upgradeName)
	local total = 0
	if not data.clanBuildings then return 0 end
	for buildingId, buildingData in Buildings do
		if data.clanBuildings[buildingId] and buildingData.upgrade then
			for _, reward in buildingData.upgrade do
				if reward:getClass() == "upgrade" and reward:getName() == upgradeName then
					total += reward:getAmount()
				end
			end
		end
	end
	return total
end

return module