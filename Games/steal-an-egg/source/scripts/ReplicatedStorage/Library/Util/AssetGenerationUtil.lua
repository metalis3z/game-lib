local ReplicatedStorage = game:GetService("ReplicatedStorage")

print("AssetGenerationUtil loading...")

local MonetizationGamepassUtil = require(ReplicatedStorage.Library.Util.MonetizationGamepassUtil)
print("MonetizationGamepassUtil ok")

require(ReplicatedStorage.Library.Types.Monetization)
print("Types.Monetization ok")

local RebirthUtil = require(script.Parent.RebirthUtil)
print("RebirthUtil ok")

local Assets = require(ReplicatedStorage.Directory.Assets)
print("Assets ok")

local AssetItem = require(ReplicatedStorage.Library.Types.AssetItem)
print("AssetItem ok")

local Asserts = require(ReplicatedStorage.Library.Asserts)
print("Asserts ok")

local Mutations = require(ReplicatedStorage.Library.Modules.Mutations)
print("Mutations ok")

local Signal = require(ReplicatedStorage.Library.Signal)
print("Signal ok")

print("AssetGenerationUtil fully loaded")

local AssetGenerationUtil = {}

--==============================--
-- Helper Functions
--==============================--

local function getSizeEarningMultiplier(scale)
	Asserts.finite(scale)
	assert(scale > 0, "Asset scale must be greater than 0")

	if scale <= 5 then
		return scale ^ 1.85
	end

	return (scale / 5) ^ 1.2 * 19.637875755794113
end

--==============================--
-- Module Methods
--==============================--

function AssetGenerationUtil.GetRate(itemData, rebirths, gamepasses, extraBoostData)
	assert(AssetItem.AssetItemData(itemData))
	Asserts.number(rebirths)

	local assetConfig = Assets.Directory[itemData.Category]
	local baseRate = assetConfig and tonumber(assetConfig.EarningRate) or 0

	local sizeMultiplier = getSizeEarningMultiplier(itemData.Scale)
	local mutationMultiplier = Mutations.GetTotalMutationsEarningMulti(itemData.Mutations)

	local rebirthBonusMultiplier = math.max(1, RebirthUtil.RebirthToMultiplier(rebirths))
	local gamepassBonus = MonetizationGamepassUtil.GetAssetMoneyAdditiveRebirthBonus(gamepasses, extraBoostData)
	local totalRebirthBonus = rebirthBonusMultiplier + gamepassBonus

	return math.max(math.round(baseRate * sizeMultiplier * mutationMultiplier * totalRebirthBonus), 1)
end

function AssetGenerationUtil.GetRateWithoutBoosts(itemData)
	assert(AssetItem.AssetItemData(itemData))

	local assetConfig = Assets.Directory[itemData.Category]
	local baseRate = assetConfig and tonumber(assetConfig.EarningRate) or 0
	local sizeMultiplier = getSizeEarningMultiplier(itemData.Scale)

	return baseRate * sizeMultiplier
end

function AssetGenerationUtil.GetBaseRateMutationOnly(itemData)
	assert(AssetItem.AssetItemData(itemData))

	return AssetGenerationUtil.GetRate(itemData, 0)
end

function AssetGenerationUtil.GetRateWithoutRebirth(itemData, gamepasses, extraBoostData)
	assert(AssetItem.AssetItemData(itemData))

	return AssetGenerationUtil.GetRate(itemData, 0, gamepasses, extraBoostData)
end

--==============================--
-- Connections
--==============================--
Signal.Invoked(Signal.MAP.Shared.AssetGenerationUtil.GET_BASE_RATE_MUTATION_ONLY).OnInvoke = AssetGenerationUtil.GetBaseRateMutationOnly

return AssetGenerationUtil