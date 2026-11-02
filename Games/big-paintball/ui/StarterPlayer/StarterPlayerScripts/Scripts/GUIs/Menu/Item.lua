-- Generated from ui/StarterPlayer/StarterPlayerScripts/Scripts/GUIs/Menu/Item.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ImageButton", nil, "Item", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=3834644695"), LayoutOrder = -1, Position = UDim2.fromScale(0.4, 1.1), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(10, 10, 40, 40) })
		I[2] = new("ImageLabel", I[1], "Thumbnail", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://4352529512"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), ZIndex = 2 })
		I[3] = new("ImageLabel", I[1], "Locked", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://6237952978"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.45, 0.5), SliceCenter = Rect.new(10, 10, 40, 40), SliceScale = 0.5, Visible = false, ZIndex = 5 })
		I[4] = new("ImageLabel", I[1], "Equipped", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=4010233435"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.4, 1), SliceCenter = Rect.new(10, 10, 40, 40), Visible = false, ZIndex = 5 })
			I[5] = new("UIAspectRatioConstraint", I[4], "UIAspectRatioConstraint")
			I[6] = new("ImageLabel", I[4], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(62, 255, 139), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=3960762769"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.5, 0.5), ZIndex = 5 })
		I[7] = new("StringValue", I[1], "State")
		I[8] = new("ImageLabel", I[1], "Limited", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://4790581719"), Position = UDim2.fromScale(0.925, 0.075), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.6, 0.6), Visible = false })
			I[9] = new("UIGradient", I[8], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 112, 253)), ColorSequenceKeypoint.new(0.332779, Color3.fromRGB(255, 55, 152)), ColorSequenceKeypoint.new(0.637271, Color3.fromRGB(255, 112, 253)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 55, 152)) }), Offset = Vector2.new(-0.2, 0.2), Rotation = -720 })
		I[10] = new("ImageLabel", I[1], "Quality", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=4010121377"), Position = UDim2.fromScale(0.925, 0.075), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.6, 0.6), Visible = false })
			I[11] = new("UIGradient", I[10], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(75, 216, 255)), ColorSequenceKeypoint.new(0.339434, Color3.fromRGB(131, 255, 245)), ColorSequenceKeypoint.new(0.657238, Color3.fromRGB(75, 216, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(131, 255, 245)) }) })
		I[12] = new("ImageLabel", I[1], "Premium", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=4010555809"), Position = UDim2.fromScale(0.925, 0.075), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.6, 0.6), Visible = false })
			I[13] = new("UIGradient", I[12], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 223, 62)), ColorSequenceKeypoint.new(0.262895, Color3.fromRGB(255, 247, 133)), ColorSequenceKeypoint.new(0.494176, Color3.fromRGB(255, 223, 62)), ColorSequenceKeypoint.new(0.770383, Color3.fromRGB(255, 247, 133)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 223, 62)) }), Rotation = -720 })
	return I[1]
end

return build
