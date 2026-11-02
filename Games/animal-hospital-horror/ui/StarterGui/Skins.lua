-- Generated from ui/StarterGui/Skins.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Skins", { DisplayOrder = 1, Enabled = false, ResetOnSpawn = false })
		I[2] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(1, 1) })
			I[3] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 1.25 })
			I[4] = new("Frame", I[2], "Options", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.new(0.01, -1, 0.4987845, 0), Size = UDim2.fromScale(0.4101124, 0.7285066) })
				I[5] = new("ScrollingFrame", I[4], "inv", { Active = true, AnchorPoint = Vector2.new(0, 0.5), AutomaticCanvasSize = Enum.AutomaticSize.XY, BackgroundColor3 = Color3.fromRGB(255, 151, 238), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, CanvasSize = UDim2.fromScale(0, 0.5), Position = UDim2.fromScale(0.0438356, 0.5), ScrollBarThickness = 8, Size = UDim2.fromScale(0.9111761, 0.9281558) })
					I[6] = new("UIStroke", I[5], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Transparency = 1 })
					I[7] = new("UIListLayout", I[5], "UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder })
					I[8] = new("UIGradient", I[5], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(120, 75, 126)), ColorSequenceKeypoint.new(0.286667, Color3.fromRGB(254, 253, 254)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }), Rotation = -90 })
				I[9] = new("UIStroke", I[4], "UIStroke", { Color = Color3.fromRGB(255, 255, 255) })
				I[10] = new("TextButton", I[4], "modal", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 232, 93), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Interactable = false, LayoutOrder = 99, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, Visible = false })
				I[11] = new("TextButton", I[4], "close", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(207, 26, 38), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/RobotoMono.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(1.0721592, -0.0624548), Size = UDim2.fromScale(0.1171474, 0.0774094), Text = "X", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[12] = new("UIAspectRatioConstraint", I[11], "UIAspectRatioConstraint")
					I[13] = new("UIStroke", I[11], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(255, 14, 0), Thickness = 2 })
				I[14] = new("Folder", I[4], "Folder")
					I[15] = new("Frame", I[14], "Template", { BackgroundColor3 = Color3.fromRGB(250, 250, 250), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderMode = Enum.BorderMode.Inset, Size = UDim2.new(1, -10, 0.1860235, 0), Visible = false, ZIndex = 101 })
						I[16] = new("ImageButton", I[15], "Button", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(60, 77, 147), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), ImageTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9706241, 0.8055776) })
							I[17] = new("ImageLabel", I[16], "img", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://187897034"), Position = UDim2.fromScale(0.0840895, 0.4117151), Size = UDim2.fromScale(0.1337853, 0.9999999), ZIndex = 2 })
								I[18] = new("UIAspectRatioConstraint", I[17], "UIAspectRatioConstraint")
							I[19] = new("TextLabel", I[16], "display", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187376739", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1680416, 0.4203595), RichText = true, Size = UDim2.fromScale(0.6630334, 0.8407187), Text = "Food Name", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(44, 44, 44), TextStrokeTransparency = 0, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 2 })
								I[20] = new("UIStroke", I[19], "UIStroke")
								I[21] = new("UIPadding", I[19], "UIPadding", { PaddingBottom = UDim.new(0.1, 0), PaddingTop = UDim.new(0.1, 0) })
							I[22] = new("Frame", I[16], "Frame", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.656933, 0.049754), Size = UDim2.fromScale(0.3134772, 0.8995081), Visible = false })
								I[23] = new("TextLabel", I[22], "cost", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/PressStart2P.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5000001, 0.7285171), Size = UDim2.fromScale(0.9, 0.3111535), Text = "", TextColor3 = Color3.fromRGB(1, 255, 3), TextScaled = true, TextSize = 14, TextWrapped = true })
									I[24] = new("UIPadding", I[23], "UIPadding", { PaddingBottom = UDim.new(0.05, 0), PaddingLeft = UDim.new(0.05, 0), PaddingRight = UDim.new(0.05, 0), PaddingTop = UDim.new(0.05, 0) })
									I[25] = new("UIStroke", I[23], "UIStroke", { Thickness = 1.5 })
								I[26] = new("TextLabel", I[22], "growth", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/PressStart2P.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5000001, 0.2761213), RichText = true, Size = UDim2.fromScale(0.9, 0.4), Text = "x Growth", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(44, 44, 44), TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 2 })
									I[27] = new("UIStroke", I[26], "UIStroke", { Thickness = 2 })
									I[28] = new("UITextSizeConstraint", I[26], "UITextSizeConstraint", { MaxTextSize = 32 })
								I[29] = new("UICorner", I[22], "UICorner", { BottomLeftRadius = UDim.new(0.1, 0), BottomRightRadius = UDim.new(0.1, 0), TopLeftRadius = UDim.new(0.1, 0), TopRightRadius = UDim.new(0.1, 0) })
							I[30] = new("UIStroke", I[16], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Thickness = 2 })
								I[31] = new("UIGradient", I[30], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 252, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 252, 255)) }), Offset = Vector2.new(0, 0.1), Rotation = 100, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.5, 1), NumberSequenceKeypoint.new(1, 0.5375) }) })
							I[32] = new("UIGradient", I[16], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(249, 253, 255)), ColorSequenceKeypoint.new(0.26, Color3.fromRGB(222, 224, 227)), ColorSequenceKeypoint.new(0.42, Color3.fromRGB(251, 252, 255)), ColorSequenceKeypoint.new(0.576667, Color3.fromRGB(189, 189, 192)), ColorSequenceKeypoint.new(1, Color3.fromRGB(18, 18, 19)) }), Offset = Vector2.new(0, 0.1), Rotation = 90 })
		I[33] = new("Frame", I[1], "Center", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
			I[34] = new("UIAspectRatioConstraint", I[33], "UIAspectRatioConstraint")
			I[35] = new("TextLabel", I[33], "robux", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187376739", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.8116561), Size = UDim2.fromScale(0.4106585, 0.0483146), Text = "Robux Only", TextColor3 = Color3.fromRGB(0, 249, 0), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false })
				I[36] = new("UIStroke", I[35], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel })
			I[37] = new("Frame", I[33], "buy", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.878), Size = UDim2.fromScale(0.7, 0.059) })
				I[38] = new("TextButton", I[37], "buyRobux", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 200, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/RobotoMono.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.7174449, 0.6248928), RichText = true, Size = UDim2.fromScale(0.3008263, 1), Text = "", TextColor3 = Color3.fromRGB(255, 198, 55), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 100 })
					I[39] = new("TextLabel", I[38], "text", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187376739", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.4499978), Size = UDim2.fromScale(0.9, 0.8999996), Text = "Buy $0", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 101 })
						I[40] = new("UIStroke", I[39], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel })
					I[41] = new("UIGradient", I[38], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(249, 253, 255)), ColorSequenceKeypoint.new(0.26, Color3.fromRGB(222, 224, 227)), ColorSequenceKeypoint.new(0.42, Color3.fromRGB(251, 252, 255)), ColorSequenceKeypoint.new(0.576667, Color3.fromRGB(189, 189, 192)), ColorSequenceKeypoint.new(1, Color3.fromRGB(18, 18, 19)) }), Offset = Vector2.new(0, 0.1), Rotation = 90 })
					I[42] = new("UIStroke", I[38], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border })
				I[43] = new("UIListLayout", I[37], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.1, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
				I[44] = new("TextButton", I[37], "buyCash", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(45, 210, 11), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/RobotoMono.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2800983, 0.6248928), RichText = true, Size = UDim2.fromScale(0.3008263, 1), Text = "", TextColor3 = Color3.fromRGB(255, 198, 55), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 100 })
					I[45] = new("TextLabel", I[44], "text", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187376739", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.4499978), Size = UDim2.fromScale(0.9, 0.8999996), Text = "Buy $0", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 101 })
						I[46] = new("UIStroke", I[45], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel })
					I[47] = new("UIStroke", I[44], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border })
					I[48] = new("UIGradient", I[44], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(249, 253, 255)), ColorSequenceKeypoint.new(0.26, Color3.fromRGB(222, 224, 227)), ColorSequenceKeypoint.new(0.42, Color3.fromRGB(251, 252, 255)), ColorSequenceKeypoint.new(0.576667, Color3.fromRGB(189, 189, 192)), ColorSequenceKeypoint.new(1, Color3.fromRGB(18, 18, 19)) }), Offset = Vector2.new(0, 0.1), Rotation = 90 })
					I[49] = new("ImageLabel", I[44], "coin", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://116416447601441"), Position = UDim2.fromScale(1.05, 0.5), Size = UDim2.fromScale(1, 1) })
						I[50] = new("UIAspectRatioConstraint", I[49], "UIAspectRatioConstraint")
						I[51] = new("ImageLabel", I[49], "shadow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://116416447601441"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1.05, 1.04), ZIndex = 0 })
							I[52] = new("UIAspectRatioConstraint", I[51], "UIAspectRatioConstraint")
			I[53] = new("TextLabel", I[33], "equipped", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187376739", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.8747583), Size = UDim2.fromScale(0.4106585, 0.0778899), Text = "Equipped", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false })
				I[54] = new("UIStroke", I[53], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel })
			I[55] = new("TextButton", I[33], "equip", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 251, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/RobotoMono.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.8778685), RichText = true, Size = UDim2.fromScale(0.2344873, 0.0586218), Text = "", TextColor3 = Color3.fromRGB(255, 198, 55), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false, ZIndex = 100 })
				I[56] = new("TextLabel", I[55], "text", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187376739", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.4499978), Size = UDim2.fromScale(0.9, 0.8999996), Text = "Equip", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 101 })
					I[57] = new("UIStroke", I[56], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel })
				I[58] = new("UIStroke", I[55], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border })
				I[59] = new("UIGradient", I[55], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(249, 253, 255)), ColorSequenceKeypoint.new(0.26, Color3.fromRGB(222, 224, 227)), ColorSequenceKeypoint.new(0.42, Color3.fromRGB(251, 252, 255)), ColorSequenceKeypoint.new(0.576667, Color3.fromRGB(189, 189, 192)), ColorSequenceKeypoint.new(1, Color3.fromRGB(18, 18, 19)) }), Offset = Vector2.new(0, 0.1), Rotation = 90 })
	return I[1]
end

return build
