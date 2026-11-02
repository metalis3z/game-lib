-- Generated from ui/ReplicatedStorage/Assets/Extra/Data.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "Data", { Active = true, MaxDistance = 40, ResetOnSpawn = false, Size = UDim2.fromScale(15, 7) }, { ["_lemonadeUniqueId"] = "B0Wwm9F7B0Ww" }, { "Billboard" })
		I[2] = new("TextLabel", I[1], "DisplayName", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.52), Size = UDim2.fromScale(2.0999999, 0.12), Text = "Bandito Bobritto", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["DefaultState"] = true, ["_lemonadeUniqueId"] = "qlqJmzBtqlqJ" })
			I[3] = new("UIStroke", I[2], "UIStroke", { StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.1 }, { ["_lemonadeUniqueId"] = "VGEjUWzLVGEj" })
		I[4] = new("TextLabel", I[1], "PerSecond", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 5, Position = UDim2.fromScale(0.5, 0.6700001), Size = UDim2.fromScale(1.0462108, 0.1428571), Text = "$35/s", TextColor3 = Color3.fromRGB(87, 255, 41), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["DefaultState"] = true, ["_lemonadeUniqueId"] = "b4cwmm1Nb4cw" })
			I[5] = new("UIStroke", I[4], "UIStroke", { StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.1 }, { ["_lemonadeUniqueId"] = "ABWKerwaABWK" })
		I[6] = new("TextLabel", I[1], "Rarity", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 3, Position = UDim2.fromScale(0.5, 0.5700001), Size = UDim2.fromScale(1.046, 0.1), Text = "Rare", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false }, { ["DefaultState"] = true, ["_lemonadeUniqueId"] = "47j97phJ47j9" })
			I[7] = new("UIStroke", I[6], "UIStroke", { StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.1 }, { ["_lemonadeUniqueId"] = "PBCntLSOPBCn" })
		I[8] = new("TextLabel", I[1], "BaseMutation", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.21), Size = UDim2.fromScale(1.046, 0.1), Text = "Gold", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false }, { ["DefaultState"] = true, ["_lemonadeUniqueId"] = "McJrfVxBMcJr" })
			I[9] = new("UIStroke", I[8], "UIStroke", { StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.1 }, { ["_lemonadeUniqueId"] = "hjKUvwV5hjKU" })
		I[10] = new("TextLabel", I[1], "Odds", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0.5, 0.3700001), Size = UDim2.fromScale(1.046, 0.15), Text = "1/500k", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["DefaultState"] = true, ["_lemonadeUniqueId"] = "oZVFybYooZVF" })
			I[11] = new("UIStroke", I[10], "UIStroke", { StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.1 }, { ["_lemonadeUniqueId"] = "m2ZGukskm2ZG" })
		I[12] = new("TextLabel", I[1], "Padding", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 20, Position = UDim2.fromScale(0.5, 0.71), Size = UDim2.fromScale(1.0462108, 0.1428571), Text = "", TextColor3 = Color3.fromRGB(74, 222, 128), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["DefaultState"] = true, ["_lemonadeUniqueId"] = "T2K1afe2T2K1" })
			I[13] = new("UIStroke", I[12], "UIStroke", { StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.1 }, { ["_lemonadeUniqueId"] = "orOPS515orOP" })
		I[14] = new("Frame", I[1], "Mutations", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = -91, Position = UDim2.fromScale(0.5, 0.22), Size = UDim2.fromScale(1.2550832, 0.1468254) }, { ["_lemonadeUniqueId"] = "f4Orxf28f4Or" })
			I[15] = new("UIListLayout", I[14], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.01, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center }, { ["_lemonadeUniqueId"] = "VTzvZEiwVTzv" })
			I[16] = new("ImageLabel", I[14], "Template", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), SizeConstraint = Enum.SizeConstraint.RelativeYY, Visible = false }, { ["_lemonadeUniqueId"] = "hebpmyPNhebp" })
	return I[1]
end

return build
