-- Generated from ui/StarterGui/GiftList.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "GiftList", { ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.75, 0.8), Visible = false }, { ["Blur"] = true })
			I[3] = new("ScrollingFrame", I[2], "inv", { Active = true, AnchorPoint = Vector2.new(0.5, 0.5), AutomaticCanvasSize = Enum.AutomaticSize.XY, BackgroundColor3 = Color3.fromRGB(69, 69, 69), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, CanvasSize = UDim2.fromScale(0, 0.5), Position = UDim2.fromScale(0.5, 0.5224537), ScrollBarImageColor3 = Color3.fromRGB(138, 139, 141), ScrollBarThickness = 15, Size = UDim2.fromScale(0.9000001, 0.8456029) })
				I[4] = new("Folder", I[3], "Folder")
					I[5] = new("Frame", I[4], "Template", { BackgroundColor3 = Color3.fromRGB(250, 250, 250), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderMode = Enum.BorderMode.Inset, Position = UDim2.fromScale(-0.0000001, 0), Size = UDim2.fromScale(0.9881202, 0.25), Visible = false })
						I[6] = new("ImageButton", I[5], "Button", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(60, 77, 147), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), ImageTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.94, 0.9) })
							I[7] = new("ImageLabel", I[6], "img", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.new(0, 2, 0.5, 0), Size = UDim2.new(1, -2, 1, -4), ZIndex = 2 })
								I[8] = new("UIStroke", I[7], "UIStroke", { Color = Color3.fromRGB(255, 255, 255) })
								I[9] = new("UIAspectRatioConstraint", I[7], "UIAspectRatioConstraint")
							I[10] = new("TextLabel", I[6], "user", { AnchorPoint = Vector2.new(0, 0.5), AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187376739", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3191366, 0.6761903), RichText = true, Size = UDim2.fromScale(0.6226274, 0.259788), Text = "@Name", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(44, 44, 44), TextStrokeTransparency = 0, TextTransparency = 0.26, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 2 })
								I[11] = new("UIStroke", I[10], "UIStroke", { Color = Color3.fromRGB(44, 44, 44), Thickness = 2 })
								I[12] = new("UITextSizeConstraint", I[10], "UITextSizeConstraint", { MaxTextSize = 24 })
							I[13] = new("TextLabel", I[6], "display", { AnchorPoint = Vector2.new(0, 0.5), AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187376739", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3191366, 0.372789), RichText = true, Size = UDim2.fromScale(0.6213223, 0.3799858), Text = "Food Name", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(44, 44, 44), TextStrokeTransparency = 0, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 2 })
								I[14] = new("UIStroke", I[13], "UIStroke", { Color = Color3.fromRGB(44, 44, 44), Thickness = 2 })
								I[15] = new("UITextSizeConstraint", I[13], "UITextSizeConstraint", { MaxTextSize = 32 })
							I[16] = new("Frame", I[6], "Frame", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.656933, 0.049754), Size = UDim2.fromScale(0.3134772, 0.8995081), Visible = false })
								I[17] = new("TextLabel", I[16], "cost", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/PressStart2P.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5000001, 0.7285171), Size = UDim2.fromScale(0.9, 0.3111535), Text = "", TextColor3 = Color3.fromRGB(1, 255, 3), TextScaled = true, TextSize = 14, TextWrapped = true })
									I[18] = new("UIPadding", I[17], "UIPadding", { PaddingBottom = UDim.new(0.05, 0), PaddingLeft = UDim.new(0.05, 0), PaddingRight = UDim.new(0.05, 0), PaddingTop = UDim.new(0.05, 0) })
									I[19] = new("UIStroke", I[17], "UIStroke", { Thickness = 1.5 })
								I[20] = new("TextLabel", I[16], "growth", { AnchorPoint = Vector2.new(0.5, 0.5), AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/PressStart2P.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5000001, 0.2761213), RichText = true, Size = UDim2.fromScale(0.9, 0.4), Text = "x Growth", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(44, 44, 44), TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 2 })
									I[21] = new("UIStroke", I[20], "UIStroke", { Thickness = 2 })
									I[22] = new("UITextSizeConstraint", I[20], "UITextSizeConstraint", { MaxTextSize = 32 })
								I[23] = new("UICorner", I[16], "UICorner", { BottomLeftRadius = UDim.new(0.1, 0), BottomRightRadius = UDim.new(0.1, 0), TopLeftRadius = UDim.new(0.1, 0), TopRightRadius = UDim.new(0.1, 0) })
							I[24] = new("UIStroke", I[6], "UIStroke", { BorderStrokePosition = Enum.BorderStrokePosition.Inner, Color = Color3.fromRGB(255, 255, 255), Thickness = 2 })
							I[25] = new("UIGradient", I[6], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(249, 253, 255)), ColorSequenceKeypoint.new(0.26, Color3.fromRGB(222, 224, 227)), ColorSequenceKeypoint.new(0.42, Color3.fromRGB(251, 252, 255)), ColorSequenceKeypoint.new(0.576667, Color3.fromRGB(189, 189, 192)), ColorSequenceKeypoint.new(1, Color3.fromRGB(18, 18, 19)) }), Offset = Vector2.new(0, 0.1), Rotation = 90 })
				I[26] = new("UIStroke", I[3], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Enabled = false })
				I[27] = new("UIListLayout", I[3], "UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder })
				I[28] = new("UIGradient", I[3], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(120, 75, 126)), ColorSequenceKeypoint.new(0.286667, Color3.fromRGB(254, 253, 254)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }), Rotation = -90 })
			I[29] = new("UIStroke", I[2], "UIStroke", { Color = Color3.fromRGB(255, 255, 255) })
			I[30] = new("TextLabel", I[2], "subtitle", { AnchorPoint = Vector2.new(0.5, 0.5), AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187376739", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.043639), Size = UDim2.fromScale(0.7, 0.057028), Text = "Choose 🎁 Recipient", TextColor3 = Color3.fromRGB(255, 249, 240), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(107, 107, 107), TextWrapped = true })
				I[31] = new("UIStroke", I[30], "UIStroke", { Thickness = 2 })
				I[32] = new("UITextSizeConstraint", I[30], "UITextSizeConstraint", { MaxTextSize = 60 })
			I[33] = new("TextButton", I[2], "modal", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 232, 93), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Interactable = false, LayoutOrder = 99, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14 })
			I[34] = new("TextButton", I[2], "close", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(207, 26, 38), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(1.0304809, -0.0349144), Size = UDim2.fromScale(0.0754691, 0.0902702), Text = "X", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[35] = new("UIAspectRatioConstraint", I[34], "UIAspectRatioConstraint")
				I[36] = new("UIStroke", I[34], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(115, 4, 0), Transparency = 0.2 })
			I[37] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 0.8449231 })
	return I[1]
end

return build
