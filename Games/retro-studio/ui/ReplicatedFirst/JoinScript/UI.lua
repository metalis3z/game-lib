-- Generated from ui/ReplicatedFirst/JoinScript/UI.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "UI", { DisplayOrder = 10000, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Backpack", { AnchorPoint = Vector2.new(0, 1), BackgroundTransparency = 1, Position = UDim2.fromScale(0, 1), Size = UDim2.fromScale(1, 1), SizeConstraint = Enum.SizeConstraint.RelativeYY })
			I[3] = new("Frame", I[2], "Backdrop", { BackgroundColor3 = Color3.fromRGB(180, 180, 180), BackgroundTransparency = 0.5, Size = UDim2.fromScale(0, 1), ZIndex = 0 })
			I[4] = new("Frame", I[2], "Slots", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) })
				I[5] = new("UIListLayout", I[4], "ListSlots", { FillDirection = Enum.FillDirection.Horizontal, SortOrder = Enum.SortOrder.LayoutOrder })
				I[6] = new("TextButton", I[4], "Template", { AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(180, 180, 180), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Selectable = false, Size = UDim2.fromScale(1, 1), Text = "", TextSize = 14, Visible = false })
					I[7] = new("TextLabel", I[6], "Index", { Active = true, AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(170, 170, 170), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.new(0.03, 2, 0.97, -2), Size = UDim2.fromScale(0.2, 0.2), SizeConstraint = Enum.SizeConstraint.RelativeYY, Text = "1", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(255, 255, 255), TextStrokeTransparency = 0.8, TextWrapped = true })
					I[8] = new("Frame", I[6], "TextHover", { BackgroundColor3 = Color3.fromRGB(180, 180, 180), BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) })
					I[9] = new("ImageLabel", I[6], "ToolIcon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.15, 0.15), Size = UDim2.fromScale(0.7, 0.7) })
					I[10] = new("TextLabel", I[6], "ToolName", { Active = true, AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1, 0.475), Size = UDim2.fromScale(2, 0.17), Text = "Tool", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 100, TextStrokeColor3 = Color3.fromRGB(127, 127, 127), TextStrokeTransparency = 0.5, TextTransparency = 0.2, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
					I[11] = new("ImageLabel", I[6], "SelectionOutline", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://4331165254"), Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 2 })
			I[12] = new("UIScale", I[2], "UIScale", { Scale = 0.1333 })
		I[13] = new("Frame", I[1], "Chat", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) })
			I[14] = new("TextBox", I[13], "ChatBar", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(43, 43, 43), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), PlaceholderColor3 = Color3.fromRGB(255, 255, 200), PlaceholderText = "To chat click here or press the \"/\" key", Position = UDim2.fromScale(1, 1), Size = UDim2.new(1, -3, 0, 15), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 15, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 3 })
				I[15] = new("Frame", I[14], "FocusBackdrop", { BackgroundColor3 = Color3.fromRGB(64, 64, 64), BorderSizePixel = 0, Position = UDim2.new(0, -3, 1, 3), Size = UDim2.new(1, 3, 0, 3), Visible = false, ZIndex = 2 })
			I[16] = new("Frame", I[13], "ChatOutput", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ClipsDescendants = true, Position = UDim2.fromOffset(23, 29), Size = UDim2.new(1, 0, 0, 96) })
				I[17] = new("UIListLayout", I[16], "Stream", { SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Bottom })
			I[18] = new("Frame", I[13], "MainBackdrop", { BackgroundColor3 = Color3.fromRGB(64, 64, 64), BorderSizePixel = 0, Position = UDim2.fromScale(0, 1), Size = UDim2.new(1, 0, 0, 20) })
			I[19] = new("Folder", I[13], "Utility")
				I[20] = new("Frame", I[19], "MessageTemplate", { BackgroundColor3 = Color3.fromRGB(153, 153, 153), BackgroundTransparency = 0.6, BorderSizePixel = 0, Size = UDim2.fromOffset(0, 16) })
					I[21] = new("TextLabel", I[20], "Message", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 1, Size = UDim2.fromScale(0, 1), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 16, TextStrokeColor3 = Color3.fromRGB(255, 255, 255), TextStrokeTransparency = 0.9, TextXAlignment = Enum.TextXAlignment.Left })
					I[22] = new("TextLabel", I[20], "PlayerName", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(0, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 16, TextStrokeTransparency = 0.9, TextXAlignment = Enum.TextXAlignment.Left })
					I[23] = new("UIListLayout", I[20], "AutoLayout", { FillDirection = Enum.FillDirection.Horizontal, SortOrder = Enum.SortOrder.LayoutOrder })
		I[24] = new("UIPadding", I[1], "ChatPadding", { PaddingBottom = UDim.new(0, 20) })
		I[25] = new("Frame", I[1], "GameJoin", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(180, 180, 180), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 3, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.6, 1), Visible = false })
			I[26] = new("TextLabel", I[25], "Message", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(1, 0.125), Text = "Connecting to server...", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(255, 255, 255), TextStrokeTransparency = 0.75, TextWrapped = true })
			I[27] = new("UIAspectRatioConstraint", I[25], "UIAspectRatioConstraint", { AspectRatio = 3, DominantAxis = Enum.DominantAxis.Height })
			I[28] = new("TextLabel", I[25], "ExitOverride", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(1, 0.25), Text = "You are now being returned to the main menu.\nPlease hold...", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(255, 255, 255), TextStrokeTransparency = 0.75, TextWrapped = true, Visible = false })
		I[29] = new("Frame", I[1], "Health", { AnchorPoint = Vector2.new(1, 0.5), BackgroundTransparency = 1, Position = UDim2.new(1, -31, 0.5, 0), Size = UDim2.fromOffset(66, 137), Visible = false })
			I[30] = new("Frame", I[29], "HealthBar", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromOffset(12, 112) })
				I[31] = new("Frame", I[30], "HealthGauge", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(129, 197, 22), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromScale(1, 1) })
			I[32] = new("TextLabel", I[29], "HealthLabel", { AnchorPoint = Vector2.new(0.5, 1), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 1), Size = UDim2.new(1, 0, 0, 24), Text = "Health", TextColor3 = Color3.fromRGB(0, 0, 255), TextScaled = true, TextStrokeColor3 = Color3.fromRGB(0, 0, 255), TextStrokeTransparency = 0.9, TextWrapped = true })
		I[33] = new("ImageLabel", I[1], "HelpWindow", { Active = true, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://1041546985"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.8, 0.7), SliceCenter = Rect.new(4, 30, 304, 130), Visible = false, ZIndex = 5 })
			I[34] = new("ImageLabel", I[33], "Help", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://1041647615"), Position = UDim2.fromOffset(4, 31), Size = UDim2.new(1, -8, 1, -36) })
				I[35] = new("UIAspectRatioConstraint", I[34], "UIAspectRatioConstraint", { AspectRatio = 2.75 })
			I[36] = new("TextLabel", I[33], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(7, 2), Size = UDim2.new(0.9, -10, 0, 30), Text = "ROBLOX Help", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, TextStrokeColor3 = Color3.fromRGB(126, 126, 126), TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 2 })
				I[37] = new("TextLabel", I[36], "Stroke", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(-1, -1), Size = UDim2.fromScale(1, 1), Text = "ROBLOX Help", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14, TextStrokeColor3 = Color3.fromRGB(126, 126, 126), TextStrokeTransparency = 0.6, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = -1000 })
			I[38] = new("ImageButton", I[33], "Close", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://1041651899"), Modal = true, Position = UDim2.new(1, -5, 0, 5), Size = UDim2.fromOffset(22, 22), SizeConstraint = Enum.SizeConstraint.RelativeXX })
			I[39] = new("UIAspectRatioConstraint", I[33], "UIAspectRatioConstraint", { AspectRatio = 2.5 })
		I[40] = new("TextLabel", I[1], "Hint", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 1), Size = UDim2.new(1, 0, 0, 20), Text = "", TextColor3 = Color3.fromRGB(225, 225, 225), TextSize = 16, TextStrokeColor3 = Color3.fromRGB(200, 200, 200), TextStrokeTransparency = 0.9, TextYAlignment = Enum.TextYAlignment.Bottom })
		I[41] = new("TextLabel", I[1], "Message", { BackgroundColor3 = Color3.fromRGB(153, 153, 153), BackgroundTransparency = 0.5, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromOffset(0, -36), Size = UDim2.new(1, 0, 1, 36), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 18, TextStrokeTransparency = 0.1, TextTransparency = 0.1, TextWrapped = true, Visible = false })
		I[42] = new("TextLabel", I[1], "Player", { BackgroundColor3 = Color3.fromRGB(153, 153, 153), BackgroundTransparency = 0.5, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromOffset(30, 40), Size = UDim2.fromScale(0.25, 0.25), Text = "Test", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 18, TextStrokeTransparency = 0.1, TextTransparency = 0.1, TextWrapped = true, ZIndex = 10 })
		I[43] = new("ImageLabel", I[1], "Mouse", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://334630296"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(80, 80), ZIndex = 100 })
		I[44] = new("Frame", I[1], "PlayerList", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) })
			I[45] = new("Frame", I[44], "Backdrop", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(153, 153, 153), BackgroundTransparency = 0.4, BorderSizePixel = 0, Position = UDim2.new(1, -10, 0, 10), Size = UDim2.fromOffset(10, 10) })
			I[46] = new("Frame", I[44], "Container", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.new(1, -10, 0, 10), Size = UDim2.fromScale(0.165, 1) })
				I[47] = new("UIAspectRatioConstraint", I[46], "AspectRatio", { AspectRatio = 3 })
			I[48] = new("ScreenGui", I[44], "Templates", { Enabled = false })
				I[49] = new("Frame", I[48], "BaseGroup", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, LayoutOrder = -9999, Size = UDim2.fromScale(1, 1) })
					I[50] = new("Frame", I[49], "Footer", { BackgroundColor3 = Color3.fromRGB(0, 255, 0), BackgroundTransparency = 1, LayoutOrder = 999999999, Size = UDim2.fromScale(1, 0.165), Visible = false })
					I[51] = new("Frame", I[49], "Header", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, LayoutOrder = -9999999, Size = UDim2.fromScale(1, 0.333) })
						I[52] = new("TextLabel", I[51], "Title", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "Player List", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 2 })
						I[53] = new("Frame", I[51], "Stats", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, Size = UDim2.fromScale(0.75, 1) })
						I[54] = new("Frame", I[51], "TeamUnderline", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.new(-1, 2, 0.875, 0), Size = UDim2.new(1, -4, 0, 1), Visible = false, ZIndex = 2 })
					I[55] = new("UIListLayout", I[49], "ListLayout", { SortOrder = Enum.SortOrder.LayoutOrder })
				I[56] = new("Frame", I[48], "BasePlayerLbl", { BackgroundColor3 = Color3.fromRGB(0, 255, 0), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 0.3333) })
					I[57] = new("TextLabel", I[56], "PlayerName", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "OnlyTwentyCharacters", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 2 })
					I[58] = new("Frame", I[56], "Stats", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, Size = UDim2.fromScale(0.75, 1) })
				I[59] = new("TextLabel", I[48], "BaseStat", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "0", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 2 })
		I[60] = new("Frame", I[1], "SafeChat", { AnchorPoint = Vector2.new(0, 1), BackgroundTransparency = 1, Position = UDim2.fromScale(0, 1), Size = UDim2.fromScale(1, 1) })
			I[61] = new("UIAspectRatioConstraint", I[60], "AspectRatio", { AspectRatio = 1.33333, DominantAxis = Enum.DominantAxis.Height })
			I[62] = new("ImageButton", I[60], "ChatButton", { AnchorPoint = Vector2.new(0, 1), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://991182833"), Position = UDim2.fromScale(0.0202, 0.7777), Size = UDim2.fromOffset(32, 32) })
				I[63] = new("Sound", I[62], "Click")
				I[64] = new("ImageLabel", I[62], "Hint", { AnchorPoint = Vector2.new(0.5, 0.75), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxasset://textures/ui/Settings/Help/XButtonDark@2x.png"), Position = UDim2.new(1, 5, 0, 0), Size = UDim2.fromScale(0.75, 0.75), Visible = false })
			I[65] = new("Folder", I[60], "Templates")
				I[66] = new("Frame", I[65], "TempBranch", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.new(1, 5, 0.5, 0), Size = UDim2.fromOffset(140, 24), Visible = false, ZIndex = 2 })
					I[67] = new("UIListLayout", I[66], "UIListLayout", { Padding = UDim.new(0, 5), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
				I[68] = new("TextButton", I[65], "TempButton", { AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(63, 63, 63), FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromOffset(140, 24), Text = "ROOT", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 12, TextStrokeTransparency = 0.95, TextTransparency = 0.25, Visible = false, ZIndex = 2 })
		I[69] = new("Frame", I[1], "Topbar", { BackgroundTransparency = 1, Position = UDim2.fromOffset(80, 0), Size = UDim2.fromOffset(100, 20) })
			I[70] = new("UIListLayout", I[69], "ButtonLayout", { FillDirection = Enum.FillDirection.Horizontal, SortOrder = Enum.SortOrder.LayoutOrder })
			I[71] = new("UIScale", I[69], "ButtonScale", { Scale = 1.4400001 })
		I[72] = new("Frame", I[1], "ZoomControls", { AnchorPoint = Vector2.new(1, 1), BackgroundTransparency = 1, Position = UDim2.fromScale(1, 1), Size = UDim2.fromOffset(70, 70) })
			I[73] = new("ImageLabel", I[72], "FirstPersonIndicator", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://598702035"), Position = UDim2.new(1, 0, 0, -97), Size = UDim2.fromOffset(168, 42), Visible = false, ZIndex = 2 })
			I[74] = new("ImageButton", I[72], "RotateDown", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://598662248"), Position = UDim2.fromOffset(0, 35), Rotation = -180, Size = UDim2.fromOffset(35, 35), ZIndex = 2 })
			I[75] = new("ImageButton", I[72], "RotateUp", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://598662248"), Size = UDim2.fromOffset(35, 35), ZIndex = 2 })
			I[76] = new("ImageButton", I[72], "ZoomIn", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://598663795"), Position = UDim2.fromOffset(35, 0), Size = UDim2.fromOffset(35, 35), ZIndex = 2 })
				I[77] = new("Frame", I[76], "Lock", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.5, BorderSizePixel = 0, Size = UDim2.fromOffset(35, 35), Visible = false, ZIndex = 3 })
			I[78] = new("ImageButton", I[72], "ZoomOut", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://598665130"), Position = UDim2.fromOffset(35, 35), Size = UDim2.fromOffset(35, 35), ZIndex = 2 })
				I[79] = new("Frame", I[78], "Lock", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.5, BorderSizePixel = 0, Size = UDim2.fromOffset(35, 35), Visible = false, ZIndex = 3 })
	return I[1]
end

return build
