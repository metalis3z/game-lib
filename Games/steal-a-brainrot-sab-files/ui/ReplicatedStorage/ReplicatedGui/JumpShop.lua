-- Generated from ui/ReplicatedStorage/ReplicatedGui/JumpShop.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "JumpShop", { ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["_lemonadeUniqueId"] = "KSqS6QB5KSqS" }, { "ScreenGui" })
		I[2] = new("Frame", I[1], "JumpShop", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(75, 63, 79), BackgroundTransparency = 0.25, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.4, 0.5172115), Visible = false }, { ["_lemonadeUniqueId"] = "CW7PKTWCCW7P" })
			I[3] = new("Frame", I[2], "Header", { BackgroundColor3 = Color3.fromRGB(233, 148, 225), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.0000001), Size = UDim2.fromScale(1.0000002, 0.1650783) }, { ["_lemonadeUniqueId"] = "vZ8Frz8YvZ8F" })
				I[4] = new("ImageButton", I[3], "Close", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, HoverImageContent = Content.fromUri("rbxassetid://137110183435251"), ImageContent = Content.fromUri("rbxassetid://105016554772347"), Position = UDim2.fromScale(0.936, 0.525), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.1090087, 0.7851255) }, { ["_lemonadeUniqueId"] = "uwIfJBtJuwIf" })
					I[5] = new("TextLabel", I[4], "X", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 0.56), Text = "X", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "9U0GakwA9U0G" })
						I[6] = new("UIStroke", I[5], "UIStroke", { Thickness = 3.2 }, { ["OriginalThickness"] = 3, ["_lemonadeUniqueId"] = "2AcVuy3t2AcV" }, { "ScreenStroke", "UIStroke" })
						I[7] = new("UIPadding", I[5], "UIPadding", { PaddingLeft = UDim.new(0.01, 0), PaddingRight = UDim.new(-0.03, 0) }, { ["_lemonadeUniqueId"] = "bsnlpiTvbsnl" })
						I[8] = new("UITextSizeConstraint", I[5], "UITextSizeConstraint", { MaxTextSize = 47 }, { ["_lemonadeUniqueId"] = "Qzz9Mr0wQzz9" })
				I[9] = new("TextLabel", I[3], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4201983, 0.3853657), Size = UDim2.fromScale(0.7939942, 0.5095937), Text = "Jump Shop", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 2 }, { ["_lemonadeUniqueId"] = "Ecf0HS71Ecf0" })
					I[10] = new("UIStroke", I[9], "UIStroke", { Color = Color3.fromRGB(71, 0, 0), Thickness = 3.2 }, { ["OriginalThickness"] = 3, ["_lemonadeUniqueId"] = "YJScOkPlYJSc" }, { "ScreenStroke", "UIStroke" })
				I[11] = new("UIStroke", I[3], "UIStroke", { Color = Color3.fromRGB(173, 82, 168), Thickness = 1.0666667 }, { ["OriginalThickness"] = 1, ["_lemonadeUniqueId"] = "X0AwE9UEX0Aw" }, { "ScreenStroke", "UIStroke" })
				I[12] = new("TextLabel", I[3], "Desc", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4200976, 0.8000003), Size = UDim2.fromScale(0.7941955, 0.285), Text = "Buy double jumps to reach new islands!", TextColor3 = Color3.fromRGB(244, 244, 244), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 2 }, { ["_lemonadeUniqueId"] = "8CKRYoXN8CKR" })
					I[13] = new("UIStroke", I[12], "UIStroke", { Color = Color3.fromRGB(71, 0, 0), Thickness = 1.6 }, { ["OriginalThickness"] = 1.5, ["_lemonadeUniqueId"] = "xe5UjuVFxe5U" }, { "ScreenStroke", "UIStroke" })
			I[14] = new("ScrollingFrame", I[2], "ScrollingFrame", { Active = true, AnchorPoint = Vector2.new(0.5, 0.5), AutomaticCanvasSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, CanvasSize = UDim2.fromScale(0, 0), Position = UDim2.new(0.5, 6, 0.581, 0), ScrollBarThickness = 8, Size = UDim2.fromScale(0.9680001, 0.7940622) }, { ["_lemonadeUniqueId"] = "f3P69MfJf3P6" })
				I[15] = new("UIGridLayout", I[14], "UIGridLayout", { CellPadding = UDim2.fromScale(0, 0), CellSize = UDim2.fromScale(0.33, 0.5), HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder }, { ["_lemonadeUniqueId"] = "fP2wmGJ9fP2w" })
				I[16] = new("Frame", I[14], "Template", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.3428144, 0), Size = UDim2.fromScale(0.2367175, 0.688) }, { ["_lemonadeUniqueId"] = "NMxQ7cmkNMxQ" })
					I[17] = new("Frame", I[16], "Spacer", { BackgroundColor3 = Color3.fromRGB(143, 212, 255), BackgroundTransparency = 0.25, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromOffset(2, 2), Size = UDim2.fromScale(0.901, 0.92) }, { ["_lemonadeUniqueId"] = "JNQSVeUqJNQS" })
						I[18] = new("ViewportFrame", I[17], "ViewportFrame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) }, { ["_lemonadeUniqueId"] = "20YtntZN20Yt" })
						I[19] = new("TextLabel", I[17], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4999999, 0.1216662), Size = UDim2.fromScale(0.85, 0.1844247), Text = "2 Jumps", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 }, { ["_lemonadeUniqueId"] = "kIsBJ80EkIsB" })
							I[20] = new("UIStroke", I[19], "UIStroke", { Thickness = 2.1333334 }, { ["OriginalThickness"] = 2, ["_lemonadeUniqueId"] = "c3QCgM24c3QC" }, { "ScreenStroke", "UIStroke" })
						I[21] = new("ImageButton", I[17], "Claim", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(111, 218, 87), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), ImageTransparency = 1, Position = UDim2.fromScale(0.5, 0.9619061), Size = UDim2.fromScale(0.7670023, 0.2081541), Visible = false }, { ["_lemonadeUniqueId"] = "PZiiw4ZLPZii" })
							I[22] = new("UIStroke", I[21], "UIStroke", { Thickness = 1.6 }, { ["OriginalThickness"] = 1.5, ["_lemonadeUniqueId"] = "KR4hSApJKR4h" }, { "ScreenStroke", "UIStroke" })
							I[23] = new("TextLabel", I[21], "Txt", { AnchorPoint = Vector2.new(0.5, 0.5), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.6430452, 0.4999995), Size = UDim2.fromScale(0.2626723, 0.8), Text = "15", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left }, { ["_lemonadeUniqueId"] = "QrIHufg0QrIH" })
								I[24] = new("UIStroke", I[23], "UIStroke", { Thickness = 2.1333334 }, { ["OriginalThickness"] = 2, ["_lemonadeUniqueId"] = "ecUEq79xecUE" }, { "ScreenStroke", "UIStroke" })
							I[25] = new("ImageLabel", I[21], "Vector", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://116762624882914"), Position = UDim2.fromScale(0.2977736, 0.5000002), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.2479049, 0.8443784) }, { ["_lemonadeUniqueId"] = "2HkxY7GU2Hkx" })
							I[26] = new("UIListLayout", I[21], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.05, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center }, { ["_lemonadeUniqueId"] = "YF4IBTsMYF4I" })
						I[27] = new("ImageLabel", I[17], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.8, 0.8), ZIndex = 0 }, { ["_lemonadeUniqueId"] = "X1kaphHDX1ka" })
						I[28] = new("ImageLabel", I[17], "Claimed", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://71822246214306"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.4, 0.4), Visible = false, ZIndex = 3 }, { ["_lemonadeUniqueId"] = "QULhwTNPQULh" })
						I[29] = new("TextLabel", I[17], "Info", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4999999, 0.8661997), Size = UDim2.fromScale(0.85, 0.2), Text = "Owned", TextColor3 = Color3.fromRGB(95, 255, 70), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 }, { ["_lemonadeUniqueId"] = "tAJzYFBDtAJz" })
							I[30] = new("UIStroke", I[29], "UIStroke", { Thickness = 2.1333334 }, { ["OriginalThickness"] = 2, ["_lemonadeUniqueId"] = "bvweoT7Fbvwe" }, { "ScreenStroke", "UIStroke" })
						I[31] = new("UIStroke", I[17], "UIStroke", { Color = Color3.fromRGB(151, 246, 255), Thickness = 2.1333334 }, { ["OriginalThickness"] = 2, ["_lemonadeUniqueId"] = "TIJhp8IgTIJh" }, { "ScreenStroke", "UIStroke" })
						I[32] = new("TextLabel", I[17], "Locked", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4999999, 0.8330995), Size = UDim2.fromScale(0.85, 0.2661986), Text = "Unlock Area Island first!", TextColor3 = Color3.fromRGB(255, 111, 111), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false, ZIndex = 2 }, { ["_lemonadeUniqueId"] = "1JjWXzrx1JjW" })
							I[33] = new("UIStroke", I[32], "UIStroke", { Thickness = 2.1333334 }, { ["OriginalThickness"] = 2, ["_lemonadeUniqueId"] = "xgXyrpCUxgXy" }, { "ScreenStroke", "UIStroke" })
			I[34] = new("UIStroke", I[2], "UIStroke", { Color = Color3.fromRGB(173, 82, 168), Thickness = 1.0666667 }, { ["OriginalThickness"] = 1, ["_lemonadeUniqueId"] = "btUKQrcEbtUK" }, { "ScreenStroke", "UIStroke" })
			I[35] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 1.15 }, { ["_lemonadeUniqueId"] = "fEobAaQ4fEob" })
	return I[1]
end

return build
