-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:18:03
-- Luau version 6, Types version 3
-- Time taken: 0.001750 seconds

local Items = require(game:GetService("ReplicatedStorage").Shared.Items)
return {{
	required = 5;
	rewards = {Items.potion("clicks"):setAmount(1), Items.potion("luck"):setAmount(1)};
}, {
	required = 10;
	rewards = {Items.potion("clicks"):setAmount(1), Items.potion("luck"):setAmount(1), Items.potion("hatch"):setAmount(1)};
}, {
	required = 15;
	rewards = {Items.potion("gems"):setAmount(1), Items.potion("luck"):setAmount(1), Items.potion("golden"):setAmount(1)};
}, {
	required = 20;
	rewards = {Items.potion("luck"):setAmount(1), Items.potion("hatch"):setAmount(1), Items.box("fruitsBox"):setAmount(1)};
}, {
	required = 30;
	rewards = {Items.potion("luck"):setAmount(3), Items.potion("hatch"):setAmount(3), Items.box("potionsBox"):setAmount(1), Items.box("fruitsBox"):setAmount(1)};
}, {
	required = 50;
	rewards = {Items.upgrade("luckMultiplier"):setAmount(0.05), Items.auraDice("voidAuraDice"):setAmount(1), Items.exclusive("ancientTicket"):setAmount(15), Items.box("potionsBox"):setAmount(2)};
}, {
	required = 75;
	rewards = {Items.upgrade("clicksMultiplier"):setAmount(0.05), Items.box("potionsBox"):setAmount(5), Items.box("fruitsBox"):setAmount(5), Items.potion("megaLuck"):setAmount(3)};
}, {
	required = 100;
	rewards = {Items.upgrade("petsEquipped"):setAmount(1), Items.box("potionsChest"):setAmount(1), Items.box("fruitsChest"):setAmount(1), Items.upgrade("luckMultiplier"):setAmount(0.05)};
}, {
	required = 125;
	rewards = {Items.potion("hatch"):setAmount(10), Items.potion("megaLuck"):setAmount(10), Items.box("potionsChest"):setAmount(1), Items.box("fruitsChest"):setAmount(1)};
}, {
	required = 150;
	rewards = {Items.upgrade("luckMultiplier"):setAmount(0.05), Items.upgrade("hatchSpeed"):setAmount(0.05), Items.box("potionsChest"):setAmount(3), Items.box("fruitsChest"):setAmount(3)};
}}