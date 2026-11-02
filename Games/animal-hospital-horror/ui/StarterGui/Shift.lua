-- Generated from ui/StarterGui/Shift.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Shift", { DisplayOrder = 3, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(0.6, 0.2) })
			I[3] = new("TextLabel", I[2], "strikes", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187376739", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.7500001), Size = UDim2.fromScale(0.5986864, 0.3269233), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 6 })
				I[4] = new("UIListLayout", I[3], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, HorizontalFlex = Enum.UIFlexAlignment.Fill, Padding = UDim.new(0.1, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
			I[5] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 4.1199999 })
			I[6] = new("TextLabel", I[2], "header", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187376739", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = -2, Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(0.8500965, 0.2135668), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Top, ZIndex = 6 })
				I[7] = new("UIStroke", I[6], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel })
				I[8] = new("UIGradient", I[6], "UIGradient", { Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.1403712, 0.30625), NumberSequenceKeypoint.new(0.2099768, 0.1), NumberSequenceKeypoint.new(0.3039443, 0), NumberSequenceKeypoint.new(0.4988399, 0), NumberSequenceKeypoint.new(0.7018561, 0.00625), NumberSequenceKeypoint.new(0.7993039, 0.15), NumberSequenceKeypoint.new(0.8677494, 0.35625), NumberSequenceKeypoint.new(1, 1) }) })
				I[9] = new("TextLabel", I[6], "text", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187376739", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = -2, Position = UDim2.fromScale(0.4975215, 0.8941053), Size = UDim2.fromScale(0.6, 1), Text = "Shift 1", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Top, ZIndex = 6 })
					I[10] = new("UIStroke", I[9], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel })
					I[11] = new("UIGradient", I[9], "UIGradient", { Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.1403712, 0.30625), NumberSequenceKeypoint.new(0.2099768, 0.1), NumberSequenceKeypoint.new(0.3039443, 0), NumberSequenceKeypoint.new(0.4988399, 0), NumberSequenceKeypoint.new(0.7018561, 0.00625), NumberSequenceKeypoint.new(0.7993039, 0.15), NumberSequenceKeypoint.new(0.8677494, 0.35625), NumberSequenceKeypoint.new(1, 1) }) })
				I[12] = new("UIScale", I[6], "UIScale", nil, { ["GoalScale"] = 1.2 })
			I[13] = new("TextLabel", I[2], "sep", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187371840", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = -1, Position = UDim2.fromScale(0.4999999, 0.3205505), Size = UDim2.fromScale(0.673826, 0.025), Text = "", TextColor3 = Color3.fromRGB(178, 177, 179), TextScaled = true, TextSize = 18, TextWrapped = true, Visible = false, ZIndex = 6 })
				I[14] = new("UIStroke", I[13], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2 })
				I[15] = new("UIGradient", I[13], "UIGradient", { Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.199536, 0.46875), NumberSequenceKeypoint.new(0.4988399, 0), NumberSequenceKeypoint.new(0.7981438, 0.475), NumberSequenceKeypoint.new(1, 1) }) })
			I[16] = new("Folder", I[2], "Folder")
				I[17] = new("ImageLabel", I[16], "Template", { Active = true, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(254, 252, 255), ImageContent = Content.fromUri("rbxassetid://12560510770"), LayoutOrder = 1000, Position = UDim2.fromScale(0.5, 0.5), Selectable = true, Size = UDim2.fromScale(0.625, 1), Visible = false, ZIndex = 0 })
					I[18] = new("UIAspectRatioConstraint", I[17], "UIAspectRatioConstraint")
					I[19] = new("ViewportFrame", I[17], "viewport", { Ambient = Color3.fromRGB(152, 152, 152), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LightColor = Color3.fromRGB(200, 200, 200), LightDirection = Vector3.new(-1, 1, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(3, 3), ZIndex = 2 })
						I[20] = new("WorldModel", I[19], "WorldModel")
						I[21] = new("Part", I[19], "RootPart", { CFrame = CFrame.new(0, -1.2, 0.4, 0.9681025, -0.0163111, 0.2500229, -0.0505947, 0.9645958, 0.2588342, -0.2453929, -0.2632279, 0.9330024), Size = Vector3.new(2.5, 2.5, 1.25), Transparency = 1 })
					I[22] = new("TextLabel", I[17], "strikes", { AnchorPoint = Vector2.new(1, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(1, 1), Size = UDim2.fromScale(0.3121695, 0.3269233), Text = "X", TextColor3 = Color3.fromRGB(255, 38, 0), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 6 })
					I[23] = new("Decal", I[17], "The Riddling Skull Badge", { TextureContent = Content.fromUri("rbxassetid://74871990") })
						I[24] = new("Decal", I[23], "mr skull", { TextureContent = Content.fromUri("rbxassetid://409226202") })
	return I[1]
end

return build
