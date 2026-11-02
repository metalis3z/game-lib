-- Generated from ui/StarterGui/USM Exchange.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "USM Exchange")
		I[2] = new("Folder", I[1], "PlayerInfo")
			I[3] = new("StringValue", I[2], "CoverOnly")
			I[4] = new("StringValue", I[2], "Paygrade")
			I[5] = new("StringValue", I[2], "Type")
			I[6] = new("StringValue", I[2], "Branch")
		I[7] = new("Frame", I[1], "Mainframe", { BackgroundColor3 = Color3.fromRGB(207, 207, 207), BorderSizePixel = 0, Position = UDim2.fromScale(0.25, 1.3), Size = UDim2.fromScale(0.5, 0.6) })
			I[8] = new("Frame", I[7], "Branch", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(135, 135, 135), BorderSizePixel = 0, Size = UDim2.fromScale(1, 0.91) })
				I[9] = new("ImageButton", I[8], "CoastGuard", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://3624043544"), Position = UDim2.fromScale(0.4, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.2, 0.3) })
				I[10] = new("ImageButton", I[8], "Navy", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=4307308602"), Position = UDim2.fromScale(0.4, 0.15), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.2, 0.3) })
				I[11] = new("ImageButton", I[8], "Marines", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=4307307731"), Position = UDim2.fromScale(0.7, 0.15), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.2, 0.3) })
				I[12] = new("ImageButton", I[8], "Army", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=4307306972"), Position = UDim2.fromScale(0.1, 0.15), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.2, 0.3) })
				I[13] = new("ImageButton", I[8], "AirForce", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=4307314465"), Position = UDim2.fromScale(0.1, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.2, 0.3) })
				I[14] = new("ImageButton", I[8], "SpaceForce", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=6433509565"), Position = UDim2.fromScale(0.7, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.2, 0.3) })
			I[15] = new("TextLabel", I[7], "Credits (Please Keep)", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.75, 0.915), Size = UDim2.fromScale(0.2, 0.075), Text = "Made by devTools", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[16] = new("ScrollingFrame", I[7], "Ranks", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(213, 213, 213), BorderSizePixel = 0, BottomImageContent = Content.fromUri("rbxassetid://158362069"), CanvasSize = UDim2.fromScale(0, 3), MidImageContent = Content.fromUri("rbxassetid://158362107"), Position = UDim2.fromScale(0, 0.1), ScrollBarThickness = 8, ScrollingDirection = Enum.ScrollingDirection.Y, Size = UDim2.fromScale(1, 0.81), TopImageContent = Content.fromUri("rbxassetid://158362148"), VerticalScrollBarInset = Enum.ScrollBarInset.Always, Visible = false })
				I[17] = new("ImageButton", I[16], "Template", { BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 72, 135), ImageContent = Content.fromUri("rbxassetid://1285673399"), Position = UDim2.fromScale(0.1, 0.005), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.8, 0.05), SliceCenter = Rect.new(8, 8, 247, 247), Visible = false })
					I[18] = new("TextLabel", I[17], "TextLabel", { AnchorPoint = Vector2.new(0, 0.5), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(1, 0.8), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14 })
			I[19] = new("TextLabel", I[7], "Selection", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 0.1), Text = "", TextColor3 = Color3.fromRGB(141, 0, 0), TextSize = 25, TextStrokeColor3 = Color3.fromRGB(170, 0, 0), TextWrapped = true, ZIndex = 2 })
			I[20] = new("ScrollingFrame", I[7], "Uniform", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(213, 213, 213), BorderSizePixel = 0, BottomImageContent = Content.fromUri("rbxassetid://158362069"), CanvasSize = UDim2.fromScale(0, 4), MidImageContent = Content.fromUri("rbxassetid://158362107"), Position = UDim2.fromScale(0, 0.1), ScrollBarThickness = 8, ScrollingDirection = Enum.ScrollingDirection.Y, Size = UDim2.fromScale(1, 0.81), TopImageContent = Content.fromUri("rbxassetid://158362148"), VerticalScrollBarInset = Enum.ScrollBarInset.Always, Visible = false })
				I[21] = new("ImageButton", I[20], "Template", { BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 72, 135), ImageContent = Content.fromUri("rbxassetid://1285673399"), Position = UDim2.fromScale(0.1, 0.005), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.8, 0.05), SliceCenter = Rect.new(8, 8, 247, 247), Visible = false })
					I[22] = new("TextLabel", I[21], "TextLabel", { AnchorPoint = Vector2.new(0, 0.5), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(1, 0.8), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14 })
			I[23] = new("Frame", I[7], "CoverOnly", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(135, 135, 135), BorderSizePixel = 0, Size = UDim2.fromScale(1, 0.91), Visible = false })
				I[24] = new("ImageButton", I[23], "Cover", { BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 72, 135), ImageContent = Content.fromUri("rbxassetid://1285673399"), ImageTransparency = 1, Position = UDim2.fromScale(0.1, 0.45), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.8, 0.1), SliceCenter = Rect.new(8, 8, 247, 247) })
					I[25] = new("TextLabel", I[24], "TextLabel", { AnchorPoint = Vector2.new(0, 0.5), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(1, 0.8), Text = "Only Cover", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14 })
				I[26] = new("ImageButton", I[23], "Full", { BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 72, 135), ImageContent = Content.fromUri("rbxassetid://1285673399"), ImageTransparency = 1, Position = UDim2.fromScale(0.1, 0.25), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.8, 0.1), SliceCenter = Rect.new(8, 8, 247, 247) })
					I[27] = new("TextLabel", I[26], "TextLabel", { AnchorPoint = Vector2.new(0, 0.5), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(1, 0.8), Text = "Full Uniform", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14 })
			I[28] = new("ImageButton", I[7], "Close", { BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 47, 93), ImageContent = Content.fromUri("rbxassetid://1283904632"), Position = UDim2.fromScale(0.4, 0.93), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.2, 0.05), SliceCenter = Rect.new(22, 22, 234, 234) })
				I[29] = new("TextLabel", I[28], "TextLabel", { AnchorPoint = Vector2.new(0, 0.5), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(1, 0.8), Text = "Close Exchange", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14 })
			I[30] = new("ImageLabel", I[7], "Header", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://1290178207"), Position = UDim2.fromScale(0, -0.325), Size = UDim2.fromScale(1, 0.325) })
		I[31] = new("ImageButton", I[1], "OpenButton", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=4332713285"), Position = UDim2.fromScale(0, 0.94), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.03, 0.05), Visible = false })
	return I[1]
end

return build
