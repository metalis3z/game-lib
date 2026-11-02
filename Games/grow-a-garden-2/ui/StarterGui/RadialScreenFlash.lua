-- Generated from ui/StarterGui/RadialScreenFlash.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "RadialScreenFlash", { ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("ImageLabel", I[1], "Green", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(13, 255, 0), ImageContent = Content.fromUri("rbxassetid://116967079950466"), ImageTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
		I[3] = new("ImageLabel", I[1], "Red", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(255, 0, 0), ImageContent = Content.fromUri("rbxassetid://116967079950466"), ImageTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Visible = false })
		I[4] = new("ImageLabel", I[1], "Rainbow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://116967079950466"), ImageTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
			I[5] = new("UIGradient", I[4], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 98)), ColorSequenceKeypoint.new(0.1111111, Color3.fromRGB(0, 229, 240)), ColorSequenceKeypoint.new(0.2222222, Color3.fromRGB(2, 70, 255)), ColorSequenceKeypoint.new(0.3333333, Color3.fromRGB(101, 0, 255)), ColorSequenceKeypoint.new(0.4444444, Color3.fromRGB(247, 0, 236)), ColorSequenceKeypoint.new(0.5555556, Color3.fromRGB(255, 2, 77)), ColorSequenceKeypoint.new(0.6666667, Color3.fromRGB(255, 95, 0)), ColorSequenceKeypoint.new(0.7777778, Color3.fromRGB(225, 237, 0)), ColorSequenceKeypoint.new(0.8888889, Color3.fromRGB(75, 255, 4)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 98)) }) }, nil, { "InfiniteGradient" })
		I[6] = new("ImageLabel", I[1], "MoonBloom", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://116967079950466"), ImageTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
			I[7] = new("UIGradient", I[6], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 111, 255)), ColorSequenceKeypoint.new(0.1111111, Color3.fromRGB(0, 97, 255)), ColorSequenceKeypoint.new(0.2222222, Color3.fromRGB(0, 135, 255)), ColorSequenceKeypoint.new(0.3333333, Color3.fromRGB(8, 167, 255)), ColorSequenceKeypoint.new(0.4444444, Color3.fromRGB(115, 128, 255)), ColorSequenceKeypoint.new(0.5555556, Color3.fromRGB(222, 89, 255)), ColorSequenceKeypoint.new(0.6666667, Color3.fromRGB(153, 114, 255)), ColorSequenceKeypoint.new(0.7777778, Color3.fromRGB(46, 153, 255)), ColorSequenceKeypoint.new(0.8888889, Color3.fromRGB(0, 148, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 111, 255)) }), Rotation = 45 }, nil, { "InfiniteGradient" })
		I[8] = new("ImageLabel", I[1], "Gold", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(255, 255, 0), ImageContent = Content.fromUri("rbxassetid://116967079950466"), ImageTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
	return I[1]
end

return build
