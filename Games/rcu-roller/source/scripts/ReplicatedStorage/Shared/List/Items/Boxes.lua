-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:18:43
-- Luau version 6, Types version 3
-- Time taken: 0.007045 seconds

local Items = require(game:GetService("ReplicatedStorage").Shared.Items)
return {
	potionsBox = {
		name = "Potions Box";
		description = "Contains potions to speed up your progress!";
		icon = "rbxassetid://87619812452695";
		rarity = "Legendary";
		layoutOrder = 91;
		rewardAmount = 3;
		rewards = {{
			item = Items.potion("clicks"):setAmount(1);
			chance = 20;
		}, {
			item = Items.potion("gems"):setAmount(1);
			chance = 20;
		}, {
			item = Items.potion("luck"):setAmount(1);
			chance = 20;
		}, {
			item = Items.potion("rngLuck"):setAmount(1);
			chance = 20;
		}, {
			item = Items.potion("hatch"):setAmount(1);
			chance = 12.5;
		}, {
			item = Items.potion("golden"):setAmount(1);
			chance = 1;
		}, {
			item = Items.potion("toxic"):setAmount(1);
			chance = 1;
		}, {
			item = Items.potion("shiny"):setAmount(1);
			chance = 1;
		}, {
			item = Items.potion("megaClicks"):setAmount(1);
			chance = 1;
		}, {
			item = Items.potion("megaGems"):setAmount(1);
			chance = 1;
		}, {
			item = Items.potion("megaLuck"):setAmount(1);
			chance = 1;
		}, {
			item = Items.box("potionsChest"):setAmount(1);
			chance = 0.5;
		}};
	};
	potionsChest = {
		name = "Potions Chest";
		description = "Contains lots of potions to speed up your progress!";
		icon = "rbxassetid://78925329693904";
		rarity = "Mythical";
		layoutOrder = 81;
		rewardAmount = 5;
		rewards = {{
			item = Items.potion("clicks"):setAmount(5);
			chance = 5;
		}, {
			item = Items.potion("gems"):setAmount(5);
			chance = 5;
		}, {
			item = Items.potion("luck"):setAmount(5);
			chance = 5;
		}, {
			item = Items.potion("rngLuck"):setAmount(5);
			chance = 5;
		}, {
			item = Items.potion("hatch"):setAmount(5);
			chance = 5;
		}, {
			item = Items.potion("clicks"):setAmount(7);
			chance = 5;
		}, {
			item = Items.potion("gems"):setAmount(7);
			chance = 5;
		}, {
			item = Items.potion("luck"):setAmount(7);
			chance = 5;
		}, {
			item = Items.potion("rngLuck"):setAmount(7);
			chance = 5;
		}, {
			item = Items.potion("hatch"):setAmount(5);
			chance = 5;
		}, {
			item = Items.potion("golden"):setAmount(3);
			chance = 4;
		}, {
			item = Items.potion("toxic"):setAmount(3);
			chance = 3;
		}, {
			item = Items.potion("shiny"):setAmount(3);
			chance = 3;
		}, {
			item = Items.potion("megaClicks"):setAmount(3);
			chance = 10;
		}, {
			item = Items.potion("megaGems"):setAmount(3);
			chance = 10;
		}, {
			item = Items.potion("megaLuck"):setAmount(3);
			chance = 10;
		}, {
			item = Items.potion("megaClicks"):setAmount(5);
			chance = 3;
		}, {
			item = Items.potion("megaGems"):setAmount(5);
			chance = 3;
		}, {
			item = Items.potion("megaLuck"):setAmount(5);
			chance = 3;
		}, {
			item = Items.potion("clicks"):setAmount(25);
			chance = 0.1;
		}, {
			item = Items.potion("gems"):setAmount(25);
			chance = 0.1;
		}, {
			item = Items.potion("luck"):setAmount(25);
			chance = 0.1;
		}, {
			item = Items.potion("rngLuck"):setAmount(25);
			chance = 0.1;
		}, {
			item = Items.potion("hatch"):setAmount(25);
			chance = 0.1;
		}, {
			item = Items.potion("megaClicks"):setAmount(10);
			chance = 0.1;
		}, {
			item = Items.potion("megaGems"):setAmount(10);
			chance = 0.1;
		}, {
			item = Items.potion("megaLuck"):setAmount(10);
			chance = 0.1;
		}, {
			item = Items.potion("golden"):setAmount(10);
			chance = 0.1;
		}, {
			item = Items.potion("toxic"):setAmount(10);
			chance = 0.1;
		}, {
			item = Items.potion("shiny"):setAmount(10);
			chance = 0.1;
		}};
	};
	fruitsBox = {
		name = "Fruits Box";
		description = "Contains fruits to speed up your progress!";
		icon = "rbxassetid://136342435099575";
		rarity = "Legendary";
		layoutOrder = 90;
		rewardAmount = 3;
		rewards = {{
			item = Items.fruit("apple"):setAmount(1);
			chance = 15;
		}, {
			item = Items.fruit("carrot"):setAmount(1);
			chance = 15;
		}, {
			item = Items.fruit("grape"):setAmount(1);
			chance = 15;
		}, {
			item = Items.fruit("strawberry"):setAmount(1);
			chance = 15;
		}, {
			item = Items.fruit("pineapple"):setAmount(1);
			chance = 14;
		}, {
			item = Items.fruit("apple"):setAmount(3);
			chance = 4;
		}, {
			item = Items.fruit("carrot"):setAmount(3);
			chance = 4;
		}, {
			item = Items.fruit("grape"):setAmount(3);
			chance = 4;
		}, {
			item = Items.fruit("strawberry"):setAmount(3);
			chance = 4;
		}, {
			item = Items.fruit("pineapple"):setAmount(3);
			chance = 4;
		}, {
			item = Items.fruit("goldenApple"):setAmount(1);
			chance = 1;
		}, {
			item = Items.fruit("goldenCarrot"):setAmount(1);
			chance = 1;
		}, {
			item = Items.fruit("goldenGrape"):setAmount(1);
			chance = 1;
		}, {
			item = Items.fruit("goldenStrawberry"):setAmount(1);
			chance = 1;
		}, {
			item = Items.fruit("goldenPineapple"):setAmount(1);
			chance = 1;
		}, {
			item = Items.fruit("goldenApple"):setAmount(2);
			chance = 0.1;
		}, {
			item = Items.fruit("goldenCarrot"):setAmount(2);
			chance = 0.1;
		}, {
			item = Items.fruit("goldenGrape"):setAmount(2);
			chance = 0.1;
		}, {
			item = Items.fruit("goldenStrawberry"):setAmount(2);
			chance = 0.1;
		}, {
			item = Items.fruit("goldenPineapple"):setAmount(2);
			chance = 0.1;
		}, {
			item = Items.box("fruitsChest"):setAmount(1);
			chance = 0.5;
		}};
	};
	fruitsChest = {
		name = "Fruits Chest";
		description = "Contains lots of fruits to speed up your progress!";
		icon = "rbxassetid://132121735933020";
		rarity = "Mythical";
		layoutOrder = 80;
		rewardAmount = 5;
		rewards = {{
			item = Items.fruit("apple"):setAmount(15);
			chance = 10;
		}, {
			item = Items.fruit("carrot"):setAmount(15);
			chance = 10;
		}, {
			item = Items.fruit("grape"):setAmount(15);
			chance = 10;
		}, {
			item = Items.fruit("strawberry"):setAmount(15);
			chance = 10;
		}, {
			item = Items.fruit("pineapple"):setAmount(15);
			chance = 10;
		}, {
			item = Items.fruit("goldenApple"):setAmount(5);
			chance = 5;
		}, {
			item = Items.fruit("goldenCarrot"):setAmount(5);
			chance = 5;
		}, {
			item = Items.fruit("goldenGrape"):setAmount(5);
			chance = 5;
		}, {
			item = Items.fruit("goldenStrawberry"):setAmount(5);
			chance = 5;
		}, {
			item = Items.fruit("goldenPineapple"):setAmount(5);
			chance = 5;
		}, {
			item = Items.fruit("apple"):setAmount(20);
			chance = 3;
		}, {
			item = Items.fruit("carrot"):setAmount(20);
			chance = 3;
		}, {
			item = Items.fruit("grape"):setAmount(20);
			chance = 3;
		}, {
			item = Items.fruit("strawberry"):setAmount(20);
			chance = 3;
		}, {
			item = Items.fruit("pineapple"):setAmount(20);
			chance = 3;
		}, {
			item = Items.fruit("apple"):setAmount(25);
			chance = 1;
		}, {
			item = Items.fruit("carrot"):setAmount(25);
			chance = 1;
		}, {
			item = Items.fruit("grape"):setAmount(25);
			chance = 1;
		}, {
			item = Items.fruit("strawberry"):setAmount(25);
			chance = 1;
		}, {
			item = Items.fruit("pineapple"):setAmount(25);
			chance = 1;
		}, {
			item = Items.fruit("goldenApple"):setAmount(10);
			chance = 1;
		}, {
			item = Items.fruit("goldenCarrot"):setAmount(10);
			chance = 1;
		}, {
			item = Items.fruit("goldenGrape"):setAmount(10);
			chance = 1;
		}, {
			item = Items.fruit("goldenStrawberry"):setAmount(10);
			chance = 1;
		}, {
			item = Items.fruit("goldenPineapple"):setAmount(10);
			chance = 1;
		}};
	};
	leaderboardsBox = {
		name = "Leaderboard Box";
		description = "Contains rewards for a place on the leaderboard!";
		icon = "rbxassetid://87042216208118";
		rarity = "Exclusive";
		layoutOrder = 2;
		confirm = true;
		rewardAmount = 3;
		rewards = {{
			item = Items.box("fruitsBox"):setAmount(3);
			chance = 12.5;
		}, {
			item = Items.box("potionsBox"):setAmount(3);
			chance = 12.5;
		}, {
			item = Items.box("fruitsBox"):setAmount(5);
			chance = 10;
		}, {
			item = Items.box("potionsBox"):setAmount(5);
			chance = 10;
		}, {
			item = Items.exclusive("ancientTicket"):setAmount(25);
			chance = 10;
		}, {
			item = Items.auraDice("royalAuraDice"):setAmount(3);
			chance = 10;
		}, {
			item = Items.auraDice("royalAuraDice"):setAmount(10);
			chance = 5;
		}, {
			item = Items.auraDice("insaneAuraDice"):setAmount(1);
			chance = 5;
		}, {
			item = Items.box("fruitsBox"):setAmount(7);
			chance = 5;
		}, {
			item = Items.box("potionsBox"):setAmount(7);
			chance = 5;
		}, {
			item = Items.box("fruitsChest"):setAmount(1);
			chance = 5;
		}, {
			item = Items.box("potionsChest"):setAmount(1);
			chance = 5;
		}, {
			item = Items.auraDice("insaneAuraDice"):setAmount(2);
			chance = 1;
		}, {
			item = Items.box("fruitsChest"):setAmount(3);
			chance = 1;
		}, {
			item = Items.box("potionsChest"):setAmount(3);
			chance = 1;
		}, {
			item = Items.exclusive("ancientTicket"):setAmount(25);
			chance = 1;
		}, {
			item = Items.exclusive("tradeTokens"):setAmount(5);
			chance = 1;
		}, {
			item = Items.exclusiveEgg(require(game:GetService("ReplicatedStorage").Shared.Variables).currentExclusiveEgg.name);
			chance = 0.2;
		}, {
			item = Items.mount("magicHoverboard");
			chance = 0.1;
		}, {
			item = Items.exclusive("tradeTokens"):setAmount(100);
			chance = 0.04;
		}, {
			item = Items.box("globalBox");
			chance = 0.02;
		}, {
			item = Items.mount("ufoMount");
			chance = 0.01;
		}};
	};
	globalBox = {
		name = "Global Box";
		description = "Contains extremely rare global items!";
		icon = "rbxassetid://140553390961815";
		rarity = "Ultimate";
		layoutOrder = 1;
		confirm = true;
		rewardAmount = 1;
		rewards = {{
			item = Items.exclusive("globalLuck");
			chance = 33;
		}, {
			item = Items.exclusive("globalLuckyEgg");
			chance = 33;
		}, {
			item = Items.exclusive("globalStarEvent");
			chance = 33;
		}};
	};
}