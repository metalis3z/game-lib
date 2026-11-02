-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:22:04
-- Luau version 6, Types version 3
-- Time taken: 0.003466 seconds

local Functions_upvr = require(game:GetService("ReplicatedStorage").Shared.Functions)
local module = {
	totalClicks = function(arg1) -- Line 5, Named "totalClicks"
		--[[ Upvalues[1]:
			[1]: Functions_upvr (readonly)
		]]
		return Functions_upvr.suffixes(arg1.stats.totalClicks)
	end;
	totalRebirths = function(arg1) -- Line 8, Named "totalRebirths"
		--[[ Upvalues[1]:
			[1]: Functions_upvr (readonly)
		]]
		return Functions_upvr.suffixes(arg1.rebirths)
	end;
	totalGems = function(arg1) -- Line 11, Named "totalGems"
		--[[ Upvalues[1]:
			[1]: Functions_upvr (readonly)
		]]
		return Functions_upvr.suffixes(arg1.stats.totalGems)
	end;
	timePlayed = function(arg1) -- Line 14, Named "timePlayed"
		--[[ Upvalues[1]:
			[1]: Functions_upvr (readonly)
		]]
		return Functions_upvr.formatTime2(arg1.stats.timePlayed)
	end;
	robuxSpent = function(arg1) -- Line 17, Named "robuxSpent"
		--[[ Upvalues[1]:
			[1]: Functions_upvr (readonly)
		]]
		local var3
		local function INLINED() -- Internal function, doesn't exist in bytecode
			var3 = Functions_upvr.comma(arg1.stats.robuxSpent)
			return var3
		end
		if arg1.stats.robuxSpent > 100000 or not INLINED() then
			var3 = Functions_upvr.suffixes(arg1.stats.robuxSpent)
		end
		return var3
	end;
	tradeTokensSpent = function(arg1) -- Line 20, Named "tradeTokensSpent"
		--[[ Upvalues[1]:
			[1]: Functions_upvr (readonly)
		]]
		return Functions_upvr.suffixes(arg1.stats.tradeTokensSpent)
	end;
	eggsOpened = function(arg1) -- Line 24, Named "eggsOpened"
		--[[ Upvalues[1]:
			[1]: Functions_upvr (readonly)
		]]
		return Functions_upvr.suffixes(arg1.stats.eggsOpened)
	end;
	legendaryHatched = function(arg1) -- Line 27, Named "legendaryHatched"
		--[[ Upvalues[1]:
			[1]: Functions_upvr (readonly)
		]]
		return Functions_upvr.suffixes(arg1.stats.rarities.legendary or 0)
	end;
	mythicalHatched = function(arg1) -- Line 30, Named "mythicalHatched"
		--[[ Upvalues[1]:
			[1]: Functions_upvr (readonly)
		]]
		return Functions_upvr.suffixes(arg1.stats.rarities.mythical or 0)
	end;
	eternalHatched = function(arg1) -- Line 33, Named "eternalHatched"
		--[[ Upvalues[1]:
			[1]: Functions_upvr (readonly)
		]]
		return Functions_upvr.suffixes(arg1.stats.rarities.eternal or 0)
	end;
	secretHatched = function(arg1) -- Line 36, Named "secretHatched"
		--[[ Upvalues[1]:
			[1]: Functions_upvr (readonly)
		]]
		return Functions_upvr.suffixes(arg1.stats.rarities.secret or 0)
	end;
	exclusiveEggsOpened = function(arg1) -- Line 39, Named "exclusiveEggsOpened"
		--[[ Upvalues[1]:
			[1]: Functions_upvr (readonly)
		]]
		return Functions_upvr.suffixes(arg1.stats.exclusiveEggsOpened)
	end;
	exclusiveHatched = function(arg1) -- Line 42, Named "exclusiveHatched"
		--[[ Upvalues[1]:
			[1]: Functions_upvr (readonly)
		]]
		return Functions_upvr.suffixes(arg1.stats.rarities.exclusive or 0)
	end;
	supremeHatched = function(arg1) -- Line 45, Named "supremeHatched"
		--[[ Upvalues[1]:
			[1]: Functions_upvr (readonly)
		]]
		return Functions_upvr.suffixes(arg1.stats.rarities.supreme or 0)
	end;
	ultimateHatched = function(arg1) -- Line 48, Named "ultimateHatched"
		--[[ Upvalues[1]:
			[1]: Functions_upvr (readonly)
		]]
		return Functions_upvr.suffixes(arg1.stats.rarities.ultimate or 0)
	end;
}
local Util_upvr = require(game:GetService("ReplicatedStorage").Shared.Util)
function module.indexCollected(arg1) -- Line 51
	--[[ Upvalues[2]:
		[1]: Functions_upvr (readonly)
		[2]: Util_upvr (readonly)
	]]
	return Functions_upvr.suffixes(Util_upvr.indexUtils.countIndex(arg1, true))
end
function module.auraRolls(arg1) -- Line 55
	--[[ Upvalues[1]:
		[1]: Functions_upvr (readonly)
	]]
	return Functions_upvr.suffixes(arg1.stats.auraRolls)
end
function module.bestAuraRoll(arg1) -- Line 58
	--[[ Upvalues[1]:
		[1]: Functions_upvr (readonly)
	]]
	return `1/{Functions_upvr.suffixes(arg1.stats.bestAuraRoll)}`
end
function module.ancientWheelSpins(arg1) -- Line 61
	--[[ Upvalues[1]:
		[1]: Functions_upvr (readonly)
	]]
	return Functions_upvr.suffixes(arg1.stats.ancientWheelSpins)
end
function module.treesDestroyed(arg1) -- Line 64
	--[[ Upvalues[1]:
		[1]: Functions_upvr (readonly)
	]]
	return Functions_upvr.suffixes(arg1.stats.treesDestroyed)
end
function module.fruitsCollected(arg1) -- Line 67
	--[[ Upvalues[1]:
		[1]: Functions_upvr (readonly)
	]]
	return Functions_upvr.suffixes(arg1.stats.fruitsCollected)
end
function module.chestsOpened(arg1) -- Line 70
	--[[ Upvalues[1]:
		[1]: Functions_upvr (readonly)
	]]
	return Functions_upvr.suffixes(arg1.stats.chestsOpened)
end
function module.fallingStarsCollected(arg1) -- Line 73
	--[[ Upvalues[1]:
		[1]: Functions_upvr (readonly)
	]]
	return Functions_upvr.suffixes(arg1.stats.fallingStarsCollected)
end
function module.joinedDate(arg1) -- Line 76
	local var6_upvw = "US"
	local pcall_result1, _ = pcall(function() -- Line 83
		--[[ Upvalues[1]:
			[1]: var6_upvw (read and write)
		]]
		var6_upvw = game:GetService("LocalizationService"):GetCountryRegionForPlayerAsync(game:GetService("Players").LocalPlayer)
	end)
	local profileCreateTime = arg1.profileCreateTime
	local DateTime_fromUnixTimestampMillis_result1 = DateTime.fromUnixTimestampMillis(profileCreateTime)
	local var12
	if 31556926 >= os.time() - DateTime_fromUnixTimestampMillis_result1.UnixTimestamp then
		profileCreateTime = false
	else
		profileCreateTime = true
	end
	if profileCreateTime then
		return `{DateTime_fromUnixTimestampMillis_result1:FormatLocalTime("ll", "en-us")}`
	end
	if table.find({"US", "GB", "CA", "AU", "NZ", "PH", "IN", "PK", "EG", "CO", "MX", "HN", "GT", "SV", "JM", "TT", "BZ", "MY", "MM", "NG", "LY", "SA", "AE"}, var6_upvw) then
		var12 = "h:mma"
	else
		var12 = "HH:mm"
	end
	return `{DateTime_fromUnixTimestampMillis_result1:FormatLocalTime(`MMM D, {var12}`, "en-us")}`
end
return module