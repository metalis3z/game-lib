-- Generated from ui/StarterPlayer/StarterPlayerScripts/Controllers/ModeratorPanelController/outfit.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "outfit", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) })
		I[2] = new("Frame", I[1], "reasonContainer", { BackgroundColor3 = Color3.fromRGB(33, 34, 39), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.536, 0.365), Size = UDim2.fromScale(0.4542959, 0.173134) })
			I[3] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0.05, 0), BottomRightRadius = UDim.new(0.05, 0), TopLeftRadius = UDim.new(0.05, 0), TopRightRadius = UDim.new(0.05, 0) })
			I[4] = new("UIStroke", I[2], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(255, 255, 255), Transparency = 0.5 })
			I[5] = new("TextLabel", I[2], "reason", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658246179", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, -8, 1, -8), Text = "some random reason here", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 24, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top }, { ["baseSize"] = 24, ["baseX"] = 1791, ["baseY"] = 1190 })
		I[6] = new("Frame", I[1], "preview", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(29, 30, 34), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.0170001, 0.5), Size = UDim2.fromScale(0.5011842, 0.9682186) })
			I[7] = new("UICorner", I[6], "UICorner", { BottomLeftRadius = UDim.new(0.015, 0), BottomRightRadius = UDim.new(0.015, 0), TopLeftRadius = UDim.new(0.015, 0), TopRightRadius = UDim.new(0.015, 0) })
			I[8] = new("ViewportFrame", I[6], "viewport", { Ambient = Color3.fromRGB(202, 202, 202), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LightColor = Color3.fromRGB(221, 221, 221), LightDirection = Vector3.new(0.5, -1, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 2 })
			I[9] = new("ImageLabel", I[6], "background", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(236, 235, 255), ImageContent = Content.fromUri("rbxassetid://83570005866923"), Size = UDim2.fromScale(1, 1) })
				I[10] = new("UICorner", I[9], "UICorner", { BottomLeftRadius = UDim.new(0.03, 0), BottomRightRadius = UDim.new(0.03, 0), TopLeftRadius = UDim.new(0.03, 0), TopRightRadius = UDim.new(0.03, 0) })
			I[11] = new("TextButton", I[6], "detector", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, ZIndex = -1 })
			I[12] = new("Frame", I[6], "statistics", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(0.5, 1), ZIndex = 5 })
				I[13] = new("UIListLayout", I[12], "UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder })
		I[14] = new("TextButton", I[1], "restore", { AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5347334, 0.559475), Size = UDim2.fromScale(0.454, 0.076), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, nil, { "UIEffect" })
			I[15] = new("TextLabel", I[14], "label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.8), Text = "Restore Outfit", TextColor3 = Color3.fromRGB(18, 18, 21), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[16] = new("UICorner", I[14], "UICorner", { BottomLeftRadius = UDim.new(0.1, 0), BottomRightRadius = UDim.new(0.1, 0), TopLeftRadius = UDim.new(0.1, 0), TopRightRadius = UDim.new(0.1, 0) })
		I[17] = new("TextLabel", I[1], "creator", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5360458, 0.1236017), RichText = true, Size = UDim2.fromScale(0.4529837, 0.0383297), Text = "Name: OnlyTwentyFiveeCharacters", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
		I[18] = new("TextLabel", I[1], "moderatorName", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5352452, 0.1869845), RichText = true, Size = UDim2.fromScale(0.4529837, 0.0383297), Text = "Moderator: OnlyTwentyCharacters (9999999999)", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
		I[19] = new("TextLabel", I[1], "moderationDate", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5352452, 0.2247704), RichText = true, Size = UDim2.fromScale(0.4529837, 0.0383297), Text = "Moderated at: xx.xx pm xx:xx:xx", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
		I[20] = new("TextLabel", I[1], "moderationAction", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5352452, 0.2625563), RichText = true, Size = UDim2.fromScale(0.4529837, 0.0383297), Text = "Moderation action: ban3Day", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
		I[21] = new("TextLabel", I[1], "label", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5352452, 0.3210635), RichText = true, Size = UDim2.fromScale(0.4529837, 0.0383297), Text = "Moderator reason:", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
		I[22] = new("TextLabel", I[1], "name", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5358524, 0.0804474), RichText = true, Size = UDim2.fromScale(0.4529837, 0.0432053), Text = "Name: OnlyTwentyFiveeCharacters", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
	return I[1]
end

return build
