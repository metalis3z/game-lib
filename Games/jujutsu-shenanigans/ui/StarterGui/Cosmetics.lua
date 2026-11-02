-- Generated from ui/StarterGui/Cosmetics.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Cosmetics", { Enabled = false, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.35, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.353857, 0.3325942) })
			I[3] = new("ScrollingFrame", I[2], "AccessoriesSF", { Active = true, AnchorPoint = Vector2.new(0.5, 0.5), AutomaticCanvasSize = Enum.AutomaticSize.XY, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, CanvasSize = UDim2.fromOffset(0, 1000), Position = UDim2.fromScale(0.5000001, 0.4999999), ScrollBarThickness = 6, Size = UDim2.fromScale(0.96, 0.9999999), VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar })
				I[4] = new("TextLabel", I[3], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1928956, 0.3849703), Size = UDim2.fromOffset(200, 22), Text = "COMING SOON", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[5] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 1.6666666 })
			I[6] = new("TextButton", I[2], "Accessories", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.35, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, -0.085), Size = UDim2.fromScale(0.3276824, 0.0765288), Text = "ACCESSORIES", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 17, TextStrokeTransparency = 0, TextWrapped = true })
				I[7] = new("UIAspectRatioConstraint", I[6], "UIAspectRatioConstraint", { AspectRatio = 7.1363635 })
				I[8] = new("UITextSizeConstraint", I[6], "UITextSizeConstraint", { MaxTextSize = 17 })
			I[9] = new("TextButton", I[2], "Auras", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.35, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3360001, -0.085), Size = UDim2.fromScale(0.3276824, 0.0765288), Text = "AURAS", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 17, TextStrokeTransparency = 0, TextWrapped = true })
				I[10] = new("UIAspectRatioConstraint", I[9], "UIAspectRatioConstraint", { AspectRatio = 7.1363635 })
				I[11] = new("UITextSizeConstraint", I[9], "UITextSizeConstraint", { MaxTextSize = 17 })
			I[12] = new("TextButton", I[2], "Titles", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.35, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.6719128, -0.085), Size = UDim2.fromScale(0.3276824, 0.0765288), Text = "TITLES", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 17, TextStrokeTransparency = 0, TextWrapped = true })
				I[13] = new("UIAspectRatioConstraint", I[12], "UIAspectRatioConstraint", { AspectRatio = 7.1363635 })
				I[14] = new("UITextSizeConstraint", I[12], "UITextSizeConstraint", { MaxTextSize = 17 })
			I[15] = new("ScrollingFrame", I[2], "AurasSF", { Active = true, AnchorPoint = Vector2.new(0.5, 0.5), AutomaticCanvasSize = Enum.AutomaticSize.XY, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, CanvasSize = UDim2.fromOffset(0, 1000), Position = UDim2.fromScale(0.5000001, 0.4999999), ScrollBarThickness = 6, Size = UDim2.fromScale(0.96, 0.9999999), VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar, Visible = false })
				I[16] = new("UIGridLayout", I[15], "UIGridLayout", { CellPadding = UDim2.fromScale(0.155, 0.01), CellSize = UDim2.fromScale(0.2, 0.475), HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder })
				I[17] = new("Frame", I[15], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.3, 0), Size = UDim2.fromOffset(184, 125) })
					I[18] = new("TextLabel", I[17], "Info", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.8), RichText = true, Size = UDim2.fromScale(2.7309999, 0.2), Text = "Corruption Aura", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 20, TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 3 })
						I[19] = new("UITextSizeConstraint", I[18], "UITextSizeConstraint", { MaxTextSize = 20 })
						I[20] = new("TextLabel", I[18], "Info", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 1), RichText = true, Size = UDim2.fromScale(1.5, 0.586), Text = "1500 KILLS", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 15, TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 3 })
							I[21] = new("UITextSizeConstraint", I[20], "UITextSizeConstraint", { MaxTextSize = 15 })
							I[22] = new("UIAspectRatioConstraint", I[20], "UIAspectRatioConstraint", { AspectRatio = 19.0848751 })
						I[23] = new("UIAspectRatioConstraint", I[18], "UIAspectRatioConstraint", { AspectRatio = 9.462285 })
					I[24] = new("ImageButton", I[17], "ImageButton", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), ImageTransparency = 1, Size = UDim2.fromScale(1, 1), ZIndex = 5 })
						I[25] = new("UIAspectRatioConstraint", I[24], "UIAspectRatioConstraint", { AspectRatio = 0.6929539 })
					I[26] = new("UIAspectRatioConstraint", I[17], "UIAspectRatioConstraint", { AspectRatio = 0.6929539 })
					I[27] = new("RemoteEvent", I[17], "Equip")
					I[28] = new("RemoteEvent", I[17], "Unequip")
					I[29] = new("ImageLabel", I[17], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=18341546446"), Position = UDim2.fromScale(0.5000001, 0), Size = UDim2.new(1.2, 1, 0.853, -2), ZIndex = 2 })
				I[30] = new("Frame", I[15], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.3, 0), Size = UDim2.fromOffset(184, 125) })
					I[31] = new("ImageLabel", I[30], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=18341551805"), Position = UDim2.fromScale(0.5000001, 0), Size = UDim2.new(1.2, 1, 0.853, -2), ZIndex = 2 })
						I[32] = new("UIAspectRatioConstraint", I[31], "UIAspectRatioConstraint", { AspectRatio = 1.0013443 })
					I[33] = new("TextLabel", I[30], "Info", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.8), RichText = true, Size = UDim2.fromScale(2.7309999, 0.2), Text = "Neko Aura", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 20, TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 3 })
						I[34] = new("UITextSizeConstraint", I[33], "UITextSizeConstraint", { MaxTextSize = 20 })
						I[35] = new("TextLabel", I[33], "Info", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 1), RichText = true, Size = UDim2.fromScale(1.5, 0.586), Text = "2500 KILLS", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 15, TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 3 })
							I[36] = new("UITextSizeConstraint", I[35], "UITextSizeConstraint", { MaxTextSize = 15 })
							I[37] = new("UIAspectRatioConstraint", I[35], "UIAspectRatioConstraint", { AspectRatio = 19.0848751 })
						I[38] = new("UIAspectRatioConstraint", I[33], "UIAspectRatioConstraint", { AspectRatio = 9.462285 })
					I[39] = new("ImageButton", I[30], "ImageButton", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), ImageTransparency = 1, Size = UDim2.fromScale(1, 1), ZIndex = 5 })
						I[40] = new("UIAspectRatioConstraint", I[39], "UIAspectRatioConstraint", { AspectRatio = 0.6929539 })
					I[41] = new("UIAspectRatioConstraint", I[30], "UIAspectRatioConstraint", { AspectRatio = 0.6929539 })
					I[42] = new("RemoteEvent", I[30], "Equip")
					I[43] = new("RemoteEvent", I[30], "Unequip")
				I[44] = new("Frame", I[15], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.3, 0), Size = UDim2.fromOffset(184, 125) })
					I[45] = new("ImageLabel", I[44], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://17855957730"), Position = UDim2.fromScale(0.5000001, 0), Size = UDim2.new(1.2, 1, 0.853, -2), ZIndex = 2 })
						I[46] = new("UIAspectRatioConstraint", I[45], "UIAspectRatioConstraint", { AspectRatio = 1.0013443 })
					I[47] = new("TextLabel", I[44], "Info", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.8), RichText = true, Size = UDim2.fromScale(2.7309999, 0.2), Text = "Magmatic Aura", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 20, TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 3 })
						I[48] = new("UITextSizeConstraint", I[47], "UITextSizeConstraint", { MaxTextSize = 20 })
						I[49] = new("TextLabel", I[47], "Info", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 1), RichText = true, Size = UDim2.fromScale(1.5, 0.586), Text = "4500 KILLS", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 15, TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 3 })
							I[50] = new("UITextSizeConstraint", I[49], "UITextSizeConstraint", { MaxTextSize = 15 })
							I[51] = new("UIAspectRatioConstraint", I[49], "UIAspectRatioConstraint", { AspectRatio = 19.0848751 })
						I[52] = new("UIAspectRatioConstraint", I[47], "UIAspectRatioConstraint", { AspectRatio = 9.462285 })
					I[53] = new("ImageButton", I[44], "ImageButton", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), ImageTransparency = 1, Size = UDim2.fromScale(1, 1), ZIndex = 5 })
						I[54] = new("UIAspectRatioConstraint", I[53], "UIAspectRatioConstraint", { AspectRatio = 0.6929539 })
					I[55] = new("UIAspectRatioConstraint", I[44], "UIAspectRatioConstraint", { AspectRatio = 0.6929539 })
					I[56] = new("RemoteEvent", I[44], "Equip")
					I[57] = new("RemoteEvent", I[44], "Unequip")
				I[58] = new("Frame", I[15], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.3, 0), Size = UDim2.fromOffset(184, 125) })
					I[59] = new("ImageLabel", I[58], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://17140620713"), Position = UDim2.fromScale(0.5000001, 0), Size = UDim2.new(1.2, 1, 0.853, -2), ZIndex = 2 })
						I[60] = new("UIAspectRatioConstraint", I[59], "UIAspectRatioConstraint", { AspectRatio = 1.0013443 })
					I[61] = new("TextLabel", I[58], "Info", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.8), RichText = true, Size = UDim2.fromScale(2.7309999, 0.2), Text = "Blue Heat Aura", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 20, TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 3 })
						I[62] = new("UITextSizeConstraint", I[61], "UITextSizeConstraint", { MaxTextSize = 20 })
						I[63] = new("TextLabel", I[61], "Info", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 1), RichText = true, Size = UDim2.fromScale(1.5, 0.586), Text = "7500 KILLS", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 15, TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 3 })
							I[64] = new("UITextSizeConstraint", I[63], "UITextSizeConstraint", { MaxTextSize = 15 })
							I[65] = new("UIAspectRatioConstraint", I[63], "UIAspectRatioConstraint", { AspectRatio = 19.0848751 })
						I[66] = new("UIAspectRatioConstraint", I[61], "UIAspectRatioConstraint", { AspectRatio = 9.462285 })
					I[67] = new("ImageButton", I[58], "ImageButton", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), ImageTransparency = 1, Size = UDim2.fromScale(1, 1), ZIndex = 5 })
						I[68] = new("UIAspectRatioConstraint", I[67], "UIAspectRatioConstraint", { AspectRatio = 0.6929539 })
					I[69] = new("UIAspectRatioConstraint", I[58], "UIAspectRatioConstraint", { AspectRatio = 0.6929539 })
					I[70] = new("RemoteEvent", I[58], "Equip")
					I[71] = new("RemoteEvent", I[58], "Unequip")
			I[72] = new("ScrollingFrame", I[2], "TitlesSF", { Active = true, AnchorPoint = Vector2.new(0.5, 0.5), AutomaticCanvasSize = Enum.AutomaticSize.XY, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, CanvasSize = UDim2.fromOffset(0, 1000), Position = UDim2.fromScale(0.5, 0.4999999), ScrollBarThickness = 6, Size = UDim2.fromScale(0.96, 0.9999999), VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar })
				I[73] = new("UIGridLayout", I[72], "UIGridLayout", { CellPadding = UDim2.fromOffset(60, 7), CellSize = UDim2.fromScale(0.95, 0.075), FillDirectionMaxCells = 1, SortOrder = Enum.SortOrder.LayoutOrder })
			I[74] = new("Frame", I[2], "Bulk", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(1.1499056, 0.5), Size = UDim2.fromScale(0.2691887, 1) })
				I[75] = new("ImageButton", I[74], "ImageButton", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://17859138719"), Position = UDim2.fromScale(0.2452142, 0), Size = UDim2.fromScale(0.6053975, 0.3337097), Visible = false })
					I[76] = new("TextButton", I[75], "Spin", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 1), RichText = true, Size = UDim2.fromScale(1.75, 0.4184783), Text = "<font size=\"45\">WANT MORE SLOTS?</font>\n<font color=\"rgb(158, 255, 174)\">99 ROBUX</font>", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 35, TextStrokeTransparency = 0, TextWrapped = true })
						I[77] = new("UITextSizeConstraint", I[76], "UITextSizeConstraint", { MaxTextSize = 35 })
						I[78] = new("UIAspectRatioConstraint", I[76], "UIAspectRatioConstraint", { AspectRatio = 4.181818 })
					I[79] = new("UIAspectRatioConstraint", I[75], "UIAspectRatioConstraint")
				I[80] = new("UIListLayout", I[74], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.05, 0), SortOrder = Enum.SortOrder.LayoutOrder })
			I[81] = new("Frame", I[2], "ButtonCat", { BackgroundColor3 = Color3.fromRGB(130, 255, 116), BackgroundTransparency = 0.2, BorderSizePixel = 0, Position = UDim2.new(0, 0, -0.0085174, -2), Size = UDim2.new(0.3276824, 0, 0, 2), ZIndex = 2 })
	return I[1]
end

return build
