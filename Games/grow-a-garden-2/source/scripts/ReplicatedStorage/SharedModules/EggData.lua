--credit to leon games studio
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Eggs = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Eggs")
local FastFlags = require(ReplicatedStorage.UserGenerated.FastFlags)
local Asserts = require(ReplicatedStorage.UserGenerated.Lang.Asserts)
local PetData = require(ReplicatedStorage.SharedData.PetData)
local v1 = FastFlags.Replicated("Game.Eggs.RainbowChanceMultiplier", Asserts.FiniteNonNegative, 1)
local v2 = FastFlags.Replicated("Game.Eggs.BigChanceMultiplier", Asserts.FiniteNonNegative, 1)
local v3 = FastFlags.Replicated("Game.Eggs.HugeChanceMultiplier", Asserts.FiniteNonNegative, 1)
local v4 = FastFlags.Replicated("Game.Eggs.PetWeightMultipliers", Asserts.Map(Asserts.String, Asserts.FiniteNonNegative), {})
local v5 = FastFlags.Replicated("Game.Eggs.SpeciesWeightMultipliers", Asserts.Map(Asserts.String, Asserts.FiniteNonNegative), {})

local function getPetWeightMultiplier(p1) --[[ getPetWeightMultiplier | Line: 26 | Upvalues: PetData (copy), v4 (copy), v5 (copy), v3 (copy), v2 (copy) ]]
	local v1 = PetData[p1.PetName]
	local v22 = if v1 then if type(v1.Rarity) == "string" then v1.Rarity else "Common" else "Common"
	local v32 = (v4:Get()[v22] or 1) * (v5:Get()[p1.PetName] or 1)

	if p1.Huge then
		return v32 * v3:Get()
	end

	if p1.Big then
		v32 = v32 * v2:Get()
	end

	return v32
end

local t = {
	Data = {
		{
			EggName = "Common Egg",
			Rarity = "Common",
			IMG = "rbxassetid://126687482540593",
			RainbowChance = 0.5,
			Model = Eggs:WaitForChild("Common Egg"),
			Pets = {
				{
					PetName = "Frog",
					Chance = 30
				},
				{
					PetName = "Bunny",
					Chance = 30
				},
				{
					PetName = "Deer",
					Chance = 20
				},
				{
					PetName = "Robin",
					Chance = 4.5
				},
				{
					PetName = "Bee",
					Chance = 4.5
				},
				{
					PetName = "Unicorn",
					Chance = 0.3
				},
				{
					PetName = "Golden Dragonfly",
					Chance = 0.3
				},
				{
					PetName = "Raccoon",
					Chance = 0.2
				},
				{
					PetName = "Frog",
					Big = true,
					Chance = 0.6
				},
				{
					PetName = "Bunny",
					Big = true,
					Chance = 0.6
				},
				{
					PetName = "Deer",
					Big = true,
					Chance = 0.4
				},
				{
					PetName = "Robin",
					Big = true,
					Chance = 0.09
				},
				{
					PetName = "Bee",
					Big = true,
					Chance = 0.09
				},
				{
					PetName = "Unicorn",
					Big = true,
					Chance = 0.006
				},
				{
					PetName = "Golden Dragonfly",
					Big = true,
					Chance = 0.006
				},
				{
					PetName = "Raccoon",
					Big = true,
					Chance = 0.004
				},
				{
					PetName = "Frog",
					Huge = true,
					Chance = 0.03
				},
				{
					PetName = "Bunny",
					Huge = true,
					Chance = 0.03
				},
				{
					PetName = "Deer",
					Huge = true,
					Chance = 0.02
				},
				{
					PetName = "Robin",
					Huge = true,
					Chance = 0.0045
				},
				{
					PetName = "Bee",
					Huge = true,
					Chance = 0.0045
				},
				{
					PetName = "Unicorn",
					Huge = true,
					Chance = 0.0003
				},
				{
					PetName = "Golden Dragonfly",
					Huge = true,
					Chance = 0.0003
				},
				{
					PetName = "Raccoon",
					Huge = true,
					Chance = 0.0002
				}
			}
		},
		{
			EggName = "Test Egg",
			Rarity = "Common",
			IMG = "rbxassetid://126687482540593",
			RainbowChance = 0.5,
			Model = Eggs:WaitForChild("Common Egg"),
			Pets = {
				{
					PetName = "Frog",
					Chance = 10
				},
				{
					PetName = "Frog",
					Chance = 10,
					Big = true
				},
				{
					PetName = "Frog",
					Chance = 10,
					Huge = true
				}
			}
		},
		{
			EggName = "Epic Egg",
			Rarity = "Epic",
			IMG = "rbxassetid://126687482540593",
			RainbowChance = 5,
			Model = Eggs:WaitForChild("Epic Egg"),
			Pets = {
				{
					PetName = "Deer",
					Chance = 60
				},
				{
					PetName = "Unicorn",
					Chance = 30
				},
				{
					PetName = "Bee",
					Chance = 9
				},
				{
					PetName = "Bee",
					Big = true,
					Chance = 1
				}
			}
		}
	}
}

function t.GetData(p1) --[[ GetData | Line: 139 | Upvalues: t (copy) ]]
	for v1, v2 in t.Data do
		if v2.EggName == p1 then
			return v2
		end
	end

	return nil
end
function t.GetRandomPet(p1) --[[ GetRandomPet | Line: 150 | Upvalues: t (copy), getPetWeightMultiplier (copy) ]]
	local v1 = t.GetData(p1)

	if not v1 then
		return nil
	end

	if not v1.Pets or #v1.Pets == 0 then
		return nil
	end

	local sum = 0

	for v2, v3 in v1.Pets do
		sum = sum + v3.Chance * getPetWeightMultiplier(v3)
	end

	if sum <= 0 then
		return v1.Pets[#v1.Pets]
	end

	local v4 = math.random() * sum
	local sum2 = 0

	for v5, v6 in v1.Pets do
		sum2 = sum2 + v6.Chance * getPetWeightMultiplier(v6)

		if v4 <= sum2 then
			return v6
		end
	end

	return v1.Pets[#v1.Pets]
end
function t.RollRainbow(p1) --[[ RollRainbow | Line: 177 | Upvalues: t (copy), v1 (copy) ]]
	local v12 = t.GetData(p1)
	local v2 = if v12 then v12.RainbowChance or 0 else 0
	local v3 = v2 * v1:Get()

	if v3 <= 0 then
		return false
	end

	return math.random() * 100 < v3
end
function t.Roll(p1) --[[ Roll | Line: 185 | Upvalues: t (copy) ]]
	local v1 = t.GetRandomPet(p1)

	if not v1 then
		return nil
	end

	local v2 = if v1.Huge then "Huge" elseif v1.Big then "Big" else nil

	return {
		PetName = v1.PetName,
		Size = v2,
		Type = if t.RollRainbow(p1) then "Rainbow" else nil
	}
end

return t