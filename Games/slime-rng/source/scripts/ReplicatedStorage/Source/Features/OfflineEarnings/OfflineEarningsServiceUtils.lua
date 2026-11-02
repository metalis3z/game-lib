-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: OfflineEarningsServiceUtils, time of decompilation: Sun May  3 10:12:12 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UpgradeServiceUtils = require(ReplicatedStorage.Source.Features.Upgrades.UpgradeServiceUtils)

require(ReplicatedStorage.Source.Game.Items.DataTemplate)

local t2 = {
	getMinOfflineSeconds = function() --[[ getMinOfflineSeconds ]] -- line: 13
		return 1200
	end,
	getMaxOfflineSeconds = function() --[[ getMaxOfflineSeconds ]] -- line: 17
		return 43200
	end,
	getEligibleOfflineSeconds = function(n1: number?) --[[ getEligibleOfflineSeconds ]] -- line: 21
		local v5 = math.max(math.floor(n1 or 0), 0)

		if v5 < 1200 then
			return 0
		end

		return (math.min(v5, 43200))
	end,
	getOfflineLootMultiplier = function(t1: {[any]: any}?) --[[ getOfflineLootMultiplier ]] -- line: 30
		-- upvalues: UpgradeServiceUtils (copy)
		local v7 = UpgradeServiceUtils.getUpgradeLevel("offlineLootAmount", t1 or {})

		return UpgradeServiceUtils.getUpgradeValue("offlineLootAmount", v7)
	end,
	reconcileRewardData = function(p1) --[[ reconcileRewardData ]] -- line: 35
		if type(p1) ~= "table" then
			return nil
		end

		local v9 = math.max(math.floor(p1.offlineSeconds or 0), 0)
		local v10 = math.max(math.floor(p1.coins or 0), 0)
		local v11 = math.max(math.floor(p1.goop or 0), 0)

		if v9 <= 0 or v10 <= 0 and v11 <= 0 then
			return nil
		end

		return {
			offlineSeconds = v9,
			coins = v10,
			goop = v11
		}
	end
}

function t2.hasReward(p2) -- line: 54
	-- upvalues: t2 (copy)
	return t2.reconcileRewardData(p2) ~= nil
end
function t2.combineRewards(p3, p4) -- line: 58
	-- upvalues: t2 (copy)
	local v15 = t2.reconcileRewardData(p3)
	local v16 = t2.reconcileRewardData(p4)

	if not v15 then
		return v16
	end

	if not v16 then
		return v15
	end

	return {
		offlineSeconds = v15.offlineSeconds + v16.offlineSeconds,
		coins = v15.coins + v16.coins,
		goop = v15.goop + v16.goop
	}
end

return t2
