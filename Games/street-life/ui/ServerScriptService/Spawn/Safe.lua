-- Generated from ui/ServerScriptService/Spawn/Safe.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Safe", { ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(50, 50, 50), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5062035), Size = UDim2.fromScale(0.3879013, 0.5719602) })
			I[3] = new("UIStroke", I[2], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Thickness = 2 })
			I[4] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0, 15), BottomRightRadius = UDim.new(0, 15), TopLeftRadius = UDim.new(0, 15), TopRightRadius = UDim.new(0, 15) })
			I[5] = new("TextLabel", I[2], "Logo", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3253389, -0.1220657), Size = UDim2.fromScale(0.3461052, 0.1220657), Text = "SAFE", TextColor3 = Color3.fromRGB(255, 0, 4), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[6] = new("UIStroke", I[5], "UIStroke", { Thickness = 3 })
			I[7] = new("TextLabel", I[2], "InventoryT", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5814567, 0.0163018), Size = UDim2.fromScale(0.3461052, 0.0821596), Text = "INVENTORY", TextColor3 = Color3.fromRGB(255, 0, 4), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[8] = new("UIStroke", I[7], "UIStroke", { Thickness = 2 })
			I[9] = new("TextLabel", I[2], "BackpackT", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0805072, 0.0163018), Size = UDim2.fromScale(0.3461052, 0.0821596), Text = "BACKPACK", TextColor3 = Color3.fromRGB(255, 0, 4), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[10] = new("UIStroke", I[9], "UIStroke", { Thickness = 2 })
			I[11] = new("BoolValue", I[2], "Cooldown")
			I[12] = new("ObjectValue", I[2], "Safe")
			I[13] = new("TextButton", I[2], "Close", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.9403203, 0), Size = UDim2.fromScale(0.0582499, 0.0867679), Text = "X", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[14] = new("UIStroke", I[13], "Around", { Thickness = 3 })
			I[15] = new("TextLabel", I[2], "Amount", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4266126, 0.9994094), Size = UDim2.fromScale(0.1548441, 0.0982046), Text = "5/5", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextTransparency = 0.5, TextWrapped = true })
				I[16] = new("UIStroke", I[15], "UIStroke", { Thickness = 3, Transparency = 0.5 })
			I[17] = new("Frame", I[2], "Line", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(0.0051916, 1.0000001) })
			I[18] = new("TextButton", I[2], "ButtonClone", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.75, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(-0.0199824, 0.0025358), Size = UDim2.fromScale(0.927, 0.02), Text = "Glock17", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false })
				I[19] = new("UICorner", I[18], "UICorner")
				I[20] = new("UIStroke", I[18], "Around", { Thickness = 2 })
				I[21] = new("UIStroke", I[18], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border })
				I[22] = new("Sound", I[18], "Press", { Volume = 0.8 })
				I[23] = new("Sound", I[18], "ERROR", { Volume = 1 })
			I[24] = new("ScrollingFrame", I[2], "Backpack", { Active = true, BackgroundColor3 = Color3.fromRGB(50, 50, 50), BackgroundTransparency = 0.25, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, CanvasSize = UDim2.fromScale(0, 5), Position = UDim2.fromScale(0.027, 0.116), ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0), Size = UDim2.fromScale(0.45, 0.866) })
				I[25] = new("UIStroke", I[24], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Thickness = 2 })
				I[26] = new("UIPadding", I[24], "UIPadding", { PaddingLeft = UDim.new(0, 20), PaddingTop = UDim.new(0, 5) })
				I[27] = new("UIListLayout", I[24], "UIListLayout", { Padding = UDim.new(0.003, 0), SortOrder = Enum.SortOrder.LayoutOrder })
				I[28] = new("UICorner", I[24], "UICorner", { BottomLeftRadius = UDim.new(0, 15), BottomRightRadius = UDim.new(0, 15), TopLeftRadius = UDim.new(0, 15), TopRightRadius = UDim.new(0, 15) })
			I[29] = new("ScrollingFrame", I[2], "Inventory", { Active = true, BackgroundColor3 = Color3.fromRGB(50, 50, 50), BackgroundTransparency = 0.25, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, CanvasSize = UDim2.fromScale(0, 5), Position = UDim2.fromScale(0.528597, 0.116), ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0), Size = UDim2.fromScale(0.45, 0.866) })
				I[30] = new("UIStroke", I[29], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Thickness = 2 })
				I[31] = new("UIPadding", I[29], "UIPadding", { PaddingLeft = UDim.new(0, 20), PaddingTop = UDim.new(0, 5) })
				I[32] = new("UIListLayout", I[29], "UIListLayout", { Padding = UDim.new(0.003, 0), SortOrder = Enum.SortOrder.LayoutOrder })
				I[33] = new("UICorner", I[29], "UICorner", { BottomLeftRadius = UDim.new(0, 15), BottomRightRadius = UDim.new(0, 15), TopLeftRadius = UDim.new(0, 15), TopRightRadius = UDim.new(0, 15) })
	return I[1]
end

return build
