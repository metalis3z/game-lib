-- Generated from ui/ReplicatedStorage/Assets/UI/InfoHover/Components/Untradeable.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Untradeable", { BackgroundColor3 = Color3.fromRGB(199, 199, 199), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 15, Position = UDim2.fromScale(0.1050702, 0.8752909), Size = UDim2.fromScale(0.7867028, 0.0812586), ZIndex = 1550 })
		I[2] = new("UIListLayout", I[1], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Bottom })
		I[3] = new("TextLabel", I[1], "Label", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0.2088774, 0.0609756), Size = UDim2.fromScale(0.776, 0.8780488), Text = "Untradeable", TextColor3 = Color3.fromRGB(255, 34, 82), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 1550 })
		I[4] = new("ImageLabel", I[1], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(255, 34, 82), ImageContent = Content.fromUri("rbxassetid://71526219434061"), LayoutOrder = 1, Position = UDim2.fromScale(-0.011, -0.09375), Size = UDim2.fromScale(0.144, 0.8780488), ZIndex = 1550 })
		I[5] = new("ImageLabel", I[1], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(255, 34, 82), ImageContent = Content.fromUri("rbxassetid://71526219434061"), LayoutOrder = 3, Position = UDim2.fromScale(-0.011, -0.09375), Size = UDim2.fromScale(0.144, 0.8780488), ZIndex = 1550 })
	return I[1]
end

return build
