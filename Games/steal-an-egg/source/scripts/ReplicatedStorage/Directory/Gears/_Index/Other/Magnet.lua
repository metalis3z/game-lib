-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(script.Parent.Parent.Parent.Types.Interface)
require(script.Parent.Parent.Parent.Types.ToolConfigs)

local Default = require(script.Parent.Parent.Parent.BaseConfigs.Default)
local v2 = setmetatable(table.clone({
	Icon = "rbxassetid://999316662",
	MoneyCost = 200000000,
	ShopDropWeight = 60,
	MinShopStockQuantity = 1,
	MaxShopStockQuantity = 1,
	ToolController = "None",
	Description = "Pull targets towards you with magnetic force",
	Rarity = "Uncommon",
	Persistent = false,
	SinglePurchase = true,
	DisplayInShop = false,
	DisplayName = script.Name
}), {
	__index = Default
})

for v3, v4 in {
	MAX_RANGE = 50,
	COOLDOWN = 10,
	PULL_DURATION = 3,
	PULL_FORCE = 50,
	PULL_SMOOTHNESS = 0.15,
	PULL_SPEED = 10,
	PULL_SFX_ID = "rbxassetid://0",
	SHOW_RANGE_INDICATOR = false,
	BEAM_TEMPLATE_PATH = ReplicatedStorage.Assets.ToolEffects.beamTrail,
	MAGNET_EFFECT_PATH = ReplicatedStorage.Assets.ToolEffects.MagnetEffect
} do
	v2[v3] = v4
end

return v2