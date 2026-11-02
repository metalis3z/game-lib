-- Generated from ui/ReplicatedStorage/Assets/UI/InfoHover/Components/Temporary.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Temporary", { BackgroundColor3 = Color3.fromRGB(199, 199, 199), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 15, Position = UDim2.fromScale(0.1065001, 0.7206029), Size = UDim2.fromScale(0.7869999, 0.121263), ZIndex = 1550 })
		I[2] = new("UIListLayout", I[1], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Bottom })
		I[3] = new("TextLabel", I[1], "Label", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0.2088774, 0.0609756), Size = UDim2.fromScale(1, 0.6), Text = "Temporary Reward", TextColor3 = Color3.fromRGB(255, 34, 82), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 1550 })
		I[4] = new("TextLabel", I[1], "Label", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0.2088774, 0.0609756), Size = UDim2.fromScale(1, 0.4), Text = "( 7 Days )", TextColor3 = Color3.fromRGB(255, 34, 82), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 1550 })
	return I[1]
end

return build
