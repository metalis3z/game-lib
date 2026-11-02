-- Generated from ui/ReplicatedStorage/ReplicatedGui/AdminSelection.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "AdminSelection", { DisplayOrder = 10000, ResetOnSpawn = false, SafeAreaCompatibility = Enum.SafeAreaCompatibility.None, ScreenInsets = Enum.ScreenInsets.None }, { ["_lemonadeUniqueId"] = "ejCjhfUSejCj" }, { "ScreenGui" })
		I[2] = new("Frame", I[1], "AdminSelection", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.4480469, 0.5368568), Visible = false }, { ["_lemonadeUniqueId"] = "XOQ80G60XOQ8" })
			I[3] = new("Folder", I[2], "GuiResizer") -- was a ModuleScript (code in source/scripts)
				I[4] = new("Frame", I[3], "resizer", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ClipsDescendants = true, Position = UDim2.new(1, -30, 1, -30), Size = UDim2.fromScale(0.0273125, 0.0442217), SizeConstraint = Enum.SizeConstraint.RelativeXX }, { ["_lemonadeUniqueId"] = "kR1rNpIekR1r" })
					I[5] = new("ImageButton", I[4], "dragger", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderSizePixel = 0, ImageTransparency = 1, Size = UDim2.fromScale(2, 2), ZIndex = 2 }, { ["_lemonadeUniqueId"] = "aQWH54l3aQWH" })
			I[6] = new("UIScale", I[2], "UIScale", { Scale = 1.3 }, { ["_lemonadeUniqueId"] = "LicbhFS6Licb" })
			I[7] = new("ImageLabel", I[2], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://76660575181533"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = -1 }, { ["_lemonadeUniqueId"] = "cq6TxMb9cq6T" })
				I[8] = new("UIGradient", I[7], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 4)), ColorSequenceKeypoint.new(0.15, Color3.fromRGB(221, 255, 0)), ColorSequenceKeypoint.new(0.3, Color3.fromRGB(25, 255, 0)), ColorSequenceKeypoint.new(0.45, Color3.fromRGB(2, 200, 255)), ColorSequenceKeypoint.new(0.6, Color3.fromRGB(0, 17, 255)), ColorSequenceKeypoint.new(0.75, Color3.fromRGB(143, 30, 255)), ColorSequenceKeypoint.new(0.9, Color3.fromRGB(255, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) }), Rotation = 45 }, { ["_lemonadeUniqueId"] = "lb8OGSdjlb8O" })
			I[9] = new("Frame", I[2], "Header", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.0012953), Size = UDim2.fromScale(0.9982563, 0.1476684) }, { ["_lemonadeUniqueId"] = "1kDRQ9PV1kDR" })
				I[10] = new("Frame", I[9], "Txts", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.0218341, 0.5), Size = UDim2.fromScale(0.5, 1) }, { ["_lemonadeUniqueId"] = "yj6Y0ZVjyj6Y" })
					I[11] = new("TextLabel", I[10], "Txt1", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(1.4579537, 0.7986092), Size = UDim2.fromScale(1, 0.7), Text = "ADMIN SELECTION", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left }, { ["_lemonadeUniqueId"] = "BLGIi4ugBLGI" })
						I[12] = new("UIStroke", I[11], "UIStroke", { Thickness = 2.8027778 }, { ["OriginalThickness"] = 3, ["_lemonadeUniqueId"] = "cQODY1rpcQOD" }, { "ScreenStroke", "UIStroke" })
					I[13] = new("UIListLayout", I[10], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0.75, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center }, { ["_lemonadeUniqueId"] = "BkpjvZ6CBkpj" })
					I[14] = new("ImageButton", I[10], "Close", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 55, Position = UDim2.fromScale(0.9373068, 0.4967697), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.7, 0.7) }, { ["_lemonadeUniqueId"] = "khLoKdHnkhLo" })
						I[15] = new("TextLabel", I[14], "Txt", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 0.56), Text = "X", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "0i183nMI0i18" })
							I[16] = new("UIStroke", I[15], "UIStroke", { Thickness = 2.8027778 }, { ["OriginalThickness"] = 3, ["_lemonadeUniqueId"] = "B3tLmUgQB3tL" }, { "ScreenStroke", "UIStroke" })
							I[17] = new("UIPadding", I[15], "UIPadding", { PaddingLeft = UDim.new(0.01, 0), PaddingRight = UDim.new(-0.03, 0) }, { ["_lemonadeUniqueId"] = "jP8XyZxTjP8X" })
						I[18] = new("UICorner", I[14], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) }, { ["_lemonadeUniqueId"] = "Ks01DBhJKs01" })
						I[19] = new("UIStroke", I[14], "UIStroke", { Thickness = 1.8685185 }, { ["OriginalThickness"] = 2, ["_lemonadeUniqueId"] = "OMghh9IyOMgh" }, { "ScreenStroke", "UIStroke" })
						I[20] = new("UIAspectRatioConstraint", I[14], "UIAspectRatioConstraint", nil, { ["_lemonadeUniqueId"] = "fgfgvfnBfgfg" })
						I[21] = new("UIScale", I[14], "ButtonUIScale", nil, { ["_lemonadeUniqueId"] = "HwnIUZeIHwnI" })
			I[22] = new("Frame", I[2], "Content", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromScale(1, 0.8523316) }, { ["_lemonadeUniqueId"] = "GfmSL10OGfmS" })
				I[23] = new("CanvasGroup", I[22], "CanvasGroup", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(1.2, 1) }, { ["_lemonadeUniqueId"] = "X27pfEAmX27p" })
					I[24] = new("ScrollingFrame", I[23], "List", { AnchorPoint = Vector2.new(0.5, 0.5), AutomaticCanvasSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, CanvasSize = UDim2.fromOffset(0, 1150), Position = UDim2.fromScale(0.5, 0.5), ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0), ScrollBarThickness = 8, ScrollingDirection = Enum.ScrollingDirection.Y, Size = UDim2.fromScale(1, 1) }, { ["_lemonadeUniqueId"] = "Af5JnXZrAf5J" })
						I[25] = new("UIListLayout", I[24], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.01, 0), SortOrder = Enum.SortOrder.LayoutOrder, Wraps = true }, { ["_lemonadeUniqueId"] = "gIo0YWxlgIo0" })
						I[26] = new("UIAspectRatioConstraint", I[24], "UIAspectRatioConstraint", { AspectRatio = 1.7431612 }, { ["_lemonadeUniqueId"] = "dSsx0lrRdSsx" })
						I[27] = new("TextButton", I[24], "Template", { BackgroundColor3 = Color3.fromRGB(20, 20, 20), BackgroundTransparency = 0.4, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(0.25, 0.25), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, Visible = false }, { ["_lemonadeUniqueId"] = "hI1w6ZnzhI1w" })
							I[28] = new("UICorner", I[27], "UICorner", { BottomLeftRadius = UDim.new(0.1, 0), BottomRightRadius = UDim.new(0.1, 0), TopLeftRadius = UDim.new(0.1, 0), TopRightRadius = UDim.new(0.1, 0) }, { ["_lemonadeUniqueId"] = "AILotpFfAILo" })
							I[29] = new("UIGradient", I[27], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 100, 100)) }), Rotation = 45 }, { ["_lemonadeUniqueId"] = "5nTtZwGU5nTt" })
							I[30] = new("ImageLabel", I[27], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) }, { ["_lemonadeUniqueId"] = "keXWhMO2keXW" })
							I[31] = new("TextLabel", I[27], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "Template", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 5 }, { ["_lemonadeUniqueId"] = "spao8E9Pspao" })
								I[32] = new("UITextSizeConstraint", I[31], "UITextSizeConstraint", { MaxTextSize = 12 }, { ["_lemonadeUniqueId"] = "VZhGGuywVZhG" })
								I[33] = new("UIStroke", I[31], "UIStroke", { Thickness = 1.8685185 }, { ["OriginalThickness"] = 2, ["_lemonadeUniqueId"] = "S3VX2D1tS3VX" }, { "ScreenStroke", "UIStroke" })
							I[34] = new("ViewportFrame", I[27], "ViewportFrame", { Ambient = Color3.fromRGB(255, 255, 255), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LightColor = Color3.fromRGB(255, 255, 255), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) }, { ["_lemonadeUniqueId"] = "BCbpzrIsBCbp" })
							I[35] = new("UIAspectRatioConstraint", I[27], "UIAspectRatioConstraint", nil, { ["_lemonadeUniqueId"] = "ZgH7Uw9PZgH7" })
			I[36] = new("UIGradient", I[2], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(21, 245, 47)), ColorSequenceKeypoint.new(0.1223371, Color3.fromRGB(2, 200, 255)), ColorSequenceKeypoint.new(0.2723372, Color3.fromRGB(0, 17, 255)), ColorSequenceKeypoint.new(0.4223371, Color3.fromRGB(143, 30, 255)), ColorSequenceKeypoint.new(0.5723372, Color3.fromRGB(255, 0, 255)), ColorSequenceKeypoint.new(0.6723372, Color3.fromRGB(255, 0, 4)), ColorSequenceKeypoint.new(0.6723372, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(0.8223372, Color3.fromRGB(221, 255, 0)), ColorSequenceKeypoint.new(0.9723372, Color3.fromRGB(25, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(21, 245, 47)) }), Rotation = 45 }, { ["_lemonadeUniqueId"] = "UKNZWG8aUKNZ" })
			I[37] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0.05, 0), BottomRightRadius = UDim.new(0.05, 0), TopLeftRadius = UDim.new(0.05, 0), TopRightRadius = UDim.new(0.05, 0) }, { ["_lemonadeUniqueId"] = "NEUwExTdNEUw" })
			I[38] = new("UIStroke", I[2], "UIStroke", { Color = Color3.fromRGB(150, 150, 150), Thickness = 2.8027778 }, { ["OriginalThickness"] = 3, ["_lemonadeUniqueId"] = "n3r95W7Vn3r9" }, { "ScreenStroke", "UIStroke" })
				I[39] = new("UIGradient", I[38], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(21, 245, 47)), ColorSequenceKeypoint.new(0.1223346, Color3.fromRGB(2, 200, 255)), ColorSequenceKeypoint.new(0.2723346, Color3.fromRGB(0, 17, 255)), ColorSequenceKeypoint.new(0.4223346, Color3.fromRGB(143, 30, 255)), ColorSequenceKeypoint.new(0.5723346, Color3.fromRGB(255, 0, 255)), ColorSequenceKeypoint.new(0.6723346, Color3.fromRGB(255, 0, 4)), ColorSequenceKeypoint.new(0.6723346, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(0.8223346, Color3.fromRGB(221, 255, 0)), ColorSequenceKeypoint.new(0.9723346, Color3.fromRGB(25, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(21, 245, 47)) }), Rotation = 45 }, { ["_lemonadeUniqueId"] = "65Lu2FMg65Lu" })
			I[40] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 1.4857513 }, { ["_lemonadeUniqueId"] = "nordyM19nord" })
			I[41] = new("Frame", I[2], "Search", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(20, 20, 20), BackgroundTransparency = 0.2, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 999999999, Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromScale(0.5, 0.1), ZIndex = 999999999 }, { ["_lemonadeUniqueId"] = "12qi3v7112qi" })
				I[42] = new("UICorner", I[41], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) }, { ["_lemonadeUniqueId"] = "r8zszE3jr8zs" })
				I[43] = new("TextBox", I[41], "TextBox", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), PlaceholderColor3 = Color3.fromRGB(178, 178, 178), PlaceholderText = "Search", Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 999999999 }, { ["_lemonadeUniqueId"] = "7Odf6Du87Odf" })
					I[44] = new("UITextSizeConstraint", I[43], "UITextSizeConstraint", { MaxTextSize = 20 }, { ["_lemonadeUniqueId"] = "CAZOeA8qCAZO" })
				I[45] = new("UIStroke", I[41], "UIStroke", { Color = Color3.fromRGB(150, 150, 150), Thickness = 2.8027778 }, { ["OriginalThickness"] = 3, ["_lemonadeUniqueId"] = "PZZAS575PZZA" }, { "ScreenStroke", "UIStroke" })
					I[46] = new("UIGradient", I[45], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(21, 245, 47)), ColorSequenceKeypoint.new(0.1223322, Color3.fromRGB(2, 200, 255)), ColorSequenceKeypoint.new(0.2723323, Color3.fromRGB(0, 17, 255)), ColorSequenceKeypoint.new(0.4223322, Color3.fromRGB(143, 30, 255)), ColorSequenceKeypoint.new(0.5723322, Color3.fromRGB(255, 0, 255)), ColorSequenceKeypoint.new(0.6723322, Color3.fromRGB(255, 0, 4)), ColorSequenceKeypoint.new(0.6723322, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(0.8223323, Color3.fromRGB(221, 255, 0)), ColorSequenceKeypoint.new(0.9723322, Color3.fromRGB(25, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(21, 245, 47)) }) }, { ["_lemonadeUniqueId"] = "MYAKNFY0MYAK" })
	return I[1]
end

return build
