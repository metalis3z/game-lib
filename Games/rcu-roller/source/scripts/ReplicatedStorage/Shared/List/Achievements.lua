-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:18:23
-- Luau version 6, Types version 3
-- Time taken: 0.014487 seconds

local Items = require(game:GetService("ReplicatedStorage").Shared.Items)
local Functions_upvr = require(game:GetService("ReplicatedStorage").Shared.Functions)
local module = {}
local tbl_3 = {
	icon = "rbxassetid://130618550818505";
	iconSize = UDim2.new(0.165, 0, 0.777, 0);
	layoutOrder = 1;
	list = {{
		name = "Rebirths I";
		amount = 250;
		rewards = {Items.fruit("apple"):setAmount(1), Items.fruit("grape"):setAmount(1)};
	}, {
		name = "Rebirths II";
		amount = 5000;
		rewards = {Items.potion("luck"):setAmount(1), Items.potion("gems"):setAmount(1), Items.potion("clicks"):setAmount(1)};
	}, {
		name = "Rebirths III";
		amount = 25000;
		rewards = {Items.potion("megaLuck"):setAmount(1), Items.potion("gems"):setAmount(1), Items.potion("clicks"):setAmount(1)};
	}, {
		name = "Rebirths IV";
		amount = 100000;
		rewards = {Items.potion("megaLuck"):setAmount(1), Items.potion("hatch"):setAmount(3), Items.box("fruitsBox"):setAmount(1), Items.upgrade("mythicalPity")};
	}, {
		name = "Rebirths V";
		amount = 500000;
		rewards = {Items.potion("luck"):setAmount(10), Items.box("potionsBox"):setAmount(3), Items.box("fruitsBox"):setAmount(3), Items.upgrade("luckMultiplier"):setAmount(0.05)};
	}, {
		name = "Rebirths VI";
		amount = 2500000;
		rewards = {Items.exclusive("epicLuck"):setAmount(1), Items.box("potionsBox"):setAmount(5), Items.box("fruitsBox"):setAmount(5), Items.upgrade("clicksMultiplier"):setAmount(0.05)};
	}, {
		name = "Rebirths VII";
		amount = 50000000;
		rewards = {Items.auraDice("royalAuraDice"):setAmount(1), Items.box("potionsChest"):setAmount(1), Items.box("fruitsChest"):setAmount(1), Items.booth("magmaBooth"):setAmount(1)};
	}, {
		name = "Rebirths VIII";
		amount = 250000000;
		rewards = {Items.exclusive("epicLuck"):setAmount(1), Items.box("fruitsChest"):setAmount(3), Items.upgrade("hatchSpeed"):setAmount(0.05), Items.upgrade("luckMultiplier"):setAmount(0.05)};
	}, {
		name = "Rebirths IX";
		amount = 1000000000;
		rewards = {Items.auraDice("royalAuraDice"):setAmount(1), Items.box("potionsChest"):setAmount(3), Items.upgrade("gemsMultiplier"):setAmount(0.05), Items.upgrade("clicksMultiplier"):setAmount(0.05)};
	}, {
		name = "Rebirths X";
		amount = 10000000000;
		rewards = {Items.auraDice("royalAuraDice"):setAmount(2), Items.box("potionsChest"):setAmount(3), Items.box("fruitsChest"):setAmount(3), Items.upgrade("luckMultiplier"):setAmount(0.05)};
	}, {
		name = "Rebirths XI";
		amount = 50000000000;
		rewards = {Items.exclusive("epicLuck"):setAmount(1), Items.upgrade("hatchSpeed"):setAmount(0.05), Items.upgrade("gemsMultiplier"):setAmount(0.05), Items.upgrade("clicksMultiplier"):setAmount(0.05)};
	}, {
		name = "Rebirths XII";
		amount = 250000000000;
		rewards = {Items.auraDice("royalAuraDice"):setAmount(2), Items.box("potionsChest"):setAmount(4), Items.box("fruitsChest"):setAmount(4), Items.upgrade("gemsMultiplier"):setAmount(0.05)};
	}};
}
local function getValue(arg1) -- Line 142
	return arg1.rebirths
end
tbl_3.getValue = getValue
local function getDescription(arg1) -- Line 145
	return `Rebirth {arg1} times!`
end
tbl_3.getDescription = getDescription
local function getProgress(arg1) -- Line 148
	--[[ Upvalues[1]:
		[1]: Functions_upvr (readonly)
	]]
	return Functions_upvr.suffixes(arg1)
end
tbl_3.getProgress = getProgress
module.rebirths = tbl_3
local tbl_7 = {
	icon = "rbxassetid://102866111544107";
	iconSize = UDim2.new(0.165, 0, 0.777, 0);
	layoutOrder = 2;
	list = {{
		name = "Hatcher I";
		amount = 100;
		rewards = {Items.potion("luck"):setAmount(1)};
	}, {
		name = "Hatcher II";
		amount = 500;
		rewards = {Items.potion("luck"):setAmount(1), Items.fruit("carrot"):setAmount(1)};
	}, {
		name = "Hatcher III";
		amount = 1000;
		rewards = {Items.potion("luck"):setAmount(2), Items.fruit("carrot"):setAmount(2)};
	}, {
		name = "Hatcher IV";
		amount = 5000;
		rewards = {Items.box("potionsBox"):setAmount(1), Items.fruit("goldenCarrot"):setAmount(1), Items.potion("megaLuck"):setAmount(1)};
	}, {
		name = "Hatcher V";
		amount = 10000;
		rewards = {Items.potion("luck"):setAmount(5), Items.potion("megaLuck"):setAmount(3), Items.box("fruitsBox"):setAmount(1), Items.upgrade("hatchSpeed"):setAmount(0.01)};
	}, {
		name = "Hatcher VI";
		amount = 25000;
		rewards = {Items.potion("megaLuck"):setAmount(5), Items.box("potionsBox"):setAmount(3), Items.box("fruitsBox"):setAmount(3)};
	}, {
		name = "Hatcher VII";
		amount = 50000;
		rewards = {Items.potion("luck"):setAmount(10), Items.fruit("carrot"):setAmount(10), Items.upgrade("luckMultiplier"):setAmount(0.05), Items.upgrade("hatchSpeed"):setAmount(0.03)};
	}, {
		name = "Hatcher VIII";
		amount = 100000;
		rewards = {Items.exclusive("epicLuck"):setAmount(1), Items.box("potionsChest"):setAmount(1), Items.auraDice("royalAuraDice"):setAmount(1), Items.upgrade("luckMultiplier"):setAmount(0.05)};
	}, {
		name = "Hatcher IX";
		amount = 250000;
		rewards = {Items.box("fruitsBox"):setAmount(5), Items.box("potionsBox"):setAmount(5), Items.upgrade("luckMultiplier"):setAmount(0.05), Items.upgrade("hatchSpeed"):setAmount(0.03)};
	}, {
		name = "Hatcher X";
		amount = 500000;
		rewards = {Items.exclusive("epicLuck"):setAmount(5), Items.box("potionsChest"):setAmount(2), Items.upgrade("shinyPetsLuck"):setAmount(0.1), Items.upgrade("hatchSpeed"):setAmount(0.03)};
	}, {
		name = "Hatcher XI";
		amount = 750000;
		rewards = {Items.potion("megaLuck"):setAmount(25), Items.fruit("goldenCarrot"):setAmount(25), Items.fruit("goldenStrawberry"):setAmount(25), Items.booth("policeBooth"):setAmount(1)};
	}, {
		name = "Hatcher XII";
		amount = 1000000;
		rewards = {Items.upgrade("luckMultiplier"):setAmount(0.15), Items.upgrade("hatchSpeed"):setAmount(0.1), Items.box("potionsChest"):setAmount(5), Items.box("fruitsChest"):setAmount(5)};
	}};
}
local function getValue(arg1) -- Line 283
	return arg1.stats.eggsOpened
end
tbl_7.getValue = getValue
local function getDescription(arg1) -- Line 286
	return `Open {arg1} eggs!`
end
tbl_7.getDescription = getDescription
local function getProgress(arg1) -- Line 289
	--[[ Upvalues[1]:
		[1]: Functions_upvr (readonly)
	]]
	return Functions_upvr.suffixes(arg1)
end
tbl_7.getProgress = getProgress
module.eggsOpened = tbl_7
local tbl_2 = {
	icon = "rbxassetid://96319134617611";
	iconSize = UDim2.new(0.165, 0, 0.777, 0);
	layoutOrder = 3;
	list = {{
		name = "Roller I";
		amount = 10;
		rewards = {Items.auraDice("fireAuraDice"):setAmount(1)};
	}, {
		name = "Roller II";
		amount = 25;
		rewards = {Items.potion("rngLuck"):setAmount(1), Items.auraDice("fireAuraDice"):setAmount(2)};
	}, {
		name = "Roller III";
		amount = 50;
		rewards = {Items.potion("rngLuck"):setAmount(1), Items.auraDice("fireAuraDice"):setAmount(3)};
	}, {
		name = "Roller IV";
		amount = 100;
		rewards = {Items.potion("rngLuck"):setAmount(1), Items.auraDice("magicAuraDice"):setAmount(1)};
	}, {
		name = "Roller V";
		amount = 250;
		rewards = {Items.fruit("pineapple"):setAmount(3), Items.potion("rngLuck"):setAmount(3), Items.auraDice("fireAuraDice"):setAmount(5), Items.upgrade("auraLuck"):setAmount(1)};
	}, {
		name = "Roller VI";
		amount = 500;
		rewards = {Items.fruit("goldenPineapple"):setAmount(1), Items.auraDice("fireAuraDice"):setAmount(25), Items.auraDice("magicAuraDice"):setAmount(3), Items.auraDice("voidAuraDice"):setAmount(1)};
	}, {
		name = "Roller VII";
		amount = 1000;
		rewards = {Items.auraDice("magicAuraDice"):setAmount(10), Items.fruit("goldenPineapple"):setAmount(3), Items.potion("rngLuck"):setAmount(3), Items.upgrade("auraLuck"):setAmount(3)};
	}, {
		name = "Roller VIII";
		amount = 2500;
		rewards = {Items.box("potionsBox"):setAmount(5), Items.box("fruitsBox"):setAmount(5), Items.auraDice("voidAuraDice"):setAmount(1), Items.upgrade("auraLuck"):setAmount(3)};
	}, {
		name = "Roller IX";
		amount = 5000;
		rewards = {Items.auraDice("voidAuraDice"):setAmount(3), Items.fruit("pineapple"):setAmount(10), Items.fruit("goldenPineapple"):setAmount(5), Items.booth("rngBooth"):setAmount(1)};
	}, {
		name = "Roller X";
		amount = 10000;
		rewards = {Items.auraDice("magicAuraDice"):setAmount(50), Items.auraDice("voidAuraDice"):setAmount(20), Items.box("potionsChest"):setAmount(1), Items.upgrade("auraLuck"):setAmount(3)};
	}, {
		name = "Roller XI";
		amount = 15000;
		rewards = {Items.auraDice("voidAuraDice"):setAmount(25), Items.auraDice("royalAuraDice"):setAmount(1), Items.potion("rngLuck"):setAmount(25), Items.upgrade("auraLuck"):setAmount(3)};
	}, {
		name = "Roller XII";
		amount = 20000;
		rewards = {Items.auraDice("royalAuraDice"):setAmount(3), Items.box("potionsChest"):setAmount(3), Items.box("fruitsChest"):setAmount(3), Items.upgrade("auraLuck"):setAmount(3)};
	}, {
		name = "Roller XIII";
		amount = 25000;
		rewards = {Items.auraDice("insaneAuraDice"):setAmount(1), Items.auraDice("royalAuraDice"):setAmount(10), Items.auraDice("voidAuraDice"):setAmount(100), Items.upgrade("auraLuck"):setAmount(4)};
	}};
}
local function getValue(arg1) -- Line 435
	return arg1.stats.auraRolls
end
tbl_2.getValue = getValue
local function getDescription(arg1) -- Line 438
	return `Roll auras {arg1} times!`
end
tbl_2.getDescription = getDescription
local function getProgress(arg1) -- Line 441
	--[[ Upvalues[1]:
		[1]: Functions_upvr (readonly)
	]]
	return Functions_upvr.suffixes(arg1)
end
tbl_2.getProgress = getProgress
module.auraRolls = tbl_2
local tbl = {
	icon = "rbxassetid://123906714289896";
	iconSize = UDim2.new(0.216, 0, 1.017, 0);
	layoutOrder = 4;
	list = {{
		name = "Time Played I";
		amount = 600;
		rewards = {Items.potion("clicks"):setAmount(1)};
	}, {
		name = "Time Played II";
		amount = 1800;
		rewards = {Items.potion("luck"):setAmount(1), Items.potion("gems"):setAmount(1)};
	}, {
		name = "Time Played III";
		amount = 3600;
		rewards = {Items.box("fruitsBox"):setAmount(1)};
	}, {
		name = "Time Played IV";
		amount = 10800;
		rewards = {Items.box("potionsBox"):setAmount(1), Items.potion("luck"):setAmount(1), Items.potion("hatch"):setAmount(1)};
	}, {
		name = "Time Played V";
		amount = 21600;
		rewards = {Items.auraDice("voidAuraDice"):setAmount(1), Items.box("potionsBox"):setAmount(1), Items.box("fruitsBox"):setAmount(1)};
	}, {
		name = "Time Played VI";
		amount = 86400;
		rewards = {Items.box("potionsBox"):setAmount(3), Items.box("fruitsBox"):setAmount(3), Items.upgrade("clicksMultiplier"):setAmount(0.05)};
	}, {
		name = "Time Played VII";
		amount = 259200;
		rewards = {Items.box("potionsChest"):setAmount(1), Items.box("fruitsChest"):setAmount(1), Items.upgrade("gemsMultiplier"):setAmount(0.05), Items.booth("cookieBooth"):setAmount(1)};
	}, {
		name = "Time Played VIII";
		amount = 604800;
		rewards = {Items.auraDice("royalAuraDice"):setAmount(1), Items.box("potionsChest"):setAmount(3), Items.box("fruitsChest"):setAmount(3), Items.upgrade("luckMultiplier"):setAmount(0.05)};
	}, {
		name = "Time Played IX";
		amount = 1209600;
		rewards = {Items.auraDice("royalAuraDice"):setAmount(3), Items.box("potionsChest"):setAmount(5), Items.box("fruitsChest"):setAmount(5), Items.upgrade("petsEquipped"):setAmount(1)};
	}};
}
local function getValue(arg1) -- Line 542
	return arg1.stats.timePlayed
end
tbl.getValue = getValue
local function getDescription(arg1) -- Line 545
	return `Play for {arg1}!`
end
tbl.getDescription = getDescription
local function getProgress(arg1) -- Line 548
	--[[ Upvalues[1]:
		[1]: Functions_upvr (readonly)
	]]
	return Functions_upvr.formatTime2(arg1)
end
tbl.getProgress = getProgress
module.timePlayed = tbl
local tbl_5 = {
	icon = "rbxassetid://138618112920990";
	iconSize = UDim2.new(0.165, 0, 0.777, 0);
	layoutOrder = 5;
	list = {{
		name = "Rewarder I";
		amount = 6;
		rewards = {Items.potion("luck"):setAmount(1), Items.potion("clicks"):setAmount(1)};
	}, {
		name = "Rewarder II";
		amount = 12;
		rewards = {Items.potion("clicks"):setAmount(1), Items.potion("luck"):setAmount(1), Items.potion("hatch"):setAmount(1)};
	}, {
		name = "Rewarder III";
		amount = 24;
		rewards = {Items.potion("megaLuck"):setAmount(1), Items.potion("megaClicks"):setAmount(1), Items.potion("megaGems"):setAmount(1)};
	}, {
		name = "Rewarder IV";
		amount = 50;
		rewards = {Items.box("potionsBox"):setAmount(1), Items.box("fruitsBox"):setAmount(1)};
	}, {
		name = "Rewarder V";
		amount = 100;
		rewards = {Items.box("potionsBox"):setAmount(3), Items.box("fruitsBox"):setAmount(3), Items.auraDice("voidAuraDice"):setAmount(1)};
	}, {
		name = "Rewarder VI";
		amount = 250;
		rewards = {Items.auraDice("voidAuraDice"):setAmount(3), Items.box("potionsBox"):setAmount(5), Items.box("fruitsBox"):setAmount(5), Items.booth("partyBooth"):setAmount(1)};
	}, {
		name = "Rewarder VII";
		amount = 500;
		rewards = {Items.auraDice("royalAuraDice"):setAmount(1), Items.box("potionsChest"):setAmount(2), Items.box("fruitsChest"):setAmount(2), Items.potion("megaLuck"):setAmount(5)};
	}};
}
local function getValue(arg1) -- Line 631
	return arg1.stats.playtimeRewards
end
tbl_5.getValue = getValue
local function getDescription(arg1) -- Line 634
	return `Claim {arg1} playtime rewards!`
end
tbl_5.getDescription = getDescription
local function getProgress(arg1) -- Line 637
	--[[ Upvalues[1]:
		[1]: Functions_upvr (readonly)
	]]
	return Functions_upvr.suffixes(arg1)
end
tbl_5.getProgress = getProgress
module.playtimeRewards = tbl_5
local tbl_4 = {
	icon = "rbxassetid://78026189597998";
	iconSize = UDim2.new(0.186, 0, 0.875, 0);
	layoutOrder = 6;
	list = {{
		name = "Collector I";
		amount = 10;
		rewards = {Items.fruit("carrot"):setAmount(1), Items.fruit("apple"):setAmount(1)};
	}, {
		name = "Collector II";
		amount = 25;
		rewards = {Items.fruit("carrot"):setAmount(3), Items.fruit("apple"):setAmount(3), Items.fruit("grape"):setAmount(3)};
	}, {
		name = "Collector III";
		amount = 50;
		rewards = {Items.box("fruitsBox"):setAmount(1), Items.fruit("goldenCarrot"):setAmount(1), Items.fruit("goldenStrawberry"):setAmount(1)};
	}, {
		name = "Collector IV";
		amount = 100;
		rewards = {Items.box("fruitsChest"):setAmount(1)};
	}, {
		name = "Collector V";
		amount = 250;
		rewards = {Items.box("fruitsChest"):setAmount(1), Items.box("fruitsBox"):setAmount(3)};
	}, {
		name = "Collector VI";
		amount = 500;
		rewards = {Items.box("fruitsChest"):setAmount(2), Items.box("fruitsBox"):setAmount(5)};
	}, {
		name = "Collector VII";
		amount = 1000;
		rewards = {Items.box("fruitsChest"):setAmount(3), Items.box("fruitsBox"):setAmount(10), Items.booth("farmBooth"):setAmount(1)};
	}, {
		name = "Collector VIII";
		amount = 2500;
		rewards = {Items.fruit("apple"):setAmount(99), Items.fruit("carrot"):setAmount(99), Items.fruit("grape"):setAmount(99), Items.fruit("strawberry"):setAmount(99)};
	}, {
		name = "Collector IX";
		amount = 5000;
		rewards = {Items.fruit("goldenCarrot"):setAmount(5), Items.fruit("goldenStrawberry"):setAmount(5), Items.box("fruitsChest"):setAmount(5)};
	}, {
		name = "Collector X";
		amount = 10000;
		rewards = {Items.box("fruitsChest"):setAmount(10), Items.box("fruitsBox"):setAmount(10), Items.box("potionsChest"):setAmount(10), Items.box("potionsBox"):setAmount(10)};
	}};
}
local function getValue(arg1) -- Line 747
	return arg1.stats.fruitsCollected
end
tbl_4.getValue = getValue
local function getDescription(arg1) -- Line 750
	return `Collect {arg1} fruits!`
end
tbl_4.getDescription = getDescription
local function getProgress(arg1) -- Line 753
	--[[ Upvalues[1]:
		[1]: Functions_upvr (readonly)
	]]
	return Functions_upvr.suffixes(arg1)
end
tbl_4.getProgress = getProgress
module.fruitsCollected = tbl_4
local tbl_6 = {
	icon = "rbxassetid://109457578332297";
	iconSize = UDim2.new(0.165, 0, 0.777, 0);
	layoutOrder = 7;
	list = {{
		name = "Destroyer I";
		amount = 5;
		rewards = {Items.exclusive("ancientTicket"):setAmount(5), Items.potion("luck"):setAmount(1)};
	}, {
		name = "Destroyer II";
		amount = 15;
		rewards = {Items.potion("luck"):setAmount(2), Items.potion("clicks"):setAmount(2), Items.potion("gems"):setAmount(2)};
	}, {
		name = "Destroyer III";
		amount = 30;
		rewards = {Items.potion("luck"):setAmount(3), Items.potion("megaLuck"):setAmount(1), Items.potion("hatch"):setAmount(2)};
	}, {
		name = "Destroyer IV";
		amount = 75;
		rewards = {Items.exclusive("ancientTicket"):setAmount(15), Items.box("potionsBox"):setAmount(1), Items.box("fruitsBox"):setAmount(1)};
	}, {
		name = "Destroyer V";
		amount = 150;
		rewards = {Items.exclusive("epicLuck"):setAmount(1), Items.box("potionsBox"):setAmount(3), Items.box("fruitsBox"):setAmount(3)};
	}, {
		name = "Destroyer VI";
		amount = 250;
		rewards = {Items.exclusive("ancientTicket"):setAmount(25), Items.box("potionsBox"):setAmount(5), Items.box("fruitsBox"):setAmount(5)};
	}, {
		name = "Destroyer VII";
		amount = 500;
		rewards = {Items.exclusive("epicLuck"):setAmount(1), Items.box("potionsBox"):setAmount(5), Items.upgrade("luckMultiplier"):setAmount(0.02), Items.booth("hackerBooth"):setAmount(1)};
	}, {
		name = "Destroyer VIII";
		amount = 1000;
		rewards = {Items.exclusive("epicLuck"):setAmount(2), Items.box("potionsChest"):setAmount(2), Items.box("fruitsChest"):setAmount(2), Items.upgrade("luckMultiplier"):setAmount(0.03)};
	}};
}
function tbl_6.getValue(arg1) -- Line 846
	return arg1.stats.treesDestroyed
end
function tbl_6.getDescription(arg1) -- Line 849
	return `Destroy {arg1} trees!`
end
function tbl_6.getProgress(arg1) -- Line 852
	--[[ Upvalues[1]:
		[1]: Functions_upvr (readonly)
	]]
	return Functions_upvr.suffixes(arg1)
end
module.treesDestroyed = tbl_6
return module