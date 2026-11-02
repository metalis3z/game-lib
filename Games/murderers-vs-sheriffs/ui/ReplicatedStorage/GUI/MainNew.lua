-- Generated from ui/ReplicatedStorage/GUI/MainNew.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "MainNew", { DisplayOrder = 5, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Gamepad", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) })
			I[3] = new("Frame", I[2], "Dock", { BackgroundColor3 = Color3.fromRGB(17, 17, 17), BorderSizePixel = 0, Position = UDim2.new(0.5, -292, 1, 0), Size = UDim2.fromOffset(584, 200) })
				I[4] = new("Frame", I[3], "Frame", { BackgroundColor3 = Color3.fromRGB(17, 17, 17), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), Style = Enum.FrameStyle.DropShadow })
					I[5] = new("ImageButton", I[4], "Inventory", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Selectable = false, Size = UDim2.fromScale(1, 1), SizeConstraint = Enum.SizeConstraint.RelativeYY, ZIndex = 2 })
						I[6] = new("ImageButton", I[5], "Icon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://189664481"), Position = UDim2.new(0.5, -125, 0, 0), Selectable = false, Size = UDim2.fromOffset(250, 250) })
							I[7] = new("StringValue", I[6], "LocalizationKey", { Value = "InventoryIcon" })
						I[8] = new("ImageLabel", I[5], "ButtonIcon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=15026911220"), Size = UDim2.fromOffset(90, 90) })
							I[9] = new("ImageLabel", I[8], "ButtonIcon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxasset://textures/ui/Settings/Help/AButtonDark@2x.png"), Size = UDim2.fromScale(1, 1), Visible = false })
								I[10] = new("ImageLabel", I[9], "ButtonIcon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxasset://textures/ui/Settings/Help/AButtonDark@2x.png"), Size = UDim2.fromScale(1, 1) })
					I[11] = new("ImageButton", I[4], "Shop", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromOffset(193, 0), Selectable = false, Size = UDim2.fromScale(1, 1), SizeConstraint = Enum.SizeConstraint.RelativeYY, ZIndex = 2 })
						I[12] = new("ImageButton", I[11], "Icon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://189689518"), Position = UDim2.new(0.5, -125, 0, 0), Selectable = false, Size = UDim2.fromOffset(250, 250) })
							I[13] = new("StringValue", I[12], "LocalizationKey", { Value = "ShopIcon" })
						I[14] = new("ImageLabel", I[11], "ButtonIcon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=15026867363"), Size = UDim2.fromOffset(90, 90) })
							I[15] = new("ImageLabel", I[14], "ButtonIcon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxasset://textures/ui/Settings/Help/XButtonDark@2x.png"), Size = UDim2.fromScale(1, 1), Visible = false })
								I[16] = new("ImageLabel", I[15], "ButtonIcon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxasset://textures/ui/Settings/Help/XButtonDark@2x.png"), Size = UDim2.fromScale(1, 1) })
					I[17] = new("ImageButton", I[4], "Spectate", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromOffset(383, 0), Selectable = false, Size = UDim2.fromScale(1, 1), SizeConstraint = Enum.SizeConstraint.RelativeYY, ZIndex = 2 })
						I[18] = new("ImageButton", I[17], "Icon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=189690337"), Position = UDim2.new(0.5, -125, 0, 0), Selectable = false, Size = UDim2.fromOffset(250, 250) })
						I[19] = new("ImageLabel", I[17], "ButtonIcon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=15026912593"), Size = UDim2.fromOffset(90, 90) })
							I[20] = new("ImageLabel", I[19], "ButtonIcon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxasset://textures/ui/Settings/Help/YButtonDark@2x.png"), Size = UDim2.fromScale(1, 1), Visible = false })
								I[21] = new("ImageLabel", I[20], "ButtonIcon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxasset://textures/ui/Settings/Help/YButtonDark@2x.png"), Size = UDim2.fromScale(1, 1) })
					I[22] = new("ImageButton", I[4], "Halloween", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.new(1, 30, 0, 10), Selectable = false, Size = UDim2.fromScale(1, 1), SizeConstraint = Enum.SizeConstraint.RelativeYY, Visible = false, ZIndex = 2 })
						I[23] = new("ImageButton", I[22], "Icon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://2515562682"), Position = UDim2.new(0.5, -125, 0, 0), Selectable = false, Size = UDim2.fromOffset(250, 250) })
						I[24] = new("ImageLabel", I[22], "ButtonIcon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://285737023"), Position = UDim2.fromOffset(-15, 0), Size = UDim2.fromOffset(90, 90) })
				I[25] = new("Frame", I[3], "Tip", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.new(0.5, -146, 0, -100), Size = UDim2.new(0.5, 0, 0, 100) })
					I[26] = new("TextLabel", I[25], "TipText", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(100, -4), Size = UDim2.new(1, -100, 1, 0), Text = "MENU", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 32, TextStrokeTransparency = 0.7, TextWrapped = true })
					I[27] = new("ImageLabel", I[25], "Icon1", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=15026867363"), Position = UDim2.fromOffset(5, 6), Size = UDim2.fromOffset(90, 90) })
						I[28] = new("ImageLabel", I[27], "Icon2", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxasset://textures/ui/Settings/Help/XButtonDark@2x.png"), Size = UDim2.fromScale(1, 1), Visible = false })
							I[29] = new("ImageLabel", I[28], "Icon3", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxasset://textures/ui/Settings/Help/XButtonDark@2x.png"), Size = UDim2.fromScale(1, 1) })
		I[30] = new("Frame", I[1], "Keyboard", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) })
			I[31] = new("Frame", I[30], "Dock", { BackgroundColor3 = Color3.fromRGB(33, 33, 33), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 2, Position = UDim2.new(0, 0, 0.5, -150), Size = UDim2.fromOffset(132, 360), Style = Enum.FrameStyle.DropShadow })
				I[32] = new("ImageButton", I[31], "Shop-X19", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromOffset(10, 150), Selectable = false, Size = UDim2.fromOffset(100, 100), Visible = false, ZIndex = 2 })
					I[33] = new("ImageLabel", I[32], "Button", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=285663928"), Position = UDim2.new(1, -15, 0, 0), Size = UDim2.fromOffset(40, 40), Visible = false, ZIndex = 2 })
					I[34] = new("ImageLabel", I[32], "Icon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=4535572404"), Position = UDim2.new(0.5, -80, 0.5, -80), Size = UDim2.fromOffset(160, 160) })
				I[35] = new("ImageButton", I[31], "Spectate", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromOffset(9, 255), Selectable = false, Size = UDim2.fromOffset(100, 100), ZIndex = 2 })
					I[36] = new("ImageLabel", I[35], "Icon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://189690337"), Position = UDim2.new(0.5, -80, 0.5, -80), Size = UDim2.fromOffset(160, 160) })
						I[37] = new("StringValue", I[36], "LocalizationKey", { Value = "SpectateIcon" })
					I[38] = new("ImageLabel", I[35], "Badge", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=189664502"), Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 3 })
						I[39] = new("TextLabel", I[38], "Amount", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(22, 15), Size = UDim2.fromOffset(50, 25), Text = "13", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 18, ZIndex = 4 })
					I[40] = new("ImageLabel", I[35], "NotificationText", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=189664513"), Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 3 })
					I[41] = new("ImageButton", I[35], "Inventory", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://189690337"), Position = UDim2.new(0.5, -80, 0.5, -80), Selectable = false, Size = UDim2.fromOffset(160, 160), Visible = false })
					I[42] = new("ImageLabel", I[35], "Button", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=285663962"), Position = UDim2.new(1, -15, 0, 0), Size = UDim2.fromOffset(40, 40), Visible = false, ZIndex = 2 })
				I[43] = new("TextLabel", I[31], "Version", { AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromOffset(0, 3), Size = UDim2.fromScale(1, 1), Text = "135", TextColor3 = Color3.fromRGB(104, 104, 104), TextSize = 14, TextTransparency = 0.7, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Bottom, ZIndex = 2 })
				I[44] = new("ImageButton", I[31], "Inventory", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromOffset(10, 25), Selectable = false, Size = UDim2.fromOffset(100, 100), ZIndex = 2 })
					I[45] = new("ImageLabel", I[44], "NotificationText", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=189664513"), Position = UDim2.fromOffset(-30, -40), Size = UDim2.fromOffset(160, 160), Visible = false, ZIndex = 3 })
					I[46] = new("ImageButton", I[44], "InventoryOLD", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=189664481"), Position = UDim2.new(0.5, -80, 0.5, -80), Selectable = false, Size = UDim2.fromOffset(160, 160), Visible = false })
					I[47] = new("ImageLabel", I[44], "Badge", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=189664502"), Position = UDim2.fromScale(1.2, 0.6), Size = UDim2.fromScale(2, 2), Visible = false, ZIndex = 3 })
						I[48] = new("TextLabel", I[47], "Amount", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0.3, -1, 0.125, -2), Size = UDim2.fromScale(0.275, 0.125), Text = "11", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextStrokeTransparency = 0.7, TextWrapped = true, ZIndex = 4 })
					I[49] = new("ImageLabel", I[44], "Button", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=285663894"), Position = UDim2.new(1, -15, 0, 0), Size = UDim2.fromOffset(40, 40), Visible = false, ZIndex = 2 })
					I[50] = new("ImageLabel", I[44], "Icon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://189664481"), Position = UDim2.new(0.5, -80, 0.5, -80), Size = UDim2.fromOffset(160, 160) })
						I[51] = new("StringValue", I[50], "LocalizationKey", { Value = "InventoryIcon" })
					I[52] = new("ImageLabel", I[44], "AnimationTarget", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.new(0.5, -1, 0.5, -15), Size = UDim2.fromScale(1, 1), ZIndex = 2 })
				I[53] = new("Frame", I[31], "Controller", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.new(0.5, -50, 0, -40), Size = UDim2.fromOffset(105, 30), Visible = false })
					I[54] = new("TextLabel", I[53], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(0, -2), Size = UDim2.fromScale(1, 1), Text = "Press", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 32, TextStrokeTransparency = 0.9, TextXAlignment = Enum.TextXAlignment.Left })
					I[55] = new("ImageButton", I[53], "ImageButton", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=285663831"), Position = UDim2.new(0, 0, 0.5, -20), ScaleType = Enum.ScaleType.Slice, Selectable = false, Size = UDim2.new(1, 0, 0, 40) })
				I[56] = new("Frame", I[31], "Touch", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.new(1, 3, 0.5, -50), Size = UDim2.fromOffset(50, 100), Style = Enum.FrameStyle.DropShadow, Visible = false })
					I[57] = new("TextLabel", I[56], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "<", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 42, TextWrapped = true })
					I[58] = new("TextButton", I[56], "Button", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromOffset(-6, -6), Size = UDim2.new(1, 12, 1, 12), Text = "", TextSize = 14 })
				I[59] = new("ImageButton", I[31], "Shop-Halloween", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromOffset(10, 145), Selectable = false, Size = UDim2.fromOffset(100, 100), Visible = false, ZIndex = 2 })
					I[60] = new("ImageLabel", I[59], "Icon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://2513159118"), Position = UDim2.new(0.5, -80, 0.5, -70), Size = UDim2.fromOffset(160, 160) })
				I[61] = new("ImageButton", I[31], "Shop", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromOffset(10, 145), Selectable = false, Size = UDim2.fromOffset(100, 100), ZIndex = 2 })
					I[62] = new("ImageLabel", I[61], "IconHW", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://2513159118"), Position = UDim2.new(0.5, -80, 0.5, -70), Size = UDim2.fromOffset(160, 160), Visible = false })
					I[63] = new("ImageLabel", I[61], "Button", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=285663928"), Position = UDim2.new(1, -15, 0, 0), Size = UDim2.fromOffset(40, 40), Visible = false, ZIndex = 2 })
					I[64] = new("ImageLabel", I[61], "Icon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://189689518"), Position = UDim2.new(0.5, -80, 0.5, -80), Size = UDim2.fromOffset(160, 160) })
						I[65] = new("StringValue", I[64], "LocalizationKey", { Value = "ShopIcon" })
		I[66] = new("Frame", I[1], "CrossPlatform", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) })
	return I[1]
end

return build
