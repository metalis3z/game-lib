-- Generated from ui/ServerScriptService/SV_MAIN_GameScript/PlrInfo.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "PlrInfo", { AutoLocalize = false, LightInfluence = 0.2, MaxDistance = 0, Size = UDim2.new(3.5, 50, 1, 12), StudsOffsetWorldSpace = Vector3.new(0, 4, 0) })
		I[2] = new("Frame", I[1], "PlayerInfo", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Interactable = false, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 50 })
			I[3] = new("Frame", I[2], "LvlInfo", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Interactable = false, Size = UDim2.fromScale(1, 0.5) })
				I[4] = new("Frame", I[3], "LvlNo", { BackgroundColor3 = Color3.fromRGB(44, 62, 80), BorderColor3 = Color3.fromRGB(44, 62, 80), BorderSizePixel = 0, Interactable = false, Size = UDim2.fromScale(0.142, 1), Visible = false })
					I[5] = new("ImageLabel", I[4], "Grad", { BackgroundColor3 = Color3.fromRGB(241, 196, 15), ImageContent = Content.fromUri("rbxassetid://156579757"), ImageTransparency = 0.6, Interactable = false, Position = UDim2.fromScale(0.05, 0.05), Size = UDim2.fromScale(0.9, 0.9) })
				I[6] = new("Frame", I[3], "ProgressBar", { BackgroundColor3 = Color3.fromRGB(44, 61, 80), BorderColor3 = Color3.fromRGB(44, 62, 80), BorderSizePixel = 0, ClipsDescendants = true, Interactable = false, Size = UDim2.fromScale(1, 0.9) })
					I[7] = new("ImageLabel", I[6], "Percentage", { BackgroundColor3 = Color3.fromRGB(241, 219, 128), BorderSizePixel = 0, Interactable = false, Size = UDim2.fromScale(0, 1), ZIndex = 2 })
						I[8] = new("UICorner", I[7], "UICorner", { BottomLeftRadius = UDim.new(0.25, 0), BottomRightRadius = UDim.new(0.25, 0), TopLeftRadius = UDim.new(0.25, 0), TopRightRadius = UDim.new(0.25, 0) })
					I[9] = new("ImageLabel", I[6], "Gradient", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://156579757"), ImageTransparency = 0.4, Interactable = false, Size = UDim2.new(1, 0, 1, 1), ZIndex = 3 })
						I[10] = new("UICorner", I[9], "UICorner", { BottomLeftRadius = UDim.new(0.25, 0), BottomRightRadius = UDim.new(0.25, 0), TopLeftRadius = UDim.new(0.25, 0), TopRightRadius = UDim.new(0.25, 0) })
					I[11] = new("ImageLabel", I[6], "NewPercentage", { BackgroundColor3 = Color3.fromRGB(236, 240, 241), BorderSizePixel = 0, Interactable = false, Size = UDim2.fromScale(0, 1) })
						I[12] = new("UICorner", I[11], "UICorner", { BottomLeftRadius = UDim.new(0.25, 0), BottomRightRadius = UDim.new(0.25, 0), TopLeftRadius = UDim.new(0.25, 0), TopRightRadius = UDim.new(0.25, 0) })
					I[13] = new("UICorner", I[6], "UICorner", { BottomLeftRadius = UDim.new(0.25, 0), BottomRightRadius = UDim.new(0.25, 0), TopLeftRadius = UDim.new(0.25, 0), TopRightRadius = UDim.new(0.25, 0) })
				I[14] = new("TextLabel", I[3], "RebirthNo", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ClipsDescendants = true, FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Interactable = false, Position = UDim2.fromScale(0.4, 0), Size = UDim2.fromScale(0.6, 0.9), Text = "Rebirth x0 ", TextColor3 = Color3.fromRGB(215, 255, 231), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.625, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, Visible = false, ZIndex = 2 })
					I[15] = new("ImageLabel", I[14], "Full_Gradient", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 128, 51), ImageContent = Content.fromUri("rbxassetid://1463504275"), ImageTransparency = 0.4, Interactable = false, Rotation = 180, Size = UDim2.new(1, 0, 1, 1) })
						I[16] = new("UICorner", I[15], "UICorner", { BottomLeftRadius = UDim.new(0.25, 0), BottomRightRadius = UDim.new(0.25, 0), TopLeftRadius = UDim.new(0.25, 0), TopRightRadius = UDim.new(0.25, 0) })
				I[17] = new("TextLabel", I[3], "LvlText", { BackgroundColor3 = Color3.fromRGB(241, 196, 15), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(44, 62, 80), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Interactable = false, Size = UDim2.fromScale(0.4, 0.9), Text = " Lvl 1", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.625, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 2 })
			I[18] = new("ImageLabel", I[2], "PlayerHolder", { BackgroundColor3 = Color3.fromRGB(44, 62, 80), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://156579757"), Interactable = false, Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(1, 0.5) })
				I[19] = new("TextLabel", I[18], "VIP", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(170, 97, 90), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Interactable = false, Position = UDim2.new(0.5, 0, 1, -1), Size = UDim2.fromScale(0.3, 1), Text = "[VIP]", TextColor3 = Color3.fromRGB(231, 76, 60), TextScaled = true, TextSize = 14, TextTransparency = 0.4, TextWrapped = true, Visible = false, ZIndex = 2 })
					I[20] = new("UIGradient", I[19], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(196, 196, 196)) }), Rotation = 90 })
				I[21] = new("UICorner", I[18], "UICorner", { BottomLeftRadius = UDim.new(0.25, 0), BottomRightRadius = UDim.new(0.25, 0), TopLeftRadius = UDim.new(0.25, 0), TopRightRadius = UDim.new(0.25, 0) })
		I[22] = new("BindableEvent", I[1], "ShowInfo")
		I[23] = new("TextLabel", I[1], "PText", { AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(22, 31, 40), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Interactable = false, Position = UDim2.fromScale(0.012, 0.5), Size = UDim2.fromScale(0.975, 0.5), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextTransparency = 0.4, TextWrapped = true, ZIndex = 2 })
			I[24] = new("UIGradient", I[23], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(196, 196, 196)) }), Rotation = 90 })
	return I[1]
end

return build
