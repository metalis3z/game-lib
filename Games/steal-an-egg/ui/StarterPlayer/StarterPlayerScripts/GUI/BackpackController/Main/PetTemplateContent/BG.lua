-- Generated from ui/StarterPlayer/StarterPlayerScripts/GUI/BackpackController/Main/PetTemplateContent/BG.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "BG", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.65, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Size = UDim2.fromScale(1, 1), ZIndex = 20 })
		I[2] = new("UICorner", I[1], "UICorner", { BottomLeftRadius = UDim.new(0.03, 0), BottomRightRadius = UDim.new(0.03, 0), TopLeftRadius = UDim.new(0.03, 0), TopRightRadius = UDim.new(0.03, 0) })
		I[3] = new("ImageLabel", I[1], "Glow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(25, 144, 255), ImageContent = Content.fromUri("rbxassetid://126841495627073"), Position = UDim2.fromScale(0.4723356, 0.6840919), Size = UDim2.fromScale(1.941677, 1.3363403), ZIndex = 0 })
			I[4] = new("UIGradient", I[3], "UIGradient")
		I[5] = new("UIStroke", I[1], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Thickness = 3 })
		I[6] = new("ImageLabel", I[1], "Pattern", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(10, 10, 10), ImageContent = Content.fromUri("rbxassetid://127017111273742"), ImageTransparency = 0.3, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(0, 256, 0, 256), TileSize = UDim2.fromOffset(300, 300) })
		I[7] = new("ImageLabel", I[1], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://124874009929433"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
	return I[1]
end

return build
