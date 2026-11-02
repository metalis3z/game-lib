--!strict
-- LOCATION: ReplicatedStorage/Shared/RarityColor
-- Provides rarity color mapping and ordering for the AdminPanel

local RarityColor = {}

-- Rarity ordering (lower = more common)
RarityColor.RARITY_ORDER = {
	Common = 1,
	Uncommon = 2,
	Rare = 3,
	Epic = 4,
	Legendary = 5,
	Mythical = 6,
	Secret = 7,
	Especial = 8,
}

-- Rarity colors
RarityColor.RARITY_COLORS = {
	Common = Color3.fromRGB(180, 180, 180),
	Uncommon = Color3.fromRGB(100, 220, 100),
	Rare = Color3.fromRGB(100, 150, 255),
	Epic = Color3.fromRGB(180, 100, 255),
	Legendary = Color3.fromRGB(255, 200, 50),
	Mythical = Color3.fromRGB(255, 100, 100),
	Secret = Color3.fromRGB(255, 50, 200),
	Especial = Color3.fromRGB(0, 255, 200),
}

function RarityColor.GetRarityColor(rarity: string?): Color3
	if not rarity then return Color3.fromRGB(255, 255, 255) end
	return RarityColor.RARITY_COLORS[rarity] or Color3.fromRGB(255, 255, 255)
end

function RarityColor.ApplyStroke(guiObject: Instance, rarity: string?)
	if not (guiObject and guiObject:IsA("GuiObject")) then return end
	if not rarity then return end
	
	local color = RarityColor.GetRarityColor(rarity)
	
	local stroke = guiObject:FindFirstChildOfClass("UIStroke")
	if not stroke then
		stroke = Instance.new("UIStroke")
		stroke.Parent = guiObject
	end
	
	stroke.Color = color
	stroke.Thickness = 2
	stroke.Transparency = 0.2
	stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
end

return RarityColor