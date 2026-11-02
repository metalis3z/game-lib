-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: FriendsServiceUtils, time of decompilation: Sun May  3 10:11:31 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UpgradeServiceUtils = require(ReplicatedStorage.Source.Features.Upgrades.UpgradeServiceUtils)
local t3 = {
	getFriendLuckLevel = function(t1: {[any]: any}?) --[[ getFriendLuckLevel ]] -- line: 15
		-- upvalues: UpgradeServiceUtils (copy)
		return UpgradeServiceUtils.getUpgradeLevel("friendLuck", t1 or {})
	end,
	getFriendLuckBoostLevel = function(t2: {[any]: any}?) --[[ getFriendLuckBoostLevel ]] -- line: 19
		-- upvalues: UpgradeServiceUtils (copy)
		return UpgradeServiceUtils.getUpgradeLevel("friendLuckBoost", t2 or {})
	end,
	getFriendLuckCap = function(n1: number) --[[ getFriendLuckCap ]] -- line: 23
		-- upvalues: UpgradeServiceUtils (copy)
		return UpgradeServiceUtils.getUpgradeValue("friendLuck", n1)
	end,
	getFriendLuckPerFriend = function(n2: number, n3: number) --[[ getFriendLuckPerFriend ]] -- line: 27
		-- upvalues: UpgradeServiceUtils (copy)
		if n2 <= 0 then
			return 0
		end

		return UpgradeServiceUtils.getUpgradeValue("friendLuckBoost", n3)
	end
}

function t3.getFriendLuckInfo(n4: number?, t4: {[any]: any}?) -- line: 35
	-- upvalues: t3 (copy)
	local v11 = math.max(n4 or 0, 0)
	local v12 = t3.getFriendLuckLevel(t4)
	local v13 = t3.getFriendLuckBoostLevel(t4)
	local v14 = t3.getFriendLuckCap(v12)
	local v15 = t3.getFriendLuckPerFriend(v12, v13)
	local v16 = math.min(v11, v14)

	return {
		friendCount = v11,
		cappedFriendCount = v16,
		cap = v14,
		luckPerFriend = v15,
		totalBonus = v16 * v15
	}
end
function t3.getFriendLuckBonus(n5: number?, t5: {[any]: any}?) -- line: 52
	-- upvalues: t3 (copy)
	return t3.getFriendLuckInfo(n5, t5).totalBonus
end

return t3
