-- Generated from ui/StarterGui/GrowingEggs.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "GrowingEggs", { DisplayOrder = 34, Enabled = false, ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["_lemonadeUniqueId"] = "Unyx2l31Unyx" })
		I[2] = new("ImageLabel", I[1], "Frame", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(50, 50, 65), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://90325592797235"), ImageTransparency = 0.75, Position = UDim2.fromScale(0.985, 0.5), ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(0.217535, 0.3427259), TileSize = UDim2.fromOffset(75, 75) }, { ["_lemonadeUniqueId"] = "SMNoOkI2SMNo" })
			I[3] = new("ImageButton", I[2], "Close", { BackgroundColor3 = Color3.fromRGB(255, 20, 20), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(-0.1797153, 0.3828548), Size = UDim2.fromScale(0.1248341, 0.1560427), ZIndex = 5 }, { ["_lemonadeUniqueId"] = "m3zL3Pkym3zL" })
				I[4] = new("TextLabel", I[3], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = ">", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "n8vUl8e0n8vU" })
					I[5] = new("UIStroke", I[4], "UIStroke", { Color = Color3.fromRGB(79, 7, 7), Thickness = 3 }, { ["_lemonadeUniqueId"] = "EZ9lQ81LEZ9l" })
				I[6] = new("UIStroke", I[3], "UIStroke", { Thickness = 3 }, { ["_lemonadeUniqueId"] = "nD0qoHNznD0q" })
				I[7] = new("UIAspectRatioConstraint", I[3], "UIAspectRatioConstraint", nil, { ["_lemonadeUniqueId"] = "WlvhrrbfWlvh" })
				I[8] = new("UIGradient", I[3], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(211, 211, 211)) }), Rotation = 90 }, { ["_lemonadeUniqueId"] = "HYO4CXqcHYO4" })
			I[9] = new("ImageLabel", I[2], "Header", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://90325592797235"), ImageTransparency = 0.75, Position = UDim2.fromScale(0.5000001, 0.0293394), ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1.0000001, 0.1810142), TileSize = UDim2.fromOffset(75, 75) }, { ["_lemonadeUniqueId"] = "mBk0b6HvmBk0" })
				I[10] = new("TextLabel", I[9], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0.0208028, 0.1540381), Size = UDim2.fromScale(0.6127635, 0.692625), Text = "Growing Eggs", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 2 }, { ["_lemonadeUniqueId"] = "C13JooCGC13J" })
					I[11] = new("UIStroke", I[10], "UIStroke", { Thickness = 2.5 }, { ["_lemonadeUniqueId"] = "dB3XTkGwdB3X" })
						I[12] = new("UIGradient", I[11], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 179, 229)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 80, 229)) }), Rotation = 90 }, { ["_lemonadeUniqueId"] = "tRHfMpAYtRHf" })
				I[13] = new("ImageLabel", I[9], "Stroke", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://98981360538955"), Position = UDim2.fromScale(0.5527315, 0.5003674), Size = UDim2.fromScale(0.5729538, 0.9916656) }, { ["_lemonadeUniqueId"] = "q4pKWAK0q4pK" })
				I[14] = new("ImageButton", I[9], "GrowAll", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.827, 0.5), Size = UDim2.fromScale(0.274412, 0.6068682) }, { ["_lemonadeUniqueId"] = "TJgCJQV3TJgC" })
					I[15] = new("ImageLabel", I[14], "Pattern", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://90325592797235"), ImageTransparency = 0.75, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(75, 75), ZIndex = -1 }, { ["_lemonadeUniqueId"] = "0oORV02m0oOR" })
					I[16] = new("TextLabel", I[14], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.975, 0.95), Text = "Grow All", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 3 }, { ["_lemonadeUniqueId"] = "dNZRgNrVdNZR" })
						I[17] = new("UIStroke", I[16], "UIStroke", { Thickness = 2.5 }, { ["_lemonadeUniqueId"] = "0hQRssgY0hQR" })
					I[18] = new("UIStroke", I[14], "UIStrokeClr", { Color = Color3.fromRGB(132, 112, 0), Thickness = 2 }, { ["_lemonadeUniqueId"] = "2Ta9HCwk2Ta9" })
					I[19] = new("UIStroke", I[14], "UIStroke", { Thickness = 4, ZIndex = 0 }, { ["_lemonadeUniqueId"] = "PftLBiL3PftL" })
					I[20] = new("UIGradient", I[14], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 247, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 136, 0)) }), Rotation = 90 }, { ["_lemonadeUniqueId"] = "mL6gzfXnmL6g" })
				I[21] = new("UIStroke", I[9], "UIStroke", { Color = Color3.fromRGB(82, 82, 107), Thickness = 2 }, { ["_lemonadeUniqueId"] = "hxtz9yBFhxtz" })
				I[22] = new("UIStroke", I[9], "UIStroke", { Color = Color3.fromRGB(21, 21, 21), Thickness = 4, ZIndex = 0 }, { ["_lemonadeUniqueId"] = "vOZHsGievOZH" })
				I[23] = new("UIGradient", I[9], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(199, 150, 104)), ColorSequenceKeypoint.new(0.532872, Color3.fromRGB(255, 202, 149)), ColorSequenceKeypoint.new(1, Color3.fromRGB(199, 169, 120)) }) }, { ["_lemonadeUniqueId"] = "mFTqLyhdmFTq" })
			I[24] = new("ScrollingFrame", I[2], "ScrollingFrame", { Active = true, AnchorPoint = Vector2.new(0.5, 0.5), AutomaticCanvasSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, CanvasSize = UDim2.fromScale(0, 0), Position = UDim2.fromScale(0.5010001, 0.5751072), ScrollBarThickness = 6, Size = UDim2.fromScale(0.97, 0.849) }, { ["_lemonadeUniqueId"] = "xMwtWmc0xMwt" })
				I[25] = new("Frame", I[24], "Template", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 2, Position = UDim2.fromScale(-0.0000002, -0.0000001), Size = UDim2.fromScale(1.0000002, 0.2914708) }, { ["_lemonadeUniqueId"] = "pdxfW1w0pdxf" })
					I[26] = new("ImageLabel", I[25], "Spacer", { BackgroundColor3 = Color3.fromRGB(49, 49, 49), BackgroundTransparency = 0.25, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, ImageTransparency = 0.75, LayoutOrder = 2, Position = UDim2.fromScale(0.0272594, 0.1249999), ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(0.9102835, 0.8121548), TileSize = UDim2.fromOffset(75, 75) }, { ["_lemonadeUniqueId"] = "OK1FV50eOK1F" })
						I[27] = new("ImageLabel", I[26], "Glow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://109516122757226"), ImageTransparency = 0.42, Position = UDim2.fromScale(0.0868729, 0.6239867), Size = UDim2.fromScale(0.6991299, 3.1066854) }, { ["_lemonadeUniqueId"] = "lshbwgN5lshb" })
						I[28] = new("ImageLabel", I[26], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), Position = UDim2.fromScale(0.1038946, 0.4990173), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.1735561, 0.8301561), ZIndex = 2 }, { ["_lemonadeUniqueId"] = "mf3PSoVjmf3P" })
						I[29] = new("Frame", I[26], "Progress", { BackgroundColor3 = Color3.fromRGB(17, 17, 22), BackgroundTransparency = 0.25, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.2468902, 0.2995859), Size = UDim2.fromScale(0.5867888, 0.4578605) }, { ["_lemonadeUniqueId"] = "7zvHPtes7zvH" })
							I[30] = new("Frame", I[29], "Fill", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.5000001), Size = UDim2.fromScale(0.406941, 1.0000001) }, { ["_lemonadeUniqueId"] = "Cy7mB6eECy7m" })
								I[31] = new("ImageLabel", I[30], "Pattern", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://90325592797235"), ImageTransparency = 0.75, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(50, 50) }, { ["_lemonadeUniqueId"] = "cDSb2arvcDSb" })
								I[32] = new("UIStroke", I[30], "UIStroke", { Thickness = 2 }, { ["_lemonadeUniqueId"] = "2bkRQHTt2bkR" })
								I[33] = new("UIGradient", I[30], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(6, 172, 3)), ColorSequenceKeypoint.new(1, Color3.fromRGB(78, 255, 69)) }), Rotation = 180 }, { ["_lemonadeUniqueId"] = "BnWlM6TlBnWl" })
							I[34] = new("TextLabel", I[29], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.7, 0.95), Text = "1m 25s", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 3 }, { ["_lemonadeUniqueId"] = "QWgGIm3HQWgG" })
								I[35] = new("UIStroke", I[34], "UIStroke", { Thickness = 2 }, { ["_lemonadeUniqueId"] = "EfZyB4PlEfZy" })
							I[36] = new("UIGradient", I[29], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(237, 237, 237)), ColorSequenceKeypoint.new(1, Color3.fromRGB(63, 63, 63)) }), Rotation = 90 }, { ["_lemonadeUniqueId"] = "a5SnHcNBa5Sn" })
							I[37] = new("UIStroke", I[29], "UIStroke", { Thickness = 2 }, { ["_lemonadeUniqueId"] = "hbQ2rE9FhbQ2" })
						I[38] = new("ImageButton", I[26], "Skip", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.9193222, 0.4999989), Size = UDim2.fromScale(0.0912003, 0.4892099) }, { ["_lemonadeUniqueId"] = "IkNe9eQuIkNe" })
							I[39] = new("ImageLabel", I[38], "Pattern", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://90325592797235"), ImageTransparency = 0.75, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(65, 65), ZIndex = -1 }, { ["_lemonadeUniqueId"] = "uyCH3KTbuyCH" })
							I[40] = new("ImageLabel", I[38], "Img", { AnchorPoint = Vector2.new(0.495, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://79657591184601"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1.1, 1.1), TileSize = UDim2.fromOffset(65, 65), ZIndex = -1 }, { ["_lemonadeUniqueId"] = "Be6WvpIoBe6W" })
							I[41] = new("UIGradient", I[38], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(136, 255, 0)) }), Rotation = -90 }, { ["_lemonadeUniqueId"] = "8MuQUeJ78MuQ" })
							I[42] = new("UIStroke", I[38], "UIStroke", { Color = Color3.fromRGB(11, 72, 0), Thickness = 4.5, ZIndex = 0 }, { ["_lemonadeUniqueId"] = "0w6r3xn10w6r" })
							I[43] = new("UIStroke", I[38], "UIStrokeClr", { Color = Color3.fromRGB(190, 255, 180), Thickness = 2 }, { ["_lemonadeUniqueId"] = "cS6agIn5cS6a" })
						I[44] = new("ImageButton", I[26], "Open", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.75, 0.5), Size = UDim2.fromScale(0.3, 0.489), Visible = false }, { ["_lemonadeUniqueId"] = "Ba6SBR4sBa6S" })
							I[45] = new("TextLabel", I[44], "Price", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.8, 0.95), Text = "Open", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 3 }, { ["_lemonadeUniqueId"] = "3gRgnPnF3gRg" })
								I[46] = new("UIStroke", I[45], "UIStroke", { Thickness = 3 }, { ["_lemonadeUniqueId"] = "ZwQOSGc0ZwQO" })
							I[47] = new("UIStroke", I[44], "UIStrokeClr", { Color = Color3.fromRGB(190, 255, 180), Thickness = 2 }, { ["_lemonadeUniqueId"] = "vOlTyIkmvOlT" })
							I[48] = new("UIStroke", I[44], "UIStroke", { Color = Color3.fromRGB(11, 72, 0), Thickness = 4.5, ZIndex = 0 }, { ["_lemonadeUniqueId"] = "fsRLnJCkfsRL" })
							I[49] = new("UIGradient", I[44], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(136, 255, 0)) }), Rotation = -90 }, { ["_lemonadeUniqueId"] = "WMH3wtZ7WMH3" })
						I[50] = new("UIStroke", I[26], "UIStroke", { Color = Color3.fromRGB(21, 21, 21), Thickness = 4.5, ZIndex = 0 }, { ["_lemonadeUniqueId"] = "37zrBGcK37zr" })
						I[51] = new("UIStroke", I[26], "UIStroke", { Color = Color3.fromRGB(82, 82, 107), Thickness = 2 }, { ["_lemonadeUniqueId"] = "rVtlvHYsrVtl" })
				I[52] = new("Frame", I[24], "EmptyLast", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 9999, Size = UDim2.fromScale(1, 0.1) }, { ["_lemonadeUniqueId"] = "LS0aVLK4LS0a" })
				I[53] = new("UIListLayout", I[24], "UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder }, { ["_lemonadeUniqueId"] = "L0DRjJeuL0DR" })
			I[54] = new("UIStroke", I[2], "UIStroke", { Color = Color3.fromRGB(82, 82, 107), Thickness = 2 }, { ["_lemonadeUniqueId"] = "CW8WlKaoCW8W" })
			I[55] = new("UIStroke", I[2], "UIStroke", { Color = Color3.fromRGB(21, 21, 21), Thickness = 4, ZIndex = 0 }, { ["_lemonadeUniqueId"] = "HFT5JiVDHFT5" })
			I[56] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 1.25 }, { ["_lemonadeUniqueId"] = "oTaOxIVtoTaO" })
	return I[1]
end

return build
