--credit to quartz games studio
local GearShopData = require(game:GetService("ReplicatedStorage"):WaitForChild("SharedModules"):WaitForChild("GearShopData"))
local SeedPackData = require(game.ReplicatedStorage.SharedModules.SeedPackData)
local t = {}
local t2 = {}

for v1, v2 in GearShopData.Data do
	t[v2.ItemName] = v2.IMG
end

local t3 = {}

for v3, v4 in SeedPackData.Data do
	t3[v4.PackName] = v4.IMG
end

t2.Data = {
	Secret = {
		RestockChance = 0.7,
		RestockTime = 10,
		GarenteedStock = 0,
		MaximumStock = 10,
		Items = {
			{
				ID = "Super Watering Can ExclusiveGear",
				ItemName = "Super Watering Can",
				ItemType = "Watering Can",
				ItemRestockChance = 100,
				PriceInRobux = 129,
				Giftable = true,
				Image = t["Super Watering Can"],
				RestockAmounts = {
					{
						Amount = 1,
						Chance = 50
					},
					{
						Amount = 2,
						Chance = 23
					},
					{
						Amount = 3,
						Chance = 2
					}
				}
			},
			{
				ID = "Common Seed Pack ExclusiveGear",
				ItemName = "Common Seed Pack",
				ItemType = "Seed Pack",
				ItemRestockChance = 100,
				PriceInRobux = 129,
				Giftable = true,
				Image = t3["Common Seed Pack"],
				RestockAmounts = {
					{
						Amount = 1,
						Chance = 50
					},
					{
						Amount = 2,
						Chance = 23
					},
					{
						Amount = 3,
						Chance = 2
					}
				}
			}
		},
		RestockAmounts = {
			{
				Chance = 75,
				Amount = 1
			},
			{
				Chance = 23,
				Amount = 2
			},
			{
				Chance = 2,
				Amount = 3
			}
		}
	},
	Super = {
		RestockChance = 2.1,
		RestockTime = 30,
		GarenteedStock = 0,
		MaximumStock = 10,
		Items = {
			{
				ID = "Teleporter ExclusiveGear",
				ItemName = "Teleporter",
				ItemType = "Teleporter",
				ItemRestockChance = 100,
				PriceInRobux = 79,
				Giftable = true,
				Image = t.Teleporter,
				RestockAmounts = {
					{
						Amount = 1,
						Chance = 50
					},
					{
						Amount = 2,
						Chance = 23
					},
					{
						Amount = 3,
						Chance = 2
					}
				}
			}
		}
	},
	Exotic = {
		RestockChance = 60,
		RestockTime = 300,
		GarenteedStock = 3,
		MaximumStock = 10,
		Items = {
			{
				ID = "Jump Mushroom ExclusiveGear",
				ItemName = "Jump Mushroom",
				ItemType = "Jump Mushroom",
				ItemRestockChance = 100,
				PriceInRobux = 29,
				Giftable = true,
				Image = t["Jump Mushroom"],
				RestockAmounts = {
					{
						Amount = 1,
						Chance = 50
					},
					{
						Amount = 2,
						Chance = 23
					},
					{
						Amount = 3,
						Chance = 2
					}
				}
			}
		}
	}
}

return t2