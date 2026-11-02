-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(script.Parent.Parent.Parent.Types.Interface)
require(script.Parent.Parent.Parent.Types.ToolConfigs)

local Default = require(script.Parent.Parent.Parent.BaseConfigs.Default)
local v2 = setmetatable(table.clone({
	Icon = "rbxassetid://65510059",
	MoneyCost = 250000000,
	ShopDropWeight = 60,
	MinShopStockQuantity = 1,
	MaxShopStockQuantity = 1,
	ToolController = "None",
	Description = "Create a powerful sound cone that continuously slaps and ragdolls targets",
	Rarity = "Uncommon",
	Persistent = false,
	SinglePurchase = true,
	DisplayInShop = false,
	DisplayName = script.Name
}), {
	__index = Default
})

for v3, v4 in {
	COOLDOWN = 14,
	MAX_RANGE = 20,
	CONE_ANGLE = 1.0471975511965976,
	EFFECT_DURATION = 4.5,
	DAMAGE = 2,
	SLAP_DURATION = 0.85,
	SLAP_FORCE = 40,
	TARGET_HIT_COOLDOWN = 0.5,
	SFX_ID = "rbxassetid://0",
	SHOW_RANGE_INDICATOR = false,
	VFX_PATH = ReplicatedStorage.Assets.ToolEffects.BeeToolEffect
} do
	v2[v3] = v4
end

return v2