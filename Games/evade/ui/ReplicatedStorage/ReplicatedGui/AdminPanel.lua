-- Generated from ui/ReplicatedStorage/ReplicatedGui/AdminPanel.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "AdminPanel", { ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, nil, { "ScreenGui" })
		I[2] = new("Frame", I[1], "AdminPanel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(51, 66, 73), BackgroundTransparency = 0.3, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.448, 0.72), Visible = false })
			I[3] = new("Frame", I[2], "Header", { BackgroundColor3 = Color3.fromRGB(85, 112, 127), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(-0.0000001, 0), Size = UDim2.fromScale(0.9998139, 0.1434383) })
				I[4] = new("ImageButton", I[3], "Close", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, HoverImageContent = Content.fromUri("rbxassetid://137110183435251"), ImageContent = Content.fromUri("rbxassetid://105016554772347"), Position = UDim2.fromScale(0.935102, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.0873362, 0.877193) })
					I[5] = new("TextLabel", I[4], "X", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 0.56), Text = "X", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
						I[6] = new("UIStroke", I[5], "UIStroke", { Thickness = 3 }, { ["OriginalThickness"] = 3 }, { "ScreenStroke", "UIStroke" })
						I[7] = new("UIPadding", I[5], "UIPadding", { PaddingLeft = UDim.new(0.01, 0), PaddingRight = UDim.new(-0.03, 0) })
						I[8] = new("UITextSizeConstraint", I[5], "UITextSizeConstraint", { MaxTextSize = 47 })
				I[9] = new("TextLabel", I[3], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2615665, 0.4916193), Size = UDim2.fromScale(0.5005739, 0.7207084), Text = "ADMIN PANEL", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[10] = new("UIStroke", I[9], "UIStroke", { Thickness = 2 }, { ["OriginalThickness"] = 2 }, { "ScreenStroke", "UIStroke" })
					I[11] = new("UITextSizeConstraint", I[9], "UITextSizeConstraint", { MaxTextSize = 69 })
			I[12] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 1.2852073 })
			I[13] = new("Frame", I[2], "Content", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.fromScale(0.0238375, 0.3076837), Size = UDim2.fromScale(0.6339706, 0.6910031) })
				I[14] = new("ScrollingFrame", I[13], "ScrollingFrame", { Active = true, AnchorPoint = Vector2.new(0.5, 0.5), AutomaticCanvasSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, CanvasSize = UDim2.fromScale(0, 0), ClipsDescendants = false, Position = UDim2.fromScale(0.4975466, 0.508079), ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0), ScrollBarImageTransparency = 1, ScrollBarThickness = 4, Size = UDim2.fromScale(0.9950933, 0.983842) })
					I[15] = new("UIGridLayout", I[14], "UIGridLayout", { CellPadding = UDim2.fromScale(0.02, 0.02), CellSize = UDim2.fromScale(0.49, 0.17), FillDirectionMaxCells = 2, SortOrder = Enum.SortOrder.LayoutOrder })
					I[16] = new("ImageButton", I[14], "Template", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.4, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Selectable = false, Size = UDim2.fromScale(0.4816622, 0.2), Visible = false })
						I[17] = new("TextLabel", I[16], "Command", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.275, 0.474), Size = UDim2.fromScale(0.7, 0.4), Text = ";ice", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
							I[18] = new("UIStroke", I[17], "UIStroke", { Thickness = 1.5 }, { ["OriginalThickness"] = 1.5 }, { "ScreenStroke", "UIStroke" })
						I[19] = new("TextLabel", I[16], "Timer", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.249126, 0.45), Text = "20s", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 5 })
							I[20] = new("UIStroke", I[19], "UIStroke", nil, { ["OriginalThickness"] = 1 }, { "ScreenStroke", "UIStroke" })
						I[21] = new("ImageLabel", I[16], "Icon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://73190169307932"), Position = UDim2.fromScale(0.02, 0.1674177), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.2200836, 0.7007138) })
						I[22] = new("UIStroke", I[16], "UIStroke", { Thickness = 1.5 }, { ["OriginalThickness"] = 1.5 }, { "ScreenStroke", "UIStroke" })
						I[23] = new("Frame", I[16], "CooldownFrame", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.175, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), Visible = false })
					I[24] = new("UIPadding", I[14], "UIPadding", { PaddingBottom = UDim.new(0, 4), PaddingLeft = UDim.new(0, 4), PaddingRight = UDim.new(0, 4), PaddingTop = UDim.new(0, 4) })
			I[25] = new("Frame", I[2], "Profiles", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.fromScale(0.6684802, 0.1429584), Size = UDim2.fromScale(0.3313337, 0.8546532) })
				I[26] = new("ScrollingFrame", I[25], "ScrollingFrame", { Active = true, AutomaticCanvasSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, CanvasSize = UDim2.fromScale(0, 0), ClipsDescendants = false, Position = UDim2.fromScale(0, 0.04), ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0), ScrollBarThickness = 6, Size = UDim2.fromScale(0.9787319, 0.9654983) })
					I[27] = new("ImageButton", I[26], "Template", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.4, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), ImageTransparency = 1, Position = UDim2.fromScale(0.4576341, 0.0625691), Size = UDim2.fromScale(0.915, 0.102), Visible = false })
						I[28] = new("UIStroke", I[27], "UIStroke", { Thickness = 1.5 }, { ["OriginalThickness"] = 1.5 }, { "ScreenStroke", "UIStroke" })
						I[29] = new("ImageLabel", I[27], "playerPhoto", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://79167338394989"), Position = UDim2.fromScale(0.18, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.345, 1) })
						I[30] = new("TextLabel", I[27], "playerName", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.703613, 0.4593849), Size = UDim2.fromScale(0.5857502, 0.5099441), Text = "HgD3v", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
							I[31] = new("UIStroke", I[30], "UIStroke", { Thickness = 1.5 }, { ["OriginalThickness"] = 1.5 }, { "ScreenStroke", "UIStroke" })
							I[32] = new("UITextSizeConstraint", I[30], "UITextSizeConstraint", { MaxTextSize = 42 })
					I[33] = new("UIListLayout", I[26], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.02, 0), SortOrder = Enum.SortOrder.LayoutOrder })
			I[34] = new("ImageButton", I[2], "CommandBox", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.4, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), ImageTransparency = 1, Position = UDim2.fromScale(0.3396927, 0.2378155), Size = UDim2.fromScale(0.6339706, 0.123) })
				I[35] = new("UIStroke", I[34], "UIStroke", { Thickness = 1.5 }, { ["OriginalThickness"] = 1.5 }, { "ScreenStroke", "UIStroke" })
				I[36] = new("TextLabel", I[34], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2539981, -0.0143956), Size = UDim2.fromScale(0.4506015, 0.443431), Text = "Type Command", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 2 })
					I[37] = new("UIStroke", I[36], "UIStroke", nil, { ["OriginalThickness"] = 1 }, { "ScreenStroke", "UIStroke" })
				I[38] = new("TextBox", I[34], "TextBox", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ClearTextOnFocus = false, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), PlaceholderColor3 = Color3.fromRGB(100, 100, 100), PlaceholderText = "Enter command", Position = UDim2.new(0.03, 1, 0.5, 0), Size = UDim2.fromScale(0.94, 0.55), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 2 })
	return I[1]
end

return build
