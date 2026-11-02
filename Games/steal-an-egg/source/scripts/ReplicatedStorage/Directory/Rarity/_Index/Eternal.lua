-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Default = require(script.Parent.Parent.Private.BaseConfigs.Systems.FormatRarity.Default)
local v2 = ReplicatedStorage.Assets.UI.Rarity[script.Name]

return {
	DisplayName = "Eternal",
	RarityNumber = 9,
	DefaultRarityValue = "1 in 100,000,000",
	Announce = false,
	ItemSlot = v2.ItemSlot,
	Gradient = v2.Gradient,
	Color = Color3.fromRGB(255, 30, 240),
	Message = Default("1 in 100,000,000")
}