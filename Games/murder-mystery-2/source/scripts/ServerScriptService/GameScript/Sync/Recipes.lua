local Module = {

	--[[["RandomCommonWeapon"] = {
		Name = "Random Common Weapon";
		Image = "https://www.roblox.com/asset/?id=380344693";
		Rarity = "Common";
		Materials = {
			["CommonShards"] = 1;
			["CommonMetal"] = 1;
		};
		SortPriority = 100;
		Function = 582103681;
	};]]

	["RandomUncommonWeapon"] = {
		Name = "Random Uncommon Weapon";
		Image = "rbxassetid://582222761";
		Rarity = "Uncommon";
		Materials = {
			["CommonShards"] = 12;
			["CommonMetal"] = 6;
		};
		SortPriority = 100;
		Function = 582103681;
	};

	["RandomRareWeapon"] = {
		Name = "Random Rare Weapon";
		Image = "rbxassetid://582222760";
		Rarity = "Rare";
		Materials = {
			["UncommonShards"] = 12;
			["UncommonMetal"] = 6;
		};
		SortPriority = 100;
		Function = 582103681;
	};

	["RandomLegendaryWeapon"] = {
		Name = "Random Legendary Weapon";
		Image = "rbxassetid://582222766";
		Rarity = "Legendary";
		Materials = {
			["RareShards"] = 15;
			["RareMetal"] = 8;
		};
		SortPriority = 100;
		Function = 582103681;
	};

	["TheSeer"] = {
		Name = "Seer";
		Image = "http://www.roblox.com/asset/?id=198459100";
		Rarity = "Godly";
		RewardItem = "TheSeer";
		RewardAmount = 1;
		RewardType = "Weapons";
		Materials = {
			["LegendaryShards"] = 10;
		};
		SortPriority = 80;
	};
	
	["CNikScythe"] = {
		Name = "Chroma Nik's Scythe";
		Image = "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=12270018846";
		Rarity = "Godly";
		RewardItem = "CNikScythe";
		RewardAmount = 1;
		RewardType = "Weapons";
		Materials = {
			["ChromaOrb"] = 20;
			["GodlyShards"] = 5;

		};
		SortPriority = 80;
	};
	
	["DL"] = {
		Name = "Diamond Lightbringer";
		Image = "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=10960524397";
		Rarity = "Godly";
		RewardItem = "DL";
		RewardAmount = 1;
		RewardType = "Weapons";
		Materials = {
			["ChromaOrb"] = 10;
			["GodlyShards"] = 20;

		};
		SortPriority = 80;
	};
	
	["DB"] = {
		Name = "Diamond Darkbringer";
		Image = "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=10960525869";
		Rarity = "Godly";
		RewardItem = "DB";
		RewardAmount = 1;
		RewardType = "Weapons";
		Materials = {
			["GodlyShards"] = 20;
			["ChromaOrb"] = 20;

		};
		SortPriority = 80;
	};

	["Chroma Seer"] = {
		Name = "Chroma Seer";
		Image = "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=6566760171";
		Rarity = "Godly";
		RewardItem = "Chroma Seer";
		RewardAmount = 1;
		RewardType = "Weapons";
		Materials = {
			["LegendaryShards"] = 20;
			["RareShards"] = 12;
		};
		SortPriority = 80;
	};
	["RandomReaver"] = {
		Name = "Random Painted Seer";
		Image = "rbxassetid://3184179319";
		Rarity = "Godly";
		Materials = {
			["GodlyShards"] = 10;
			["GodlyMetal"] = 10;
		};
		SortPriority = 100;
		Function = 12269517310;
	};




	--[[["Basketball"] = {
		Name = "Basketball (Christmas 2016)";
		Image = "rbxassetid://583505141";
		Rarity = "Common";
		RewardItem = "ToyBasketball";
		RewardAmount = 1;
		RewardType = "Materials";
		Materials = {
			["BasketballParts"] = 4;
		};
		SortPriority = 90;
	};
	["ToyRobot"] = {
		Name = "Toy Robot (Christmas 2016)";
		Image = "rbxassetid://583508162";
		Rarity = "Uncommon";
		RewardItem = "ToyRobot";
		RewardAmount = 1;
		RewardType = "Materials";
		Materials = {
			["ActionFigureParts"] = 4;
		};
		SortPriority = 90;
	};
	["Skateboard"] = {
		Name = "Skateboard (Christmas 2016)";
		Image = "rbxassetid://583508609";
		Rarity = "Rare";
		RewardItem = "ToySkateboard";
		RewardAmount = 1;
		RewardType = "Materials";
		Materials = {
			["SkateboardParts"] = 4;
		};
		SortPriority = 90;
	};
	["GameSystem"] = {
		Name = "Game System (Christmas 2016)";
		Image = "rbxassetid://583509564";
		Rarity = "Legendary";
		RewardItem = "ToyGameSystem";
		RewardAmount = 1;
		RewardType = "Materials";
		Materials = {
			["GameSystemParts"] = 4;
		};
		SortPriority = 90;
	};]]





	--[[["WrappedBasketball"] = {
		Name = "Wrapped Basketball (Christmas 2016)";
		Rarity = "Common";
		CombinationRecipe = true;
		SortPriority = 89
	};
	["WrappedBasketballRed"] = {
		Name = "Wrapped Basketball (Christmas 2016)";
		Image = "rbxassetid://584820728";
		Rarity = "Common";

		RewardItem = "WrappedBasketballRed";
		RewardAmount = 1;
		RewardType = "Materials";		
		
		Materials = {
			["ToyBasketball"] = 1;
			["WrappingPaperRed"] = 1;
		};
		CombinedRecipe = "WrappedBasketball";
	};
	["WrappedBasketballPurple"] = {
		Name = "Wrapped Basketball (Christmas 2016)";
		Image = "rbxassetid://584821953";
		Rarity = "Common";
		RewardItem = "WrappedBasketballPurple";
		RewardAmount = 1;
		RewardType = "Materials";	
		Materials = {
			["ToyBasketball"] = 1;
			["WrappingPaperPurple"] = 1;
		};
		CombinedRecipe = "WrappedBasketball";
	};
	["WrappedBasketballGold"] = {
		Name = "Wrapped Basketball(Christmas 2016)";
		Image = "rbxassetid://584822040";
		Rarity = "Common";
		RewardItem = "WrappedBasketballGold";
		RewardAmount = 1;
		RewardType = "Materials";	
		Materials = {
			["ToyBasketball"] = 1;
			["WrappingPaperGold"] = 1;
		};
		CombinedRecipe = "WrappedBasketball";
	};]]





	--[[["WrappedRobot"] = {
		Name = "Wrapped Toy Robot (Christmas 2016)";
		Rarity = "Uncommon";
		CombinationRecipe = true;
		SortPriority = 89
	};
	["WrappedRobotRed"] = {
		Name = "";
		Image = "rbxassetid://584862997";
		Rarity = "Uncommon";
		RewardItem = "WrappedRobotRed";
		RewardAmount = 1;
		RewardType = "Materials";	
		Materials = {
			["ToyRobot"] = 1;
			["WrappingPaperRed"] = 1;
		};
		CombinedRecipe = "WrappedRobot";
	};
	["WrappedRobotPurple"] = {
		Name = "";
		Image = "rbxassetid://584863032";
		Rarity = "Uncommon";
		RewardItem = "WrappedRobotPurple";
		RewardAmount = 1;
		RewardType = "Materials";	
		Materials = {
			["ToyRobot"] = 1;
			["WrappingPaperPurple"] = 1;
		};
		CombinedRecipe = "WrappedRobot";
	};
	["WrappedRobotGold"] = {
		Name = "";
		Image = "rbxassetid://584863080";
		Rarity = "Uncommon";
		RewardItem = "WrappedRobotGold";
		RewardAmount = 1;
		RewardType = "Materials";	
		Materials = {
			["ToyRobot"] = 1;
			["WrappingPaperGold"] = 1;
		};
		CombinedRecipe = "WrappedRobot";
	};]]



	--[[["WrappedSkateboard"] = {
		Name = "Wrapped Skateboard (Christmas 2016)";
		Rarity = "Rare";
		CombinationRecipe = true;
		SortPriority = 89
	};
	["WrappedSkateboardRed"] = {
		Name = "";
		Image = "rbxassetid://584864157";
		Rarity = "Rare";
		RewardItem = "WrappedSkateboardRed";
		RewardAmount = 1;
		RewardType = "Materials";	
		Materials = {
			["ToySkateboard"] = 1;
			["WrappingPaperRed"] = 1;
		};
		CombinedRecipe = "WrappedSkateboard";
	};
	["WrappedSkateboardPurple"] = {
		Name = "";
		Image = "rbxassetid://584864219";
		Rarity = "Rare";
		RewardItem = "WrappedSkateboardPurple";
		RewardAmount = 1;
		RewardType = "Materials";	
		Materials = {
			["ToySkateboard"] = 1;
			["WrappingPaperPurple"] = 1;
		};
		CombinedRecipe = "WrappedSkateboard";
	};
	["WrappedSkateboardGold"] = {
		Name = "";
		Image = "rbxassetid://584864241";
		Rarity = "Rare";
		RewardItem = "WrappedSkateboardGold";
		RewardAmount = 1;
		RewardType = "Materials";	
		Materials = {
			["ToySkateboard"] = 1;
			["WrappingPaperGold"] = 1;
		};
		CombinedRecipe = "WrappedSkateboard";
	};]]










	--[[["WrappedGameSystem"] = {
		Name = "Wrapped Game System (Christmas 2016)";
		Rarity = "Legendary";
		CombinationRecipe = true;
		SortPriority = 89
	};
	["WrappedGameSystemRed"] = {
		Name = "";
		Image = "rbxassetid://584864788";
		Rarity = "Legendary";
		RewardItem = "WrappedGameSystemRed";
		RewardAmount = 1;
		RewardType = "Materials";	
		Materials = {
			["ToyGameSystem"] = 1;
			["WrappingPaperRed"] = 1;
		};
		CombinedRecipe = "WrappedGameSystem";
	};
	["WrappedGameSystemPurple"] = {
		Name = "";
		Image = "rbxassetid://584864824";
		Rarity = "Legendary";
		RewardItem = "WrappedGameSystemPurple";
		RewardAmount = 1;
		RewardType = "Materials";	
		Materials = {
			["ToyGameSystem"] = 1;
			["WrappingPaperPurple"] = 1;
		};
		CombinedRecipe = "WrappedGameSystem";
	};
	["WrappedGameSystemGold"] = {
		Name = "";
		Image = "rbxassetid://584864856";
		Rarity = "Legendary";
		RewardItem = "WrappedGameSystemGold";
		RewardAmount = 1;
		RewardType = "Materials";	
		Materials = {
			["ToyGameSystem"] = 1;
			["WrappingPaperGold"] = 1;
		};
		CombinedRecipe = "WrappedGameSystem";
	};]]


	["Flames"] = {
		Name = "Flames";
		Image = "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=585873746";
		Rarity = "Ancient";
		RewardItem = "Flames";
		RewardAmount = 1;
		RewardType = "Weapons";
		Materials = {
			["FireOrb"] = 1;
			["WaterOrb"] = 1;
			["GodlyShards"] = 2;
			["GodlyMetal"] = 1;
		};
		SortPriority = 80;
	};


};


return Module;
