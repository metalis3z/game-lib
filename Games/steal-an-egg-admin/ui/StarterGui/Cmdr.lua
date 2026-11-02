-- Generated from ui/StarterGui/Cmdr.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Cmdr", { AutoLocalize = false, DisplayOrder = 1000, Enabled = false, ResetOnSpawn = false }, { ["_lemonadeUniqueId"] = "QAaMmdqwQAaM" })
		I[2] = new("ScrollingFrame", I[1], "Frame", { AutomaticCanvasSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(17, 17, 17), BackgroundTransparency = 0.4, BorderSizePixel = 0, CanvasSize = UDim2.fromScale(0, 0), Position = UDim2.new(0.025, 0, 0, 25), ScrollBarThickness = 6, ScrollingDirection = Enum.ScrollingDirection.Y, Selectable = false, Size = UDim2.fromScale(0.95, 0), Visible = false }, { ["_lemonadeUniqueId"] = "vDOOmxGUvDOO" })
			I[3] = new("TextBox", I[2], "Line", { AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ClearTextOnFocus = false, FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.new(1, 0, 0, 20), TextColor3 = Color3.fromRGB(255, 255, 255), TextEditable = false, TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left }, { ["_lemonadeUniqueId"] = "4xRHvhsy4xRH" })
			I[4] = new("Frame", I[2], "Entry", { BackgroundTransparency = 1, LayoutOrder = 999999999, Size = UDim2.new(1, 0, 0, 20) }, { ["_lemonadeUniqueId"] = "eNhR0vqOeNhR" })
				I[5] = new("TextBox", I[4], "TextBox", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ClearTextOnFocus = false, FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 999999999, Position = UDim2.fromOffset(140, 0), Selectable = false, Size = UDim2.new(1, 0, 0, 20), Text = "x", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left }, { ["_lemonadeUniqueId"] = "5nBvhY5r5nBv" })
				I[6] = new("TextLabel", I[4], "TextLabel", { AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromOffset(0, 20), Text = "", TextColor3 = Color3.fromRGB(255, 223, 93), TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left }, { ["_lemonadeUniqueId"] = "JlQiHvUeJlQi" })
				I[7] = new("UIListLayout", I[4], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 7), SortOrder = Enum.SortOrder.LayoutOrder }, { ["_lemonadeUniqueId"] = "ZeyeGvpHZeye" })
			I[8] = new("UIPadding", I[2], "UIPadding", { PaddingBottom = UDim.new(0, 10), PaddingLeft = UDim.new(0, 10), PaddingRight = UDim.new(0, 10), PaddingTop = UDim.new(0, 10) }, { ["_lemonadeUniqueId"] = "eR1tcj4KeR1t" })
			I[9] = new("UIListLayout", I[2], "UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder }, { ["_lemonadeUniqueId"] = "GIQH46n3GIQH" })
		I[10] = new("ScrollingFrame", I[1], "Autocomplete", { AutomaticCanvasSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(59, 59, 59), BackgroundTransparency = 0.5, BorderSizePixel = 0, CanvasSize = UDim2.fromScale(0, 0), Position = UDim2.fromOffset(167, 75), ScrollBarThickness = 6, ScrollingDirection = Enum.ScrollingDirection.Y, Selectable = false, Size = UDim2.fromOffset(200, 200), Visible = false }, { ["_lemonadeUniqueId"] = "bjtUH00ibjtU" })
			I[11] = new("Frame", I[10], "Title", { BackgroundColor3 = Color3.fromRGB(59, 59, 59), BackgroundTransparency = 0.2, BorderSizePixel = 0, LayoutOrder = -2, Size = UDim2.new(1, 0, 0, 40) }, { ["_lemonadeUniqueId"] = "tbp8S9Aktbp8" })
				I[12] = new("UIPadding", I[11], "UIPadding", { PaddingLeft = UDim.new(0, 10) }, { ["_lemonadeUniqueId"] = "OcOTj5X1OcOT" })
				I[13] = new("TextLabel", I[11], "Field", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.new(0, 37, 1, 0), Text = "from", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 20, TextXAlignment = Enum.TextXAlignment.Left }, { ["_lemonadeUniqueId"] = "6l43Ib6Y6l43" })
					I[14] = new("TextLabel", I[13], "Type", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(255, 153, 153), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(1, 0), Size = UDim2.fromScale(0, 1), Text = ": Players", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 15, TextXAlignment = Enum.TextXAlignment.Left }, { ["_lemonadeUniqueId"] = "ZilKd0saZilK" })
			I[15] = new("Frame", I[10], "Description", { BackgroundColor3 = Color3.fromRGB(59, 59, 59), BackgroundTransparency = 0.2, BorderSizePixel = 0, LayoutOrder = -1, Size = UDim2.new(1, 0, 0, 20) }, { ["_lemonadeUniqueId"] = "2QmxbodN2Qmx" })
				I[16] = new("TextLabel", I[15], "Label", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Light, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "The players to teleport. The players to teleport. The players to teleport. The players to teleport. ", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 16, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top }, { ["_lemonadeUniqueId"] = "HWRvTKcWHWRv" })
				I[17] = new("UIPadding", I[15], "UIPadding", { PaddingBottom = UDim.new(0, 10), PaddingLeft = UDim.new(0, 10), PaddingRight = UDim.new(0, 10) }, { ["_lemonadeUniqueId"] = "BW1gVA68BW1g" })
			I[18] = new("TextButton", I[10], "TextButton", { BackgroundColor3 = Color3.fromRGB(59, 59, 59), BackgroundTransparency = 0.5, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.new(1, 0, 0, 30), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left }, { ["_lemonadeUniqueId"] = "7j8TeeTZ7j8T" })
				I[19] = new("TextLabel", I[18], "Typed", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "Lab", TextColor3 = Color3.fromRGB(131, 222, 255), TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left }, { ["_lemonadeUniqueId"] = "PjKgagxpPjKg" })
				I[20] = new("UIPadding", I[18], "UIPadding", { PaddingLeft = UDim.new(0, 10) }, { ["_lemonadeUniqueId"] = "B7yvLYhhB7yv" })
				I[21] = new("TextLabel", I[18], "Suggest", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "   el", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left }, { ["_lemonadeUniqueId"] = "75gMhtqU75gM" })
			I[22] = new("UIListLayout", I[10], "UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder }, { ["_lemonadeUniqueId"] = "0b8ukI060b8u" })
	return I[1]
end

return build
