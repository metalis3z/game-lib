-- Generated from ui/ServerScriptService/StatChanger/StatChanger.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "StatChanger", { ResetOnSpawn = false })
		I[2] = new("ImageButton", I[1], "Toggle", { BackgroundColor3 = Color3.fromRGB(35, 35, 35), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(35, 35, 35), ImageContent = Content.fromUri("rbxassetid://2790390993"), Position = UDim2.fromScale(0.9612007, 0.9180064), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromOffset(46, 45), SliceCenter = Rect.new(16, 16, 240, 240) })
			I[3] = new("ImageLabel", I[2], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=5469163400"), Position = UDim2.fromScale(0.0652174, 0.111111), Size = UDim2.fromOffset(39, 35) })
		I[4] = new("ImageLabel", I[1], "UI", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(30, 30, 30), ImageContent = Content.fromUri("rbxassetid://3570695787"), Position = UDim2.fromScale(0.4996339, 0.5152733), ScaleType = Enum.ScaleType.Slice, Size = UDim2.new(0.1661786, 24, 0.5450161, 24), SliceCenter = Rect.new(100, 100, 100, 100), SliceScale = 0.12, Visible = false })
			I[5] = new("ScrollingFrame", I[4], "UI", { BackgroundColor3 = Color3.fromRGB(30, 30, 30), BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.0992287), ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0), ScrollBarThickness = 2, Size = UDim2.fromScale(0.9999999, 0.8649587) })
				I[6] = new("UIListLayout", I[5], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 3), SortOrder = Enum.SortOrder.LayoutOrder })
			I[7] = new("TextLabel", I[4], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/LuckiestGuy.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(-0.0278884, 0.0151515), Size = UDim2.fromScale(1.0597609, 0.0840771), Text = "Stats", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 23, TextWrapped = true })
		I[8] = new("ImageLabel", I[1], "Template", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(42, 42, 42), ImageContent = Content.fromUri("rbxassetid://3570695787"), Position = UDim2.fromScale(0.0087848, 0.1093247), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.9736457, 0.1223473), SliceCenter = Rect.new(100, 100, 100, 100), SliceScale = 0.12, Visible = false })
			I[9] = new("TextLabel", I[8], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Jura.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 0.2918889), Text = "Cash ", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[10] = new("TextBox", I[8], "Stat", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.8, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Jura.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), PlaceholderColor3 = Color3.fromRGB(178, 178, 178), Position = UDim2.fromScale(0.0269946, 0.3838728), Size = UDim2.fromScale(0.45, 0.5), Text = "45", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14 })
			I[11] = new("TextButton", I[8], "Submit", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.8, FontFace = Font.new("rbxasset://fonts/families/Jura.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5235924, 0.3838728), Size = UDim2.fromScale(0.45, 0.5), Text = "Proceed →", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14, TextWrapped = true })
	return I[1]
end

return build
