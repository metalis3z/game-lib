-- Generated from ui/StarterGui/BrainrotShopGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "BrainrotShopGui", { ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "MainFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.new(0.5, -250, 0.5, -200), Size = UDim2.fromOffset(500, 400), Visible = false })
			I[3] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0, 20), BottomRightRadius = UDim.new(0, 20), TopLeftRadius = UDim.new(0, 20), TopRightRadius = UDim.new(0, 20) })
			I[4] = new("UIStroke", I[2], "UIStroke", { Thickness = 3 })
			I[5] = new("Frame", I[2], "TitleBar", { BackgroundColor3 = Color3.fromRGB(25, 25, 45), BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 60) })
				I[6] = new("TextLabel", I[5], "TitleLabel", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(20, 0), Size = UDim2.new(1, -60, 1, 0), Text = "Admin Store", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 28, TextStrokeTransparency = 0.5 })
				I[7] = new("TextButton", I[5], "CloseButton", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0.986, -50, 0, 10), Size = UDim2.fromOffset(40, 40), Text = "X", TextColor3 = Color3.fromRGB(255, 0, 0), TextScaled = true, TextSize = 24, TextStrokeTransparency = 0, TextWrapped = true })
					I[8] = new("UICorner", I[7], "UICorner")
					I[9] = new("UIStroke", I[7], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(255, 0, 0), Thickness = 1.6 })
				I[10] = new("UICorner", I[5], "UICorner", { BottomLeftRadius = UDim.new(0, 20), BottomRightRadius = UDim.new(0, 20), TopLeftRadius = UDim.new(0, 20), TopRightRadius = UDim.new(0, 20) })
			I[11] = new("ScrollingFrame", I[2], "ItemsContainer", { AutomaticCanvasSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderSizePixel = 0, CanvasSize = UDim2.fromScale(0, 0), Position = UDim2.fromOffset(20, 70), ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0), ScrollBarThickness = 10, ScrollingDirection = Enum.ScrollingDirection.Y, Size = UDim2.new(1, -40, 1, -80) })
				I[12] = new("UICorner", I[11], "UICorner", { BottomLeftRadius = UDim.new(0, 15), BottomRightRadius = UDim.new(0, 15), TopLeftRadius = UDim.new(0, 15), TopRightRadius = UDim.new(0, 15) })
				I[13] = new("UIGridLayout", I[11], "UIGridLayout", { CellPadding = UDim2.fromOffset(15, 15), CellSize = UDim2.fromOffset(150, 170) })
				I[14] = new("UIPadding", I[11], "UIPadding", { PaddingLeft = UDim.new(0, 10), PaddingTop = UDim.new(0, 10) })
				I[15] = new("Frame", I[11], "Item_25", { BackgroundColor3 = Color3.fromRGB(40, 40, 55), BorderSizePixel = 0 })
					I[16] = new("UICorner", I[15], "UICorner", { BottomLeftRadius = UDim.new(0, 12), BottomRightRadius = UDim.new(0, 12), TopLeftRadius = UDim.new(0, 12), TopRightRadius = UDim.new(0, 12) })
					I[17] = new("UIStroke", I[15], "UIStroke", { Thickness = 2 })
					I[18] = new("TextLabel", I[15], "ItemName", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(0, 95), Size = UDim2.new(1, 0, 0, 25), Text = "Strawberry Harder", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 18 })
					I[19] = new("TextLabel", I[15], "PriceLabel", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(5, 120), Size = UDim2.new(0.5, 0, 0, 20), Text = "299", TextColor3 = Color3.fromRGB(255, 215, 0), TextSize = 16, TextXAlignment = Enum.TextXAlignment.Left })
					I[20] = new("TextButton", I[15], "BuyButton", { BackgroundColor3 = Color3.fromRGB(50, 200, 100), FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(1, -55, 0, 120), Size = UDim2.fromOffset(50, 25), Text = "Buy", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14 })
						I[21] = new("UICorner", I[20], "UICorner", { BottomLeftRadius = UDim.new(0, 6), BottomRightRadius = UDim.new(0, 6), TopLeftRadius = UDim.new(0, 6), TopRightRadius = UDim.new(0, 6) })
					I[22] = new("ViewportFrame", I[15], "ItemImage", { BackgroundColor3 = Color3.fromRGB(50, 50, 70), BorderSizePixel = 0, Position = UDim2.new(0.5, -40, 0, 10), Size = UDim2.fromOffset(80, 80) })
						I[23] = new("UICorner", I[22], "UICorner", { BottomLeftRadius = UDim.new(0, 10), BottomRightRadius = UDim.new(0, 10), TopLeftRadius = UDim.new(0, 10), TopRightRadius = UDim.new(0, 10) })
	return I[1]
end

return build
