-- Generated from ui/ServerStorage/Scripts_BeforeAngelShop/PassShopHandler/Icons/VIP.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "VIP", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(64, 64), ZIndex = 2 })
		I[2] = new("Frame", I[1], "Shape", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.fromOffset(14, 27), Rotation = 45, Size = UDim2.fromOffset(15, 15), ZIndex = 3 })
			I[3] = new("UIStroke", I[2], "UIStroke", { Thickness = 2 })
			I[4] = new("UIGradient", I[2], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 232, 110)), ColorSequenceKeypoint.new(1, Color3.fromRGB(72, 169, 255)) }), Rotation = 90 })
		I[5] = new("Frame", I[1], "Shape", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.fromOffset(32, 27), Rotation = 45, Size = UDim2.fromOffset(15, 15), ZIndex = 3 })
			I[6] = new("UIStroke", I[5], "UIStroke", { Thickness = 2 })
			I[7] = new("UIGradient", I[5], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 232, 110)), ColorSequenceKeypoint.new(1, Color3.fromRGB(72, 169, 255)) }), Rotation = 90 })
		I[8] = new("Frame", I[1], "Shape", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.fromOffset(50, 27), Rotation = 45, Size = UDim2.fromOffset(15, 15), ZIndex = 3 })
			I[9] = new("UIStroke", I[8], "UIStroke", { Thickness = 2 })
			I[10] = new("UIGradient", I[8], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 232, 110)), ColorSequenceKeypoint.new(1, Color3.fromRGB(72, 169, 255)) }), Rotation = 90 })
		I[11] = new("Frame", I[1], "Shape", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.fromOffset(32, 38), Size = UDim2.fromOffset(44, 18), ZIndex = 4 })
			I[12] = new("UIStroke", I[11], "UIStroke", { Thickness = 2 })
			I[13] = new("UIGradient", I[11], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 232, 110)), ColorSequenceKeypoint.new(1, Color3.fromRGB(72, 169, 255)) }), Rotation = 90 })
		I[14] = new("Frame", I[1], "Shape", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.fromOffset(32, 48), Size = UDim2.fromOffset(48, 9), ZIndex = 5 })
			I[15] = new("UIStroke", I[14], "UIStroke", { Thickness = 2 })
			I[16] = new("UIGradient", I[14], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 196, 60)), ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 156, 230)) }), Rotation = 90 })
		I[17] = new("Frame", I[1], "Shape", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 80, 100), BorderSizePixel = 0, Position = UDim2.fromOffset(32, 37), Size = UDim2.fromOffset(9, 9), ZIndex = 6 })
			I[18] = new("UIStroke", I[17], "UIStroke", { Thickness = 1.5 })
		I[19] = new("Frame", I[1], "Shape", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(110, 200, 255), BorderSizePixel = 0, Position = UDim2.fromOffset(17, 38), Size = UDim2.fromOffset(6, 6), ZIndex = 6 })
			I[20] = new("UIStroke", I[19], "UIStroke", { Thickness = 1.5 })
		I[21] = new("Frame", I[1], "Shape", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(110, 200, 255), BorderSizePixel = 0, Position = UDim2.fromOffset(47, 38), Size = UDim2.fromOffset(6, 6), ZIndex = 6 })
			I[22] = new("UIStroke", I[21], "UIStroke", { Thickness = 1.5 })
		I[23] = new("Frame", I[1], "Shape", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 250, 200), BorderSizePixel = 0, Position = UDim2.fromOffset(14, 17), Size = UDim2.fromOffset(7, 7), ZIndex = 6 })
			I[24] = new("UIStroke", I[23], "UIStroke", { Thickness = 1.5 })
		I[25] = new("Frame", I[1], "Shape", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 250, 200), BorderSizePixel = 0, Position = UDim2.fromOffset(32, 17), Size = UDim2.fromOffset(7, 7), ZIndex = 6 })
			I[26] = new("UIStroke", I[25], "UIStroke", { Thickness = 1.5 })
		I[27] = new("Frame", I[1], "Shape", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 250, 200), BorderSizePixel = 0, Position = UDim2.fromOffset(50, 17), Size = UDim2.fromOffset(7, 7), ZIndex = 6 })
			I[28] = new("UIStroke", I[27], "UIStroke", { Thickness = 1.5 })
	return I[1]
end

return build
