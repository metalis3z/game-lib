-- Generated from ui/StarterGui/Admin Commands.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Admin Commands", { DisplayOrder = 1000, Enabled = false, ResetOnSpawn = false })
		I[2] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(0.4, 200, 0.2, 200) })
			I[3] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 1.25 })
			I[4] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0.05, 0), BottomRightRadius = UDim.new(0.05, 0), TopLeftRadius = UDim.new(0.05, 0), TopRightRadius = UDim.new(0.05, 0) })
			I[5] = new("TextLabel", I[2], "Title", { AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 0.075), Text = "BIG Games Commands", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 18 })
			I[6] = new("UIPadding", I[2], "UIPadding", { PaddingBottom = UDim.new(0, 4), PaddingLeft = UDim.new(0, 4), PaddingRight = UDim.new(0, 4), PaddingTop = UDim.new(0, 4) })
			I[7] = new("ScrollingFrame", I[2], "Cmds", { Active = true, AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, BottomImageContent = Content.fromUri("rbxassetid://5722186442"), CanvasSize = UDim2.fromScale(0, 1), MidImageContent = Content.fromUri("rbxassetid://5722187782"), Position = UDim2.fromScale(0, 1), ScrollBarImageTransparency = 0.5, ScrollBarThickness = 8, ScrollingDirection = Enum.ScrollingDirection.Y, Size = UDim2.fromScale(1, 0.825), TopImageContent = Content.fromUri("rbxassetid://5722188468"), VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar })
				I[8] = new("UIPadding", I[7], "UIPadding", { PaddingLeft = UDim.new(0, 4), PaddingRight = UDim.new(0, 4) })
				I[9] = new("UIListLayout", I[7], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder })
			I[10] = new("Frame", I[2], "Search", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.8, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.075), Size = UDim2.fromScale(0.95, 0.075) })
				I[11] = new("UICorner", I[10], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
				I[12] = new("TextBox", I[10], "Input", { AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), PlaceholderColor3 = Color3.fromRGB(223, 223, 223), PlaceholderText = "[Search]", Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 18 })
			I[13] = new("TextButton", I[2], "Close", { AnchorPoint = Vector2.new(1, 0), AutoButtonColor = false, AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.99, 0.01), Size = UDim2.fromScale(0.1, 0.055), Text = "X", TextColor3 = Color3.fromRGB(255, 64, 64), TextScaled = true, TextSize = 18, TextWrapped = true })
				I[14] = new("UIAspectRatioConstraint", I[13], "UIAspectRatioConstraint")
			I[15] = new("TextLabel", I[2], "Keybind", { AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(0.075, 0.075), Text = "F4", TextColor3 = Color3.fromRGB(255, 48, 245), TextSize = 18 })
			I[16] = new("UIScale", I[2], "UIScale")
		I[17] = new("Frame", I[1], "DescBlock", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = 1, Size = UDim2.new(1, 0, 0, 30) })
			I[18] = new("TextLabel", I[17], "Title", { AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ClipsDescendants = true, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal), RichText = true, Size = UDim2.fromScale(1, 1), Text = "<b>Shortcuts:</b> fling, f, throw", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 18, TextXAlignment = Enum.TextXAlignment.Left })
		I[19] = new("Frame", I[1], "Cmd", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ClipsDescendants = true, Size = UDim2.new(1, 0, 0, 35) })
			I[20] = new("Frame", I[19], "Header", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.65, BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 35) })
				I[21] = new("UICorner", I[20], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
				I[22] = new("TextLabel", I[20], "Title", { AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1, 0), RichText = true, Size = UDim2.fromScale(0.9, 1), Text = "<b>/fling</b> <font color=\"#FFA500\">Player</font>", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 18, TextXAlignment = Enum.TextXAlignment.Left })
				I[23] = new("ImageButton", I[20], "ToggleOpen", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=6744295081"), Position = UDim2.fromScale(0, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.1, 0.6) })
			I[24] = new("Frame", I[19], "Descs", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.85, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 1), Size = UDim2.new(0.94, 0, 1, -35), Visible = false })
				I[25] = new("UIListLayout", I[24], "UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder })
				I[26] = new("UIPadding", I[24], "UIPadding", { PaddingLeft = UDim.new(0, 6), PaddingRight = UDim.new(0, 6) })
		I[27] = new("Frame", I[1], "Notification", { AnchorPoint = Vector2.new(1, 0), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.5, BorderSizePixel = 0, Position = UDim2.fromScale(1, 0), Size = UDim2.fromOffset(0, 35) })
			I[28] = new("UICorner", I[27], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
			I[29] = new("TextLabel", I[27], "TextLabel", { AutoLocalize = false, AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), RichText = true, Size = UDim2.fromScale(1, 1), Text = "Super long cmd!!!", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 18 })
			I[30] = new("UIPadding", I[27], "UIPadding", { PaddingBottom = UDim.new(0, 4), PaddingLeft = UDim.new(0, 12), PaddingRight = UDim.new(0, 12), PaddingTop = UDim.new(0, 4) })
		I[31] = new("UIPadding", I[1], "UIPadding", { PaddingBottom = UDim.new(0, 8), PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8), PaddingTop = UDim.new(0, 8) })
		I[32] = new("Frame", I[1], "Notifications", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.new(1, -200, 0, -34), Size = UDim2.fromScale(1, 1) })
			I[33] = new("UIListLayout", I[32], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Right, Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder })
	return I[1]
end

return build
