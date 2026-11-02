-- Generated from ui/ReplicatedStorage/Assets/UI/FreeGifts/Slot.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("TextButton", nil, "Slot", { AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 2, Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 18, ZIndex = 2 }, { ["Tick"] = 0 })
		I[2] = new("UIAspectRatioConstraint", I[1], "UIAspectRatioConstraint")
		I[3] = new("Frame", I[1], "Progress", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.8, 1), ZIndex = 4 })
			I[4] = new("ImageLabel", I[3], "Left", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://96652414317905"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), ZIndex = 5 })
				I[5] = new("UIGradient", I[4], "UIGradient", { Rotation = 180, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.499, 0), NumberSequenceKeypoint.new(0.5, 1), NumberSequenceKeypoint.new(1, 1) }) })
			I[6] = new("ImageLabel", I[3], "Right", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://101177892736984"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), ZIndex = 5 })
				I[7] = new("UIGradient", I[6], "UIGradient", { Rotation = 180, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.499, 0), NumberSequenceKeypoint.new(0.5, 1), NumberSequenceKeypoint.new(1, 1) }) })
			I[8] = new("UIAspectRatioConstraint", I[3], "UIAspectRatioConstraint")
		I[9] = new("ImageLabel", I[1], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://117608174395485"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.9, 0.9), ZIndex = 3 })
		I[10] = new("TextLabel", I[1], "Timer", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LineHeight = 0.8, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 0.35), Text = "4:49", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextWrapped = true, ZIndex = 5 })
			I[11] = new("UIStroke", I[10], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 3 })
		I[12] = new("UIGradient", I[1], "UIGradient")
	return I[1]
end

return build
