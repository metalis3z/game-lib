-- Reference copy for study. Game: steal-a-brainrot
-- Original: ReplicatedStorage/Datas/Bases.lua
-- What it does: Data table mapping rebirth level to base model (first/second/third floor template) and
--   MaxAnimals (podium count). The plot service clones the matching model and trims podiums above MaxAnimals.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Bases = {
	[0] = {
		["MaxAnimals"] = 10,
		["Model"] = ReplicatedStorage.Bases.FirstFloor
	},
	[1] = {
		["MaxAnimals"] = 10,
		["Model"] = ReplicatedStorage.Bases.FirstFloor
	},
	[2] = {
		["MaxAnimals"] = 11,
		["Model"] = ReplicatedStorage.Bases.SecondFloor
	},
	[3] = {
		["MaxAnimals"] = 12,
		["Model"] = ReplicatedStorage.Bases.SecondFloor
	},
	[4] = {
		["MaxAnimals"] = 13,
		["Model"] = ReplicatedStorage.Bases.SecondFloor
	},
	[5] = {
		["MaxAnimals"] = 14,
		["Model"] = ReplicatedStorage.Bases.SecondFloor
	},
	[6] = {
		["MaxAnimals"] = 15,
		["Model"] = ReplicatedStorage.Bases.SecondFloor
	},
	[7] = {
		["MaxAnimals"] = 16,
		["Model"] = ReplicatedStorage.Bases.SecondFloor
	},
	[8] = {
		["MaxAnimals"] = 17,
		["Model"] = ReplicatedStorage.Bases.SecondFloor
	},
	[9] = {
		["MaxAnimals"] = 18,
		["Model"] = ReplicatedStorage.Bases.SecondFloor
	},
	[10] = {
		["MaxAnimals"] = 19,
		["Model"] = ReplicatedStorage.Bases.ThirdFloor
	},
	[11] = {
		["MaxAnimals"] = 20,
		["Model"] = ReplicatedStorage.Bases.ThirdFloor
	},
	[12] = {
		["MaxAnimals"] = 21,
		["Model"] = ReplicatedStorage.Bases.ThirdFloor
	},
	[13] = {
		["MaxAnimals"] = 22,
		["Model"] = ReplicatedStorage.Bases.ThirdFloor
	},
	[14] = {
		["MaxAnimals"] = 23,
		["Model"] = ReplicatedStorage.Bases.ThirdFloor
	},
	[15] = {
		["MaxAnimals"] = 24,
		["Model"] = ReplicatedStorage.Bases.ThirdFloor
	},
	[16] = {
		["MaxAnimals"] = 25,
		["Model"] = ReplicatedStorage.Bases.ThirdFloor
	},
	[17] = {
		["MaxAnimals"] = 26,
		["Model"] = ReplicatedStorage.Bases.ThirdFloor
	},
	[18] = {
		["MaxAnimals"] = 27,
		["Model"] = ReplicatedStorage.Bases.ThirdFloor
	}
}

return Bases