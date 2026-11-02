-- Generated from ui/StarterGui/AdminModelBrowser.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "AdminModelBrowser", { DisplayOrder = 205, Enabled = false, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["_lemonadeUniqueId"] = "E98getZDE98g" })
		I[2] = new("Frame", I[1], "Shade", { BackgroundColor3 = Color3.fromRGB(4, 5, 9), BackgroundTransparency = 0.4, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), Visible = false }, { ["_lemonadeUniqueId"] = "9s0TqhEY9s0T" })
			I[3] = new("Frame", I[2], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(20, 22, 30), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.56, 0.66) }, { ["_lemonadeUniqueId"] = "bwCbGTPVbwCb" })
				I[4] = new("UICorner", I[3], "UICorner", { BottomLeftRadius = UDim.new(0, 14), BottomRightRadius = UDim.new(0, 14), TopLeftRadius = UDim.new(0, 14), TopRightRadius = UDim.new(0, 14) }, { ["_lemonadeUniqueId"] = "X5nJjyfpX5nJ" })
				I[5] = new("UIStroke", I[3], "UIStroke", { Color = Color3.fromRGB(52, 58, 76) }, { ["_lemonadeUniqueId"] = "2YFWRTsM2YFW" })
				I[6] = new("UISizeConstraint", I[3], "UISizeConstraint", { MaxSize = Vector2.new(1020, 690), MinSize = Vector2.new(620, 430) }, { ["_lemonadeUniqueId"] = "qsti042Uqsti" })
				I[7] = new("Frame", I[3], "Header", { BackgroundColor3 = Color3.fromRGB(28, 31, 42), BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 50) }, { ["_lemonadeUniqueId"] = "Q2xUt5n3Q2xU" })
					I[8] = new("UICorner", I[7], "UICorner", { BottomLeftRadius = UDim.new(0, 14), BottomRightRadius = UDim.new(0, 14), TopLeftRadius = UDim.new(0, 14), TopRightRadius = UDim.new(0, 14) }, { ["_lemonadeUniqueId"] = "y9OcBPR1y9Oc" })
					I[9] = new("Frame", I[7], "Cover", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(28, 31, 42), BorderSizePixel = 0, Position = UDim2.fromScale(0, 1), Size = UDim2.new(1, 0, 0, 14) }, { ["_lemonadeUniqueId"] = "twobfXIctwob" })
					I[10] = new("Frame", I[7], "Accent", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(96, 165, 250), BorderSizePixel = 0, Position = UDim2.fromScale(0, 1), Size = UDim2.new(1, 0, 0, 2), ZIndex = 2 }, { ["_lemonadeUniqueId"] = "u1hHSCCQu1hH" })
					I[11] = new("Frame", I[7], "Mark", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(96, 165, 250), BorderSizePixel = 0, Position = UDim2.new(0, 16, 0.5, 0), Size = UDim2.fromOffset(5, 20) }, { ["_lemonadeUniqueId"] = "uc8ZxnMeuc8Z" })
						I[12] = new("UICorner", I[11], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) }, { ["_lemonadeUniqueId"] = "yEJkZXT1yEJk" })
					I[13] = new("TextLabel", I[7], "Title", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(30, 8), Size = UDim2.fromOffset(260, 19), Text = "MODEL BROWSER", TextColor3 = Color3.fromRGB(238, 241, 248), TextSize = 15, TextXAlignment = Enum.TextXAlignment.Left }, { ["_lemonadeUniqueId"] = "f8v5F5a6f8v5" })
					I[14] = new("TextLabel", I[7], "Subtitle", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromOffset(30, 26), Size = UDim2.fromOffset(300, 15), Text = "Roblox free models", TextColor3 = Color3.fromRGB(146, 158, 184), TextSize = 11, TextXAlignment = Enum.TextXAlignment.Left }, { ["_lemonadeUniqueId"] = "aCIDcdD1aCID" })
					I[15] = new("TextLabel", I[7], "Hint", { AnchorPoint = Vector2.new(1, 0.5), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.new(1, -52, 0.5, 0), Size = UDim2.fromOffset(230, 14), Text = "F3 toggle  -  ESC close  -  F2 build tools", TextColor3 = Color3.fromRGB(146, 158, 184), TextSize = 10, TextXAlignment = Enum.TextXAlignment.Right }, { ["_lemonadeUniqueId"] = "VganzUg8Vgan" })
					I[16] = new("TextButton", I[7], "Close", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(48, 54, 72), FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(1, -14, 0.5, 0), Size = UDim2.fromOffset(28, 28), Text = "X", TextColor3 = Color3.fromRGB(238, 241, 248), TextSize = 14 }, { ["_lemonadeUniqueId"] = "VTFm1X1FVTFm" })
						I[17] = new("UICorner", I[16], "UICorner", nil, { ["_lemonadeUniqueId"] = "8FqZVRs68FqZ" })
				I[18] = new("TextBox", I[3], "SearchInput", { BackgroundColor3 = Color3.fromRGB(35, 39, 52), BorderSizePixel = 0, ClearTextOnFocus = false, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), PlaceholderColor3 = Color3.fromRGB(146, 158, 184), PlaceholderText = "Search Roblox free models...", Position = UDim2.fromOffset(16, 64), Size = UDim2.new(1, -386, 0, 36), Text = "", TextColor3 = Color3.fromRGB(238, 241, 248), TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left }, { ["_lemonadeUniqueId"] = "slL3RHaKslL3" })
					I[19] = new("UICorner", I[18], "UICorner", { BottomLeftRadius = UDim.new(0, 9), BottomRightRadius = UDim.new(0, 9), TopLeftRadius = UDim.new(0, 9), TopRightRadius = UDim.new(0, 9) }, { ["_lemonadeUniqueId"] = "5E48dqDZ5E48" })
					I[20] = new("UIStroke", I[18], "UIStroke", { Color = Color3.fromRGB(52, 58, 76) }, { ["_lemonadeUniqueId"] = "iYYEoteSiYYE" })
					I[21] = new("UIPadding", I[18], "UIPadding", { PaddingLeft = UDim.new(0, 11), PaddingRight = UDim.new(0, 11) }, { ["_lemonadeUniqueId"] = "3KaWCGQm3KaW" })
				I[22] = new("TextButton", I[3], "SearchButton", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(96, 165, 250), FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(1, -266, 0, 64), Size = UDim2.fromOffset(96, 36), Text = "SEARCH", TextColor3 = Color3.fromRGB(12, 18, 30), TextSize = 12 }, { ["_lemonadeUniqueId"] = "l6AORR5Fl6AO" })
					I[23] = new("UICorner", I[22], "UICorner", { BottomLeftRadius = UDim.new(0, 9), BottomRightRadius = UDim.new(0, 9), TopLeftRadius = UDim.new(0, 9), TopRightRadius = UDim.new(0, 9) }, { ["_lemonadeUniqueId"] = "f2Iw9Qgqf2Iw" })
				I[24] = new("TextBox", I[3], "IdInput", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(35, 39, 52), BorderSizePixel = 0, ClearTextOnFocus = false, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), PlaceholderColor3 = Color3.fromRGB(146, 158, 184), PlaceholderText = "Asset ID", Position = UDim2.new(1, -124, 0, 64), Size = UDim2.fromOffset(134, 36), Text = "", TextColor3 = Color3.fromRGB(238, 241, 248), TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left }, { ["_lemonadeUniqueId"] = "6C9rs5xZ6C9r" })
					I[25] = new("UICorner", I[24], "UICorner", { BottomLeftRadius = UDim.new(0, 9), BottomRightRadius = UDim.new(0, 9), TopLeftRadius = UDim.new(0, 9), TopRightRadius = UDim.new(0, 9) }, { ["_lemonadeUniqueId"] = "sh5n9dL5sh5n" })
					I[26] = new("UIStroke", I[24], "UIStroke", { Color = Color3.fromRGB(52, 58, 76) }, { ["_lemonadeUniqueId"] = "wSFtZJPRwSFt" })
					I[27] = new("UIPadding", I[24], "UIPadding", { PaddingLeft = UDim.new(0, 11), PaddingRight = UDim.new(0, 11) }, { ["_lemonadeUniqueId"] = "IwYaP6RFIwYa" })
				I[28] = new("TextButton", I[3], "LoadButton", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(48, 54, 72), FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(1, -16, 0, 64), Size = UDim2.fromOffset(100, 36), Text = "LOAD ID", TextColor3 = Color3.fromRGB(238, 241, 248), TextSize = 12 }, { ["_lemonadeUniqueId"] = "6vi502dv6vi5" })
					I[29] = new("UICorner", I[28], "UICorner", { BottomLeftRadius = UDim.new(0, 9), BottomRightRadius = UDim.new(0, 9), TopLeftRadius = UDim.new(0, 9), TopRightRadius = UDim.new(0, 9) }, { ["_lemonadeUniqueId"] = "LwHHiDKMLwHH" })
				I[30] = new("ScrollingFrame", I[3], "Results", { AutomaticCanvasSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(24, 26, 35), BackgroundTransparency = 0.4, BorderSizePixel = 0, CanvasSize = UDim2.fromScale(0, 0), Position = UDim2.fromOffset(16, 156), ScrollBarImageColor3 = Color3.fromRGB(52, 58, 76), ScrollBarThickness = 6, Size = UDim2.new(1, -32, 1, -204) }, { ["_lemonadeUniqueId"] = "IraWRRf3IraW" })
					I[31] = new("UICorner", I[30], "UICorner", { BottomLeftRadius = UDim.new(0, 10), BottomRightRadius = UDim.new(0, 10), TopLeftRadius = UDim.new(0, 10), TopRightRadius = UDim.new(0, 10) }, { ["_lemonadeUniqueId"] = "GPlQXfUcGPlQ" })
					I[32] = new("UIGridLayout", I[30], "UIGridLayout", { CellPadding = UDim2.fromOffset(10, 10), CellSize = UDim2.fromOffset(140, 198), SortOrder = Enum.SortOrder.LayoutOrder }, { ["_lemonadeUniqueId"] = "frsVpDyqfrsV" })
					I[33] = new("UIPadding", I[30], "UIPadding", { PaddingBottom = UDim.new(0, 12), PaddingLeft = UDim.new(0, 10), PaddingRight = UDim.new(0, 10), PaddingTop = UDim.new(0, 10) }, { ["_lemonadeUniqueId"] = "44BL2kdJ44BL" })
					I[34] = new("Frame", I[30], "ResultTemplate", { BackgroundColor3 = Color3.fromRGB(33, 37, 49), BorderSizePixel = 0, Visible = false }, { ["_lemonadeUniqueId"] = "BkQPIkEABkQP" })
						I[35] = new("UICorner", I[34], "UICorner", { BottomLeftRadius = UDim.new(0, 10), BottomRightRadius = UDim.new(0, 10), TopLeftRadius = UDim.new(0, 10), TopRightRadius = UDim.new(0, 10) }, { ["_lemonadeUniqueId"] = "8K6FN0Cy8K6F" })
						I[36] = new("UIStroke", I[34], "Outline", { Color = Color3.fromRGB(52, 58, 76), Transparency = 0.35 }, { ["_lemonadeUniqueId"] = "S2xDSdGwS2xD" })
						I[37] = new("Frame", I[34], "PreviewHolder", { BackgroundColor3 = Color3.fromRGB(23, 25, 34), BorderSizePixel = 0, Position = UDim2.fromOffset(6, 6), Size = UDim2.new(1, -12, 0, 108) }, { ["_lemonadeUniqueId"] = "ee5aWeUIee5a" })
							I[38] = new("UICorner", I[37], "UICorner", nil, { ["_lemonadeUniqueId"] = "ihTnHxWwihTn" })
							I[39] = new("ViewportFrame", I[37], "Viewport", { BackgroundTransparency = 1, LightColor = Color3.fromRGB(255, 255, 255), Size = UDim2.fromScale(1, 1) }, { ["_lemonadeUniqueId"] = "ySx0jQxFySx0" })
							I[40] = new("ImageLabel", I[37], "Thumbnail", { BackgroundTransparency = 1, ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), ZIndex = 2 }, { ["_lemonadeUniqueId"] = "zBmFRViuzBmF" })
							I[41] = new("TextLabel", I[37], "Loading", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(14, 16, 22), BackgroundTransparency = 0.25, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0.5, 0, 1, -5), Size = UDim2.new(1, -12, 0, 15), Text = "LOADING 3D...", TextColor3 = Color3.fromRGB(146, 158, 184), TextSize = 9, ZIndex = 3 }, { ["_lemonadeUniqueId"] = "HGkJ0Gv1HGkJ" })
								I[42] = new("UICorner", I[41], "UICorner", { BottomLeftRadius = UDim.new(0, 5), BottomRightRadius = UDim.new(0, 5), TopLeftRadius = UDim.new(0, 5), TopRightRadius = UDim.new(0, 5) }, { ["_lemonadeUniqueId"] = "cCgSfp4WcCgS" })
						I[43] = new("TextLabel", I[34], "ModelName", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.fromOffset(8, 120), Size = UDim2.new(1, -16, 0, 28), Text = "Model", TextColor3 = Color3.fromRGB(238, 241, 248), TextSize = 11, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top }, { ["_lemonadeUniqueId"] = "dG4M3PGudG4M" })
						I[44] = new("TextLabel", I[34], "Creator", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromOffset(8, 150), Size = UDim2.new(0.58, -8, 0, 13), Text = "", TextColor3 = Color3.fromRGB(146, 158, 184), TextSize = 9, TextTruncate = Enum.TextTruncate.AtEnd, TextXAlignment = Enum.TextXAlignment.Left }, { ["_lemonadeUniqueId"] = "gRRNmagggRRN" })
						I[45] = new("TextLabel", I[34], "AssetId", { AnchorPoint = Vector2.new(1, 0), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.new(1, -8, 0, 150), Size = UDim2.new(0.42, -8, 0, 13), Text = "ID: ?", TextColor3 = Color3.fromRGB(146, 158, 184), TextSize = 9, TextTruncate = Enum.TextTruncate.AtEnd, TextXAlignment = Enum.TextXAlignment.Right }, { ["_lemonadeUniqueId"] = "VZxywuTfVZxy" })
						I[46] = new("TextButton", I[34], "Insert", { BackgroundColor3 = Color3.fromRGB(96, 165, 250), FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(8, 168), Size = UDim2.new(1, -16, 0, 22), Text = "INSERT", TextColor3 = Color3.fromRGB(12, 18, 30), TextSize = 11 }, { ["_lemonadeUniqueId"] = "3Sklgpo03Skl" })
							I[47] = new("UICorner", I[46], "UICorner", { BottomLeftRadius = UDim.new(0, 7), BottomRightRadius = UDim.new(0, 7), TopLeftRadius = UDim.new(0, 7), TopRightRadius = UDim.new(0, 7) }, { ["_lemonadeUniqueId"] = "bddKmxS8bddK" })
				I[48] = new("TextLabel", I[3], "Hero", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromOffset(16, 156), Size = UDim2.new(1, -32, 1, -204), Text = "Search Roblox free models by keyword, paste an asset ID, or type a Roblox username to load that user's avatar.\n\nClick INSERT to drop it in front of you, then press F2 for the F3X build tools.", TextColor3 = Color3.fromRGB(146, 158, 184), TextSize = 13, TextWrapped = true }, { ["_lemonadeUniqueId"] = "bNEQnUNxbNEQ" })
				I[49] = new("TextLabel", I[3], "Status", { AnchorPoint = Vector2.new(0, 1), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.new(0, 18, 1, -16), Size = UDim2.new(1, -190, 0, 18), Text = "", TextColor3 = Color3.fromRGB(146, 158, 184), TextSize = 12, TextTruncate = Enum.TextTruncate.AtEnd, TextXAlignment = Enum.TextXAlignment.Left }, { ["_lemonadeUniqueId"] = "WOFQObLHWOFQ" })
				I[50] = new("TextButton", I[3], "LoadMoreButton", { AnchorPoint = Vector2.new(1, 1), BackgroundColor3 = Color3.fromRGB(48, 54, 72), FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(1, -16, 1, -10), Size = UDim2.fromOffset(130, 28), Text = "LOAD MORE", TextColor3 = Color3.fromRGB(238, 241, 248), TextSize = 12, Visible = false }, { ["_lemonadeUniqueId"] = "k2uctbSmk2uc" })
					I[51] = new("UICorner", I[50], "UICorner", { BottomLeftRadius = UDim.new(0, 9), BottomRightRadius = UDim.new(0, 9), TopLeftRadius = UDim.new(0, 9), TopRightRadius = UDim.new(0, 9) }, { ["_lemonadeUniqueId"] = "Q7t504JdQ7t5" })
				I[52] = new("TextBox", I[3], "AvatarInput", { BackgroundColor3 = Color3.fromRGB(35, 39, 52), BorderSizePixel = 0, ClearTextOnFocus = false, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), PlaceholderColor3 = Color3.fromRGB(146, 158, 184), PlaceholderText = "Roblox username or user ID (avatar)", Position = UDim2.fromOffset(16, 110), Size = UDim2.new(1, -192, 0, 36), Text = "", TextColor3 = Color3.fromRGB(238, 241, 248), TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left }, { ["_lemonadeUniqueId"] = "jaIpaDEAjaIp" })
					I[53] = new("UICorner", I[52], "UICorner", { BottomLeftRadius = UDim.new(0, 9), BottomRightRadius = UDim.new(0, 9), TopLeftRadius = UDim.new(0, 9), TopRightRadius = UDim.new(0, 9) }, { ["_lemonadeUniqueId"] = "PS8B15OWPS8B" })
					I[54] = new("UIStroke", I[52], "UIStroke", { Color = Color3.fromRGB(52, 58, 76) }, { ["_lemonadeUniqueId"] = "oNr02PesoNr0" })
					I[55] = new("UIPadding", I[52], "UIPadding", { PaddingLeft = UDim.new(0, 11), PaddingRight = UDim.new(0, 11) }, { ["_lemonadeUniqueId"] = "uIFIjYbfuIFI" })
				I[56] = new("TextButton", I[3], "AvatarButton", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(48, 54, 72), FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(1, -16, 0, 110), Size = UDim2.fromOffset(152, 36), Text = "LOAD AVATAR", TextColor3 = Color3.fromRGB(238, 241, 248), TextSize = 12 }, { ["_lemonadeUniqueId"] = "R9HV7nVdR9HV" })
					I[57] = new("UICorner", I[56], "UICorner", { BottomLeftRadius = UDim.new(0, 9), BottomRightRadius = UDim.new(0, 9), TopLeftRadius = UDim.new(0, 9), TopRightRadius = UDim.new(0, 9) }, { ["_lemonadeUniqueId"] = "rcDaojl3rcDa" })
	return I[1]
end

return build
