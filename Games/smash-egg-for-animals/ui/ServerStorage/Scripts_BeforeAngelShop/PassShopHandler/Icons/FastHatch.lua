-- Generated from ui/ServerStorage/Scripts_BeforeAngelShop/PassShopHandler/Icons/FastHatch.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "FastHatch", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(64, 64), ZIndex = 2 })
		I[2] = new("Frame", I[1], "Shape", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.fromOffset(15, 22), Size = UDim2.fromOffset(14, 4), ZIndex = 3 })
			I[3] = new("UIStroke", I[2], "UIStroke", { Thickness = 1.5 })
		I[4] = new("Frame", I[1], "Shape", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.fromOffset(12, 33), Size = UDim2.fromOffset(14, 4), ZIndex = 3 })
			I[5] = new("UIStroke", I[4], "UIStroke", { Thickness = 1.5 })
		I[6] = new("Frame", I[1], "Shape", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.fromOffset(15, 44), Size = UDim2.fromOffset(14, 4), ZIndex = 3 })
			I[7] = new("UIStroke", I[6], "UIStroke", { Thickness = 1.5 })
		I[8] = new("Frame", I[1], "Shape", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.fromOffset(38, 33), Size = UDim2.fromOffset(30, 40), ZIndex = 4 })
			I[9] = new("UIStroke", I[8], "UIStroke", { Thickness = 2.5 })
			I[10] = new("UIGradient", I[8], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 252, 235)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 214, 150)) }), Rotation = 90 })
		I[11] = new("Frame", I[1], "Shape", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(115, 199, 255), BorderSizePixel = 0, Position = UDim2.fromOffset(32, 26), Size = UDim2.fromOffset(6, 6), ZIndex = 5 })
		I[12] = new("Frame", I[1], "Shape", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(115, 199, 255), BorderSizePixel = 0, Position = UDim2.fromOffset(44, 34), Size = UDim2.fromOffset(5, 5), ZIndex = 5 })
		I[13] = new("Frame", I[1], "Shape", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(115, 199, 255), BorderSizePixel = 0, Position = UDim2.fromOffset(35, 44), Size = UDim2.fromOffset(4, 4), ZIndex = 5 })
		I[14] = new("Frame", I[1], "Shape", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 232, 80), BorderSizePixel = 0, Position = UDim2.fromOffset(44, 20), Rotation = 28, Size = UDim2.fromOffset(6, 14), ZIndex = 6 })
			I[15] = new("UIStroke", I[14], "UIStroke", { Thickness = 1.5 })
		I[16] = new("Frame", I[1], "Shape", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 232, 80), BorderSizePixel = 0, Position = UDim2.fromOffset(49, 30), Rotation = 28, Size = UDim2.fromOffset(6, 14), ZIndex = 6 })
			I[17] = new("UIStroke", I[16], "UIStroke", { Thickness = 1.5 })
		I[18] = new("Frame", I[1], "Shape", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 232, 80), BorderSizePixel = 0, Position = UDim2.fromOffset(46, 25), Size = UDim2.fromOffset(9, 5), ZIndex = 7 })
	return I[1]
end

return build
