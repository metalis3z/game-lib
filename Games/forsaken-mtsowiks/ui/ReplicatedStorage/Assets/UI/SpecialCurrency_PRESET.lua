-- Generated from ui/ReplicatedStorage/Assets/UI/SpecialCurrency_PRESET.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ImageLabel", nil, "SpecialCurrency_PRESET", { AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://18989812311"), LayoutOrder = 1, Size = UDim2.fromScale(1.5, 0.07) })
		I[2] = new("TextLabel", I[1], "CurrentBalance", { AnchorPoint = Vector2.new(0, 0.5), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/AccanthisADFStd.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LineHeight = 1.25, Position = UDim2.fromScale(0.25, 0.5), RichText = true, Size = UDim2.fromScale(0.75, 0.8), Text = "123", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 30, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
			I[3] = new("UIPadding", I[2], "UIPadding", { PaddingTop = UDim.new(-0.075, 0) })
		I[4] = new("ImageLabel", I[1], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://131194603531359"), Position = UDim2.fromScale(0.125, 0.5), Size = UDim2.fromScale(0.25, 0.75) })
			I[5] = new("UIAspectRatioConstraint", I[4], "UIAspectRatioConstraint")
			I[6] = new("UIPadding", I[4], "UIPadding", { PaddingRight = UDim.new(-0.1, 0), PaddingTop = UDim.new(-0.2, 0) })
	return I[1]
end

return build
