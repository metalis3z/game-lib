-- Generated from ui/ReplicatedStorage/Assets/MoneyChange.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "MoneyChange", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.77), Size = UDim2.fromScale(0.9999999, 0.24168), ZIndex = 2 })
		I[2] = new("TextLabel", I[1], "Label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "$0", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextTransparency = 0.25, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 2 })
			I[3] = new("UIStroke", I[2], "UIStroke", { Thickness = 1.5, Transparency = 0.25 })
			I[4] = new("UIGradient", I[2], "Less", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(196, 0, 3)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 108, 110)) }), Enabled = false, Rotation = 270 })
			I[5] = new("UIGradient", I[2], "More", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(77, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(19, 194, 0)) }), Enabled = false, Rotation = 90 })
		I[6] = new("UIListLayout", I[1], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
		I[7] = new("ImageLabel", I[1], "Icon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.2108759, 0), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.067499, 1), Visible = false })
			I[8] = new("UIAspectRatioConstraint", I[7], "UIAspectRatioConstraint", { AspectRatio = 1.3231632 })
		I[9] = new("UIScale", I[1], "UIScale")
		I[10] = new("ImageLabel", I[1], "Brainrot", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.2108759, 0), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.067499, 1), Visible = false })
			I[11] = new("UIAspectRatioConstraint", I[10], "UIAspectRatioConstraint", { AspectRatio = 1.3231632 })
		I[12] = new("ImageLabel", I[1], "EggIcon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.2108759, 0), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.067499, 1), Visible = false })
			I[13] = new("UIAspectRatioConstraint", I[12], "UIAspectRatioConstraint", { AspectRatio = 1.3231632 })
	return I[1]
end

return build
