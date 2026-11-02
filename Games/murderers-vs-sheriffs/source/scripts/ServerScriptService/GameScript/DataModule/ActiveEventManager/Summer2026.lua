return {
	EventEndTime = 1787511600,
	EventStartInfo = {
		CurrencyName = "Coins";
		FeaturedItems = {
			Console = {
				"Event";
				"Summer2026Box";
				"BeachBundleEffect";
				"MysteryBox2";
				"MysteryBox1";
				"Decoy";
				"Dual";
				"Electric"
			};
			Desktop = {
				"Summer2026Box";
				"BeachBundleEffect";
				"Dual";
				"Electric";
				"Trap";
				"Decoy";
			};
			Mobile = {
				"Event";
				"BeachBundleEffect";
				"MysteryBox2";
				"Electric";
				"Dual";
				"Decoy"
			}
		};
		Items = {
			MysteryBox = {
				Summer2026Box = {
					BoxType = "Weapons",
					Contents = {
						"Tourist_K_2026",
						"Sand_K_2026",
						"Duckies_G_2026",
						"Cherries_G_2026",
						"Neopolitan_K_2026",
						"Turtles_K_2026",
						"Floral_G_2026",
						"Pier_K_2026",
						"Sunset_G_2026",
						"Bubbles_K_2026",
					},
					Godly = "Icecream",
					Image = "rbxassetid://119248648714628",
					Name = "Summer Box '26",
					RarityChances = {
						{ Chance = 70, Rarity = "Common" },
						{ Chance = 18, Rarity = "Uncommon" },
						{ Chance = 8,  Rarity = "Rare" },
						{ Chance = 4,  Rarity = "Legendary" },
					},
					Season = 1,
				},
			},
		};
		KeyName = "SummerKey2026";
		ProfileData = {
			Quests = {
				DailyCoins = {
					Claimed = {},
					LastReset = 0,
					Progress = 0,
				},
				Rewards = {
					Claimed = {},
					Progress = 0,
				},
				WeeklyCoins = {
					Claimed = {},
					LastReset = 0,
					Progress = 0,
				},
			},
		},
		Quests = {
			DailyCoins = {
				CompleteText = {
					Prefix = "Collect",
					Suffix = "coins",
				},
				ContributesTo = "WeeklyQuests",
				Description = "Collect coins",
				LayoutOrder = 1,
				Quests = {
					{ ChallengeAmount = 60,  RewardAmount = 30, RewardID = "SummerKey2026", RewardType = "Materials" },
					{ ChallengeAmount = 120, RewardAmount = 15, RewardID = "SummerKey2026", RewardType = "Materials" },
					{ ChallengeAmount = 240, RewardAmount = 15, RewardID = "SummerKey2026", RewardType = "Materials" },
					{ ChallengeAmount = 480, RewardAmount = 15, RewardID = "SummerKey2026", RewardType = "Materials" },
					{ ChallengeAmount = 720, RewardAmount = 15, RewardID = "SummerKey2026", RewardType = "Materials" },
					{ ChallengeAmount = 960, RewardAmount = 30, RewardID = "SummerKey2026", RewardType = "Materials" },
				},
				RefreshTime = 86400,
				Subtitle = "Daily",
				Title = "DAILY QUEST",
			},
			Rewards = {
				CompleteText = {
					Prefix = "Open",
					Suffix = "event boxes",
				},
				Description = "Open event boxes",
				LayoutOrder = 0,
				Quests = {
					{ ChallengeAmount = 1,  RewardAmount = 1, RewardID = "Bubbles26",  RewardType = "Toys" },
					{ ChallengeAmount = 6,  RewardAmount = 1, RewardID = "Bubbly26",   RewardType = "Effects" },
					{ ChallengeAmount = 12, RewardAmount = 1, RewardID = "RCCar26",    RewardType = "Toys" },
					{ ChallengeAmount = 20, RewardAmount = 1, RewardID = "Nightlife26", RewardType = "Effects" },
				},
				Subtitle = "Rewards",
				Title = "EVENT QUEST",
			},
			WeeklyCoins = {
				CompleteText = {
					Prefix = "Complete",
					Suffix = "quests",
				},
				Description = "Complete daily quest tiers",
				LayoutOrder = 3,
				Quests = {
					{ ChallengeAmount = 6,  RewardAmount = 120, RewardID = "SummerKey2026", RewardType = "Materials" },
					{ ChallengeAmount = 18, RewardAmount = 120, RewardID = "SummerKey2026", RewardType = "Materials" },
					{ ChallengeAmount = 26, RewardAmount = 120, RewardID = "SummerKey2026", RewardType = "Materials" },
				},
				RefreshTime = 604800,
				Subtitle = "Weekly",
				Title = "WEEKLY QUEST",
			},
		},
		ShopData = {
			BeachBundleEffect = {
				Description = "[Limited] A godly bundle including: a knife, a gun and an effect. Available for a limited time, then goes off-sale.",
				DisplayInfo = {
					Color = Color3.new(1, 0, 1),
					Image = "rbxassetid://118201085928893",
					Name = "Beach Bundle",
				},
				GamepassId = 1927110322,
				LayoutOrder = 50,
				Limited = true,
				OneTimePurchase = true,
				Price = {
					Robux = 3399,
				},
				RewardItems = {
					{ Amount = 1, ItemID = "Beachy", ItemType = "Weapons" },
					{ Amount = 1, ItemID = "Sands",  ItemType = "Weapons" },
					{ Amount = 1, ItemID = "Ocean26", ItemType = "Effects" },
				},
				Type = "ItemBundle",
			},
			BeachyKnife = {
				Description = "[Limited] A godly knife. Available as a bundle with a gun and effect. Available for a limited time, then goes off-sale.",
				DevProductId = 3611355018,
				DisplayInfo = {
					Color = Color3.new(1, 0, 1),
					Image = "rbxassetid://140691282666607",
					Name = "Beachy",
				},
				LayoutOrder = 51,
				Limited = true,
				Price = {
					Robux = 1699,
				},
				RewardItems = {
					{ Amount = 1, ItemID = "Beachy", ItemType = "Weapons" },
				},
				Type = "ItemBundle",
			},
			SandsGun = {
				Description = "[Limited] A godly gun. Available as a bundle with a knife and effect. Available for a limited time, then goes off-sale.",
				DevProductId = 3611355069,
				DisplayInfo = {
					Color = Color3.new(1, 0, 1),
					Image = "rbxassetid://129247240443270",
					Name = "Sands",
				},
				LayoutOrder = 51,
				Limited = true,
				Price = {
					Robux = 1699,
				},
				RewardItems = {
					{ Amount = 1, ItemID = "Sands", ItemType = "Weapons" },
				},
				Type = "ItemBundle",
			},
		};
		UI = {
			PrimaryColor = Color3.fromRGB(0, 0, 0);
			ShopButton = "rbxassetid://13932988534";
			ShopCover = "rbxassetid://125895446046269"
		};
	};
	EventStartTime = 1784833200;
	Name = "Summer";
	Priority = "Main";
	Title = "Summer2026";
	Year = "2026";
	
	
}
