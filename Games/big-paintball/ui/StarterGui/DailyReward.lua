-- Generated from ui/StarterGui/DailyReward.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "DailyReward", { Enabled = false, ResetOnSpawn = false })
		I[2] = new("ImageLabel", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://5431965152"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.new(0.25, 100, 0.4, 200), SliceCenter = Rect.new(20, 20, 80, 80) })
			I[3] = new("UIPadding", I[2], "UIPadding", { PaddingBottom = UDim.new(0.02, 0), PaddingLeft = UDim.new(0.025, 0), PaddingRight = UDim.new(0.025, 0), PaddingTop = UDim.new(0.02, 0) })
			I[4] = new("TextLabel", I[2], "Title", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.025), Size = UDim2.new(0.9, 0, 0.075, 14), Text = "Daily Rewards!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextWrapped = true, ZIndex = 2 })
				I[5] = new("TextLabel", I[4], "Shadow", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(0, 1), Size = UDim2.fromScale(1, 1), Text = "Daily Rewards!", TextColor3 = Color3.fromRGB(255, 210, 29), TextScaled = true, TextSize = 18, TextWrapped = true })
					I[6] = new("UIStroke", I[5], "UIStroke", { Color = Color3.fromRGB(255, 210, 29), Thickness = 6 })
				I[7] = new("UIStroke", I[4], "UIStroke", { Thickness = 3 })
			I[8] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 1.5 })
			I[9] = new("Frame", I[2], "Container", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.55), Size = UDim2.fromScale(1, 0.65) })
				I[10] = new("ImageLabel", I[9], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://5431965152"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.new(0.25, 100, 0.4, 200), SliceCenter = Rect.new(20, 20, 80, 80) })
					I[11] = new("ImageLabel", I[10], "Arrow", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(255, 217, 26), ImageContent = Content.fromUri("rbxassetid://9515051675"), Position = UDim2.fromScale(0, 1.01), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 0.1) })
					I[12] = new("TextLabel", I[10], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.05), Size = UDim2.fromScale(1, 0.2), Text = "Day 1", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 18, TextWrapped = true })
				I[13] = new("UIGridLayout", I[9], "UIGridLayout", { CellPadding = UDim2.fromScale(0.035, 0.085), CellSize = UDim2.fromScale(0.234, 0.45), FillDirectionMaxCells = 4, HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
					I[14] = new("UIAspectRatioConstraint", I[13], "UIAspectRatioConstraint")
				I[15] = new("ImageLabel", I[9], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://5431965152"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.new(0.25, 100, 0.4, 200), SliceCenter = Rect.new(20, 20, 80, 80) })
					I[16] = new("ImageLabel", I[15], "Arrow", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(255, 217, 26), ImageContent = Content.fromUri("rbxassetid://9515051675"), Position = UDim2.fromScale(0, 1.01), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 0.1), Visible = false })
					I[17] = new("TextLabel", I[15], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.05), Size = UDim2.fromScale(1, 0.2), Text = "Day 2", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 18, TextWrapped = true })
				I[18] = new("ImageLabel", I[9], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://5431965152"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.new(0.25, 100, 0.4, 200), SliceCenter = Rect.new(20, 20, 80, 80) })
					I[19] = new("ImageLabel", I[18], "Arrow", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(255, 217, 26), ImageContent = Content.fromUri("rbxassetid://9515051675"), Position = UDim2.fromScale(0, 1.01), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 0.1), Visible = false })
					I[20] = new("TextLabel", I[18], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.05), Size = UDim2.fromScale(1, 0.2), Text = "Day 3", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 18, TextWrapped = true })
				I[21] = new("ImageLabel", I[9], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://5431965152"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.new(0.25, 100, 0.4, 200), SliceCenter = Rect.new(20, 20, 80, 80) })
					I[22] = new("ImageLabel", I[21], "Arrow", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(255, 217, 26), ImageContent = Content.fromUri("rbxassetid://9515051675"), Position = UDim2.fromScale(0, 1.01), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 0.1), Visible = false })
					I[23] = new("TextLabel", I[21], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.05), Size = UDim2.fromScale(1, 0.2), Text = "Day 4", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 18, TextWrapped = true })
				I[24] = new("ImageLabel", I[9], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://5431965152"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.new(0.25, 100, 0.4, 200), SliceCenter = Rect.new(20, 20, 80, 80) })
					I[25] = new("ImageLabel", I[24], "Arrow", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(255, 217, 26), ImageContent = Content.fromUri("rbxassetid://9515051675"), Position = UDim2.fromScale(0, 1.01), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 0.1), Visible = false })
					I[26] = new("TextLabel", I[24], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.05), Size = UDim2.fromScale(1, 0.2), Text = "Day 5", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 18, TextWrapped = true })
				I[27] = new("ImageLabel", I[9], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://5431965152"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.new(0.25, 100, 0.4, 200), SliceCenter = Rect.new(20, 20, 80, 80) })
					I[28] = new("ImageLabel", I[27], "Arrow", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(255, 217, 26), ImageContent = Content.fromUri("rbxassetid://9515051675"), Position = UDim2.fromScale(0, 1.01), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 0.1), Visible = false })
					I[29] = new("TextLabel", I[27], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.05), Size = UDim2.fromScale(1, 0.2), Text = "Day 6", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 18, TextWrapped = true })
				I[30] = new("ImageLabel", I[9], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://5431965152"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.new(0.25, 100, 0.4, 200), SliceCenter = Rect.new(20, 20, 80, 80) })
					I[31] = new("ImageLabel", I[30], "Arrow", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(255, 217, 26), ImageContent = Content.fromUri("rbxassetid://9515051675"), Position = UDim2.fromScale(0, 1.01), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 0.1), Visible = false })
					I[32] = new("TextLabel", I[30], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.05), Size = UDim2.fromScale(1, 0.2), Text = "Day 7", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 18, TextWrapped = true })
	return I[1]
end

return build
