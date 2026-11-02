-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:18:15
-- Luau version 6, Types version 3
-- Time taken: 0.005786 seconds

local Functions_upvr = require(game:GetService("ReplicatedStorage").Shared.Functions)
local module = {}
local tbl_3 = {
	title = "Fan";
	description = "Join the Powerful Studio group!";
	gradient = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(125, 220, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(7, 251, 255))});
	chatColor = Color3.fromRGB(129, 211, 255);
}
local function isUnlocked(arg1, arg2) -- Line 14
	--[[ Upvalues[1]:
		[1]: Functions_upvr (readonly)
	]]
	return Functions_upvr.isInGroup(arg1)
end
tbl_3.isUnlocked = isUnlocked
module[1] = tbl_3
local tbl_5 = {
	title = "👑 VIP";
	description = "For VIP Gamepass Owners!";
	gradient = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 251, 133)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 203, 73))});
	chatColor = Color3.fromRGB(255, 186, 24);
}
local function isUnlocked(arg1, arg2) -- Line 29
	return arg2.passes.vip
end
tbl_5.isUnlocked = isUnlocked
module[2] = tbl_5
local tbl_15 = {
	title = "Content Creator";
	description = "For Content Creators!";
	gradient = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 121, 123)), ColorSequenceKeypoint.new(1, Color3.fromRGB(218, 63, 66))});
	chatColor = Color3.fromRGB(255, 66, 66);
}
local function isUnlocked(arg1, arg2) -- Line 44
	--[[ Upvalues[1]:
		[1]: Functions_upvr (readonly)
	]]
	local var9
	if Functions_upvr.getRankInGroup(arg1) ~= 4 then
		var9 = false
	else
		var9 = true
	end
	return var9
end
tbl_15.isUnlocked = isUnlocked
function tbl_15.isHidden(arg1, arg2) -- Line 47
	--[[ Upvalues[1]:
		[1]: Functions_upvr (readonly)
	]]
	local var10
	if Functions_upvr.getRankInGroup(arg1) == 4 then
		var10 = false
	else
		var10 = true
	end
	return var10
end
module[3] = tbl_15
local tbl_6 = {
	title = "OG Player";
	description = "Join within 3 days of the release!";
	gradient = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(117, 255, 75)), ColorSequenceKeypoint.new(1, Color3.fromRGB(74, 222, 30))});
	chatColor = Color3.fromRGB(127, 255, 41);
}
local function isUnlocked(arg1, arg2) -- Line 62
	local var13
	if arg2.profileCreateTime > 1742839200000 then
		var13 = false
	else
		var13 = true
	end
	return var13
end
tbl_6.isUnlocked = isUnlocked
module[4] = tbl_6
local tbl_10 = {
	title = "RCX Fan";
	description = "Spent 90 days or 10,000 robux in the previous game!";
	gradient = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(87, 227, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(55, 134, 218))});
	chatColor = Color3.fromRGB(0, 166, 255);
}
local function isUnlocked(arg1, arg2) -- Line 77
	local var16
	if 3 > arg2.rcxTier then
		var16 = false
	else
		var16 = true
	end
	return var16
end
tbl_10.isUnlocked = isUnlocked
module[5] = tbl_10
local tbl_11 = {
	title = "RCX Enjoyer";
	description = "Spent 180 days or 25,000 robux in the previous game!";
	gradient = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 136, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(218, 87, 0))});
	chatColor = Color3.fromRGB(255, 85, 0);
}
local function isUnlocked(arg1, arg2) -- Line 92
	local var19
	if 4 > arg2.rcxTier then
		var19 = false
	else
		var19 = true
	end
	return var19
end
tbl_11.isUnlocked = isUnlocked
module[6] = tbl_11
local tbl_14 = {
	title = "Supporter";
	description = "Spend 5,000+ Robux!";
	gradient = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(138, 255, 84)), ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 175, 55))});
	chatColor = Color3.fromRGB(127, 255, 88);
}
local function isUnlocked(arg1, arg2) -- Line 107
	local var22
	if 5000 > arg2.stats.robuxSpent then
		var22 = false
	else
		var22 = true
	end
	return var22
end
tbl_14.isUnlocked = isUnlocked
module[7] = tbl_14
local tbl_4 = {
	title = "Mega Supporter";
	description = "Spend 10,000+ Robux!";
	gradient = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(225, 133, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(198, 70, 230))});
	chatColor = Color3.fromRGB(240, 156, 255);
}
local function isUnlocked(arg1, arg2) -- Line 122
	local var25
	if 10000 > arg2.stats.robuxSpent then
		var25 = false
	else
		var25 = true
	end
	return var25
end
tbl_4.isUnlocked = isUnlocked
module[8] = tbl_4
local tbl_8 = {
	title = "Insane Supporter";
	description = "Spend 25,000+ Robux!";
	gradient = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 52, 55)), ColorSequenceKeypoint.new(1, Color3.fromRGB(218, 0, 4))});
	chatColor = Color3.fromRGB(255, 51, 51);
}
local function isUnlocked(arg1, arg2) -- Line 137
	local var28
	if 25000 > arg2.stats.robuxSpent then
		var28 = false
	else
		var28 = true
	end
	return var28
end
tbl_8.isUnlocked = isUnlocked
module[9] = tbl_8
local tbl_7 = {
	title = "Farmer";
	description = "Collect 2,500+ Fruits!";
	category = "progress";
	gradient = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 217, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(235, 129, 0))});
	chatColor = Color3.fromRGB(255, 196, 47);
}
local function isUnlocked(arg1, arg2) -- Line 154
	local var31
	if 2500 > arg2.stats.fruitsCollected then
		var31 = false
	else
		var31 = true
	end
	return var31
end
tbl_7.isUnlocked = isUnlocked
module[10] = tbl_7
local tbl_16 = {
	title = "Lumberjack";
	description = "Destroy 1,000+ Trees!";
	category = "progress";
	gradient = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(107, 255, 62)), ColorSequenceKeypoint.new(1, Color3.fromRGB(5, 165, 2))});
	chatColor = Color3.fromRGB(99, 255, 64);
}
local function isUnlocked(arg1, arg2) -- Line 171
	local var34
	if 1000 > arg2.stats.treesDestroyed then
		var34 = false
	else
		var34 = true
	end
	return var34
end
tbl_16.isUnlocked = isUnlocked
module[11] = tbl_16
local tbl_2 = {
	title = "Pro Hatcher";
	description = "Hatch 500,000+ Pets!";
	category = "progress";
	gradient = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 195, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(28, 104, 218))});
	chatColor = Color3.fromRGB(42, 134, 255);
}
local function isUnlocked(arg1, arg2) -- Line 188
	local var37
	if 500000 > arg2.stats.eggsOpened then
		var37 = false
	else
		var37 = true
	end
	return var37
end
tbl_2.isUnlocked = isUnlocked
module[12] = tbl_2
local tbl_9 = {
	title = "Insane Hatcher";
	description = "Hatch 1,000,000+ Pets!";
	category = "progress";
	gradient = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(196, 125, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(154, 63, 218))});
	chatColor = Color3.fromRGB(175, 83, 255);
}
local function isUnlocked(arg1, arg2) -- Line 205
	local var40
	if 1000000 > arg2.stats.eggsOpened then
		var40 = false
	else
		var40 = true
	end
	return var40
end
tbl_9.isUnlocked = isUnlocked
module[13] = tbl_9
local tbl_12 = {
	title = "Mega Roller";
	description = "Use 10,000 Aura Dice!";
	category = "progress";
	gradient = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 102, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(218, 80, 0))});
	chatColor = Color3.fromRGB(255, 119, 0);
}
local function isUnlocked(arg1, arg2) -- Line 222
	local var43
	if 10000 > arg2.stats.auraRolls then
		var43 = false
	else
		var43 = true
	end
	return var43
end
tbl_12.isUnlocked = isUnlocked
module[14] = tbl_12
local tbl_13 = {
	title = "No-Life";
	description = "Spend 14 days in the game!";
	category = "progress";
	gradient = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 213)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 220, 213))});
	chatColor = Color3.fromRGB(2, 255, 238);
}
local function isUnlocked(arg1, arg2) -- Line 239
	local var46
	if 1209600 > arg2.stats.timePlayed then
		var46 = false
	else
		var46 = true
	end
	return var46
end
tbl_13.isUnlocked = isUnlocked
module[15] = tbl_13
local tbl = {
	title = "Daily Player";
	description = "Get 14+ Daily Streak!";
	category = "progress";
	gradient = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 247, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(221, 177, 0))});
	chatColor = Color3.fromRGB(255, 225, 0);
}
local function isUnlocked(arg1, arg2) -- Line 256
	local var49
	if 14 > arg2.day then
		var49 = false
	else
		var49 = true
	end
	return var49
end
tbl.isUnlocked = isUnlocked
module[16] = tbl
module[17] = {
	title = "Secrets Hatcher";
	description = "Hatch 3+ Secret Pets!";
	category = "progress";
	gradient = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 46, 49)), ColorSequenceKeypoint.new(1, Color3.fromRGB(218, 22, 25))});
	chatColor = Color3.fromRGB(255, 29, 29);
	isUnlocked = function(arg1, arg2) -- Line 273, Named "isUnlocked"
		local var52
		if 3 > (arg2.stats.rarities.secret or 0) then
			var52 = false
		else
			var52 = true
		end
		return var52
	end;
}
return module