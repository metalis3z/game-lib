-- Generated from ui/ReplicatedStorage/Assets/Killers/Nosferatu/Config/BloodUI.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "BloodUI", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.4861023, 0.8871508), Size = UDim2.fromScale(0.1722046, 0.1743017), Visible = false })
		I[2] = new("ImageLabel", I[1], "Blood", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://121087754705235"), Position = UDim2.fromScale(0.4999999, 0.1), Size = UDim2.new(0.28, -1, 0.7, 0) })
			I[3] = new("TextLabel", I[2], "Count", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Merriweather.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.1), Size = UDim2.fromScale(0.9999999, 0.7768596), Text = "300", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 20, TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 3 })
			I[4] = new("ImageLabel", I[2], "Fill", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(255, 0, 0), ImageContent = Content.fromUri("rbxassetid://121087754705235"), Position = UDim2.fromScale(0.5000001, 0.5082644), Size = UDim2.fromScale(0.8599999, 0.8834711), ZIndex = 2 })
				I[5] = new("UIGradient", I[4], "Gradient", { Rotation = -90 })
			I[6] = new("ImageLabel", I[2], "COOL", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(255, 0, 0), ImageContent = Content.fromUri("rbxassetid://70490437985609"), Position = UDim2.new(0.4999976, 0, 0.4999991, -1), ResampleMode = Enum.ResamplerMode.Pixelated, Size = UDim2.new(1.0000013, 0, 1.0000006, -1), ZIndex = 4 })
			I[7] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint")
	return I[1]
end

return build
