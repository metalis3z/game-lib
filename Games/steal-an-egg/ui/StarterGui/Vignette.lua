-- Generated from ui/StarterGui/Vignette.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Vignette", { ClipToDeviceSafeArea = false, DisplayOrder = 2, Enabled = false, ResetOnSpawn = false, SafeAreaCompatibility = Enum.SafeAreaCompatibility.None, ScreenInsets = Enum.ScreenInsets.None, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Sound", I[1], "Ambience", { Looped = true, RollOffMaxDistance = 17.5073166, RollOffMinDistance = 0.8753659, RollOffMode = Enum.RollOffMode.InverseTapered, Volume = 1 })
		I[3] = new("Frame", I[1], "Vignette", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 2 })
			I[4] = new("ImageLabel", I[3], "Blue", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 26, 255), ImageContent = Content.fromUri("rbxassetid://104574024062008"), ImageTransparency = 0.56, Position = UDim2.fromScale(0.6, 0.5), Size = UDim2.fromScale(1.2, 1), ZIndex = 2 })
			I[5] = new("ImageLabel", I[3], "Red", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(255, 0, 0), ImageContent = Content.fromUri("rbxassetid://104574024062008"), ImageTransparency = 0.56, Position = UDim2.fromScale(0.4, 0.5), Size = UDim2.fromScale(1.2, 1) })
			I[6] = new("UIScale", I[3], "UIScale", { Scale = 2.2 })
			I[7] = new("ImageLabel", I[3], "Black", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://104574024062008"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 10 })
		I[8] = new("ImageLabel", I[1], "FilmGrain", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 4, 59), ImageContent = Content.fromUri("rbxassetid://132842658650580"), Position = UDim2.fromScale(0.5, 0.5), ResampleMode = Enum.ResamplerMode.Pixelated, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(0, 0, 1024, 1024), TileSize = UDim2.fromScale(0.1, 0.2), Visible = false })
		I[9] = new("Frame", I[1], "Binoculars", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 5 })
			I[10] = new("ImageLabel", I[9], "BinocularsView", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://118013693693130"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(0, 0, 256, 144), Visible = false, ZIndex = 5 })
			I[11] = new("UIAspectRatioConstraint", I[9], "UIAspectRatioConstraint", { AspectRatio = 1.7777778 })
			I[12] = new("Frame", I[9], "Frame", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(-0.999, 0), Size = UDim2.fromScale(1, 1), Visible = false })
			I[13] = new("Frame", I[9], "Frame_2", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.999, 0), Size = UDim2.fromScale(1, 1), Visible = false })
			I[14] = new("Frame", I[9], "Frame_3", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.999), Size = UDim2.fromScale(1, 1), Visible = false })
			I[15] = new("Frame", I[9], "Frame_4", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, -0.999), Size = UDim2.fromScale(1, 1), Visible = false })
	return I[1]
end

return build
