-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(script.Parent.Parent.Types.Interface)

local Guards = require(ReplicatedStorage.Directory.Guards)
local Rarities = require(ReplicatedStorage.Directory.Rarity).Rarities

return {
	Emoji = "\240\159\152\176",
	Icon = "rbxassetid://114058528069937",
	IndexBatGearId = "Volcano Bat",
	DisplayName = script.Name,
	DropTable = {
		{ "Ash Gecko", 26.848869 },
		{ "Lava frog", 22.040116 },
		{ "Flaming Bull", 18.032822 },
		{ "Lava Iguana", 15.027352 },
		{ "Chillin Chilli", 17.030999 },
		{ "Cerberus", 0.61984 },
		{ "Ascended Vermilion Phoenix", 0.222224 },
		{ "Dragon", 0.177779 }
	},
	GuardId = Guards.Directory.Volcano._id,
	Rarity = Rarities.Mythic
}