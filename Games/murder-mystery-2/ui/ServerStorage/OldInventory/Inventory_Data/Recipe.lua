-- Generated from ui/ServerStorage/OldInventory/Inventory_Data/Recipe.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Recipe", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.new(1, -12, 0, 0), Size = UDim2.fromOffset(264, 136), ZIndex = 2 })
		I[2] = new("Frame", I[1], "Container", { BackgroundColor3 = Color3.fromRGB(56, 56, 56), BackgroundTransparency = 0.3, BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.fromOffset(3, 3), Size = UDim2.new(1, -6, 1, -6), ZIndex = 2 })
			I[3] = new("ImageLabel", I[2], "Item1", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.9, Position = UDim2.fromOffset(3, 3), Size = UDim2.fromOffset(60, 60), SizeConstraint = Enum.SizeConstraint.RelativeXX, ZIndex = 3 })
				I[4] = new("TextLabel", I[3], "Amount", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromOffset(-3, 3), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 18, TextStrokeTransparency = 0.9, TextXAlignment = Enum.TextXAlignment.Right, TextYAlignment = Enum.TextYAlignment.Top, ZIndex = 3 })
				I[5] = new("TextLabel", I[3], "ItemName", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0, 4, 0.65, 0), Size = UDim2.new(1, -8, 0.3, 0), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 28, TextStrokeTransparency = 0.7, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Bottom, ZIndex = 3 })
			I[6] = new("ImageLabel", I[2], "Item2", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.9, Position = UDim2.fromOffset(67, 3), Size = UDim2.fromOffset(60, 60), SizeConstraint = Enum.SizeConstraint.RelativeXX, ZIndex = 3 })
				I[7] = new("TextLabel", I[6], "Amount", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromOffset(-3, 3), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 18, TextStrokeTransparency = 0.9, TextXAlignment = Enum.TextXAlignment.Right, TextYAlignment = Enum.TextYAlignment.Top, ZIndex = 3 })
				I[8] = new("TextLabel", I[6], "ItemName", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0, 4, 0.65, 0), Size = UDim2.new(1, -8, 0.3, 0), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 28, TextStrokeTransparency = 0.7, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Bottom, ZIndex = 3 })
			I[9] = new("ImageLabel", I[2], "Item3", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.9, Position = UDim2.fromOffset(3, 67), Size = UDim2.fromOffset(60, 60), SizeConstraint = Enum.SizeConstraint.RelativeXX, ZIndex = 3 })
				I[10] = new("TextLabel", I[9], "Amount", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromOffset(-3, 3), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 18, TextStrokeTransparency = 0.9, TextXAlignment = Enum.TextXAlignment.Right, TextYAlignment = Enum.TextYAlignment.Top, ZIndex = 3 })
				I[11] = new("TextLabel", I[9], "ItemName", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0, 4, 0.65, 0), Size = UDim2.new(1, -8, 0.3, 0), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 28, TextStrokeTransparency = 0.7, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Bottom, ZIndex = 3 })
			I[12] = new("ImageLabel", I[2], "Item4", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.9, Position = UDim2.fromOffset(67, 67), Size = UDim2.fromOffset(60, 60), SizeConstraint = Enum.SizeConstraint.RelativeXX, ZIndex = 3 })
				I[13] = new("TextLabel", I[12], "Amount", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromOffset(-3, 3), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 18, TextStrokeTransparency = 0.9, TextXAlignment = Enum.TextXAlignment.Right, TextYAlignment = Enum.TextYAlignment.Top, ZIndex = 3 })
				I[14] = new("TextLabel", I[12], "ItemName", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0, 4, 0.65, 0), Size = UDim2.new(1, -8, 0.3, 0), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 28, TextStrokeTransparency = 0.7, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Bottom, ZIndex = 3 })
			I[15] = new("ImageLabel", I[2], "Result", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.9, Position = UDim2.fromOffset(131, 3), Size = UDim2.fromOffset(124, 124), SizeConstraint = Enum.SizeConstraint.RelativeXX, ZIndex = 3 })
				I[16] = new("TextLabel", I[15], "ItemName", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0, 4, 0.65, 0), Size = UDim2.new(1, -8, 0.3, 0), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 28, TextStrokeTransparency = 0.7, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Bottom, ZIndex = 3 })
				I[17] = new("TextLabel", I[15], "Amount", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromOffset(-3, 3), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 18, TextStrokeTransparency = 0.9, TextXAlignment = Enum.TextXAlignment.Right, TextYAlignment = Enum.TextYAlignment.Top, ZIndex = 3 })
			I[18] = new("TextLabel", I[2], "Plus", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromOffset(129, 129), Text = "+", TextColor3 = Color3.fromRGB(184, 184, 184), TextSize = 48, ZIndex = 4 })
			I[19] = new("TextLabel", I[2], "Equals", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(1, -195, 0, 0), Size = UDim2.fromOffset(129, 129), Text = "=", TextColor3 = Color3.fromRGB(184, 184, 184), TextSize = 48, ZIndex = 4 })
	return I[1]
end

return build
