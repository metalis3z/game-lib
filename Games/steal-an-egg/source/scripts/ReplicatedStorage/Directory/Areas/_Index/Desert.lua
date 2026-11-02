-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(script.Parent.Parent.Types.Interface)

local Guards = require(ReplicatedStorage.Directory.Guards)
local Rarities = require(ReplicatedStorage.Directory.Rarity).Rarities

return {
	Emoji = "\240\159\152\174",
	Icon = "rbxassetid://84222502657359",
	IndexBatGearId = "Desert Bat",
	DisplayName = script.Name,
	DropTable = {
		{ "Jerboa", 26.585432 },
		{ "FennecFox", 20.450332 },
		{ "Camel", 15.337749 },
		{ "Tob Tobi Tob Tob", 12.270199 },
		{ "Rattlesnake", 9.20265 },
		{ "Sand Spider", 8.180133 },
		{ "DeathstalkerScorpion", 6.646358 },
		{ "Irihorus", 1.327147 }
	},
	GuardId = Guards.Directory.Desert._id,
	Rarity = Rarities.Rare
}