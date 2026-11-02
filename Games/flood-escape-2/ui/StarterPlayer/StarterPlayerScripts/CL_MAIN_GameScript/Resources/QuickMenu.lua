-- Generated from ui/StarterPlayer/StarterPlayerScripts/CL_MAIN_GameScript/Resources/QuickMenu.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ImageButton", nil, "QuickMenu", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageTransparency = 1, Position = UDim2.fromScale(0, 0.6799679), Size = UDim2.fromScale(0.7760141, 1.4449331) })
		I[2] = new("ImageLabel", I[1], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.9, 0.9) })
			I[3] = new("UIGradient", I[2], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(127, 127, 127)), ColorSequenceKeypoint.new(0.1487889, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.399654, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.8512111, Color3.fromRGB(194, 194, 194)), ColorSequenceKeypoint.new(1, Color3.fromRGB(63, 63, 63)) }), Rotation = 90 })
	return I[1]
end

return build
