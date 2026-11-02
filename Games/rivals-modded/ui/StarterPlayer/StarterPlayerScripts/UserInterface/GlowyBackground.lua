-- Generated from ui/StarterPlayer/StarterPlayerScripts/UserInterface/GlowyBackground.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "GlowyBackground", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = -100 })
		I[2] = new("ImageLabel", I[1], "Purple", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(58, 34, 111), ImageContent = Content.fromUri("rbxassetid://71305144748855"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(10, 10), SizeConstraint = Enum.SizeConstraint.RelativeXX, TileSize = UDim2.fromOffset(2000, 2000) })
		I[3] = new("ImageLabel", I[1], "Yellow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(255, 215, 0), ImageContent = Content.fromUri("rbxassetid://78667945674716"), ImageTransparency = 0.7, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(10, 10), SizeConstraint = Enum.SizeConstraint.RelativeXX, TileSize = UDim2.fromOffset(2000, 2000) })
		I[4] = new("ImageLabel", I[1], "Black", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://78667945674716"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(10, 10), SizeConstraint = Enum.SizeConstraint.RelativeXX, TileSize = UDim2.fromOffset(3000, 3000), ZIndex = 2 })
		I[5] = new("ImageLabel", I[1], "Purple2", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(58, 34, 111), ImageContent = Content.fromUri("rbxassetid://71305144748855"), ImageTransparency = 0.5, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(10, 10), SizeConstraint = Enum.SizeConstraint.RelativeXX, TileSize = UDim2.fromOffset(1000, 1000) })
	return I[1]
end

return build
