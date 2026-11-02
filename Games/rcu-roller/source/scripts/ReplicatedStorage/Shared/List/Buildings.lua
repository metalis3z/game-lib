-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:18:18
-- Luau version 6, Types version 3
-- Time taken: 0.001585 seconds

local Items = require(game:GetService("ReplicatedStorage").Shared.Items)
return {
	axesUpgraderFrame = {
		name = "Axe Upgrader";
		required = {Items.mapItem("wood"):setAmount(3)};
	};
	kingdomChest = {
		name = "Kingdom Chest";
		previousBuilding = "axesUpgraderFrame";
		required = {Items.mapItem("cactusWood"):setAmount(30), Items.mapItem("nuclearWood"):setAmount(25), Items.mapItem("underwaterWood"):setAmount(15), Items.mapItem("royalWood"):setAmount(5)};
	};
	woodenBridge = {
		name = "Wooden Bridge";
		required = {Items.mapItem("wood"):setAmount(25), Items.mapItem("underwaterWood"):setAmount(15), Items.mapItem("royalWood"):setAmount(10)};
	};
	lightSwitch1 = {
		name = "Light Switch #1";
		required = {Items.mapItem("wood"):setAmount(30), Items.fruit("apple"):setAmount(5), Items.fruit("grape"):setAmount(5)};
		hasProximity = true;
	};
	lightSwitch2 = {
		name = "Light Switch #2";
		required = {Items.mapItem("cactusWood"):setAmount(25), Items.exclusive("ancientTicket"):setAmount(3)};
		hasProximity = true;
	};
	lightSwitch3 = {
		name = "Light Switch #3";
		required = {Items.fruit("carrot"):setAmount(3), Items.fruit("grape"):setAmount(3), Items.mapItem("nuclearWood"):setAmount(25)};
		hasProximity = true;
	};
	lightSwitch4 = {
		name = "Light Switch #4";
		required = {Items.mapItem("underwaterWood"):setAmount(25), Items.auraDice("auraDice"):setAmount(3), Items.auraDice("fireAuraDice"):setAmount(1)};
		hasProximity = true;
	};
	lightSwitch5 = {
		name = "Light Switch #5";
		required = {Items.mapItem("royalWood"):setAmount(25), Items.exclusive("ancientTicket"):setAmount(3)};
		hasProximity = true;
	};
	lightSwitch6 = {
		name = "Light Switch #6";
		required = {Items.potion("luck"):setAmount(3), Items.auraDice("auraDice"):setAmount(10), Items.auraDice("magicAuraDice"):setAmount(1), Items.mapItem("wood"):setAmount(50)};
		hasProximity = true;
	};
}