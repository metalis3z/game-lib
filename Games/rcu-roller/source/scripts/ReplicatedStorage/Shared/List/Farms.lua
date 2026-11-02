-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:18:10
-- Luau version 6, Types version 3
-- Time taken: 0.004102 seconds

local Items = require(game:GetService("ReplicatedStorage").Shared.Items)
return {
	farmer = {
		farmIcon = "rbxassetid://78026189597998";
		farmBackgroundColor = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 251, 234))});
		items = 3;
		isNotFarm = true;
		upgrades = {{
			title = "Farmer";
			description = "Collects 2 items per hour!";
			upgrade = "farmerItems";
			amount = 2;
			price = 5000;
		}, {
			title = "Better Farmer";
			description = "Collects 3 items per hour!";
			upgrade = "farmerItems";
			amount = 3;
			price = 50000;
		}, {
			title = "Advanced Farmer";
			description = "Collects 4 items per hour!";
			upgrade = "farmerItems";
			amount = 4;
			price = 250000;
		}, {
			title = "Epic Farmer";
			description = "Collects 5 items per hour!";
			upgrade = "farmerItems";
			amount = 5;
			price = 1000000;
		}, {
			title = "Pro Farmer";
			description = "Collects 7 items per hour!";
			upgrade = "farmerItems";
			amount = 7;
			price = 6000000;
		}, {
			title = "Ultra Farmer";
			description = "Collects 8 items per hour!";
			upgrade = "farmerItems";
			amount = 8;
			price = 25000000;
		}, {
			title = "Master Farmer";
			description = "Collects 10 items per hour!";
			upgrade = "farmerItems";
			amount = 10;
			price = 100000000;
		}, {
			title = "Mega Farmer";
			description = "Collects 12 items per hour!";
			upgrade = "farmerItems";
			amount = 12;
			price = 250000000;
		}, {
			title = "Hyper Farmer";
			description = "Collects 14 items per hour!";
			upgrade = "farmerItems";
			amount = 14;
			price = 1000000000;
		}};
	};
	appleFarm = {
		farmIcon = "rbxassetid://127009104608227";
		farmBackgroundColor = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 237, 237))});
		price = 2500;
		items = 1;
		cooldown = 1800;
		item = Items.fruit("apple");
		goldenItem = Items.fruit("goldenApple");
		upgrades = {{
			title = "Extra Apples";
			description = "Get 2 apples per collect!";
			upgrade = "moreItems";
			amount = 2;
			price = 15000;
		}, {
			title = "Better Cooldown";
			description = "Your farm grows faster!";
			upgrade = "cooldown";
			amount = 1500;
			price = 50000;
		}, {
			title = "MORE Apples";
			description = "Get 4 Apples per collect!";
			upgrade = "moreItems";
			amount = 4;
			price = 750000;
		}, {
			title = "Golden Apples";
			description = "Unlock a chance to get a golden apple!";
			upgrade = "goldenLuck";
			amount = 3;
			price = 2500000;
		}, {
			title = "Apple Cloner";
			description = "There is a small chance that your farm will drop double items!";
			upgrade = "doubleItems";
			amount = 1;
			price = 15000000;
		}, {
			title = "Golden Apples II";
			description = "Better chance to get a golden apple!";
			upgrade = "goldenLuck";
			amount = 7;
			price = 100000000;
		}};
	};
	carrotFarm = {
		farmIcon = "rbxassetid://116638006194935";
		farmBackgroundColor = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 245, 226))});
		price = 15000;
		items = 1;
		cooldown = 1800;
		item = Items.fruit("carrot");
		goldenItem = Items.fruit("goldenCarrot");
		upgrades = {{
			title = "Extra Carrots";
			description = "Get 2 carrots per collect!";
			upgrade = "moreItems";
			amount = 2;
			price = 125000;
		}, {
			title = "Better Cooldown";
			description = "Your farm grows faster!";
			upgrade = "cooldown";
			amount = 1500;
			price = 500000;
		}, {
			title = "Extra Carrots";
			description = "Get 3 carrots per collect!";
			upgrade = "moreItems";
			amount = 3;
			price = 1000000;
		}, {
			title = "Golden Carrots";
			description = "Unlock a chance to get a golden carrot!";
			upgrade = "goldenLuck";
			amount = 3;
			price = 10000000;
		}, {
			title = "Carrots Cloner";
			description = "There is a small chance that your farm will drop double items!";
			upgrade = "doubleItems";
			amount = 1;
			price = 50000000;
		}, {
			title = "Extra Carrots";
			description = "Get 4 carrots per collect!";
			upgrade = "moreItems";
			amount = 4;
			price = 125000000;
		}};
	};
	grapeFarm = {
		farmIcon = "rbxassetid://110498742169341";
		farmBackgroundColor = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(246, 224, 255))});
		price = 100000;
		items = 1;
		cooldown = 1800;
		item = Items.fruit("grape");
		goldenItem = Items.fruit("goldenGrape");
		upgrades = {{
			title = "Extra Grapes";
			description = "Get 2 grapes per collect!";
			upgrade = "moreItems";
			amount = 2;
			price = 250000;
		}, {
			title = "Better Cooldown";
			description = "Your farm grows faster!";
			upgrade = "cooldown";
			amount = 1500;
			price = 800000;
		}, {
			title = "Extra Grapes";
			description = "Get 3 grapes per collect!";
			upgrade = "moreItems";
			amount = 3;
			price = 2500000;
		}, {
			title = "Golden Grapes";
			description = "Unlock a chance to get a golden grape!";
			upgrade = "goldenLuck";
			amount = 3;
			price = 15000000;
		}, {
			title = "Grapes Cloner";
			description = "There is a small chance that your farm will drop double items!";
			upgrade = "doubleItems";
			amount = 1;
			price = 75000000;
		}, {
			title = "Extra Grapes";
			description = "Get 4 grapes per collect!";
			upgrade = "moreItems";
			amount = 4;
			price = 250000000;
		}};
	};
	strawberryFarm = {
		farmIcon = "rbxassetid://88455563468009";
		farmBackgroundColor = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 213, 214))});
		price = 500000;
		items = 1;
		cooldown = 1800;
		item = Items.fruit("strawberry");
		goldenItem = Items.fruit("goldenStrawberry");
		upgrades = {{
			title = "Extra Strawberries";
			description = "Get 2 strawberries per collect!";
			upgrade = "moreItems";
			amount = 2;
			price = 750000;
		}, {
			title = "Better Cooldown";
			description = "Your farm grows faster!";
			upgrade = "cooldown";
			amount = 1500;
			price = 1500000;
		}, {
			title = "Extra Strawberries";
			description = "Get 3 strawberries per collect!";
			upgrade = "moreItems";
			amount = 3;
			price = 5000000;
		}, {
			title = "Golden Strawberries";
			description = "Unlock a chance to get a golden strawberry!";
			upgrade = "goldenLuck";
			amount = 3;
			price = 25000000;
		}, {
			title = "Strawberries Cloner";
			description = "There is a small chance that your farm will drop double items!";
			upgrade = "doubleItems";
			amount = 1;
			price = 100000000;
		}, {
			title = "Extra Strawberries";
			description = "Get 4 strawberries per collect!";
			upgrade = "moreItems";
			amount = 4;
			price = 350000000;
		}};
	};
	pineappleFarm = {
		farmIcon = "rbxassetid://71475857455624";
		farmBackgroundColor = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(254, 255, 222))});
		price = 1000000;
		items = 1;
		cooldown = 1800;
		item = Items.fruit("pineapple");
		goldenItem = Items.fruit("goldenPineapple");
		upgrades = {{
			title = "Extra Pineapples";
			description = "Get 2 pineapples per collect!";
			upgrade = "moreItems";
			amount = 2;
			price = 1500000;
		}, {
			title = "Better Cooldown";
			description = "Your farm grows faster!";
			upgrade = "cooldown";
			amount = 1500;
			price = 6000000;
		}, {
			title = "Extra Pineapples";
			description = "Get 3 pineapples per collect!";
			upgrade = "moreItems";
			amount = 3;
			price = 10000000;
		}, {
			title = "Golden Pineapples";
			description = "Unlock a chance to get a golden pineapple!";
			upgrade = "goldenLuck";
			amount = 3;
			price = 15000000;
		}, {
			title = "Pineapples Cloner";
			description = "There is a small chance that your farm will drop double items!";
			upgrade = "doubleItems";
			amount = 1;
			price = 25000000;
		}, {
			title = "Extra Pineapples";
			description = "Get 4 pineapples per collect!";
			upgrade = "moreItems";
			amount = 4;
			price = 40000000;
		}, {
			title = "More Golden Pineapples";
			description = "Better chance to get a golden pineapple!";
			upgrade = "goldenLuck";
			amount = 6;
			price = 100000000;
		}};
	};
}