-- Generated from ui/ServerStorage/Removed_CodesAndLiveUpdate/CodeGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "CodeGui", { ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.3, Position = UDim2.fromScale(0.5, 0.45), Size = UDim2.fromOffset(500, 340), Visible = false })
			I[3] = new("UIStroke", I[2], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 4 })
			I[4] = new("UIGradient", I[2], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(78, 91, 112)), ColorSequenceKeypoint.new(1, Color3.fromRGB(44, 52, 65)) }), Rotation = 90 }, { ["HW_Color"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(226, 228, 238)) }) })
			I[5] = new("ImageLabel", I[2], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.2, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(28, 28), Visible = false, ZIndex = 0 })
				I[6] = new("UIGradient", I[5], "Tint", { Rotation = 90 })
			I[7] = new("Frame", I[2], "Header", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.fromOffset(10, 10), Size = UDim2.new(1, -20, 0, 58) })
				I[8] = new("UIStroke", I[7], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 3 })
				I[9] = new("UIGradient", I[7], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(64, 180, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(43, 164, 222)) }) }, { ["HW_Color"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 235, 20)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(215, 250, 60)), ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 235, 20)) }) })
				I[10] = new("ImageLabel", I[7], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.2, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(28, 28), Visible = false, ZIndex = 0 })
					I[11] = new("UIGradient", I[10], "Tint", { Rotation = 90 })
				I[12] = new("TextLabel", I[7], "Title", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(68, 9), Size = UDim2.new(0, 300, 1, -18), Text = "Redeem Code", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 2 })
					I[13] = new("UIStroke", I[12], "TextStroke", { Thickness = 4.5 })
				I[14] = new("TextButton", I[7], "Close", { AnchorPoint = Vector2.new(1, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.new(1, -9, 0.5, 0), Size = UDim2.fromOffset(44, 44), Text = "", ZIndex = 2 }, { ["MontFix"] = true })
					I[15] = new("UIStroke", I[14], "Outline", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 3 })
					I[16] = new("UIGradient", I[14], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 0, 0)), ColorSequenceKeypoint.new(0.4833887, Color3.fromRGB(170, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) }), Rotation = 90 })
					I[17] = new("ImageLabel", I[14], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.2, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(26, 26), Visible = false, ZIndex = 0 })
						I[18] = new("UIGradient", I[17], "Tint", { Rotation = 90 })
					I[19] = new("Frame", I[14], "Bar", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.fromScale(0.5, 0.5), Rotation = 45, Size = UDim2.fromOffset(26, 7), ZIndex = 3 })
						I[20] = new("UIStroke", I[19], "UIStroke", { Thickness = 2 })
					I[21] = new("Frame", I[14], "Bar", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.fromScale(0.5, 0.5), Rotation = -45, Size = UDim2.fromOffset(26, 7), ZIndex = 3 })
						I[22] = new("UIStroke", I[21], "UIStroke", { Thickness = 2 })
			I[23] = new("TextLabel", I[2], "Subtitle", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(20, 76), Size = UDim2.new(1, -40, 0, 30), Text = "~ Enter a code below ~", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true })
				I[24] = new("UIGradient", I[23], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(236, 60, 60)), ColorSequenceKeypoint.new(1, Color3.fromRGB(38, 150, 255)) }), Rotation = 90 })
				I[25] = new("UIStroke", I[23], "TextStroke", { Thickness = 3.5 })
			I[26] = new("TextBox", I[2], "CodeInput", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), PlaceholderColor3 = Color3.fromRGB(153, 153, 166), PlaceholderText = "Enter code here...", Position = UDim2.fromOffset(20, 120), Size = UDim2.new(1, -40, 0, 56), Text = "", TextScaled = true, TextWrapped = true, ZIndex = 2 })
				I[27] = new("UIStroke", I[26], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 3 })
				I[28] = new("ImageLabel", I[26], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.2, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(26, 26), Visible = false, ZIndex = 0 })
					I[29] = new("UIGradient", I[28], "Tint", { Rotation = 90 })
				I[30] = new("UIPadding", I[26], "UIPadding", { PaddingLeft = UDim.new(0, 12), PaddingRight = UDim.new(0, 12) })
			I[31] = new("TextButton", I[2], "Redeem", { AnchorPoint = Vector2.new(0.5, 0), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.new(0.5, 0, 0, 196), Size = UDim2.fromOffset(200, 56), Text = "Redeem", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, ZIndex = 2 })
				I[32] = new("UIStroke", I[31], "Outline", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 3 })
				I[33] = new("UIGradient", I[31], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 238, 112)), ColorSequenceKeypoint.new(1, Color3.fromRGB(250, 168, 16)) }), Rotation = 90 })
				I[34] = new("ImageLabel", I[31], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.2, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(26, 26), Visible = false, ZIndex = 0 })
					I[35] = new("UIGradient", I[34], "Tint", { Rotation = 90 })
				I[36] = new("UIStroke", I[31], "TextStroke", { Thickness = 4 })
				I[37] = new("UIPadding", I[31], "UIPadding", { PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8) })
			I[38] = new("TextLabel", I[2], "Result", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(20, 270), Size = UDim2.new(1, -40, 0, 40), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, ZIndex = 2 })
				I[39] = new("UIStroke", I[38], "TextStroke", { Thickness = 3.5 })
	return I[1]
end

return build
