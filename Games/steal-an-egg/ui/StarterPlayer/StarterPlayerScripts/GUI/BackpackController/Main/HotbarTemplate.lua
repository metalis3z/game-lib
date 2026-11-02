-- Generated from ui/StarterPlayer/StarterPlayerScripts/GUI/BackpackController/Main/HotbarTemplate.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("TextButton", nil, "HotbarTemplate", { AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(38, 38, 38), BackgroundTransparency = 0.4, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromOffset(5, 5), Size = UDim2.fromOffset(80, 80), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14, TextWrapped = true, ZIndex = 20 }, { ["Draggable"] = true, ["IsInventorySlot"] = false })
		I[2] = new("Folder", I[1], "BaseTemplate")
			I[3] = new("TextLabel", I[2], "Amount", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(1, 1), Size = UDim2.new(1, -2, 0.725, -2), Text = "", TextColor3 = Color3.fromRGB(217, 217, 217), TextSize = 13, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Bottom, Visible = false, ZIndex = 23 })
				I[4] = new("UIStroke", I[3], "UIStroke", { Thickness = 1.1381944, Transparency = 0.5 }, { ["oldp_Thickness"] = 1.5 })
			I[5] = new("Frame", I[2], "Mutations", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = -91, Position = UDim2.fromScale(0.0719998, 0.05), Size = UDim2.fromScale(0.6185185, 0.2518519), ZIndex = 555 })
				I[6] = new("UIListLayout", I[5], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0.01, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
				I[7] = new("ImageLabel", I[5], "Template", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), SizeConstraint = Enum.SizeConstraint.RelativeYY, Visible = false, ZIndex = 2 })
		I[8] = new("UIStroke", I[1], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Thickness = 0 }, { ["oldp_Thickness"] = 0 })
		I[9] = new("UICorner", I[1], "UICorner", { BottomLeftRadius = UDim.new(0.1, 0), BottomRightRadius = UDim.new(0.1, 0), TopLeftRadius = UDim.new(0.1, 0), TopRightRadius = UDim.new(0.1, 0) })
		I[10] = new("UIScale", I[1], "ButtonUIScale")
		I[11] = new("Frame", I[1], "SelectionObjectClipper", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), Visible = false })
			I[12] = new("ImageLabel", I[11], "Selector", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxasset://textures/ui/Keyboard/key_selection_9slice.png"), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(12, 12, 52, 52), SliceScale = 0.7587963 }, { ["oldp_SliceScale"] = 1 })
		I[13] = new("ImageLabel", I[1], "Shadow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://126841495627073"), ImageTransparency = 0.5, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.8, 0.889), Visible = false, ZIndex = 20 })
		I[14] = new("ImageLabel", I[1], "Icon", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.95), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.9, 0.9), ZIndex = 20 })
		I[15] = new("TextLabel", I[1], "ToolName", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(1, 1), Size = UDim2.new(0.98, -2, 0.98, -2), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 19, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, TextYAlignment = Enum.TextYAlignment.Bottom, Visible = false, ZIndex = 20 })
			I[16] = new("UIStroke", I[15], "UIStroke", { Thickness = 1.7072917, Transparency = 0.5 }, { ["oldp_Thickness"] = 2.25 })
		I[17] = new("TextLabel", I[1], "Weight", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.2799999), Size = UDim2.fromScale(0.95, 0.25), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, TextYAlignment = Enum.TextYAlignment.Top, ZIndex = 23 })
			I[18] = new("UIStroke", I[17], "UIStroke", { Thickness = 1.9, Transparency = 0.5 }, { ["oldp_Thickness"] = 1.5 })
		I[19] = new("Frame", I[1], "StrokeFrame", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 19 })
			I[20] = new("UICorner", I[19], "UICorner", { BottomLeftRadius = UDim.new(0, 0), BottomRightRadius = UDim.new(0, 0), TopLeftRadius = UDim.new(0, 0), TopRightRadius = UDim.new(0, 0) })
			I[21] = new("UIStroke", I[19], "UIStroke", { Thickness = 1.5175925, Transparency = 0.1 }, { ["oldp_Thickness"] = 2 })
		I[22] = new("TextLabel", I[1], "ToolTip", { BackgroundColor3 = Color3.fromRGB(102, 102, 102), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14, Visible = false, ZIndex = 22 })
			I[23] = new("UICorner", I[22], "UICorner", { BottomLeftRadius = UDim.new(0, 0), BottomRightRadius = UDim.new(0, 0), TopLeftRadius = UDim.new(0, 0), TopRightRadius = UDim.new(0, 0) })
		I[24] = new("TextLabel", I[1], "Number", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.01, 0.01), Size = UDim2.fromScale(0.2153846, 0.3307692), Text = "1", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 20 })
			I[25] = new("UIAspectRatioConstraint", I[24], "UIAspectRatioConstraint")
			I[26] = new("UICorner", I[24], "UICorner", { BottomLeftRadius = UDim.new(0.3, 0), BottomRightRadius = UDim.new(0.3, 0), TopLeftRadius = UDim.new(0.3, 0), TopRightRadius = UDim.new(0.3, 0) })
			I[27] = new("UIStroke", I[24], "UIStroke", { Color = Color3.fromRGB(26, 26, 26), Enabled = false, Thickness = 2.2763889 }, { ["oldp_Thickness"] = 3 })
		I[28] = new("ImageLabel", I[1], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://80145570836173"), ImageTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), ZIndex = 2 })
			I[29] = new("Frame", I[28], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(38, 38, 38), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.9) })
				I[30] = new("UICorner", I[29], "UICorner", { BottomLeftRadius = UDim.new(0.1, 0), BottomRightRadius = UDim.new(0.1, 0), TopLeftRadius = UDim.new(0.1, 0), TopRightRadius = UDim.new(0.1, 0) })
				I[31] = new("UIAspectRatioConstraint", I[29], "UIAspectRatioConstraint")
				I[32] = new("UIGradient", I[29], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(111, 236, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(16, 9, 21)) }), Enabled = false, Rotation = 90 })
				I[33] = new("ImageLabel", I[29], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://136476006205731"), ImageTransparency = 0.2, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Visible = false })
		I[34] = new("ImageLabel", I[1], "FavIcon", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://122201416359766"), Position = UDim2.fromScale(0.7346154, 0.077), Size = UDim2.fromScale(0.2153846, 0.205432), ZIndex = 30 })
	return I[1]
end

return build
