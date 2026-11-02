-- Generated from ui/StarterGui/EmergencyCounter.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "EmergencyCounter", { DisplayOrder = 4, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.None, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.new(1, -15, 0.3, 0), Size = UDim2.fromScale(0.1558459, 0.1049024), Visible = false })
			I[3] = new("Folder", I[2], "Templates")
				I[4] = new("Frame", I[3], "Frame", { Active = true, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5112735), Selectable = true, Size = UDim2.fromScale(1, 0.4297319), Visible = false })
					I[5] = new("UICorner", I[4], "UICorner", { BottomLeftRadius = UDim.new(0, 5), BottomRightRadius = UDim.new(0, 5), TopLeftRadius = UDim.new(0, 5), TopRightRadius = UDim.new(0, 5) })
					I[6] = new("UIGradient", I[4], "UIGradient", { Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.5), NumberSequenceKeypoint.new(0.675, 0.5), NumberSequenceKeypoint.new(1, 1) }) })
					I[7] = new("TextLabel", I[4], "text", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5755684, 0.5), RichText = true, Size = UDim2.fromScale(0.7096838, 0.7), Text = "Patient being eaten in room 5", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 6 }, { ["goal"] = "Get near tv" })
						I[8] = new("UIStroke", I[7], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel })
					I[9] = new("Frame", I[4], "square", { Active = true, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.1, 0.5), Selectable = true, Size = UDim2.fromScale(1, 1) })
						I[10] = new("UIAspectRatioConstraint", I[9], "UIAspectRatioConstraint")
						I[11] = new("UIStroke", I[9], "UIStroke")
					I[12] = new("TextLabel", I[4], "timer", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1, 0.5), RichText = true, Size = UDim2.fromScale(0.1390126, 0.535162), Text = "99s", TextColor3 = Color3.fromRGB(255, 0, 0), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 6 }, { ["goal"] = "Get near tv" })
						I[13] = new("UIStroke", I[12], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel })
			I[14] = new("Frame", I[2], "Feed", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) })
				I[15] = new("UIListLayout", I[14], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.05, 0), SortOrder = Enum.SortOrder.LayoutOrder })
				I[16] = new("TextLabel", I[14], "daily", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = -1, Position = UDim2.fromScale(0.4999999, 0.2114802), Size = UDim2.fromScale(0.673826, 0.1714075), Text = "EMERGENCIES", TextColor3 = Color3.fromRGB(255, 251, 0), TextScaled = true, TextSize = 18, TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 6 })
					I[17] = new("UIStroke", I[16], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel })
					I[18] = new("UIGradient", I[16], "UIGradient", { Enabled = false, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.1403712, 0.30625), NumberSequenceKeypoint.new(0.2099768, 0.1), NumberSequenceKeypoint.new(0.3039443, 0), NumberSequenceKeypoint.new(0.4988399, 0), NumberSequenceKeypoint.new(0.7018561, 0.00625), NumberSequenceKeypoint.new(0.7993039, 0.15), NumberSequenceKeypoint.new(0.8677494, 0.35625), NumberSequenceKeypoint.new(1, 1) }) })
				I[19] = new("TextLabel", I[14], "sep", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 251, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187371840", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = -1, Position = UDim2.fromScale(0.4999999, 0.3205505), Size = UDim2.fromScale(0.673826, 0.025), Text = "", TextColor3 = Color3.fromRGB(178, 177, 179), TextScaled = true, TextSize = 18, TextWrapped = true, ZIndex = 6 })
					I[20] = new("UIStroke", I[19], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2 })
					I[21] = new("UIGradient", I[19], "UIGradient", { Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.199536, 0.70625), NumberSequenceKeypoint.new(0.5, 0.525), NumberSequenceKeypoint.new(0.7958236, 0.675), NumberSequenceKeypoint.new(1, 1) }) })
			I[22] = new("UIListLayout", I[2], "UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Bottom })
			I[23] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 2.2 })
			I[24] = new("UIScale", I[2], "UIScale", { Scale = 1.35 }, { ["BaseScale"] = 1.35, ["GoalScale"] = 2.1 })
	return I[1]
end

return build
