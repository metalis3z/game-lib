-- Generated from ui/StarterGui/Crosshairs/CustomCrosshairs.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "CustomCrosshairs", { DisplayOrder = 100, Enabled = false, ResetOnSpawn = false })
		I[2] = new("Folder", I[1], "BpStuff")
			I[3] = new("ImageButton", I[2], "Yes", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(62, 255, 139), ImageContent = Content.fromUri("rbxassetid://5431965152"), Position = UDim2.fromScale(0.25, 0.85), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.45, 0.24), SliceCenter = Rect.new(10, 10, 40, 40), Visible = false, ZIndex = 6 })
				I[4] = new("TextLabel", I[3], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.75, 0.8), Text = "Yes", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(17, 58, 72), TextWrapped = true, ZIndex = 7 })
					I[5] = new("UITextSizeConstraint", I[4], "UITextSizeConstraint", { MaxTextSize = 60 })
			I[6] = new("ImageButton", I[2], "Option 2", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(62, 255, 139), ImageContent = Content.fromUri("rbxassetid://5431965152"), Position = UDim2.fromScale(0.75, 0.665), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.45, 0.18), SliceCenter = Rect.new(10, 10, 40, 40), Visible = false, ZIndex = 6 })
				I[7] = new("TextLabel", I[6], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.75, 0.8), Text = "Option", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(17, 58, 72), TextWrapped = true, ZIndex = 7 })
					I[8] = new("UITextSizeConstraint", I[7], "UITextSizeConstraint", { MaxTextSize = 40 })
			I[9] = new("ImageButton", I[2], "Option 1", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(62, 255, 139), ImageContent = Content.fromUri("rbxassetid://5431965152"), Position = UDim2.fromScale(0.25, 0.665), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.45, 0.18), SliceCenter = Rect.new(10, 10, 40, 40), Visible = false, ZIndex = 6 })
				I[10] = new("TextLabel", I[9], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.75, 0.8), Text = "Option", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(17, 58, 72), TextWrapped = true, ZIndex = 7 })
					I[11] = new("UITextSizeConstraint", I[10], "UITextSizeConstraint", { MaxTextSize = 40 })
			I[12] = new("ImageButton", I[2], "No", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(255, 46, 137), ImageContent = Content.fromUri("rbxassetid://5431965152"), Position = UDim2.fromScale(0.75, 0.85), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.45, 0.24), SliceCenter = Rect.new(10, 10, 40, 40), Visible = false, ZIndex = 6 })
				I[13] = new("TextLabel", I[12], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.75, 0.8), Text = "No", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(17, 58, 72), TextWrapped = true, ZIndex = 7 })
					I[14] = new("UITextSizeConstraint", I[13], "UITextSizeConstraint", { MaxTextSize = 60 })
			I[15] = new("ImageButton", I[2], "Cancel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(255, 46, 137), ImageContent = Content.fromUri("rbxassetid://5431965152"), Position = UDim2.fromScale(0.5, 0.88), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.45, 0.2), SliceCenter = Rect.new(10, 10, 40, 40), Visible = false, ZIndex = 6 })
				I[16] = new("TextLabel", I[15], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.75, 0.8), Text = "Cancel", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(17, 58, 72), TextWrapped = true, ZIndex = 7 })
					I[17] = new("UITextSizeConstraint", I[16], "UITextSizeConstraint", { MaxTextSize = 40 })
		I[18] = new("Frame", I[1], "Frame", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.fromScale(0.2917448, 0.2071006), Size = UDim2.fromOffset(443, 296) })
			I[19] = new("UICorner", I[18], "UICorner")
			I[20] = new("ImageButton", I[18], "Equip", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(62, 255, 139), ImageContent = Content.fromUri("rbxassetid://5431965152"), Position = UDim2.fromScale(0.5, 0.85), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.5, 0.25), SliceCenter = Rect.new(10, 10, 40, 40), ZIndex = 6 })
				I[21] = new("TextLabel", I[20], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.75, 0.8), Text = "Ok!", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(17, 58, 72), TextWrapped = true, ZIndex = 7 })
					I[22] = new("UITextSizeConstraint", I[21], "UITextSizeConstraint", { MaxTextSize = 60 })
			I[23] = new("TextLabel", I[18], "Desc", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5000001, 0.025), Size = UDim2.fromScale(0.9250001, 0.153303), Text = "Custom Crosshairs!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(255, 255, 255), TextTruncate = Enum.TextTruncate.AtEnd, TextWrapped = true, ZIndex = 7 })
				I[24] = new("UITextSizeConstraint", I[23], "UITextSizeConstraint", { MaxTextSize = 30, MinTextSize = 10 })
			I[25] = new("ScrollingFrame", I[18], "Container", { Active = true, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.0112867, 0.1756757), ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0), Size = UDim2.fromOffset(433, 146) })
				I[26] = new("TextLabel", I[25], "NormalCrosshair", { BackgroundColor3 = Color3.fromRGB(84, 84, 84), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0254042, 0.0198948), Size = UDim2.fromOffset(122, 122), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14 })
					I[27] = new("UICorner", I[26], "UICorner")
					I[28] = new("TextLabel", I[26], "Title", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.53, 0.005), Size = UDim2.fromScale(0.9400001, 0.153303), Text = "Normal Crosshair", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(255, 255, 255), TextTruncate = Enum.TextTruncate.AtEnd, TextWrapped = true, ZIndex = 7 })
						I[29] = new("UITextSizeConstraint", I[28], "UITextSizeConstraint", { MaxTextSize = 30, MinTextSize = 10 })
					I[30] = new("Folder", I[26], "OrginalCrosshair")
						I[31] = new("Frame", I[30], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.4830624, 0.4416516), Size = UDim2.fromOffset(37, 25) })
							I[32] = new("Frame", I[31], "Frame", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(0, 255, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(53, 53, 53), BorderMode = Enum.BorderMode.Middle, Position = UDim2.fromScale(1, 0.5), Size = UDim2.new(0.3, 0, 0, 2) })
							I[33] = new("UIAspectRatioConstraint", I[31], "UIAspectRatioConstraint")
							I[34] = new("Frame", I[31], "cntr", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 255, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(53, 53, 53), BorderMode = Enum.BorderMode.Middle, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(2, 2) })
							I[35] = new("Frame", I[31], "Frame", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(0, 255, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(53, 53, 53), BorderMode = Enum.BorderMode.Middle, Position = UDim2.fromScale(0, 0.5), Size = UDim2.new(0.3, 0, 0, 2) })
							I[36] = new("Frame", I[31], "Frame", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(0, 255, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(53, 53, 53), BorderMode = Enum.BorderMode.Middle, Position = UDim2.fromScale(0.5, 0), Size = UDim2.new(0, 2, 0.3, 0) })
							I[37] = new("Frame", I[31], "Frame", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(0, 255, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(53, 53, 53), BorderMode = Enum.BorderMode.Middle, Position = UDim2.fromScale(0.5, 1), Size = UDim2.new(0, 2, 0.3, 0) })
					I[38] = new("TextButton", I[26], "Equip", { BackgroundColor3 = Color3.fromRGB(0, 255, 127), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.16, 0.685), Size = UDim2.fromOffset(67, 26), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14 })
						I[39] = new("UICorner", I[38], "UICorner", { BottomLeftRadius = UDim.new(0, 4), BottomRightRadius = UDim.new(0, 4), TopLeftRadius = UDim.new(0, 4), TopRightRadius = UDim.new(0, 4) })
						I[40] = new("TextLabel", I[38], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.75, 0.8), Text = "Equip", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(17, 58, 72), TextWrapped = true, ZIndex = 7 })
							I[41] = new("UITextSizeConstraint", I[40], "UITextSizeConstraint", { MaxTextSize = 60 })
				I[42] = new("UIGridLayout", I[25], "UIGridLayout", { FillDirectionMaxCells = 4, SortOrder = Enum.SortOrder.LayoutOrder })
				I[43] = new("TextLabel", I[25], "DotCrosshair", { BackgroundColor3 = Color3.fromRGB(84, 84, 84), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0254042, 0.0198948), Size = UDim2.fromOffset(122, 122), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14 })
					I[44] = new("UICorner", I[43], "UICorner")
					I[45] = new("TextLabel", I[43], "Title", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.53, 0.005), Size = UDim2.fromScale(0.9400001, 0.153303), Text = "Dot Crosshair", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(255, 255, 255), TextTruncate = Enum.TextTruncate.AtEnd, TextWrapped = true, ZIndex = 7 })
						I[46] = new("UITextSizeConstraint", I[45], "UITextSizeConstraint", { MaxTextSize = 30, MinTextSize = 10 })
					I[47] = new("Folder", I[43], "DotCrosshair")
						I[48] = new("Frame", I[47], "cntr", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 255, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(53, 53, 53), BorderMode = Enum.BorderMode.Middle, Position = UDim2.fromScale(0.499082, 0.4404072), Size = UDim2.fromOffset(20, 19) })
							I[49] = new("UICorner", I[48], "UICorner")
			I[50] = new("Folder", I[18], "EquippedCrosshairs")
	return I[1]
end

return build
