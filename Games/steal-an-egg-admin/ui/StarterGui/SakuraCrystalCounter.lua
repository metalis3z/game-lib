-- Generated from ui/StarterGui/SakuraCrystalCounter.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "SakuraCrystalCounter", { DisplayOrder = 6, Enabled = false, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets }, { ["_lemonadeUniqueId"] = "RkkiuZ9lRkki" })
		I[2] = new("Frame", I[1], "Counter", { AnchorPoint = Vector2.new(0.5, 0), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.065), Size = UDim2.fromScale(0.1094211, 0.09) }, { ["_lemonadeUniqueId"] = "S0HLvblnS0HL" })
			I[3] = new("Frame", I[2], "Holder", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) }, { ["_lemonadeUniqueId"] = "TqagTxcqTqag" })
				I[4] = new("ImageButton", I[3], "Icon", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://97376774977217"), Position = UDim2.fromScale(0.02, 0.5), ScaleType = Enum.ScaleType.Fit, Selectable = false, Size = UDim2.fromScale(0.24, 0.7) }, { ["OldId"] = "rbxassetid://71612969542341", ["_lemonadeUniqueId"] = "91alDJJ191al" })
					I[5] = new("UICorner", I[4], "UICorner", { BottomLeftRadius = UDim.new(0.2, 0), BottomRightRadius = UDim.new(0.2, 0), TopLeftRadius = UDim.new(0.2, 0), TopRightRadius = UDim.new(0.2, 0) }, { ["_lemonadeUniqueId"] = "hi9PKYlDhi9P" })
				I[6] = new("TextLabel", I[3], "Count", { AnchorPoint = Vector2.new(0, 0.5), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3, 0.4948628), Size = UDim2.fromScale(0.1082251, 0.55), Text = "0", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left }, { ["_lemonadeUniqueId"] = "iYKdywmkiYKd" })
					I[7] = new("UIStroke", I[6], "UIStroke", { Thickness = 1.5 }, { ["_lemonadeUniqueId"] = "Zki23LmiZki2" })
				I[8] = new("UIListLayout", I[3], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.05, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center }, { ["_lemonadeUniqueId"] = "put7TbvRput7" })
			I[9] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 3 }, { ["_lemonadeUniqueId"] = "FgGX370eFgGX" })
			I[10] = new("TextLabel", I[2], "Gain", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.9553631, 0.3133623), Size = UDim2.fromScale(0.68, 0.34), Text = "+0", TextColor3 = Color3.fromRGB(255, 120, 200), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left }, { ["_lemonadeUniqueId"] = "Ltsv3E0wLtsv" })
				I[11] = new("UIStroke", I[10], "UIStroke", { Thickness = 1.5 }, { ["_lemonadeUniqueId"] = "saWnvKHZsaWn" })
	return I[1]
end

return build
