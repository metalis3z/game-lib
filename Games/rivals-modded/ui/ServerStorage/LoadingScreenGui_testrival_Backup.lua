-- Generated from ui/ServerStorage/LoadingScreenGui_testrival_Backup.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "LoadingScreenGui_testrival_Backup", { DisplayOrder = 1000, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "MainFrame", { Active = true, BackgroundColor3 = Color3.fromRGB(24, 24, 28), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) })
			I[3] = new("ImageLabel", I[2], "GameLogo", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://17803962335"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.6, 0.6), Visible = false, ZIndex = 5 })
			I[4] = new("Frame", I[2], "Device", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(34, 34, 40), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.42, 0.42), Visible = false, ZIndex = 10 })
				I[5] = new("UICorner", I[4], "UICorner", { BottomLeftRadius = UDim.new(0.08, 0), BottomRightRadius = UDim.new(0.08, 0), TopLeftRadius = UDim.new(0.08, 0), TopRightRadius = UDim.new(0.08, 0) })
				I[6] = new("UIAspectRatioConstraint", I[4], "UIAspectRatioConstraint", { AspectRatio = 1.6 })
				I[7] = new("UIStroke", I[4], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Thickness = 2, Transparency = 0.85 })
				I[8] = new("TextLabel", I[4], "Title", { AnchorPoint = Vector2.new(0.5, 0), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.06), Size = UDim2.fromScale(0.9, 0.14), Text = "What are you playing on?", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, ZIndex = 11 })
				I[9] = new("Frame", I[4], "Controls", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.46), ZIndex = 11 })
					I[10] = new("UIListLayout", I[9], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.04, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
					I[11] = new("ImageButton", I[9], "Desktop", { BackgroundColor3 = Color3.fromRGB(24, 24, 28), BorderSizePixel = 0, LayoutOrder = 1, Size = UDim2.fromScale(0.28, 1), ZIndex = 11 })
						I[12] = new("UICorner", I[11], "UICorner", { BottomLeftRadius = UDim.new(0.12, 0), BottomRightRadius = UDim.new(0.12, 0), TopLeftRadius = UDim.new(0.12, 0), TopRightRadius = UDim.new(0.12, 0) })
						I[13] = new("ImageLabel", I[11], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://88012714630436"), Position = UDim2.fromScale(0.5, 0.42), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.55, 0.55), ZIndex = 12 })
						I[14] = new("TextLabel", I[11], "Label", { AnchorPoint = Vector2.new(0.5, 1), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.95), Size = UDim2.fromScale(0.9, 0.2), Text = "Computer", TextColor3 = Color3.fromRGB(220, 220, 220), TextScaled = true, TextWrapped = true, ZIndex = 12 })
						I[15] = new("Frame", I[11], "Chosen", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 13 })
							I[16] = new("UICorner", I[15], "UICorner", { BottomLeftRadius = UDim.new(0.12, 0), BottomRightRadius = UDim.new(0.12, 0), TopLeftRadius = UDim.new(0.12, 0), TopRightRadius = UDim.new(0.12, 0) })
							I[17] = new("UIStroke", I[15], "UIStroke", { Color = Color3.fromRGB(60, 226, 31), Thickness = 3 })
					I[18] = new("ImageButton", I[9], "Console", { BackgroundColor3 = Color3.fromRGB(24, 24, 28), BorderSizePixel = 0, LayoutOrder = 2, Size = UDim2.fromScale(0.28, 1), ZIndex = 11 })
						I[19] = new("UICorner", I[18], "UICorner", { BottomLeftRadius = UDim.new(0.12, 0), BottomRightRadius = UDim.new(0.12, 0), TopLeftRadius = UDim.new(0.12, 0), TopRightRadius = UDim.new(0.12, 0) })
						I[20] = new("ImageLabel", I[18], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://110291144710849"), Position = UDim2.fromScale(0.5, 0.42), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.55, 0.55), ZIndex = 12 })
						I[21] = new("TextLabel", I[18], "Label", { AnchorPoint = Vector2.new(0.5, 1), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.95), Size = UDim2.fromScale(0.9, 0.2), Text = "Console", TextColor3 = Color3.fromRGB(220, 220, 220), TextScaled = true, TextWrapped = true, ZIndex = 12 })
						I[22] = new("Frame", I[18], "Chosen", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 13 })
							I[23] = new("UICorner", I[22], "UICorner", { BottomLeftRadius = UDim.new(0.12, 0), BottomRightRadius = UDim.new(0.12, 0), TopLeftRadius = UDim.new(0.12, 0), TopRightRadius = UDim.new(0.12, 0) })
							I[24] = new("UIStroke", I[22], "UIStroke", { Color = Color3.fromRGB(60, 226, 31), Thickness = 3 })
					I[25] = new("ImageButton", I[9], "Mobile", { BackgroundColor3 = Color3.fromRGB(24, 24, 28), BorderSizePixel = 0, LayoutOrder = 3, Size = UDim2.fromScale(0.28, 1), ZIndex = 11 })
						I[26] = new("UICorner", I[25], "UICorner", { BottomLeftRadius = UDim.new(0.12, 0), BottomRightRadius = UDim.new(0.12, 0), TopLeftRadius = UDim.new(0.12, 0), TopRightRadius = UDim.new(0.12, 0) })
						I[27] = new("ImageLabel", I[25], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://18214330364"), Position = UDim2.fromScale(0.5, 0.42), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.55, 0.55), ZIndex = 12 })
						I[28] = new("TextLabel", I[25], "Label", { AnchorPoint = Vector2.new(0.5, 1), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.95), Size = UDim2.fromScale(0.9, 0.2), Text = "Mobile", TextColor3 = Color3.fromRGB(220, 220, 220), TextScaled = true, TextWrapped = true, ZIndex = 12 })
						I[29] = new("Frame", I[25], "Chosen", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 13 })
							I[30] = new("UICorner", I[29], "UICorner", { BottomLeftRadius = UDim.new(0.12, 0), BottomRightRadius = UDim.new(0.12, 0), TopLeftRadius = UDim.new(0.12, 0), TopRightRadius = UDim.new(0.12, 0) })
							I[31] = new("UIStroke", I[29], "UIStroke", { Color = Color3.fromRGB(60, 226, 31), Thickness = 3 })
				I[32] = new("TextButton", I[4], "Confirm", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(60, 226, 31), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.94), Size = UDim2.fromScale(0.36, 0.16), Text = "Confirm", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, Visible = false, ZIndex = 11 })
					I[33] = new("UICorner", I[32], "UICorner", { BottomLeftRadius = UDim.new(0.25, 0), BottomRightRadius = UDim.new(0.25, 0), TopLeftRadius = UDim.new(0.25, 0), TopRightRadius = UDim.new(0.25, 0) })
					I[34] = new("UIPadding", I[32], "UIPadding", { PaddingBottom = UDim.new(0.18, 0), PaddingTop = UDim.new(0.18, 0) })
			I[35] = new("Frame", I[2], "Logo", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.75, 0.75), Visible = false, ZIndex = 4 })
				I[36] = new("UIAspectRatioConstraint", I[35], "UIAspectRatioConstraint")
				I[37] = new("Frame", I[35], "N", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 4 })
					I[38] = new("Frame", I[37], "Container", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 4 })
						I[39] = new("Frame", I[38], "White", { AnchorPoint = Vector2.new(0, 1), BackgroundTransparency = 1, Position = UDim2.fromScale(0, 1), Size = UDim2.fromScale(1, 0) })
						I[40] = new("Frame", I[38], "Black", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) })
						I[41] = new("CanvasGroup", I[38], "Half", { BackgroundTransparency = 1, Size = UDim2.fromScale(0.5, 1), ZIndex = 4 })
							I[42] = new("ImageLabel", I[41], "Image", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://140099562989635"), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(2, 1), ZIndex = 4 })
								I[43] = new("UIGradient", I[42], "Fill", { Rotation = 90 })
				I[44] = new("Frame", I[35], "G", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 4 })
					I[45] = new("Frame", I[44], "Container", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 4 })
						I[46] = new("Frame", I[45], "White", { AnchorPoint = Vector2.new(0, 1), BackgroundTransparency = 1, Position = UDim2.fromScale(0, 1), Size = UDim2.fromScale(1, 0) })
						I[47] = new("Frame", I[45], "Black", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) })
						I[48] = new("CanvasGroup", I[45], "Half", { BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(0.5, 1), ZIndex = 4 })
							I[49] = new("ImageLabel", I[48], "Image", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://140099562989635"), Position = UDim2.fromScale(-1, 0), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(2, 1), ZIndex = 4 })
								I[50] = new("UIGradient", I[49], "Fill", { Rotation = 90 })
	return I[1]
end

return build
