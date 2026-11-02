--credit to leon games studio
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SeedPacks = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("SeedPacks")
local SeedData = require(ReplicatedStorage.SharedModules.SeedData)
local SellValueData = require(ReplicatedStorage.SharedModules.SellValueData)
local t = {
	Data = {
		{
			PackName = "Ghost Pepper Pack",
			IMG = "rbxassetid://133021483253462",
			CustomProgressBased = false,
			Model = SeedPacks:WaitForChild("Ghost Pepper Pack"),
			Seeds = {
				{
					SeedName = "Baby Cactus",
					Chance = 50
				},
				{
					SeedName = "Horned Melon",
					Chance = 30
				},
				{
					SeedName = "Glow Mushroom",
					Chance = 15
				},
				{
					SeedName = "Poison Ivy",
					Chance = 4
				},
				{
					SeedName = "Ghost Pepper",
					Chance = 1
				}
			}
		},
		{
			PackName = "Common Seed Pack",
			Rarity = "Common",
			IMG = "rbxassetid://115799317193062",
			CustomProgressBased = true,
			TargetPercentile = 0.1,
			Spread = 0.15,
			Model = SeedPacks:WaitForChild("Common Seed Pack")
		},
		{
			PackName = "Uncommon Seed Pack",
			Rarity = "Uncommon",
			IMG = "rbxassetid://95821847618828",
			CustomProgressBased = true,
			TargetPercentile = 0.22,
			Spread = 0.15,
			Model = SeedPacks:WaitForChild("Uncommon Seed Pack")
		},
		{
			PackName = "Rare Seed Pack",
			Rarity = "Rare",
			IMG = "rbxassetid://100209155560487",
			CustomProgressBased = true,
			TargetPercentile = 0.35,
			Spread = 0.15,
			Model = SeedPacks:WaitForChild("Rare Seed Pack")
		},
		{
			PackName = "Mythic Seed Pack",
			Rarity = "Mythic",
			IMG = "rbxassetid://107746478038169",
			CustomProgressBased = true,
			TargetPercentile = 0.5,
			Spread = 0.15,
			Model = SeedPacks:WaitForChild("Mythic Seed Pack")
		},
		{
			PackName = "Legendary Seed Pack",
			Rarity = "Legendary",
			IMG = "rbxassetid://125344445268180",
			CustomProgressBased = true,
			TargetPercentile = 0.65,
			Spread = 0.13,
			Model = SeedPacks:WaitForChild("Legendary Seed Pack")
		},
		{
			PackName = "Super Seed Pack",
			Rarity = "Super",
			IMG = "rbxassetid://99496177404475",
			CustomProgressBased = true,
			TargetPercentile = 0.78,
			Spread = 0.13,
			Model = SeedPacks:WaitForChild("Super Seed Pack")
		},
		{
			PackName = "Secret Seed Pack",
			Rarity = "Secret",
			IMG = "rbxassetid://113604428669546",
			CustomProgressBased = true,
			TargetPercentile = 0.87,
			Spread = 0.13,
			Model = SeedPacks:WaitForChild("Secret Seed Pack")
		}
	}
}

function t.GetData(p1) --[[ GetData | Line: 95 | Upvalues: t (copy) ]]
	for v1, v2 in t.Data do
		if v2.PackName == p1 then
			return v2
		end
	end

	return nil
end

local function EstimateSeedGeneration(p1) --[[ EstimateSeedGeneration | Line: 104 | Upvalues: SellValueData (copy) ]]
	local v1 = SellValueData[p1.SeedName] or 0

	if p1.IsSingleHarvest then
		return v1
	end

	return v1 * 6
end

local v1 = nil

local function GetSortedEligibleSeeds() --[[ GetSortedEligibleSeeds | Line: 116 | Upvalues: v1 (ref), SeedData (copy), SellValueData (copy) ]]
	if v1 then
		return v1
	end

	local t = {}

	for v12, v2 in SeedData do
		if v2.RestockShop and v2.SeedName then
			local t2 = {
				Name = v2.SeedName
			}
			local v3 = SellValueData[v2.SeedName] or 0

			t2.Gen = if v2.IsSingleHarvest then v3 else v3 * 6
			table.insert(t, t2)
		end
	end

	table.sort(t, function(p1, p2) --[[ Line: 131 ]]
		if p1.Gen == p2.Gen then
			return p1.Name < p2.Name
		end

		return p1.Gen < p2.Gen
	end)

	local t2 = {}

	for v5, v6 in t do
		table.insert(t2, v6.Name)
	end

	v1 = t2

	return t2
end

function t.GetRandomSeed(p1, p2) --[[ GetRandomSeed | Line: 155 | Upvalues: t (copy), GetSortedEligibleSeeds (copy) ]]
	local v1 = t.GetData(p1)

	if not v1 then
		return nil
	end

	if v1.Seeds and #v1.Seeds > 0 then
		local sum = 0

		for v2, v3 in v1.Seeds do
			sum = sum + v3.Chance
		end

		local v4 = math.random() * sum
		local sum2 = 0

		for v5, v6 in v1.Seeds do
			sum2 = sum2 + v6.Chance

			if v4 <= sum2 then
				return v6.SeedName
			end
		end

		return v1.Seeds[#v1.Seeds].SeedName
	end

	local v7 = GetSortedEligibleSeeds()

	if #v7 == 0 then
		return nil
	end

	if #v7 == 1 then
		return v7[1]
	end

	local v8 = v1.TargetPercentile or 0.5
	local v9 = v1.Spread or 0.15

	if p2 and p2 > 0 then
		v8 = math.min(1, v8 + p2)
	end

	if v9 <= 0 then
		v9 = 0.0001
	end

	local v11 = #v7
	local v12 = table.create(v11)
	local sum = 0

	for i = 1, v11 do
		local v13 = ((i - 1) / (v11 - 1) - v8) / v9
		local v14 = math.exp(-0.5 * v13 * v13)

		v12[i] = v14
		sum = sum + v14
	end

	if sum <= 0 then
		return v7[v11]
	end

	local v15 = math.random() * sum
	local sum2 = 0

	for j = 1, v11 do
		sum2 = sum2 + v12[j]

		if v15 <= sum2 then
			return v7[j]
		end
	end

	return v7[v11]
end

return t