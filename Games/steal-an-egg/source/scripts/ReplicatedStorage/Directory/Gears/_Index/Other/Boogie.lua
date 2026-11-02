-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent.Parent.Parent.Types.Interface)
require(script.Parent.Parent.Parent.Types.ToolConfigs)

local Default = require(script.Parent.Parent.Parent.BaseConfigs.Default)
local t = {
	Icon = "rbxassetid://106718228085156",
	MoneyCost = 500000,
	ShopDropWeight = 50,
	MinShopStockQuantity = 1,
	MaxShopStockQuantity = 1,
	ToolController = "None",
	Description = "Boogie the thieves to make them dance!",
	Rarity = "Common",
	Persistent = false,
	SinglePurchase = true,
	DisplayInShop = false,
	DisplayName = script.Name
}
local t2 = {
	COOLDOWN = 9,
	MAX_RANGE = 20,
	BOOGIE_DURATION = 7,
	HIGHLIGHT_OUTLINE_TRANSPARENCY = 0.5,
	HIGHLIGHT_FILL_TRANSPARENCY = 0.7,
	BOOGIE_ANIMATION_ID = "rbxassetid://98044165147662 ",
	BOOGIE_SFX_ID = "rbxassetid://0",
	FOV_OFFSET = 10,
	SHAKE_PRESET = "Bump",
	HIGHLIGHT_COLOR = Color3.new(255/255, 0/255, 0/255),
	FOV_TWEEN_INFO = TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
	COLOR_CORRECTION_TWEEN_INFO = TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
	COLOR_CORRECTION = {
		Saturation = -0.2,
		Brightness = 0.1,
		Contrast = 0.1
	},
	COLOR_CORRECTION_TWEEN = {
		Brightness = 0.25
	}
}
local v2 = setmetatable(table.clone(t), {
	__index = Default
})

for v3, v4 in t2 do
	v2[v3] = v4
end

return v2