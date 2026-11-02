-- Generated from ui/StarterGui/MonsterChestRewards.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "MonsterChestRewards", { DisplayOrder = 8, Enabled = false, ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["_lemonadeUniqueId"] = "7AzXEjQ87AzX" })
		I[2] = new("ImageLabel", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(50, 50, 65), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://90325592797235"), ImageTransparency = 0.75, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(0.6, 0.6), TileSize = UDim2.fromOffset(75, 75) }, { ["_lemonadeUniqueId"] = "xVIrRwwKxVIr" })
			I[3] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 1.7794254 }, { ["_lemonadeUniqueId"] = "zWs9YV4kzWs9" })
			I[4] = new("UIStroke", I[2], "UIStroke", { Color = Color3.fromRGB(82, 82, 107), Thickness = 3 }, { ["_lemonadeUniqueId"] = "MEqAy37TMEqA" })
			I[5] = new("UIStroke", I[2], "UIStroke", { Color = Color3.fromRGB(21, 21, 21), Thickness = 8.3000002, ZIndex = 0 }, { ["_lemonadeUniqueId"] = "ZS5ZyvTnZS5Z" })
			I[6] = new("ImageButton", I[2], "Close", { BackgroundColor3 = Color3.fromRGB(255, 20, 20), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.9202963, -0.043909), Size = UDim2.fromScale(0.0713584, 0.1248773), ZIndex = 5 }, { ["_lemonadeUniqueId"] = "r6MNFyYKr6MN" })
				I[7] = new("UIStroke", I[6], "UIStroke", { Thickness = 3 }, { ["_lemonadeUniqueId"] = "7m2JXTcQ7m2J" })
				I[8] = new("UIAspectRatioConstraint", I[6], "UIAspectRatioConstraint", nil, { ["_lemonadeUniqueId"] = "jXNXaRQUjXNX" })
				I[9] = new("UIGradient", I[6], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(211, 211, 211)) }), Rotation = 90 }, { ["_lemonadeUniqueId"] = "Tfm4Hks8Tfm4" })
				I[10] = new("TextLabel", I[6], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.8, 0.8), Text = "X", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "sRggPRu0sRgg" })
					I[11] = new("UIStroke", I[10], "UIStroke", { Color = Color3.fromRGB(79, 7, 7), Thickness = 3 }, { ["_lemonadeUniqueId"] = "c2e1xn0Sc2e1" })
			I[12] = new("ImageLabel", I[2], "Header", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://90325592797235"), ImageTransparency = 0.75, Position = UDim2.fromScale(0.5, 0.0159346), ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 0.1542045), TileSize = UDim2.fromOffset(75, 75) }, { ["_lemonadeUniqueId"] = "vbqXDTRTvbqX" })
				I[13] = new("UIStroke", I[12], "UIStroke", { Color = Color3.fromRGB(82, 82, 107), Thickness = 3 }, { ["_lemonadeUniqueId"] = "DjEfXqCYDjEf" })
				I[14] = new("UIStroke", I[12], "UIStroke", { Color = Color3.fromRGB(21, 21, 21), Thickness = 8.3000002, ZIndex = 0 }, { ["_lemonadeUniqueId"] = "I9FQo3JVI9FQ" })
				I[15] = new("UIGradient", I[12], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(198, 255, 73)), ColorSequenceKeypoint.new(0.533, Color3.fromRGB(62, 158, 34)), ColorSequenceKeypoint.new(1, Color3.fromRGB(223, 255, 122)) }) }, { ["_lemonadeUniqueId"] = "gn89lRqWgn89" })
				I[16] = new("TextLabel", I[12], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0.0208038, 0.1694509), Size = UDim2.fromScale(0.66, 0.6617998), Text = "MONSTER CHEST REWARDS", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 2 }, { ["_lemonadeUniqueId"] = "VejIlDlrVejI" })
					I[17] = new("UIStroke", I[16], "UIStroke", { Thickness = 3 }, { ["_lemonadeUniqueId"] = "A4KUgDR9A4KU" })
						I[18] = new("UIGradient", I[17], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(46, 125, 28)), ColorSequenceKeypoint.new(1, Color3.fromRGB(18, 60, 10)) }), Rotation = 90 }, { ["_lemonadeUniqueId"] = "jBuzXgxbjBuz" })
				I[19] = new("TextLabel", I[12], "Title2Stroke", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0208038, 0.1916927), Size = UDim2.fromScale(0.66, 0.6617998), Text = "MONSTER CHEST REWARDS", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left }, { ["_lemonadeUniqueId"] = "OwTv7AUwOwTv" })
					I[20] = new("UIStroke", I[19], "UIStroke", { Color = Color3.fromRGB(50, 50, 65), Thickness = 5 }, { ["_lemonadeUniqueId"] = "WWxVcrpTWWxV" })
						I[21] = new("UIGradient", I[20], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 179, 229)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 80, 229)) }), Enabled = false, Rotation = 90 }, { ["_lemonadeUniqueId"] = "90pK5Xgw90pK" })
				I[22] = new("ImageLabel", I[12], "Stroke", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://98981360538955"), Position = UDim2.fromScale(0.5548137, 0.5003672), Size = UDim2.fromScale(0.4401042, 0.9916657) }, { ["_lemonadeUniqueId"] = "A2wqMXFNA2wq" })
			I[23] = new("ScrollingFrame", I[2], "ScrollingFrame", { Active = true, AnchorPoint = Vector2.new(0.5, 0.5), AutomaticCanvasSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, CanvasSize = UDim2.fromScale(0, 0), Position = UDim2.fromScale(0.5, 0.575), ScrollBarThickness = 0, ScrollingEnabled = false, Size = UDim2.fromScale(0.96, 0.8) }, { ["_lemonadeUniqueId"] = "yrwukEAyyrwu" })
				I[24] = new("UIGridLayout", I[23], "UIGridLayout", { CellPadding = UDim2.fromScale(0.025, 0.06), CellSize = UDim2.fromScale(0.3, 0.455), FillDirectionMaxCells = 3, HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center }, { ["_lemonadeUniqueId"] = "VLs9VmpPVLs9" })
				I[25] = new("ImageLabel", I[23], "Template", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://90325592797235"), ImageTransparency = 0.75, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(120, 120), Visible = false }, { ["FallbackIcon"] = "rbxassetid://116351329433541", ["_lemonadeUniqueId"] = "5UvLVxJF5UvL" })
					I[26] = new("TextLabel", I[25], "RewardName", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0.7, 0.345), RichText = true, Size = UDim2.fromScale(0.585, 0.46), Text = "Reward Name", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 3 }, { ["_lemonadeUniqueId"] = "XH4mLYSCXH4m" })
						I[27] = new("UIStroke", I[26], "UIStroke", { Thickness = 3 }, { ["_lemonadeUniqueId"] = "fJVAuv6SfJVA" })
							I[28] = new("UIGradient", I[27], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 179, 229)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 80, 229)) }), Rotation = 90 }, { ["_lemonadeUniqueId"] = "83Hm0UJD83Hm" })
						I[29] = new("UITextSizeConstraint", I[26], "UITextSizeConstraint", nil, { ["_lemonadeUniqueId"] = "z50t2Wu0z50t" })
					I[30] = new("UIStroke", I[25], "UIStroke", { Color = Color3.fromRGB(21, 21, 21), Thickness = 5.5, ZIndex = 0 }, { ["_lemonadeUniqueId"] = "Y2w8hpgqY2w8" })
					I[31] = new("UIStroke", I[25], "UIStrokeClr", { Color = Color3.fromRGB(82, 82, 107), Thickness = 2 }, { ["_lemonadeUniqueId"] = "1JswxTLD1Jsw" })
					I[32] = new("ImageLabel", I[25], "Glow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://109516122757226"), ImageTransparency = 0.42, Position = UDim2.fromScale(0.215, 0.5), Size = UDim2.fromScale(0.56, 1.15) }, { ["_lemonadeUniqueId"] = "SZucbZugSZuc" })
					I[33] = new("ImageLabel", I[25], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://119310588672254"), Position = UDim2.fromScale(0.215, 0.48), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.38, 0.68), ZIndex = 3 }, { ["_lemonadeUniqueId"] = "BAwKbXsIBAwK" })
					I[34] = new("UIGradient", I[25], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 166, 255)), ColorSequenceKeypoint.new(0.5173011, Color3.fromRGB(38, 237, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 166, 255)) }), Rotation = 90 }, { ["_lemonadeUniqueId"] = "itQ94v0WitQ9" })
					I[35] = new("Frame", I[25], "Chance", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(47, 47, 47), BorderSizePixel = 0, Position = UDim2.fromScale(0.72, 0.79), Size = UDim2.fromScale(0.46, 0.22), ZIndex = 3 }, { ["_lemonadeUniqueId"] = "TBOko7hlTBOk" })
						I[36] = new("UICorner", I[35], "UICorner", { BottomLeftRadius = UDim.new(0.35, 0), BottomRightRadius = UDim.new(0.35, 0), TopLeftRadius = UDim.new(0.35, 0), TopRightRadius = UDim.new(0.35, 0) }, { ["_lemonadeUniqueId"] = "VFzGWNBPVFzG" })
						I[37] = new("UIStroke", I[35], "UIStroke", { Color = Color3.fromRGB(21, 21, 21), Thickness = 3 }, { ["_lemonadeUniqueId"] = "wwAmoSkuwwAm" })
						I[38] = new("TextLabel", I[35], "Value", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), RichText = true, Size = UDim2.fromScale(0.86, 0.74), Text = "0%", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, ZIndex = 4 }, { ["_lemonadeUniqueId"] = "xbdKwtBHxbdK" })
							I[39] = new("UIStroke", I[38], "UIStroke", { Thickness = 3 }, { ["_lemonadeUniqueId"] = "VNdW8gK0VNdW" })
							I[40] = new("UITextSizeConstraint", I[38], "UITextSizeConstraint", nil, { ["_lemonadeUniqueId"] = "Q71SfCmIQ71S" })
					I[41] = new("TextLabel", I[25], "Note", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0.7, 0.56), RichText = true, Size = UDim2.fromScale(0.585, 0.115), Text = "(10 Minutes)", TextColor3 = Color3.fromRGB(226, 232, 240), TextSize = 14, Visible = false, ZIndex = 3 }, { ["_lemonadeUniqueId"] = "93vrxH2A93vr" })
						I[42] = new("UIStroke", I[41], "UIStroke", { Thickness = 2 }, { ["_lemonadeUniqueId"] = "loCpzkJJloCp" })
							I[43] = new("UIGradient", I[42], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 179, 229)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 80, 229)) }), Rotation = 90 }, { ["_lemonadeUniqueId"] = "apXEda8eapXE" })
						I[44] = new("UITextSizeConstraint", I[41], "UITextSizeConstraint", nil, { ["_lemonadeUniqueId"] = "ac6rFwbBac6r" })
	return I[1]
end

return build
