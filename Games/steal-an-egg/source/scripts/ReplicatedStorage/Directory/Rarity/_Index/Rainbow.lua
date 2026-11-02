-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Default = require(script.Parent.Parent.Private.BaseConfigs.Systems.FormatRarity.Default)
local v1 = script.Name
local v2 = ReplicatedStorage.Assets.UI.Rarity[v1]

return {
	RarityNumber = 6,
	DefaultRarityValue = "1 in 100,000,000",
	Announce = false,
	DisplayName = v1,
	ItemSlot = v2.ItemSlot,
	Gradient = v2.Gradient,
	Color = Color3.fromRGB(240, 35, 172),
	Message = Default("1 in 100,000,000")
}