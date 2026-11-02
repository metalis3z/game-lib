-- Generated from ui/ReplicatedStorage/Assets/UI/InfoHover/Components/Multiplier.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Multiplier", { BackgroundColor3 = Color3.fromRGB(199, 199, 199), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 7, Position = UDim2.fromScale(0.1050702, 0.8752909), Size = UDim2.fromScale(1, 0.081), ZIndex = 1550 })
		I[2] = new("ImageLabel", I[1], "CurrencyIcon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://110346817492414"), Position = UDim2.fromScale(0.035, 0.0304878), Size = UDim2.fromScale(0.1371573, 1.0803609), ZIndex = 1550 })
		I[3] = new("UIListLayout", I[1], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
		I[4] = new("TextLabel", I[1], "Label", { AutomaticSize = Enum.AutomaticSize.XY, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 7, Position = UDim2.fromScale(0.1769602, 0.0853656), Size = UDim2.new(0, 50, 1, 0), Text = "x10.9K Clicks", TextColor3 = Color3.fromRGB(0, 32, 54), TextSize = 32, ZIndex = 1550 })
	return I[1]
end

return build
