-- Generated from ui/StarterGui/NewScooter.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "NewScooter", { DisplayOrder = 20, Enabled = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Black", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(-0.5, -0.5), Size = UDim2.fromScale(2, 2) })
		I[3] = new("Frame", I[1], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) })
			I[4] = new("Frame", I[3], "Frame", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.45, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.3, 0.3), Size = UDim2.fromScale(0.4, 0.4) })
				I[5] = new("UICorner", I[4], "UICorner")
				I[6] = new("TextLabel", I[4], "NameLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0520833, 0.7999147), Size = UDim2.fromScale(0.8999999, 0.2), Text = "PLACEHOLDER SCOOTER", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[7] = new("UIStroke", I[6], "UIStroke", { Color = Color3.fromRGB(112, 112, 112), Thickness = 2.9000001 })
				I[8] = new("TextLabel", I[4], "Rarity", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0521664, 0.7412543), Size = UDim2.fromScale(0.8999999, 0.060577), Text = "COMMON", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[9] = new("UIStroke", I[8], "UIStroke", { Color = Color3.fromRGB(112, 112, 112) })
				I[10] = new("Frame", I[4], "IconHolder", { AnchorPoint = Vector2.new(0.275, 0.05), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.41, 0.05), Size = UDim2.fromScale(0.4492259, 0.6399317) })
					I[11] = new("UIAspectRatioConstraint", I[10], "UIAspectRatioConstraint")
					I[12] = new("UICorner", I[10], "UICorner", { BottomLeftRadius = UDim.new(0.1, 0), BottomRightRadius = UDim.new(0.1, 0), TopLeftRadius = UDim.new(0.1, 0), TopRightRadius = UDim.new(0.1, 0) })
					I[13] = new("ViewportFrame", I[10], "Icon", { BackgroundColor3 = Color3.fromRGB(200, 200, 200), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) })
				I[14] = new("TextLabel", I[4], "Duplicate", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0521664, -0.1121899), Size = UDim2.fromScale(0.9, 0.223233), Text = "DUPLICATE", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false })
					I[15] = new("UIStroke", I[14], "UIStroke", { Color = Color3.fromRGB(255, 234, 0), Thickness = 3 })
	return I[1]
end

return build
