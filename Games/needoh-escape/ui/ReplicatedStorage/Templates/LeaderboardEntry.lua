-- Generated from ui/ReplicatedStorage/Templates/LeaderboardEntry.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "LeaderboardEntry", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.65, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 0.05) })
		I[2] = new("TextLabel", I[1], "RankLabel", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(0.15, 0.8), Text = "#0", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 40, TextStrokeColor3 = Color3.fromRGB(30, 30, 30), TextStrokeTransparency = 0, TextWrapped = true })
			I[3] = new("UIStroke", I[2], "Stroke", { Thickness = 3 })
		I[4] = new("TextLabel", I[1], "NameLabel", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.15, 0.5), Size = UDim2.fromScale(0.2724044, 0.8), Text = "Player0", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 40, TextStrokeTransparency = 0, TextWrapped = true })
			I[5] = new("UIStroke", I[4], "Stroke", { Thickness = 3 })
		I[6] = new("TextLabel", I[1], "ScoreLabel", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4224046, 0.5), Size = UDim2.fromScale(0.2604641, 0.8), Text = "0s", TextColor3 = Color3.fromRGB(255, 200, 0), TextScaled = true, TextSize = 40, TextStrokeTransparency = 0, TextWrapped = true })
			I[7] = new("UIStroke", I[6], "Stroke", { Thickness = 3 })
		I[8] = new("UICorner", I[1], "UICorner")
		I[9] = new("UIListLayout", I[1], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 5), SortOrder = Enum.SortOrder.LayoutOrder })
		I[10] = new("TextButton", I[1], "View", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.8140165, 0.3922414), Size = UDim2.fromOffset(100, 50), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false })
			I[11] = new("UICorner", I[10], "UICorner", { BottomLeftRadius = UDim.new(0, 11), BottomRightRadius = UDim.new(0, 11), TopLeftRadius = UDim.new(0, 11), TopRightRadius = UDim.new(0, 11) })
			I[12] = new("UIGradient", I[10], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(99, 49, 148)) }), Rotation = 100 })
			I[13] = new("UIStroke", I[10], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(103, 103, 103), Thickness = 2 })
				I[14] = new("UIGradient", I[13], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(99, 49, 148)) }), Rotation = 100 })
			I[15] = new("TextLabel", I[10], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Size = UDim2.fromOffset(100, 50), Text = "View", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[16] = new("UIStroke", I[15], "UIStroke", { Color = Color3.fromRGB(103, 103, 103), Thickness = 2 })
					I[17] = new("UIGradient", I[16], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(99, 49, 148)) }), Rotation = 100 })
	return I[1]
end

return build
