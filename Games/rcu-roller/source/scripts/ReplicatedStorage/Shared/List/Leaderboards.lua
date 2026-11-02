-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:18:09
-- Luau version 6, Types version 3
-- Time taken: 0.003336 seconds

local Functions_upvr = require(game:GetService("ReplicatedStorage").Shared.Functions)
local Auras_upvr = require(game:GetService("ReplicatedStorage").Shared.List.Items.Auras)
local module = {
	clanRebirths = {
		shouldCompress = true;
		isClan = true;
		values = {{
			name = "clanRebirths";
		}};
	};
	clanHatching = {
		isClan = true;
		values = {{
			name = "clanHatching";
		}};
	};
}
local tbl_3 = {
	shouldCompress = true;
}
local tbl = {}
local tbl_8 = {
	name = "rebirths";
}
local function getValue(arg1) -- Line 31
	return arg1.rebirths
end
tbl_8.getValue = getValue
tbl[1] = tbl_8
tbl_3.values = tbl
module.rebirths = tbl_3
local tbl_22 = {
	shouldCompress = true;
}
local tbl_6 = {}
local tbl_11 = {
	name = "totalClicks";
}
local function getValue(arg1) -- Line 43
	return arg1.stats.totalClicks
end
tbl_11.getValue = getValue
tbl_6[1] = tbl_11
tbl_22.values = tbl_6
module.totalClicks = tbl_22
local tbl_4 = {}
local tbl_7 = {}
local tbl_10 = {
	name = "timePlayed";
}
local function getValue(arg1) -- Line 54
	return arg1.stats.timePlayed
end
tbl_10.getValue = getValue
local function getText(arg1) -- Line 57
	--[[ Upvalues[1]:
		[1]: Functions_upvr (readonly)
	]]
	return Functions_upvr.formatTime2(arg1)
end
tbl_10.getText = getText
tbl_7[1] = tbl_10
tbl_4.values = tbl_7
module.timePlayed = tbl_4
local tbl_16 = {}
local tbl_19 = {}
local tbl_17 = {
	name = "robuxSpent";
}
local function getValue(arg1) -- Line 68
	return arg1.stats.robuxSpent
end
tbl_17.getValue = getValue
local function getText(arg1) -- Line 71
	--[[ Upvalues[1]:
		[1]: Functions_upvr (readonly)
	]]
	return `{Functions_upvr.suffixes(arg1)}`
end
tbl_17.getText = getText
tbl_19[1] = tbl_17
tbl_16.values = tbl_19
module.robuxSpent = tbl_16
local tbl_12 = {}
local tbl_14 = {}
local tbl_18 = {
	name = "eggsOpened";
	title = "Eggs Opened";
}
local function getValue(arg1) -- Line 83
	return arg1.stats.eggsOpened
end
tbl_18.getValue = getValue
tbl_14[1] = tbl_18
local tbl_21 = {
	name = "mythicalsHatched";
	title = "Mythicals Hatched";
}
local function getValue(arg1) -- Line 90
	return arg1.stats.rarities.mythical or 0
end
tbl_21.getValue = getValue
tbl_14[2] = tbl_21
local tbl_13 = {
	name = "eternalsHatched";
	title = "Eternals Hatched";
}
local function getValue(arg1) -- Line 97
	return arg1.stats.rarities.eternal or 0
end
tbl_13.getValue = getValue
tbl_14[3] = tbl_13
local tbl_5 = {
	name = "secretsHatched";
	title = "Secrets Hatched";
}
local function getValue(arg1) -- Line 104
	return arg1.stats.rarities.secret or 0
end
tbl_5.getValue = getValue
tbl_14[4] = tbl_5
local tbl_15 = {
	name = "indexCollected";
	title = "Index Collected";
}
local Util_upvr = require(game:GetService("ReplicatedStorage").Shared.Util)
local function getValue(arg1) -- Line 111
	--[[ Upvalues[1]:
		[1]: Util_upvr (readonly)
	]]
	return Util_upvr.indexUtils.countIndex(arg1, true)
end
tbl_15.getValue = getValue
tbl_14[5] = tbl_15
tbl_12.values = tbl_14
module.eggsOpened = tbl_12
local tbl_20 = {}
local tbl_9 = {}
local tbl_23 = {
	name = "auraRolls";
	title = "Aura Rolls";
}
local function getValue(arg1) -- Line 123
	return arg1.stats.auraRolls
end
tbl_23.getValue = getValue
tbl_9[1] = tbl_23
local tbl_2 = {
	name = "bestAuraRoll";
	title = "Best Aura Roll";
	getText = function(arg1) -- Line 130, Named "getText"
		--[[ Upvalues[1]:
			[1]: Functions_upvr (readonly)
		]]
		local var34
		local function INLINED() -- Internal function, doesn't exist in bytecode
			var34 = Functions_upvr.comma(arg1)
			return var34
		end
		if arg1 >= 999999 or not INLINED() then
			var34 = Functions_upvr.suffixes(arg1)
		end
		return `1/{var34}`
	end;
	getIcon = function(arg1) -- Line 133, Named "getIcon"
		--[[ Upvalues[2]:
			[1]: Auras_upvr (readonly)
			[2]: Functions_upvr (readonly)
		]]
		for _, v in Auras_upvr do
			if math.floor(Functions_upvr.floatingPoint(1 / v.chance) * 100) == arg1 then
				return v.icon
			end
		end
	end;
	getValue = function(arg1) -- Line 140, Named "getValue"
		return arg1.stats.bestAuraRoll
	end;
}
local Items_upvr = require(game:GetService("ReplicatedStorage").Shared.Items)
function tbl_2.getInfoHoverItem(arg1) -- Line 143
	--[[ Upvalues[3]:
		[1]: Auras_upvr (readonly)
		[2]: Functions_upvr (readonly)
		[3]: Items_upvr (readonly)
	]]
	for i_2, v_2 in Auras_upvr do
		if math.floor(Functions_upvr.floatingPoint(1 / v_2.chance) * 100) == arg1 then
			return Items_upvr.aura(i_2)
		end
	end
end
tbl_9[2] = tbl_2
tbl_20.values = tbl_9
module.auraRolls = tbl_20
return module