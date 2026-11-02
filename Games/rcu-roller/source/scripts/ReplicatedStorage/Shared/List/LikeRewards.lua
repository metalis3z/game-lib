-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:18:29
-- Luau version 6, Types version 3
-- Time taken: 0.001170 seconds

local Items_upvr = require(game:GetService("ReplicatedStorage").Shared.Items)
local module = {}
local tbl_3 = {
	min = 0;
	max = 10000;
}
local function getReward() -- Line 8
	--[[ Upvalues[1]:
		[1]: Items_upvr (readonly)
	]]
	local tbl = {"clicks", "gems", "luck", "rngLuck", "hatch", "golden", "toxic", "shiny"}
	return {Items_upvr.potion(tbl[math.random(1, #tbl)])}
end
tbl_3.getReward = getReward
module[1] = tbl_3
local tbl_4 = {
	min = 10001;
	max = 1000000;
}
local function getReward() -- Line 21
	--[[ Upvalues[1]:
		[1]: Items_upvr (readonly)
	]]
	local tbl_5 = {"clicks", "gems", "luck", "rngLuck", "hatch", "golden", "toxic", "shiny"}
	return {Items_upvr.potion(tbl_5[math.random(1, #tbl_5)]), Items_upvr.potion(tbl_5[math.random(1, #tbl_5)])}
end
tbl_4.getReward = getReward
module[2] = tbl_4
local tbl_6 = {
	min = 1000001;
	max = 1000000000;
}
local function getReward() -- Line 35
	--[[ Upvalues[1]:
		[1]: Items_upvr (readonly)
	]]
	local tbl_2 = {"megaClicks", "megaGems", "megaLuck"}
	return {Items_upvr.potion(tbl_2[math.random(1, #tbl_2)])}
end
tbl_6.getReward = getReward
module[3] = tbl_6
module[4] = {
	min = 1000000001;
	max = math.huge;
	getReward = function() -- Line 48, Named "getReward"
		--[[ Upvalues[1]:
			[1]: Items_upvr (readonly)
		]]
		return {Items_upvr.box("potionsBox")}
	end;
}
return module