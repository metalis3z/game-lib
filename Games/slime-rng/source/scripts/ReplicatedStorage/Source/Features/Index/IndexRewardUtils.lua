-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: IndexRewardUtils, time of decompilation: Sun May  3 10:12:30 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Abbreviate = require(ReplicatedStorage.Source.Core.UI.Abbreviate)
local Food = require(ReplicatedStorage.Source.Game.Items.Food)
local InventoryItemUtils = require(ReplicatedStorage.Source.Features.Inventory.InventoryItemUtils)
local SpecialDiceServiceUtils = require(ReplicatedStorage.Source.Features.SpecialDice.SpecialDiceServiceUtils)
local Mutations = require(ReplicatedStorage.Source.Features.Mutations.Mutations)
local ImageIds = require(ReplicatedStorage.Source.Game.AssetIds.ImageIds)

require(ReplicatedStorage.Source.Game.Items.DataTemplate)

local Slimes = require(ReplicatedStorage.Source.Game.Items.Slimes)
local IndexRewards = require(script.Parent.IndexRewards)
local IndexServiceUtils = require(script.Parent.IndexServiceUtils)
local t1 = {}
local v12 = ImageIds.index or ImageIds.lock

local function getSafeRewardsForCategory(p1) -- line: 44
	-- upvalues: IndexRewards (copy)
	local v17 = IndexRewards[p1]

	if type(v17) ~= "table" then
		return {}
	end

	local t2 = {}

	for _, v20 in v17 do
		if type(v20) == "table" and type(v20.key) == "string" and v20.key ~= "" then
			table.insert(t2, v20)
		end
	end

	table.sort(t2, function(t3: {[any]: any}, t4: {[any]: any}) -- line: 56
		if t3.req == t4.req then
			return t3.key < t4.key
		end

		return t3.req < t4.req
	end)

	return t2
end

function t1.getRewards(p2) -- line: 67
	-- upvalues: getSafeRewardsForCategory (copy)
	return (getSafeRewardsForCategory(p2))
end
function t1.getEntryKey(_, t5: {[any]: any}, _: number) -- line: 71
	assert(type(t5.key) == "string" and t5.key ~= "", "Index rewards must define a stable key")

	return t5.key
end
function t1.isRewardClaimed(p4, p5, t6: {[any]: any}, n2: number) -- line: 80
	-- upvalues: IndexServiceUtils (copy), t1 (copy)
	local v29 = IndexServiceUtils.reconcileIndexData(p4)

	return t1.isRewardClaimedFromData(v29, p5, t6, n2)
end
function t1.isRewardClaimedFromData(p6, p7, t7: {[any]: any}, n3: number) -- line: 90
	-- upvalues: t1 (copy)
	local v34 = t1.getEntryKey(p7, t7, n3)

	return p6.categories[p7].claimedRewards[v34] == true
end
function t1.getNextRewardEntry(p8, p9) -- line: 100
	-- upvalues: IndexServiceUtils (copy), t1 (copy)
	local v37 = IndexServiceUtils.reconcileIndexData(p8)

	return t1.getNextRewardEntryFromData(v37, p9)
end
function t1.getNextRewardEntryFromData(p10, p11) -- line: 105
	-- upvalues: getSafeRewardsForCategory (copy), t1 (copy)
	for v40, v41 in getSafeRewardsForCategory(p11) do
		if not t1.isRewardClaimedFromData(p10, p11, v41, v40) then
			return v41, v40
		end
	end

	return nil, nil
end
function t1.isCategoryClaimable(p12, p13) -- line: 118
	-- upvalues: IndexServiceUtils (copy), t1 (copy)
	local v44 = IndexServiceUtils.reconcileIndexData(p12)

	return t1.isCategoryClaimableFromData(v44, p13)
end
function t1.isCategoryClaimableFromData(p14, p15) -- line: 123
	-- upvalues: t1 (copy), IndexServiceUtils (copy)
	local v47 = t1.getNextRewardEntryFromData(p14, p15)

	if v47 == nil then
		return false
	end

	return IndexServiceUtils.getUnlockedCountFromData(p14, p15) >= v47.req
end
function t1.getClaimableRewardCountForCategory(p16, p17) -- line: 135
	-- upvalues: IndexServiceUtils (copy), t1 (copy)
	local v50 = IndexServiceUtils.reconcileIndexData(p16)

	return t1.getClaimableRewardCountForCategoryFromData(v50, p17)
end
function t1.getClaimableRewardCountForCategoryFromData(p18, p19) -- line: 140
	-- upvalues: IndexServiceUtils (copy), getSafeRewardsForCategory (copy), t1 (copy)
	local v53 = IndexServiceUtils.getUnlockedCountFromData(p18, p19)
	local n4 = 0

	for v55, v56 in getSafeRewardsForCategory(p19) do
		if not t1.isRewardClaimedFromData(p18, p19, v56, v55) and v53 >= v56.req then
			n4 += 1
		end
	end

	return n4
end
function t1.getClaimableCategoryCount(p20) -- line: 159
	-- upvalues: IndexServiceUtils (copy), t1 (copy)
	local v58 = IndexServiceUtils.reconcileIndexData(p20)

	return t1.getClaimableCategoryCountFromData(v58)
end
function t1.getClaimableCategoryCountFromData(p21) -- line: 164
	-- upvalues: IndexServiceUtils (copy), t1 (copy)
	local n5 = 0

	for _, v62 in IndexServiceUtils.getCategoryIds() do
		if t1.isCategoryClaimableFromData(p21, v62) then
			n5 += 1
		end
	end

	return n5
end
function t1.getClaimableRewardCount(p22) -- line: 175
	-- upvalues: IndexServiceUtils (copy), t1 (copy)
	local v64 = IndexServiceUtils.reconcileIndexData(p22)

	return t1.getClaimableRewardCountFromData(v64)
end
function t1.getClaimableRewardCountFromData(p23) -- line: 180
	-- upvalues: IndexServiceUtils (copy), t1 (copy)
	local n6 = 0

	for _, v68 in IndexServiceUtils.getCategoryIds() do
		n6 += t1.getClaimableRewardCountForCategoryFromData(p23, v68)
	end

	return n6
end
function t1.getRewardGoal(p24, p25) -- line: 189
	-- upvalues: IndexServiceUtils (copy), t1 (copy)
	local v71 = IndexServiceUtils.reconcileIndexData(p24)

	return t1.getRewardGoalFromData(v71, p25)
end
function t1.getRewardGoalFromData(p26, p27) -- line: 194
	-- upvalues: t1 (copy), IndexServiceUtils (copy)
	local v74 = t1.getNextRewardEntryFromData(p26, p27)

	if v74 ~= nil then
		return v74.req
	end

	return IndexServiceUtils.getMaxUnlockCount()
end

local function resolveBoostDisplay(t8: {[any]: any}) -- line: 203
	-- upvalues: InventoryItemUtils (copy)
	local boostKind = t8.boostKind

	if type(boostKind) ~= "string" then
		return nil
	end

	local v77 = InventoryItemUtils.getDefinition(boostKind)

	if v77 == nil then
		return nil
	end

	local v78 = math.max(math.floor((t8.amount or 1) + 0.5), 1)

	return {
		icon = v77.icon,
		title = v77.name,
		description = v77.description,
		amountText = `x{ v78 }`
	}
end
local function resolveSpecialDiceDisplay(t9: {[any]: any}) -- line: 223
	-- upvalues: SpecialDiceServiceUtils (copy)
	local itemId = t9.itemId

	if type(itemId) ~= "string" or not SpecialDiceServiceUtils.isSpecialDiceItemId(itemId) then
		return nil
	end

	local v81 = SpecialDiceServiceUtils.getDefinition(itemId)
	local v82 = math.max(math.floor((t9.amount or 1) + 0.5), 1)

	return {
		icon = v81.icon,
		title = v81.name,
		description = v81.description,
		amountText = `x{ v82 }`
	}
end

function t1.getDisplayData(t10: {[any]: any}) -- line: 239
	-- upvalues: resolveBoostDisplay (copy), resolveSpecialDiceDisplay (copy), ImageIds (copy), Abbreviate (copy), Food (copy), Slimes (copy), Mutations (copy), v12 (copy)
	local v84 = if t10.kind ~= "boost" then if t10.kind ~= "specialDice" then nil else resolveSpecialDiceDisplay(t10) else resolveBoostDisplay(t10)

	if v84 ~= nil then
		return v84
	end

	if t10.kind == "coins" then
		local v85 = math.max(math.floor((t10.amount or 0) + 0.5), 0)

		return {
			title = "Coins",
			description = "Adds coins instantly.",
			icon = ImageIds.coin,
			amountText = if not (v85 > 0) then nil else `x{ Abbreviate(v85) }`
		}
	end

	if t10.kind == "goop" then
		local v86 = math.max(math.floor((t10.amount or 0) + 0.5), 0)

		return {
			title = "Goop",
			description = "Adds goop instantly.",
			icon = ImageIds.goop,
			amountText = if not (v86 > 0) then nil else `x{ Abbreviate(v86) }`
		}
	end

	if t10.kind == "boostTime" then
		local v87 = resolveBoostDisplay({
			kind = "boost",
			amount = 1,
			boostKind = t10.boostKind
		})

		if v87 ~= nil then
			v87.description = `Activates this boost for about { math.max(math.floor((t10.seconds or 0) / 60 + 0.5), 1) } minute(s).`
			v87.amountText = nil

			return v87
		end
	end

	if t10.kind == "food" then
		local v88 = Food.getFood(t10.itemId or "")
		local v89 = math.max(math.floor((t10.amount or 1) + 0.5), 1)

		if v88 ~= nil then
			return {
				icon = v88.icon,
				title = v88.name,
				description = Food.getDescription(v88.id),
				amountText = `x{ v89 }`
			}
		end
	end

	if t10.kind == "slime" and type(t10.slimeId) == "string" then
		local v90 = Slimes.getSlime(t10.slimeId)
		local v91 = math.max(math.floor((t10.amount or 1) + 0.5), 1)

		return {
			description = "Adds this slime to your inventory.",
			icon = Slimes.getImage(t10.slimeId, t10.mutations),
			title = Mutations.getDisplayName(v90.name, t10.mutations),
			amountText = `x{ v91 }`
		}
	end

	if t10.kind == "luckFlat" then
		local v92 = math.max(math.floor((t10.amount or 0) + 0.5), 0)

		return {
			title = "Permanent Luck",
			icon = ImageIds.luckIcons[1],
			description = `Permanently increases your luck by +{ v92 }.`,
			amountText = if not (v92 > 0) then nil else `+{ v92 }`
		}
	end

	if t10.kind == "luckMultiplier" then
		local v93 = math.round(math.max(tonumber(t10.amount) or 0, 0) * 1000) / 10

		return {
			title = "Permanent Luck %",
			icon = ImageIds.luckIcons[1],
			description = `Permanently increases your luck by { v93 }%.`,
			amountText = `+{ v93 }%`
		}
	end

	if t10.kind == "coinMultiplier" then
		local v94 = math.round(math.max(tonumber(t10.amount) or 0, 0) * 1000) / 10

		return {
			title = "Permanent Coins %",
			icon = ImageIds.coin,
			description = `Permanently increases your coin rewards by { v94 }%.`,
			amountText = `+{ v94 }%`
		}
	end

	return {
		title = "Reward",
		description = "Unknown reward configuration.",
		amountText = nil,
		icon = v12
	}
end

return t1
