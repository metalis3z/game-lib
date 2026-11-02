-- Generated from ui/StarterGui/GameTopbar.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "GameTopbar", { AutoLocalize = false, ResetOnSpawn = false, SafeAreaCompatibility = Enum.SafeAreaCompatibility.None, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Container", { BackgroundTransparency = 1, Position = UDim2.fromOffset(154, 6), Size = UDim2.new(1, 0, 0, 48) })
			I[3] = new("Frame", I[2], "MouseLock", { BackgroundTransparency = 1, BorderSizePixel = 0, SelectionBehaviorLeft = Enum.SelectionBehavior.Stop, SelectionBehaviorRight = Enum.SelectionBehavior.Stop, SelectionBehaviorUp = Enum.SelectionBehavior.Stop, SelectionGroup = true, Size = UDim2.fromOffset(44, 44) })
				I[4] = new("Frame", I[3], "Container", { BackgroundTransparency = 1, BorderSizePixel = 0, SelectionGroup = true, Size = UDim2.fromScale(1, 1) })
					I[5] = new("Frame", I[4], "Background", { BackgroundColor3 = Color3.fromRGB(18, 18, 21), BackgroundTransparency = 0.08, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = 0 })
						I[6] = new("UICorner", I[5], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
						I[7] = new("UIStroke", I[5], "UIStroke", { Color = Color3.fromRGB(0, 170, 255), Enabled = false, Thickness = 2, Transparency = 0.2 })
					I[8] = new("Frame", I[4], "Icon", { BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = 5 })
						I[9] = new("ImageLabel", I[8], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=15476088982"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.7, 0.7) })
							I[10] = new("UIAspectRatioConstraint", I[9], "UIAspectRatioConstraint")
					I[11] = new("TextButton", I[4], "Button", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, ZIndex = 6 })
			I[12] = new("Frame", I[2], "Mute", { BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = 10, SelectionBehaviorLeft = Enum.SelectionBehavior.Stop, SelectionBehaviorRight = Enum.SelectionBehavior.Stop, SelectionBehaviorUp = Enum.SelectionBehavior.Stop, SelectionGroup = true, Size = UDim2.fromOffset(44, 44) })
				I[13] = new("Frame", I[12], "Container", { BackgroundTransparency = 1, BorderSizePixel = 0, SelectionGroup = true, Size = UDim2.fromScale(1, 1) })
					I[14] = new("Frame", I[13], "Background", { BackgroundColor3 = Color3.fromRGB(18, 18, 21), BackgroundTransparency = 0.08, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) })
						I[15] = new("UICorner", I[14], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
					I[16] = new("Frame", I[13], "Icon", { BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = 2 })
						I[17] = new("ImageLabel", I[16], "MutedIcon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=4662727525"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.9), Visible = false })
							I[18] = new("UIAspectRatioConstraint", I[17], "UIAspectRatioConstraint")
						I[19] = new("ImageLabel", I[16], "UnmutedIcon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=4662727331"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.6, 0.6) })
							I[20] = new("UIAspectRatioConstraint", I[19], "UIAspectRatioConstraint")
						I[21] = new("ImageLabel", I[16], "MutedIconLoad", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=4662727525"), Position = UDim2.fromScale(0.5, 0.5) })
							I[22] = new("UIAspectRatioConstraint", I[21], "UIAspectRatioConstraint")
					I[23] = new("TextButton", I[13], "Button", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, ZIndex = 5 })
			I[24] = new("UIListLayout", I[2], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 5), SortOrder = Enum.SortOrder.LayoutOrder })
			I[25] = new("Frame", I[2], "Emotes", { BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = 5, SelectionBehaviorLeft = Enum.SelectionBehavior.Stop, SelectionBehaviorRight = Enum.SelectionBehavior.Stop, SelectionBehaviorUp = Enum.SelectionBehavior.Stop, SelectionGroup = true, Size = UDim2.fromOffset(44, 44) })
				I[26] = new("Frame", I[25], "Container", { BackgroundTransparency = 1, BorderSizePixel = 0, SelectionGroup = true, Size = UDim2.fromScale(1, 1) })
					I[27] = new("Frame", I[26], "Background", { BackgroundColor3 = Color3.fromRGB(18, 18, 21), BackgroundTransparency = 0.08, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) })
						I[28] = new("UICorner", I[27], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
					I[29] = new("Frame", I[26], "Icon", { BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = 2 })
						I[30] = new("ImageLabel", I[29], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://2474247481"), Position = UDim2.new(0.5, -1, 0.5, 1), Size = UDim2.fromScale(0.75, 0.75) })
							I[31] = new("UIAspectRatioConstraint", I[30], "UIAspectRatioConstraint")
					I[32] = new("TextButton", I[26], "Button", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, ZIndex = 5 })
				I[33] = new("Frame", I[25], "Hotkey", { AnchorPoint = Vector2.new(1, 1), BackgroundColor3 = Color3.fromRGB(62, 62, 62), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(1, 1), Size = UDim2.fromOffset(18, 18), ZIndex = 5 })
					I[34] = new("UICorner", I[33], "UICorner", { BottomLeftRadius = UDim.new(0, 3), BottomRightRadius = UDim.new(0, 3), TopLeftRadius = UDim.new(0, 3), TopRightRadius = UDim.new(0, 3) })
					I[35] = new("ImageLabel", I[33], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) }, { ["Keybind_Gamepad"] = "DPadRight" })
						I[36] = new("TextLabel", I[35], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "B", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
							I[37] = new("UIStroke", I[36], "UIStroke")
			I[38] = new("Frame", I[2], "Settings", { BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = 10, SelectionBehaviorLeft = Enum.SelectionBehavior.Stop, SelectionBehaviorRight = Enum.SelectionBehavior.Stop, SelectionBehaviorUp = Enum.SelectionBehavior.Stop, SelectionGroup = true, Size = UDim2.fromOffset(44, 44) })
				I[39] = new("Frame", I[38], "Container", { BackgroundTransparency = 1, BorderSizePixel = 0, SelectionGroup = true, Size = UDim2.fromScale(1, 1) })
					I[40] = new("Frame", I[39], "Background", { BackgroundColor3 = Color3.fromRGB(18, 18, 21), BackgroundTransparency = 0.08, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) })
						I[41] = new("UICorner", I[40], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
						I[42] = new("UIStroke", I[40], "UIStroke", { Color = Color3.fromRGB(0, 170, 255), Enabled = false, Thickness = 2, Transparency = 0.2 })
					I[43] = new("Frame", I[39], "Icon", { BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = 2 })
						I[44] = new("ImageLabel", I[43], "UnmutedIcon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://13530838822"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.6, 0.6) })
							I[45] = new("UIAspectRatioConstraint", I[44], "UIAspectRatioConstraint")
					I[46] = new("TextButton", I[39], "Button", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, ZIndex = 5 })
			I[47] = new("Frame", I[2], "Admin", { BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = 11, SelectionBehaviorLeft = Enum.SelectionBehavior.Stop, SelectionBehaviorRight = Enum.SelectionBehavior.Stop, SelectionBehaviorUp = Enum.SelectionBehavior.Stop, SelectionGroup = true, Size = UDim2.fromOffset(44, 44), Visible = false })
				I[48] = new("Frame", I[47], "Container", { BackgroundTransparency = 1, BorderSizePixel = 0, SelectionGroup = true, Size = UDim2.fromScale(1, 1) })
					I[49] = new("Frame", I[48], "Background", { BackgroundColor3 = Color3.fromRGB(18, 18, 21), BackgroundTransparency = 0.08, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) })
						I[50] = new("UICorner", I[49], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
						I[51] = new("UIStroke", I[49], "AdminRainbowStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(0, 170, 255), Thickness = 2 })
					I[52] = new("Frame", I[48], "Icon", { BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = 2 })
						I[53] = new("ImageLabel", I[52], "UnmutedIcon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://18386899616"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.62, 0.62) })
							I[54] = new("UIAspectRatioConstraint", I[53], "UIAspectRatioConstraint")
					I[55] = new("TextButton", I[48], "Button", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, ZIndex = 5 })
			I[56] = new("ImageButton", I[2], "Event", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://119248648714628"), LayoutOrder = 12, ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromOffset(78, 44), Visible = false })
				I[57] = new("TextLabel", I[56], "TextLabel", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 1.08), Size = UDim2.new(1, 6, 0, 18), Text = "EVENT", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 15, TextStrokeTransparency = 0.3, TextYAlignment = Enum.TextYAlignment.Top, Visible = false, ZIndex = 4 })
				I[58] = new("Frame", I[56], "Background", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 1.08), Size = UDim2.new(1, 0, 0, 18), ZIndex = 3 })
					I[59] = new("TextLabel", I[58], "TextLabel", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(1, 0.8), Text = "EVENT", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 15, TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 4 })
					I[60] = new("UICorner", I[58], "UICorner")
		I[61] = new("ImageLabel", I[1], "Crosshair", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxasset://textures/MouseLockedCursor.png"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(25, 25), Visible = false })
	return I[1]
end

return build
