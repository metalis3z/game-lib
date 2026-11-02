local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AssetItem = require(ReplicatedStorage.Library.Types.AssetItem)
local Personalities = require(ReplicatedStorage.Directory.Assets.Personalities)
local Assets = require(ReplicatedStorage.Directory.Assets)
local AssetGenerationUtil = require(ReplicatedStorage.Library.Util.AssetGenerationUtil)
local Commas = require(ReplicatedStorage.Library.Functions.Commas)
local t = {}

local function createItemData(p1)
	return {
		Scale = 1,
		HasBeenFirstPlaced = true,
		Category = p1,
		Mutations = {},
		Personality = Personalities.Personalities.Normal
	}
end

function t.GetIndexMoneyRewardAmount(p1)
	return math.round(AssetGenerationUtil.GetBaseRateMutationOnly({
		Scale = 1,
		HasBeenFirstPlaced = true,
		Category = p1,
		Mutations = {},
		Personality = Personalities.Personalities.Normal
	}) * 100)
end
function t.GetIndexSpeedRewardAmount(p1)
	return Assets.Directory[p1].IndexSpeedReward
end
function t.GetVisualWeightKg(p1)
	assert(AssetItem.AssetItemData(p1))

	return Assets.Directory[p1.Category].ModelWeight * math.max(p1.Scale, 0) ^ 3
end
function t.GetVisualWeightKgDisplay(p1)
	return ("%*Kg"):format((Commas((math.max(math.round(t.GetVisualWeightKg(p1) * 100) / 100, 0)))))
end

return t