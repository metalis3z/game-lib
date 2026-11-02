-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(script.Parent.Parent.Types.Interface)

local Guards = require(ReplicatedStorage.Directory.Guards)
local Rarities = require(ReplicatedStorage.Directory.Rarity).Rarities

return {
	Emoji = "\240\159\152\168",
	Icon = "rbxassetid://128413001319264",
	IndexBatGearId = "Prehistoric Bat",
	DisplayName = script.Name,
	DropTable = {
		{ "Dodo", 39.066058 },
		{ "Pterodactyl", 26.044039 },
		{ "Ankylosaurus", 20.835231 },
		{ "Triceratops", 4.929402 },
		{ "Bronto", 6.995959 },
		{ "TyrannosaurusRex", 0.991743 },
		{ "Tralaledon", 0.826453 },
		{ "Mosasaurus", 0.311113 }
	},
	GuardId = Guards.Directory.Prehistoric._id,
	Rarity = Rarities.Secret
}