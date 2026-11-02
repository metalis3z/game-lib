-- Generated from ui/ReplicatedStorage/Assets/UI/PlotUpgrade/FirstUpgradeInfo.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "FirstUpgradeInfo", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.05), Size = UDim2.fromScale(0.9, 0.4) }, { ["_lemonadeUniqueId"] = "nVtcpNHJnVtc" })
		I[2] = new("TextLabel", I[1], "Info", { AnchorPoint = Vector2.new(0.5, 0), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.35, 0.05), RichText = true, Size = UDim2.fromScale(0.6, 1), Text = "Unlock:", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "lk6Ht9oKlk6H" })
			I[3] = new("UIStroke", I[2], "UIStroke", { Thickness = 3 }, { ["_lemonadeUniqueId"] = "PUB37B42PUB3" })
		I[4] = new("ImageLabel", I[1], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://100053895191632"), LayoutOrder = 3, Position = UDim2.fromScale(0.8, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1) }, { ["_lemonadeUniqueId"] = "N4SjvkeIN4Sj" })
			I[5] = new("UIAspectRatioConstraint", I[4], "UIAspectRatioConstraint", nil, { ["_lemonadeUniqueId"] = "ASwBdSF7ASwB" })
	return I[1]
end

return build
