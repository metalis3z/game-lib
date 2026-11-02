-- Generated from ui/ReplicatedStorage/ReplicatedGui/CraftingMachine.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "CraftingMachine", { ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, nil, { "ScreenGui" })
		I[2] = new("Frame", I[1], "CraftingMachine", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(51, 66, 73), BackgroundTransparency = 0.3, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.4604996, 0.6366835), Visible = false })
			I[3] = new("Frame", I[2], "Header", { BackgroundColor3 = Color3.fromRGB(85, 112, 127), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(-0.0000001, 0), Size = UDim2.fromScale(0.9998139, 0.1434383) })
				I[4] = new("ImageButton", I[3], "Close", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, HoverImageContent = Content.fromUri("rbxassetid://137110183435251"), ImageContent = Content.fromUri("rbxassetid://105016554772347"), Position = UDim2.fromScale(0.935102, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.0873362, 0.877193) })
					I[5] = new("TextLabel", I[4], "X", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 0.56), Text = "X", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
						I[6] = new("UIStroke", I[5], "UIStroke", { Thickness = 3 }, { ["OriginalThickness"] = 3 }, { "ScreenStroke", "UIStroke" })
						I[7] = new("UIPadding", I[5], "UIPadding", { PaddingLeft = UDim.new(0.01, 0), PaddingRight = UDim.new(-0.03, 0) })
						I[8] = new("UITextSizeConstraint", I[5], "UITextSizeConstraint", { MaxTextSize = 47 })
				I[9] = new("TextLabel", I[3], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2615665, 0.4916193), Size = UDim2.fromScale(0.5005739, 0.7207084), Text = "Craft Brainrots", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[10] = new("UIStroke", I[9], "UIStroke", { Thickness = 3 }, { ["OriginalThickness"] = 3 }, { "ScreenStroke", "UIStroke" })
					I[11] = new("UITextSizeConstraint", I[9], "UITextSizeConstraint", { MaxTextSize = 69 })
			I[12] = new("Frame", I[2], "Content", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.fromScale(0.3534378, 0.1613765), Size = UDim2.fromScale(0.6465182, 0.8386235) })
				I[13] = new("TextLabel", I[12], "Required", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0.0812714, 0.2849171), Size = UDim2.fromScale(0.6458023, 0.1025935), Text = "Brainrots Required:", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[14] = new("UIStroke", I[13], "UIStroke", { Thickness = 3 }, { ["OriginalThickness"] = 3 }, { "ScreenStroke", "UIStroke" })
				I[15] = new("TextLabel", I[12], "Selected", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2571572, 0.0470385), Size = UDim2.fromScale(0.4541475, 0.0990974), Text = "Selected:", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[16] = new("UIStroke", I[15], "UIStroke", { Thickness = 3 }, { ["OriginalThickness"] = 3 }, { "ScreenStroke", "UIStroke" })
				I[17] = new("UIListLayout", I[12], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.01, 0), SortOrder = Enum.SortOrder.LayoutOrder })
				I[18] = new("Frame", I[12], "Brainrots", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 3, Position = UDim2.fromScale(0.0247084, 0.4203681), Size = UDim2.fromScale(0.9505831, 0.3092228) })
					I[19] = new("UIListLayout", I[18], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.025, 0), SortOrder = Enum.SortOrder.LayoutOrder })
					I[20] = new("Frame", I[18], "Template", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.0032234, 0), Size = UDim2.fromScale(0.2162764, 0.66), Visible = false })
						I[21] = new("UIStroke", I[20], "UIStroke", { Thickness = 3 }, { ["OriginalThickness"] = 3 }, { "ScreenStroke", "UIStroke" })
						I[22] = new("TextLabel", I[20], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4976864, 0.1447079), Size = UDim2.fromScale(0.7249393, 0.2894168), Text = "Tralelero Tralala", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 2 })
							I[23] = new("UIStroke", I[22], "UIStroke", { Thickness = 3 }, { ["OriginalThickness"] = 3 }, { "ScreenStroke", "UIStroke" })
						I[24] = new("ImageButton", I[20], "Return", { BackgroundColor3 = Color3.fromRGB(240, 198, 48), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), ImageTransparency = 1, Position = UDim2.fromScale(0.0083674, 1.0851285), Size = UDim2.fromScale(0.9916336, 0.2728657), ZIndex = 2 })
							I[25] = new("UIStroke", I[24], "UIStroke", { Thickness = 3 }, { ["OriginalThickness"] = 3 }, { "ScreenStroke", "UIStroke" })
							I[26] = new("TextLabel", I[24], "Txt", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.8, 0.8), Text = "Return", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
								I[27] = new("UIStroke", I[26], "UIStroke", { Thickness = 2.5 }, { ["OriginalThickness"] = 2.5 }, { "ScreenStroke", "UIStroke" })
						I[28] = new("ViewportFrame", I[20], "ViewportFrame", { Ambient = Color3.fromRGB(255, 255, 255), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LightColor = Color3.fromRGB(255, 255, 255), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
				I[29] = new("ImageButton", I[12], "Buy", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, HoverImageContent = Content.fromUri("rbxassetid://100703312924377"), ImageContent = Content.fromUri("rbxassetid://83673098636246"), LayoutOrder = 10, Position = UDim2.fromScale(0.5429137, 0.7654078), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.4580259, 0.1504734), Visible = false })
					I[30] = new("TextLabel", I[29], "Price", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 0.78), Text = "$38.5K", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
						I[31] = new("UIStroke", I[30], "UIStroke", { Thickness = 3 }, { ["OriginalThickness"] = 3 }, { "ScreenStroke", "UIStroke" })
				I[32] = new("TextLabel", I[12], "Time", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 6, Position = UDim2.fromScale(0.1190634, 0.7198133), RichText = true, Size = UDim2.fromScale(0.7618731, 0.0776498), Text = "Crafting Time (<font color=\"#ffff00\">0s</font>)", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[33] = new("UIStroke", I[32], "UIStroke", { Thickness = 3 }, { ["OriginalThickness"] = 3 }, { "ScreenStroke", "UIStroke" })
				I[34] = new("ImageButton", I[12], "BrainrotName", { Active = false, AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.4, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), ImageTransparency = 1, Interactable = false, LayoutOrder = 1, Position = UDim2.fromScale(0.4999999, 0.1804564), Size = UDim2.fromScale(0.5438523, 0.1427181) })
					I[35] = new("UIStroke", I[34], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Thickness = 3 }, { ["OriginalThickness"] = 3 }, { "ScreenStroke", "UIStroke" })
					I[36] = new("TextLabel", I[34], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5981671, 0.4931071), Size = UDim2.fromScale(0.7501364, 0.6445284), Text = "Tralalero Tralala", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
						I[37] = new("UIStroke", I[36], "UIStroke", { Thickness = 3 }, { ["OriginalThickness"] = 3 }, { "ScreenStroke", "UIStroke" })
						I[38] = new("UITextSizeConstraint", I[36], "UITextSizeConstraint", { MaxTextSize = 42 })
					I[39] = new("ViewportFrame", I[34], "ViewportFrame", { Ambient = Color3.fromRGB(255, 255, 255), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LightColor = Color3.fromRGB(255, 255, 255), Position = UDim2.fromScale(0.13, 0.5), Size = UDim2.fromScale(0.2232618, 0.8372748) })
			I[40] = new("Frame", I[2], "List", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.fromScale(0.022, 0.2251587), Size = UDim2.fromScale(0.3405218, 0.721418) })
				I[41] = new("UIStroke", I[40], "UIStroke", { Thickness = 3 }, { ["OriginalThickness"] = 3 }, { "ScreenStroke", "UIStroke" })
				I[42] = new("UIListLayout", I[40], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.04, 0), SortOrder = Enum.SortOrder.LayoutOrder })
				I[43] = new("UIPadding", I[40], "UIPadding", { PaddingTop = UDim.new(0.04, 0) })
				I[44] = new("ImageButton", I[40], "Template", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.4, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), ImageTransparency = 1, Position = UDim2.fromScale(0.4999999, 0.0812184), Size = UDim2.fromScale(0.915269, 0.1559389), Visible = false })
					I[45] = new("UIStroke", I[44], "UIStroke", { Color = Color3.fromRGB(198, 198, 198), Thickness = 3 }, { ["OriginalThickness"] = 3 }, { "ScreenStroke", "UIStroke" })
					I[46] = new("TextLabel", I[44], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(56, 56, 56), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.617, 0.5), Size = UDim2.fromScale(0.723, 0.714), Text = "Brainrot Name", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
						I[47] = new("UITextSizeConstraint", I[46], "UITextSizeConstraint", { MaxTextSize = 42 })
						I[48] = new("UIStroke", I[46], "UIStroke", { Thickness = 2 }, { ["OriginalThickness"] = 2 }, { "ScreenStroke", "UIStroke" })
					I[49] = new("ViewportFrame", I[44], "ViewportFrame", { Ambient = Color3.fromRGB(255, 255, 255), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LightColor = Color3.fromRGB(255, 255, 255), Position = UDim2.fromScale(0.13, 0.5), Size = UDim2.fromScale(0.2232618, 0.8372748) })
			I[50] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 1.2870204 })
	return I[1]
end

return build
