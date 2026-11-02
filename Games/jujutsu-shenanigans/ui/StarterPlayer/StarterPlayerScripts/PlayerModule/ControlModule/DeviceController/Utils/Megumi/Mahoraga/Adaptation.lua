-- Generated from ui/StarterPlayer/StarterPlayerScripts/PlayerModule/ControlModule/DeviceController/Utils/Megumi/Mahoraga/Adaptation.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Adaptation", { ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("ImageLabel", I[1], "Wheel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://17594182704"), ImageTransparency = 1, Position = UDim2.new(0.5, 0, 1, -173), Size = UDim2.new(0.03, 60, 0.03, 60), SizeConstraint = Enum.SizeConstraint.RelativeYY, ZIndex = 2 })
			I[3] = new("ImageLabel", I[2], "Glow", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://284205403"), ImageTransparency = 1, Size = UDim2.fromScale(1, 1) })
		I[4] = new("ImageLabel", I[1], "WheelBG", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(255, 0, 0), ImageContent = Content.fromUri("rbxassetid://17594182704"), ImageTransparency = 1, Position = UDim2.new(0.5, 0, 1, -170), Size = UDim2.new(0.03, 60, 0.03, 60), SizeConstraint = Enum.SizeConstraint.RelativeYY })
			I[5] = new("UIGradient", I[4], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(138, 138, 138)) }), Rotation = 90 })
		I[6] = new("ImageLabel", I[1], "Type", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(255, 0, 0), ImageContent = Content.fromUri("rbxassetid://7485051715"), ImageTransparency = 1, Position = UDim2.new(0.5, 0, 1, -173), Size = UDim2.new(0.02, 20, 0.02, 20), SizeConstraint = Enum.SizeConstraint.RelativeYY, ZIndex = 3 })
	return I[1]
end

return build
