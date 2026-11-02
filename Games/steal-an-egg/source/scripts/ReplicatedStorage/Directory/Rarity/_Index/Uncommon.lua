-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Default = require(script.Parent.Parent.Private.BaseConfigs.Systems.FormatRarity.Default)
local v2 = ReplicatedStorage.Assets.UI.Rarity[script.Name]

return {
	RarityNumber = 2,
	DefaultRarityValue = "1 in 2",
	Announce = false,
	DisplayName = script.Name,
	ItemSlot = v2.ItemSlot,
	Gradient = v2.Gradient,
	Color = Color3.fromRGB(0, 255, 0),
	Message = Default("1 in 2")
}