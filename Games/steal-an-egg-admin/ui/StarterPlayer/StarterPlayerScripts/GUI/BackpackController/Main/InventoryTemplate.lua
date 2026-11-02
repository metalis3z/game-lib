-- Generated from ui/StarterPlayer/StarterPlayerScripts/GUI/BackpackController/Main/InventoryTemplate.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("TextButton", nil, "InventoryTemplate", { AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 7, Size = UDim2.fromOffset(120, 120), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14, TextWrapped = true, ZIndex = 20 }, { ["Draggable"] = true, ["HasAssetOverlay"] = true, ["IsInventorySlot"] = true, ["_lemonadeUniqueId"] = "1ioLuWRT1ioL" })
		I[2] = new("ImageLabel", I[1], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://80145570836173"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 2 }, { ["_lemonadeUniqueId"] = "MbsXX8MKMbsX" })
		I[3] = new("Folder", I[1], "BaseTemplate", nil, { ["_lemonadeUniqueId"] = "trwCqvuStrwC" })
			I[4] = new("TextLabel", I[3], "Amount", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(1, 1), Size = UDim2.new(1, -2, 0.725, -2), Text = "", TextColor3 = Color3.fromRGB(217, 217, 217), TextSize = 13, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Bottom, Visible = false, ZIndex = 23 }, { ["_lemonadeUniqueId"] = "NrJhIyNdNrJh" })
				I[5] = new("UIStroke", I[4], "UIStroke", { Thickness = 1.1381944, Transparency = 0.5 }, { ["_lemonadeUniqueId"] = "ZTnha63ZZTnh", ["oldp_Thickness"] = 1.5 })
			I[6] = new("Frame", I[3], "Mutations", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = -91, Position = UDim2.fromScale(0.0518519, 0), Size = UDim2.fromScale(0.6481481, 0.2518519), ZIndex = 555 }, { ["_lemonadeUniqueId"] = "mMSovAHBmMSo" })
				I[7] = new("ImageLabel", I[6], "Template", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), SizeConstraint = Enum.SizeConstraint.RelativeYY, Visible = false }, { ["_lemonadeUniqueId"] = "VrnUrHHHVrnU" })
				I[8] = new("UIListLayout", I[6], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0.01, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center }, { ["_lemonadeUniqueId"] = "2v3E1pWQ2v3E" })
		I[9] = new("Frame", I[1], "SelectionObjectClipper", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), Visible = false }, { ["_lemonadeUniqueId"] = "XnmaIIE8Xnma" })
			I[10] = new("ImageLabel", I[9], "Selector", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxasset://textures/ui/Keyboard/key_selection_9slice.png"), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(12, 12, 52, 52), SliceScale = 0.7587963 }, { ["_lemonadeUniqueId"] = "66FAySOO66FA", ["oldp_SliceScale"] = 1 })
		I[11] = new("ImageLabel", I[1], "Shadow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 20 }, { ["_lemonadeUniqueId"] = "ri3tTTlLri3t" })
		I[12] = new("ImageLabel", I[1], "Icon", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://71120564553448"), Position = UDim2.fromScale(0.5, 1), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), ZIndex = 22 }, { ["OldId"] = "rbxassetid://130302316617096", ["_lemonadeUniqueId"] = "s7QD8j0gs7QD" })
		I[13] = new("ImageLabel", I[1], "FavIcon", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://122201416359766"), Position = UDim2.fromScale(0.7346154, 0.077), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.2153846, 0.205432), Visible = false, ZIndex = 30 }, { ["_lemonadeUniqueId"] = "vWIlUlI6vWIl" })
		I[14] = new("TextLabel", I[1], "ToolName", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.9692309), Size = UDim2.fromScale(0.75, 0.25), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 25, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Bottom, ZIndex = 23 }, { ["_lemonadeUniqueId"] = "ZlUuR32gZlUu" })
			I[15] = new("UIStroke", I[14], "UIStroke", { Color = Color3.fromRGB(61, 61, 61), Thickness = 3 }, { ["_lemonadeUniqueId"] = "KeXiRwQsKeXi" })
		I[16] = new("TextLabel", I[1], "Weight", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(1, 0), Size = UDim2.fromScale(0.5, 0.2), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, TextYAlignment = Enum.TextYAlignment.Top, ZIndex = 23 }, { ["_lemonadeUniqueId"] = "OYejQKPDOYej" })
			I[17] = new("UIStroke", I[16], "UIStroke", { Thickness = 2 }, { ["_lemonadeUniqueId"] = "49XkVZ1D49Xk" })
		I[18] = new("ImageLabel", I[1], "Shadow_2", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://114192272550083"), ImageTransparency = 0.34, Position = UDim2.fromScale(0, 0.2), Size = UDim2.fromScale(1, 1), ZIndex = 2 }, { ["_lemonadeUniqueId"] = "ug7cJ63nug7c" })
		I[19] = new("UIScale", I[1], "ButtonUIScale", nil, { ["_lemonadeUniqueId"] = "tmjgj9Ywtmjg" })
		I[20] = new("UICorner", I[1], "UICorner", { BottomLeftRadius = UDim.new(0.1, 0), BottomRightRadius = UDim.new(0.1, 0), TopLeftRadius = UDim.new(0.1, 0), TopRightRadius = UDim.new(0.1, 0) }, { ["_lemonadeUniqueId"] = "hW7m9JIChW7m" })
		I[21] = new("UIStroke", I[1], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Thickness = 0 }, { ["_lemonadeUniqueId"] = "pyCR5nQ0pyCR", ["oldp_Thickness"] = 0 })
	return I[1]
end

return build
