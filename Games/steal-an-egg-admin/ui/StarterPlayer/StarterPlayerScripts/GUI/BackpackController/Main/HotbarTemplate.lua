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
	I[1] = new("TextButton", nil, "HotbarTemplate", { AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(38, 38, 38), BackgroundTransparency = 0.4, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromOffset(5, 5), Size = UDim2.fromOffset(80, 80), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14, TextWrapped = true, ZIndex = 20 }, { ["Draggable"] = true, ["IsInventorySlot"] = false, ["_lemonadeUniqueId"] = "GMfVlVIOGMfV" })
		I[2] = new("Folder", I[1], "BaseTemplate", nil, { ["_lemonadeUniqueId"] = "ig2mYq7Pig2m" })
			I[3] = new("TextLabel", I[2], "Amount", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(1, 1), Size = UDim2.new(1, -2, 0.725, -2), Text = "", TextColor3 = Color3.fromRGB(217, 217, 217), TextSize = 13, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Bottom, Visible = false, ZIndex = 23 }, { ["_lemonadeUniqueId"] = "8fscKGpN8fsc" })
				I[4] = new("UIStroke", I[3], "UIStroke", { Thickness = 1.1381944, Transparency = 0.5 }, { ["_lemonadeUniqueId"] = "7ZjuVhJv7Zju", ["oldp_Thickness"] = 1.5 })
			I[5] = new("Frame", I[2], "Mutations", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = -91, Position = UDim2.fromScale(0.0719998, 0.05), Size = UDim2.fromScale(0.6185185, 0.2518519), ZIndex = 555 }, { ["_lemonadeUniqueId"] = "ZpixfCBfZpix" })
				I[6] = new("ImageLabel", I[5], "Template", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), SizeConstraint = Enum.SizeConstraint.RelativeYY, Visible = false, ZIndex = 2 }, { ["_lemonadeUniqueId"] = "EAr2obzvEAr2" })
				I[7] = new("UIListLayout", I[5], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0.01, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center }, { ["_lemonadeUniqueId"] = "0CMzjnq40CMz" })
		I[8] = new("Frame", I[1], "SelectionObjectClipper", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), Visible = false }, { ["_lemonadeUniqueId"] = "4G08AiX94G08" })
			I[9] = new("ImageLabel", I[8], "Selector", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxasset://textures/ui/Keyboard/key_selection_9slice.png"), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(12, 12, 52, 52), SliceScale = 0.7587963 }, { ["_lemonadeUniqueId"] = "8wIacmeG8wIa", ["oldp_SliceScale"] = 1 })
		I[10] = new("ImageLabel", I[1], "Shadow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://126841495627073"), ImageTransparency = 0.5, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.8, 0.889), Visible = false, ZIndex = 20 }, { ["_lemonadeUniqueId"] = "gkv8cCrFgkv8" })
		I[11] = new("ImageLabel", I[1], "Icon", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.95), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.9, 0.9), ZIndex = 20 }, { ["_lemonadeUniqueId"] = "HrXlSgiAHrXl" })
		I[12] = new("TextLabel", I[1], "ToolName", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(1, 1), Size = UDim2.new(0.98, -2, 0.98, -2), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 19, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, TextYAlignment = Enum.TextYAlignment.Bottom, Visible = false, ZIndex = 20 }, { ["_lemonadeUniqueId"] = "zDYLNWxZzDYL" })
			I[13] = new("UIStroke", I[12], "UIStroke", { Thickness = 1.7072917, Transparency = 0.5 }, { ["_lemonadeUniqueId"] = "IXY4A0hRIXY4", ["oldp_Thickness"] = 2.25 })
		I[14] = new("TextLabel", I[1], "Weight", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.2799999), Size = UDim2.fromScale(0.95, 0.25), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, TextYAlignment = Enum.TextYAlignment.Top, ZIndex = 23 }, { ["_lemonadeUniqueId"] = "tyuzW6Pftyuz" })
			I[15] = new("UIStroke", I[14], "UIStroke", { Thickness = 1.9, Transparency = 0.5 }, { ["_lemonadeUniqueId"] = "lssQSVfJlssQ", ["oldp_Thickness"] = 1.5 })
		I[16] = new("Frame", I[1], "StrokeFrame", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 19 }, { ["_lemonadeUniqueId"] = "fEQktnfVfEQk" })
			I[17] = new("UIStroke", I[16], "UIStroke", { Thickness = 1.5175925, Transparency = 0.1 }, { ["_lemonadeUniqueId"] = "MLysJ8pRMLys", ["oldp_Thickness"] = 2 })
			I[18] = new("UICorner", I[16], "UICorner", { BottomLeftRadius = UDim.new(0, 0), BottomRightRadius = UDim.new(0, 0), TopLeftRadius = UDim.new(0, 0), TopRightRadius = UDim.new(0, 0) }, { ["_lemonadeUniqueId"] = "ye3EUc5Lye3E" })
		I[19] = new("TextLabel", I[1], "ToolTip", { BackgroundColor3 = Color3.fromRGB(102, 102, 102), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14, Visible = false, ZIndex = 22 }, { ["_lemonadeUniqueId"] = "JqayVbLRJqay" })
			I[20] = new("UICorner", I[19], "UICorner", { BottomLeftRadius = UDim.new(0, 0), BottomRightRadius = UDim.new(0, 0), TopLeftRadius = UDim.new(0, 0), TopRightRadius = UDim.new(0, 0) }, { ["_lemonadeUniqueId"] = "d3b0xKkqd3b0" })
		I[21] = new("TextLabel", I[1], "Number", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.01, 0.01), Size = UDim2.fromScale(0.2153846, 0.3307692), Text = "1", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 20 }, { ["_lemonadeUniqueId"] = "XM1Qaf2iXM1Q" })
			I[22] = new("UIStroke", I[21], "UIStroke", { Color = Color3.fromRGB(26, 26, 26), Enabled = false, Thickness = 2.2763889 }, { ["_lemonadeUniqueId"] = "GDBPDNrfGDBP", ["oldp_Thickness"] = 3 })
			I[23] = new("UICorner", I[21], "UICorner", { BottomLeftRadius = UDim.new(0.3, 0), BottomRightRadius = UDim.new(0.3, 0), TopLeftRadius = UDim.new(0.3, 0), TopRightRadius = UDim.new(0.3, 0) }, { ["_lemonadeUniqueId"] = "Hiye2YfzHiye" })
			I[24] = new("UIAspectRatioConstraint", I[21], "UIAspectRatioConstraint", nil, { ["_lemonadeUniqueId"] = "lxYHmCMUlxYH" })
		I[25] = new("ImageLabel", I[1], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://80145570836173"), ImageTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), ZIndex = 2 }, { ["_lemonadeUniqueId"] = "WQKKIysEWQKK" })
			I[26] = new("Frame", I[25], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(38, 38, 38), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.9) }, { ["_lemonadeUniqueId"] = "7qQ53kvr7qQ5" })
				I[27] = new("ImageLabel", I[26], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://136476006205731"), ImageTransparency = 0.2, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Visible = false }, { ["_lemonadeUniqueId"] = "oapucOjdoapu" })
				I[28] = new("UIGradient", I[26], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(111, 236, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(16, 9, 21)) }), Enabled = false, Rotation = 90 }, { ["_lemonadeUniqueId"] = "zqAJ9VptzqAJ" })
				I[29] = new("UIAspectRatioConstraint", I[26], "UIAspectRatioConstraint", nil, { ["_lemonadeUniqueId"] = "RcBHthTrRcBH" })
				I[30] = new("UICorner", I[26], "UICorner", { BottomLeftRadius = UDim.new(0.1, 0), BottomRightRadius = UDim.new(0.1, 0), TopLeftRadius = UDim.new(0.1, 0), TopRightRadius = UDim.new(0.1, 0) }, { ["_lemonadeUniqueId"] = "ozdVQnp7ozdV" })
		I[31] = new("ImageLabel", I[1], "FavIcon", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://122201416359766"), Position = UDim2.fromScale(0.7346154, 0.077), Size = UDim2.fromScale(0.2153846, 0.205432), ZIndex = 30 }, { ["_lemonadeUniqueId"] = "qkzxBIucqkzx" })
		I[32] = new("UIScale", I[1], "ButtonUIScale", nil, { ["_lemonadeUniqueId"] = "XZ2Y14SQXZ2Y" })
		I[33] = new("UICorner", I[1], "UICorner", { BottomLeftRadius = UDim.new(0.1, 0), BottomRightRadius = UDim.new(0.1, 0), TopLeftRadius = UDim.new(0.1, 0), TopRightRadius = UDim.new(0.1, 0) }, { ["_lemonadeUniqueId"] = "RA76B1QCRA76" })
		I[34] = new("UIStroke", I[1], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Thickness = 0 }, { ["_lemonadeUniqueId"] = "1PA2LAoW1PA2", ["oldp_Thickness"] = 0 })
	return I[1]
end

return build
