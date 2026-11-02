-- Generated from ui/ServerScriptService/Giver/BanGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "BanGui", { Enabled = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "BanMainFrame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(88, 88, 88), Position = UDim2.fromScale(0.5, 0.5114007), Size = UDim2.fromOffset(563, 337), ZIndex = 6 })
			I[3] = new("TextBox", I[2], "Username", { BackgroundColor3 = Color3.fromRGB(88, 88, 88), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), PlaceholderColor3 = Color3.fromRGB(178, 178, 178), PlaceholderText = "USERNAME", Position = UDim2.fromScale(0.0461812, 0.0563798), Size = UDim2.fromOffset(511, 45), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 4 })
				I[4] = new("UIGradient", I[3], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(57, 57, 57)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }), Rotation = -90 })
				I[5] = new("UICorner", I[3], "UICorner", { BottomLeftRadius = UDim.new(0, 5), BottomRightRadius = UDim.new(0, 5), TopLeftRadius = UDim.new(0, 5), TopRightRadius = UDim.new(0, 5) })
			I[6] = new("TextBox", I[2], "Reason", { BackgroundColor3 = Color3.fromRGB(88, 88, 88), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), PlaceholderColor3 = Color3.fromRGB(178, 178, 178), PlaceholderText = "REASON", Position = UDim2.fromScale(0.0852575, 0.231454), Size = UDim2.fromOffset(467, 45), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 4 })
				I[7] = new("UIGradient", I[6], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(57, 57, 57)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }), Rotation = -90 })
				I[8] = new("UICorner", I[6], "UICorner", { BottomLeftRadius = UDim.new(0, 5), BottomRightRadius = UDim.new(0, 5), TopLeftRadius = UDim.new(0, 5), TopRightRadius = UDim.new(0, 5) })
			I[9] = new("TextButton", I[2], "BanButton", { BackgroundColor3 = Color3.fromRGB(255, 0, 0), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0213144, 0.6884273), Size = UDim2.fromOffset(254, 55), Text = "Ban", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 4 })
				I[10] = new("UICorner", I[9], "UICorner", { BottomLeftRadius = UDim.new(6, 9), BottomRightRadius = UDim.new(6, 9), TopLeftRadius = UDim.new(6, 9), TopRightRadius = UDim.new(6, 9) })
				I[11] = new("UIGradient", I[9], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(57, 57, 57)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }), Rotation = -90 })
			I[12] = new("TextButton", I[2], "UnbanButton", { BackgroundColor3 = Color3.fromRGB(0, 255, 0), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5293073, 0.6884273), Size = UDim2.fromOffset(254, 55), Text = "Unban", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 4 })
				I[13] = new("UICorner", I[12], "UICorner", { BottomLeftRadius = UDim.new(6, 9), BottomRightRadius = UDim.new(6, 9), TopLeftRadius = UDim.new(6, 9), TopRightRadius = UDim.new(6, 9) })
				I[14] = new("UIGradient", I[12], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(57, 57, 57)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }), Rotation = -90 })
			I[15] = new("UIGradient", I[2], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(57, 57, 57)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }), Rotation = -90 })
			I[16] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0, 5), BottomRightRadius = UDim.new(0, 5), TopLeftRadius = UDim.new(0, 5), TopRightRadius = UDim.new(0, 5) })
			I[17] = new("TextButton", I[2], "Close", { BackgroundColor3 = Color3.fromRGB(255, 0, 4), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.166099, 0.4462467), Size = UDim2.fromOffset(374, 50), Text = "CLOSE", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 4 })
				I[18] = new("UICorner", I[17], "UICorner", { BottomLeftRadius = UDim.new(6, 9), BottomRightRadius = UDim.new(6, 9), TopLeftRadius = UDim.new(6, 9), TopRightRadius = UDim.new(6, 9) })
				I[19] = new("UIGradient", I[17], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(57, 57, 57)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }), Rotation = -90 })
			I[20] = new("TextLabel", I[2], "TextLabel", { BackgroundColor3 = Color3.fromRGB(88, 88, 88), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2362127, -0.1668526), Size = UDim2.fromOffset(295, 64), Text = "Ban", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 60, TextStrokeColor3 = Color3.fromRGB(255, 255, 255), TextStrokeTransparency = 0, TextWrapped = true })
				I[21] = new("UIGradient", I[20], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(176, 176, 176)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }), Rotation = 90 })
				I[22] = new("UICorner", I[20], "UICorner", { BottomLeftRadius = UDim.new(0, 5), BottomRightRadius = UDim.new(0, 5), TopLeftRadius = UDim.new(0, 5), TopRightRadius = UDim.new(0, 5) })
	return I[1]
end

return build
