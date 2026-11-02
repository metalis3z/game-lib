-- Generated from ui/ReplicatedStorage/Assets/UI/CharacterBillboard.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "CharacterBillboard", { Active = true, MaxDistance = 300, ResetOnSpawn = false, Size = UDim2.fromScale(5, 3), StudsOffsetWorldSpace = Vector3.new(0, 4, 0) })
		I[2] = new("Frame", I[1], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
			I[3] = new("ImageLabel", I[2], "ProgressBar", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://12445578494"), Position = UDim2.fromScale(0.499, 0.8), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.9, 0.2), SliceCenter = Rect.new(50, 47, 50, 47), ZIndex = 0 })
				I[4] = new("ImageLabel", I[3], "Progress", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://13650382403"), ImageTransparency = 0.25, Position = UDim2.fromScale(0, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.1325, 1), SliceCenter = Rect.new(50, 47, 50, 47) })
					I[5] = new("UIGradient", I[4], "UIGradient", { Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.0011601, 0), NumberSequenceKeypoint.new(0.0023202, 1), NumberSequenceKeypoint.new(0.4709977, 1), NumberSequenceKeypoint.new(1, 1) }) })
				I[6] = new("TextLabel", I[3], "ProgressText", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.6, 0.95), Text = "100/100", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
					I[7] = new("UIStroke", I[6], "UIStroke", { Color = Color3.fromRGB(40, 40, 40), Thickness = 2 })
					I[8] = new("UITextSizeConstraint", I[6], "UITextSizeConstraint", { MaxTextSize = 39 })
			I[9] = new("TextLabel", I[2], "Strength", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.55), Size = UDim2.fromScale(1, 0.25), Text = "11.9k Strength", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[10] = new("UIStroke", I[9], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2.5 })
			I[11] = new("UIScale", I[2], "UIScale")
			I[12] = new("TextLabel", I[2], "Rank", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.3), Size = UDim2.fromScale(1, 0.25), Text = "Novive", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[13] = new("UIStroke", I[12], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2.5 })
			I[14] = new("ImageLabel", I[2], "Shield", { Active = true, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://14267881007"), Position = UDim2.fromScale(0.5, -0.1), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1.2, 0.4) })
				I[15] = new("UIAspectRatioConstraint", I[14], "UIAspectRatioConstraint")
	return I[1]
end

return build
