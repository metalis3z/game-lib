-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(script.Parent.Parent.Types.Interface)

local Guards = require(ReplicatedStorage.Directory.Guards)
local Rarities = require(ReplicatedStorage.Directory.Rarity).Rarities

return {
	Emoji = "\240\159\153\130",
	Icon = "rbxassetid://110449023764288",
	IndexBatGearId = "Forest Bat",
	DisplayName = script.Name,
	DropTable = {
		{ "Chicken", 34 },
		{ "Dog", 24 },
		{ "DesertLark", 17 },
		{ "Burrowing Owl", 10 },
		{ "Raccoon", 7 },
		{ "Mire Fox", 4.5 },
		{ "Bear", 2.5 },
		{ "Brr Brr Patapim", 1 }
	},
	GuardId = Guards.Directory.Forest._id,
	Rarity = Rarities.Common
}