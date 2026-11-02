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
	I[1] = new("ScreenGui", nil, "Cmdr", { AutoLocalize = false, DisplayOrder = 1000, ResetOnSpawn = false })
		I[2] = new("ScrollingFrame", I[1], "Frame", { AutomaticCanvasSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(17, 17, 17), BackgroundTransparency = 0.4, BorderSizePixel = 0, CanvasSize = UDim2.fromScale(0, 0), Position = UDim2.new(0.025, 0, 0, 25), ScrollBarThickness = 6, ScrollingDirection = Enum.ScrollingDirection.Y, Selectable = false, Size = UDim2.fromScale(0.95, 0), Visible = false })
			I[3] = new("UIListLayout", I[2], "UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder })
			I[4] = new("TextBox", I[2], "Line", { AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ClearTextOnFocus = false, FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.new(1, 0, 0, 20), TextColor3 = Color3.fromRGB(255, 255, 255), TextEditable = false, TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left })
			I[5] = new("UIPadding", I[2], "UIPadding", { PaddingBottom = UDim.new(0, 10), PaddingLeft = UDim.new(0, 10), PaddingRight = UDim.new(0, 10), PaddingTop = UDim.new(0, 10) })
			I[6] = new("Frame", I[2], "Entry", { BackgroundTransparency = 1, LayoutOrder = 999999999, Size = UDim2.new(1, 0, 0, 20) })
				I[7] = new("UIListLayout", I[6], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 7), SortOrder = Enum.SortOrder.LayoutOrder })
				I[8] = new("TextBox", I[6], "TextBox", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ClearTextOnFocus = false, FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 999999999, Position = UDim2.fromOffset(140, 0), Selectable = false, Size = UDim2.new(1, 0, 0, 20), Text = "x", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left })
				I[9] = new("TextLabel", I[6], "TextLabel", { AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromOffset(0, 20), Text = "", TextColor3 = Color3.fromRGB(255, 223, 93), TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left })
		I[10] = new("ScrollingFrame", I[1], "Autocomplete", { AutomaticCanvasSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(59, 59, 59), BackgroundTransparency = 0.5, BorderSizePixel = 0, CanvasSize = UDim2.fromScale(0, 0), Position = UDim2.fromOffset(167, 75), ScrollBarThickness = 6, ScrollingDirection = Enum.ScrollingDirection.Y, Selectable = false, Size = UDim2.fromOffset(200, 200), Visible = false })
			I[11] = new("UIListLayout", I[10], "UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder })
			I[12] = new("Frame", I[10], "Title", { BackgroundColor3 = Color3.fromRGB(59, 59, 59), BackgroundTransparency = 0.2, BorderSizePixel = 0, LayoutOrder = -2, Size = UDim2.new(1, 0, 0, 40) })
				I[13] = new("TextLabel", I[12], "Field", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.new(0, 37, 1, 0), Text = "from", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 20, TextXAlignment = Enum.TextXAlignment.Left })
					I[14] = new("TextLabel", I[13], "Type", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(255, 153, 153), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(1, 0), Size = UDim2.fromScale(0, 1), Text = ": Players", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 15, TextXAlignment = Enum.TextXAlignment.Left })
				I[15] = new("UIPadding", I[12], "UIPadding", { PaddingLeft = UDim.new(0, 10) })
			I[16] = new("Frame", I[10], "Description", { BackgroundColor3 = Color3.fromRGB(59, 59, 59), BackgroundTransparency = 0.2, BorderSizePixel = 0, LayoutOrder = -1, Size = UDim2.new(1, 0, 0, 20) })
				I[17] = new("TextLabel", I[16], "Label", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Light, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "The players to teleport. The players to teleport. The players to teleport. The players to teleport. ", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 16, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top })
				I[18] = new("UIPadding", I[16], "UIPadding", { PaddingBottom = UDim.new(0, 10), PaddingLeft = UDim.new(0, 10), PaddingRight = UDim.new(0, 10) })
			I[19] = new("TextButton", I[10], "TextButton", { BackgroundColor3 = Color3.fromRGB(59, 59, 59), BackgroundTransparency = 0.5, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.new(1, 0, 0, 30), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left })
				I[20] = new("TextLabel", I[19], "Typed", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "Lab", TextColor3 = Color3.fromRGB(131, 222, 255), TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left })
				I[21] = new("UIPadding", I[19], "UIPadding", { PaddingLeft = UDim.new(0, 10) })
				I[22] = new("TextLabel", I[19], "Suggest", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "   el", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left })
	return I[1]
end

return build
