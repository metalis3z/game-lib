-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(script.Parent.Parent.Types.Interface)

return {
	Price = 0,
	ProductId = nil,
	Icon = "",
	SpeedMultiplier = 1,
	DisplayInShop = true,
	DisplayName = "",
	Rarity = require(ReplicatedStorage.Directory.Rarity).Rarities.Common
}