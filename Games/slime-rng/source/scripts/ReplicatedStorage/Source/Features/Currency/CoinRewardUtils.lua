-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: CoinRewardUtils, time of decompilation: Sun May  3 10:11:30 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BoostServiceUtils = require(ReplicatedStorage.Source.Features.Boosts.BoostServiceUtils)
local IndexServiceUtils = require(ReplicatedStorage.Source.Features.Index.IndexServiceUtils)
local MonetizationServiceUtils = require(ReplicatedStorage.Source.Features.Monetization.MonetizationServiceUtils)
local UpgradeServiceUtils = require(ReplicatedStorage.Source.Features.Upgrades.UpgradeServiceUtils)
local t1 = {}

local function getModifierList(t2: {[any]: any}) -- line: 31
	-- upvalues: BoostServiceUtils (copy), UpgradeServiceUtils (copy), MonetizationServiceUtils (copy), IndexServiceUtils (copy)
	local v9 = BoostServiceUtils.getCoinRewardModifiers(t2.boosts, t2.currentTime or os.time())
	local v10 = UpgradeServiceUtils.getUpgradeLevel("coinIncome", t2.upgradesOwned or {})
	local v11 = UpgradeServiceUtils.getUpgradeValue("coinIncome", v10)

	if v11 > 1 then
		table.insert(v9, {
			id = "upgrades.coinIncome",
			multiplier = v11
		})
	end

	local v12 = MonetizationServiceUtils.getCoinRewardMultiplier(t2.ownsProductKey)

	if v12 > 1 then
		table.insert(v9, {
			id = "passes.vip",
			multiplier = v12
		})
	end

	local v13 = IndexServiceUtils.getCoinRewardMultiplier(t2.indexData)

	if v13 > 1 then
		table.insert(v9, {
			id = "index.coinMultiplier",
			multiplier = v13
		})
	end

	return v9
end

function t1.getEnemyCoinReward(n1: number, t3: {[any]: any}) -- line: 64
	-- upvalues: getModifierList (copy)
	local v16 = math.max(math.floor(n1 + 0.5), 0)
	local v17 = getModifierList(t3)
	local n2 = 1

	for _, v20 in v17 do
		n2 *= v20.multiplier
	end

	local v21 = math.max(math.floor(v16 * n2 + 0.5), 0)

	return {
		baseAmount = v16,
		totalMultiplier = n2,
		totalAmount = v21,
		modifiers = v17
	}
end

return t1
