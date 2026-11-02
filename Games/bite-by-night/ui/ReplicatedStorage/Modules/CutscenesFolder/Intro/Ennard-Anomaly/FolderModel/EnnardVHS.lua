-- Generated from ui/ReplicatedStorage/Modules/CutscenesFolder/Intro/Ennard-Anomaly/FolderModel/EnnardVHS.rbxm by _tools/rbxm2lua.luau
-- UI builder: local gui = require(this)(); gui.Parent = game.Players.LocalPlayer.PlayerGui (or StarterGui)

local function new(class, parent, name, props, attrs, tags)
	local o = Instance.new(class)
	o.Name = name
	if props then
		for k, v in props do
			o[k] = v
		end
	end
	if attrs then
		for k, v in attrs do
			o:SetAttribute(k, v)
		end
	end
	if tags then
		for _, t in tags do
			o:AddTag(t)
		end
	end
	if parent then
		o.Parent = parent
	end
	return o
end

local function build()
	local I = {}
	I[1] = new("ScreenGui", nil, "EnnardVHS", { SafeAreaCompatibility = Enum.SafeAreaCompatibility.None, ScreenInsets = Enum.ScreenInsets.None, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("UIListLayout", I[1], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, HorizontalFlex = Enum.UIFlexAlignment.Fill, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
		I[3] = new("CanvasGroup", I[1], "Holder", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.98, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.6800001, 1) })
			I[4] = new("UIAspectRatioConstraint", I[3], "UIAspectRatioConstraint", { AspectRatio = 1.2066609, AspectType = Enum.AspectType.ScaleWithParentSize })
			I[5] = new("UIStroke", I[3], "Black", { StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 25 })
			I[6] = new("ImageLabel", I[3], "Static1", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://135927051711724"), ImageTransparency = 0.91, Position = UDim2.fromScale(0.5, 0.5), ResampleMode = Enum.ResamplerMode.Pixelated, Size = UDim2.fromScale(1, 1), ZIndex = 3 })
			I[7] = new("ImageLabel", I[3], "Static2", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://137864525305507"), ImageTransparency = 0.9, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 4 })
			I[8] = new("ImageLabel", I[3], "Static3", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://77041023963523"), ImageTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Rotation = 180, ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(50, 79, 75, 88), SliceScale = 6, ZIndex = 5 })
			I[9] = new("ImageLabel", I[3], "Static4", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://13928716599"), ImageTransparency = 0.98, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Crop, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(50, 79, 75, 88), ZIndex = 6 })
			I[10] = new("ImageLabel", I[3], "Static", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://135927051711724"), ImageTransparency = 0.74, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(4, 1), TileSize = UDim2.fromOffset(400, 400), ZIndex = -3 })
			I[11] = new("ImageLabel", I[3], "PLAY", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://79011358792964"), ImageTransparency = 0.87, Position = UDim2.fromScale(0.0128643, 0.0065359), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.1710655, 0.1283608), ZIndex = -100 })
			I[12] = new("ImageLabel", I[3], "SLP", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://76013647676334"), ImageTransparency = 0.87, Position = UDim2.fromScale(-0.0250516, 0.8810138), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.1782531, 0.1326973), ZIndex = -100 })
			I[13] = new("ImageLabel", I[3], "DATE", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://133567491497221"), ImageTransparency = 0.87, Position = UDim2.fromScale(0.6979417, 0.8959041), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.3838192, 0.1300954), ZIndex = -100 })
			I[14] = new("ImageLabel", I[3], "TIME", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://88990313573530"), ImageTransparency = 0.87, Position = UDim2.fromScale(0.7677063, 0.8455881), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.3191306, 0.1023417), ZIndex = -100 })
			I[15] = new("ImageLabel", I[3], "Vignette", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://12754479702"), ImageTransparency = 0.96, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 25 })
	return I[1]
end

return build
