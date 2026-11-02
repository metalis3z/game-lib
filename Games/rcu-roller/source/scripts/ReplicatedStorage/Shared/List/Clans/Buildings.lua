-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:19:00
-- Luau version 6, Types version 3
-- Time taken: 0.009002 seconds

local Items = require(game:GetService("ReplicatedStorage").Shared.Items)
return {
	clanSeat1 = {
		name = "Clan Seat 1";
		required = {Items.mapItem("wood"):setAmount(100)};
		hasProximity = true;
	};
	clanSeat2 = {
		name = "Clan Seat 2";
		required = {Items.mapItem("wood"):setAmount(100), Items.mapItem("cactusWood"):setAmount(100), Items.mapItem("nuclearWood"):setAmount(100)};
		hasProximity = true;
	};
	clanSeat3 = {
		name = "Clan Seat 3";
		required = {Items.mapItem("cactusWood"):setAmount(100), Items.mapItem("nuclearWood"):setAmount(100), Items.mapItem("underwaterWood"):setAmount(100), Items.mapItem("royalWood"):setAmount(100)};
		hasProximity = true;
	};
	clanSeat4 = {
		name = "Clan Seat 4";
		required = {Items.mapItem("cactusWood"):setAmount(150), Items.mapItem("nuclearWood"):setAmount(150), Items.mapItem("underwaterWood"):setAmount(150), Items.mapItem("royalWood"):setAmount(150)};
		hasProximity = true;
	};
	clanSeat5 = {
		name = "Clan Seat 5";
		required = {Items.mapItem("nuclearWood"):setAmount(200), Items.mapItem("underwaterWood"):setAmount(200), Items.mapItem("royalWood"):setAmount(200), Items.mapItem("hackerWood"):setAmount(200)};
		hasProximity = true;
	};
	clanSeat6 = {
		name = "Clan Seat 6";
		required = {Items.mapItem("nuclearWood"):setAmount(300), Items.mapItem("underwaterWood"):setAmount(300), Items.mapItem("royalWood"):setAmount(300), Items.mapItem("hackerWood"):setAmount(300)};
		hasProximity = true;
	};
	clanSeat7 = {
		name = "Clan Seat 7";
		required = {Items.mapItem("wood"):setAmount(500), Items.mapItem("cactusWood"):setAmount(500), Items.mapItem("nuclearWood"):setAmount(500), Items.mapItem("underwaterWood"):setAmount(500), Items.mapItem("royalWood"):setAmount(300), Items.mapItem("hackerWood"):setAmount(250)};
		hasProximity = true;
	};
	clanSeat8 = {
		name = "Clan Seat 8";
		required = {Items.mapItem("wood"):setAmount(750), Items.mapItem("cactusWood"):setAmount(750), Items.mapItem("nuclearWood"):setAmount(750), Items.mapItem("underwaterWood"):setAmount(750), Items.mapItem("royalWood"):setAmount(500), Items.mapItem("hackerWood"):setAmount(300)};
		hasProximity = true;
	};
	clanSeat9 = {
		name = "Clan Seat 9";
		required = {Items.mapItem("wood"):setAmount(1000), Items.mapItem("cactusWood"):setAmount(1000), Items.mapItem("nuclearWood"):setAmount(1000), Items.mapItem("underwaterWood"):setAmount(1000), Items.mapItem("royalWood"):setAmount(750), Items.mapItem("hackerWood"):setAmount(500), Items.exclusive("ancientTicket"):setAmount(25), Items.fruit("apple"):setAmount(25)};
		hasProximity = true;
	};
	clanSeat10 = {
		name = "Clan Seat 10";
		required = {Items.mapItem("wood"):setAmount(1000), Items.mapItem("cactusWood"):setAmount(1000), Items.mapItem("nuclearWood"):setAmount(1000), Items.mapItem("underwaterWood"):setAmount(1000), Items.mapItem("royalWood"):setAmount(1000), Items.mapItem("hackerWood"):setAmount(1000), Items.fruit("grape"):setAmount(75), Items.fruit("pineapple"):setAmount(75)};
		hasProximity = true;
	};
	clanSeat11 = {
		name = "Clan Seat 11";
		required = {Items.mapItem("wood"):setAmount(1500), Items.mapItem("cactusWood"):setAmount(1500), Items.mapItem("nuclearWood"):setAmount(1500), Items.mapItem("underwaterWood"):setAmount(1500), Items.mapItem("royalWood"):setAmount(1500), Items.mapItem("hackerWood"):setAmount(1500), Items.fruit("goldenApple"):setAmount(10), Items.fruit("goldenCarrot"):setAmount(10)};
		hasProximity = true;
	};
	clanSeat12 = {
		name = "Clan Seat 12";
		required = {Items.mapItem("wood"):setAmount(2500), Items.mapItem("cactusWood"):setAmount(2500), Items.mapItem("nuclearWood"):setAmount(2500), Items.mapItem("underwaterWood"):setAmount(2500), Items.mapItem("royalWood"):setAmount(2500), Items.mapItem("hackerWood"):setAmount(2500), Items.potion("megaLuck"):setAmount(10), Items.potion("megaClicks"):setAmount(10)};
		hasProximity = true;
	};
	clanDecoration1 = {
		name = "Castle Decoration #1";
		required = {Items.mapItem("wood"):setAmount(250), Items.mapItem("cactusWood"):setAmount(250), Items.mapItem("nuclearWood"):setAmount(250)};
		upgrade = {Items.upgrade("clicksMultiplier"):setAmount(0.05)};
		hasProximity = true;
	};
	clanDecoration2 = {
		name = "Castle Decoration #2";
		required = {Items.mapItem("nuclearWood"):setAmount(250), Items.mapItem("underwaterWood"):setAmount(250), Items.mapItem("royalWood"):setAmount(250)};
		upgrade = {Items.upgrade("auraLuck"):setAmount(0.05)};
		hasProximity = true;
	};
	clanDecoration3 = {
		name = "Castle Decoration #3";
		required = {Items.mapItem("underwaterWood"):setAmount(250), Items.mapItem("royalWood"):setAmount(250), Items.mapItem("hackerWood"):setAmount(250)};
		upgrade = {Items.upgrade("gemsMultiplier"):setAmount(0.05)};
		hasProximity = true;
	};
	clanDecoration4 = {
		name = "Castle Decoration #4";
		required = {Items.mapItem("wood"):setAmount(333), Items.fruit("goldenApple"):setAmount(5), Items.fruit("goldenCarrot"):setAmount(5), Items.potion("clicks"):setAmount(15), Items.potion("gems"):setAmount(15), Items.potion("rngLuck"):setAmount(15)};
		upgrade = {Items.upgrade("clicksMultiplier"):setAmount(0.05)};
		hasProximity = true;
	};
	clanDecoration5 = {
		name = "Castle Decoration #5";
		required = {Items.auraDice("auraDice"):setAmount(250), Items.auraDice("fireAuraDice"):setAmount(50), Items.auraDice("magicAuraDice"):setAmount(15), Items.auraDice("voidAuraDice"):setAmount(5)};
		upgrade = {Items.upgrade("luckMultiplier"):setAmount(0.03)};
		hasProximity = true;
	};
	clanRewardsUnlock = {
		name = "Clan Rewards Room";
		required = {Items.potion("clicks"):setAmount(25), Items.potion("gems"):setAmount(25), Items.potion("luck"):setAmount(25), Items.potion("hatch"):setAmount(25), Items.fruit("apple"):setAmount(25), Items.fruit("carrot"):setAmount(25), Items.fruit("grape"):setAmount(25), Items.fruit("strawberry"):setAmount(25)};
		hasProximity = true;
	};
	clanUpgradesUnlock = {
		name = "Clan Upgrades Room";
		required = {Items.mapItem("wood"):setAmount(500), Items.mapItem("cactusWood"):setAmount(500), Items.mapItem("nuclearWood"):setAmount(500), Items.mapItem("underwaterWood"):setAmount(500), Items.mapItem("royalWood"):setAmount(500)};
		hasProximity = true;
	};
	clanSpin = {
		name = "Clan Spin Wheel";
		previousBuilding = "clanRewardsUnlock";
		required = {Items.mapItem("wood"):setAmount(2500), Items.mapItem("cactusWood"):setAmount(2500), Items.mapItem("nuclearWood"):setAmount(2500), Items.mapItem("underwaterWood"):setAmount(2500), Items.auraDice("fireAuraDice"):setAmount(100), Items.auraDice("magicAuraDice"):setAmount(25), Items.exclusive("ancientTicket"):setAmount(100)};
	};
	clanChest = {
		name = "Clan Chest";
		previousBuilding = "clanRewardsUnlock";
		required = {Items.potion("clicks"):setAmount(100), Items.potion("gems"):setAmount(100), Items.potion("luck"):setAmount(100), Items.potion("rngLuck"):setAmount(100), Items.potion("hatch"):setAmount(100), Items.potion("megaClicks"):setAmount(25), Items.potion("megaGems"):setAmount(25), Items.potion("megaLuck"):setAmount(25)};
	};
	clanDiamonds = {
		name = "Diamonds (+5% Hatch Speed)";
		previousBuilding = "clanUpgradesUnlock";
		required = {Items.potion("hatch"):setAmount(50), Items.fruit("strawberry"):setAmount(150), Items.fruit("goldenStrawberry"):setAmount(15), Items.auraDice("voidAuraDice"):setAmount(10), Items.mapItem("nuclearWood"):setAmount(500), Items.exclusive("ancientTicket"):setAmount(100)};
		upgrade = {Items.upgrade("hatchSpeed"):setAmount(0.05)};
		hasProximity = true;
	};
	clanDiamondsBox = {
		name = "Diamonds Box (+1% Golden Pets Luck)";
		previousBuilding = "clanUpgradesUnlock";
		required = {Items.potion("golden"):setAmount(10), Items.fruit("goldenApple"):setAmount(10), Items.fruit("goldenCarrot"):setAmount(10), Items.fruit("goldenGrape"):setAmount(10), Items.fruit("goldenStrawberry"):setAmount(10), Items.fruit("goldenPineapple"):setAmount(10), Items.activeEvent("goldenStar"):setAmount(50)};
		upgrade = {Items.upgrade("goldenPetsLuck"):setAmount(1)};
		hasProximity = true;
	};
	clanDiamondsBarrel = {
		name = "Diamonds Barrel (+0.25% Shiny Pets Luck)";
		previousBuilding = "clanUpgradesUnlock";
		required = {Items.mapItem("wood"):setAmount(1000), Items.mapItem("cactusWood"):setAmount(500), Items.mapItem("nuclearWood"):setAmount(250), Items.potion("shiny"):setAmount(20), Items.auraDice("magicAuraDice"):setAmount(50), Items.auraDice("voidAuraDice"):setAmount(15), Items.auraDice("royalAuraDice"):setAmount(1)};
		upgrade = {Items.upgrade("shinyPetsLuck"):setAmount(0.25)};
		hasProximity = true;
	};
	clanDiamondsChest = {
		name = "Diamonds Chest (+0.1% Toxic Pets Luck)";
		previousBuilding = "clanUpgradesUnlock";
		required = {Items.potion("toxic"):setAmount(10), Items.exclusive("ancientTicket"):setAmount(222), Items.auraDice("auraDice"):setAmount(250), Items.mapItem("wood"):setAmount(1000), Items.mapItem("cactusWood"):setAmount(1000), Items.mapItem("nuclearWood"):setAmount(1000), Items.mapItem("underwaterWood"):setAmount(1000), Items.mapItem("royalWood"):setAmount(1000)};
		upgrade = {Items.upgrade("toxicPetsLuck"):setAmount(0.1)};
		hasProximity = true;
	};
	clanEmeralds = {
		name = "Emeralds (+3% Luck)";
		previousBuilding = "clanUpgradesUnlock";
		required = {Items.potion("luck"):setAmount(100), Items.potion("megaLuck"):setAmount(25), Items.fruit("carrot"):setAmount(100), Items.fruit("goldenCarrot"):setAmount(25), Items.activeEvent("luckyStar"):setAmount(100), Items.activeEvent("megaLuckyStar"):setAmount(25), Items.auraDice("royalAuraDice"):setAmount(1)};
		upgrade = {Items.upgrade("luckMultiplier"):setAmount(0.03)};
		hasProximity = true;
	};
	clanEmeraldsBox = {
		name = "Emeralds Box (+3% Luck)";
		previousBuilding = "clanUpgradesUnlock";
		required = {Items.mapItem("wood"):setAmount(5000), Items.mapItem("cactusWood"):setAmount(2500), Items.mapItem("nuclearWood"):setAmount(2500), Items.mapItem("underwaterWood"):setAmount(2500), Items.mapItem("royalWood"):setAmount(3000)};
		upgrade = {Items.upgrade("luckMultiplier"):setAmount(0.03)};
		hasProximity = true;
	};
	clanEmeraldsChest = {
		name = "Emeralds Chest (+3% Luck)";
		previousBuilding = "clanUpgradesUnlock";
		required = {Items.potion("luck"):setAmount(300), Items.potion("megaLuck"):setAmount(50), Items.fruit("carrot"):setAmount(300), Items.fruit("goldenCarrot"):setAmount(50), Items.activeEvent("luckyStar"):setAmount(250), Items.activeEvent("megaLuckyStar"):setAmount(50), Items.auraDice("voidAuraDice"):setAmount(50)};
		upgrade = {Items.upgrade("luckMultiplier"):setAmount(0.03)};
		hasProximity = true;
	};
	clanEmeraldsVault = {
		name = "Emeralds Vault (+5% Luck)";
		previousBuilding = "clanUpgradesUnlock";
		required = {Items.mapItem("wood"):setAmount(10000), Items.mapItem("cactusWood"):setAmount(7500), Items.mapItem("nuclearWood"):setAmount(7500), Items.mapItem("underwaterWood"):setAmount(5000), Items.mapItem("royalWood"):setAmount(5000), Items.mapItem("hackerWood"):setAmount(5000)};
		upgrade = {Items.upgrade("luckMultiplier"):setAmount(0.05)};
		hasProximity = true;
	};
	clanGems = {
		name = "Gems (+5% Gems)";
		previousBuilding = "clanUpgradesUnlock";
		required = {Items.mapItem("wood"):setAmount(500), Items.mapItem("cactusWood"):setAmount(500), Items.mapItem("nuclearWood"):setAmount(500), Items.mapItem("underwaterWood"):setAmount(500), Items.mapItem("royalWood"):setAmount(500), Items.auraDice("fireAuraDice"):setAmount(50), Items.potion("gems"):setAmount(25), Items.potion("megaGems"):setAmount(5)};
		upgrade = {Items.upgrade("gemsMultiplier"):setAmount(0.05)};
		hasProximity = true;
	};
	clanGemsChest = {
		name = "Gems Chest (+15% Gems)";
		previousBuilding = "clanUpgradesUnlock";
		required = {Items.potion("gems"):setAmount(300), Items.potion("megaGems"):setAmount(50), Items.fruit("grape"):setAmount(300), Items.fruit("goldenGrape"):setAmount(50), Items.activeEvent("gemStar"):setAmount(200), Items.auraDice("fireAuraDice"):setAmount(250), Items.exclusive("ancientTicket"):setAmount(250)};
		upgrade = {Items.upgrade("gemsMultiplier"):setAmount(0.15)};
		hasProximity = true;
	};
	clanRuby = {
		name = "Ruby (+25% RNG Luck)";
		previousBuilding = "clanUpgradesUnlock";
		required = {Items.potion("rngLuck"):setAmount(100), Items.auraDice("auraDice"):setAmount(2500), Items.auraDice("fireAuraDice"):setAmount(1000), Items.auraDice("magicAuraDice"):setAmount(250), Items.auraDice("voidAuraDice"):setAmount(25), Items.auraDice("royalAuraDice"):setAmount(5)};
		upgrade = {Items.upgrade("auraLuck"):setAmount(0.25)};
		hasProximity = true;
	};
	clanRubyChest = {
		name = "Ruby Chest (+10% Clicks)";
		previousBuilding = "clanUpgradesUnlock";
		required = {Items.mapItem("wood"):setAmount(1000), Items.potion("clicks"):setAmount(200), Items.potion("megaClicks"):setAmount(30), Items.fruit("apple"):setAmount(300), Items.fruit("goldenApple"):setAmount(50), Items.activeEvent("clickStar"):setAmount(200), Items.exclusive("ancientTicket"):setAmount(250)};
		upgrade = {Items.upgrade("clicksMultiplier"):setAmount(0.1)};
		hasProximity = true;
	};
	clanRubyVault = {
		name = "Ruby Vault (+1 Pets Equipped)";
		previousBuilding = "clanUpgradesUnlock";
		required = {Items.mapItem("wood"):setAmount(25000), Items.mapItem("cactusWood"):setAmount(25000), Items.mapItem("nuclearWood"):setAmount(25000), Items.mapItem("underwaterWood"):setAmount(25000), Items.mapItem("royalWood"):setAmount(25000), Items.mapItem("hackerWood"):setAmount(25000)};
		upgrade = {Items.upgrade("petsEquipped"):setAmount(1)};
		hasProximity = true;
	};
}