-- Generated from ui/StarterPlayer/StarterPlayerScripts/Scripts/GUIs/Currency/CreditCircleOld.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "CreditCircleOld", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 223, 62), BorderSizePixel = 0, Position = UDim2.fromScale(-0.35, -2), Size = UDim2.new(0.075, 0, 0, 100), ZIndex = 0 })
		I[2] = new("UICorner", I[1], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
		I[3] = new("UIAspectRatioConstraint", I[1], "UIAspectRatioConstraint")
		I[4] = new("Frame", I[1], "Outline", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(222, 194, 54), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1.1, 0, 1, 100), ZIndex = -1 })
			I[5] = new("UICorner", I[4], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
			I[6] = new("UIAspectRatioConstraint", I[4], "UIAspectRatioConstraint")
		I[7] = new("ImageLabel", I[1], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(222, 194, 54), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=3701177967"), Position = UDim2.fromScale(0.425, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.65, 1) })
		I[8] = new("UIGradient", I[1], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(238, 238, 238)) }), Rotation = 90 })
	return I[1]
end

return build
