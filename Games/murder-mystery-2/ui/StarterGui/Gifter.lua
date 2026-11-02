-- Generated from ui/StarterGui/Gifter.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Gifter", { Enabled = false, ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "ContainerOld", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(248, 248, 248), BorderColor3 = Color3.fromRGB(124, 124, 124), BorderSizePixel = 3, Position = UDim2.new(0.5, 0, 1, -159), Size = UDim2.fromOffset(300, 30), Visible = false })
			I[3] = new("TextLabel", I[2], "GiftCount", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "You have 0 gifts", TextColor3 = Color3.fromRGB(99, 99, 99), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[4] = new("Frame", I[2], "PlayerName", { AnchorPoint = Vector2.new(0.5, 1), AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(248, 248, 248), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(124, 124, 124), BorderSizePixel = 3, Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(1, 1) })
				I[5] = new("TextLabel", I[4], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "PlayerName", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
			I[6] = new("TextLabel", I[2], "Instructions", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 1), Size = UDim2.fromScale(1, 0.8), Text = "Click on a player to gift them", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.3, TextWrapped = true })
		I[7] = new("Frame", I[1], "Container", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.4, Position = UDim2.fromScale(0.5, 0.8), Size = UDim2.fromScale(0.5, 0.25) })
			I[8] = new("TextLabel", I[7], "GiftCount", { BackgroundColor3 = Color3.fromRGB(84, 99, 147), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 0.4), Text = "You have 0 gifts", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
			I[9] = new("TextButton", I[7], "Confirm", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), ClipsDescendants = true, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Modal = true, Position = UDim2.fromScale(0, 0.4), Size = UDim2.fromScale(1, 0.6), Style = Enum.ButtonStyle.RobloxRoundDefaultButton, Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
				I[10] = new("TextLabel", I[9], "Player", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, 6, 1, 0), Text = "Send Gift: playerName", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
			I[11] = new("UIStroke", I[7], "UIStroke", { Color = Color3.fromRGB(63, 63, 63), Thickness = 4, Transparency = 0.3 })
			I[12] = new("UIPadding", I[7], "UIPadding", { PaddingBottom = UDim.new(0, 3), PaddingLeft = UDim.new(0, 3), PaddingRight = UDim.new(0, 3), PaddingTop = UDim.new(0, 3) })
			I[13] = new("UISizeConstraint", I[7], "UISizeConstraint", { MaxSize = Vector2.new(300, math.huge) })
			I[14] = new("UIAspectRatioConstraint", I[7], "UIAspectRatioConstraint", { AspectRatio = 3.5 })
			I[15] = new("Frame", I[7], "Instructions", { BackgroundColor3 = Color3.fromRGB(91, 128, 154), Position = UDim2.fromScale(0, 0.4), Size = UDim2.fromScale(1, 0.6), Visible = false, ZIndex = 3 })
				I[16] = new("TextLabel", I[15], "Instructions", { BackgroundColor3 = Color3.fromRGB(91, 128, 154), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "Click on a player to gift them", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.3, TextWrapped = true, ZIndex = 2 })
				I[17] = new("UIPadding", I[15], "UIPadding", { PaddingLeft = UDim.new(0, 2), PaddingRight = UDim.new(0, 2) })
			I[18] = new("TextButton", I[7], "Sent", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), ClipsDescendants = true, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.4), Size = UDim2.fromScale(1, 0.6), Style = Enum.ButtonStyle.RobloxRoundButton, Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, Visible = false, ZIndex = 2 })
				I[19] = new("TextLabel", I[18], "Player", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, 6, 1, 0), Text = "SENT!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
			I[20] = new("UIGradient", I[7], "Summer", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 207, 94)), ColorSequenceKeypoint.new(0.3287197, Color3.fromRGB(255, 207, 94)), ColorSequenceKeypoint.new(0.5813149, Color3.fromRGB(0, 255, 0)), ColorSequenceKeypoint.new(0.8304499, Color3.fromRGB(0, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 255)) }), Rotation = 90 })
			I[21] = new("UICorner", I[7], "UICorner")
	return I[1]
end

return build
