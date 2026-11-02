-- Generated from ui/ReplicatedStorage/Assets/UI/FRAMEWORK/InfoOverlay/Blocks/CurrencyBoost.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "CurrencyBoost", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = 20, Size = UDim2.new(1, 0, 0, 32) })
		I[2] = new("TextLabel", I[1], "boost", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0.5601693, 0.5000001), RichText = true, Size = UDim2.fromScale(0.5, 1), Text = "+100%", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 20, TextWrapped = true })
			I[3] = new("UIGradient", I[2], "Coins", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(226, 130, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 241, 0)) }), Enabled = false, Rotation = -90 })
			I[4] = new("UIGradient", I[2], "Diamonds", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 226, 226)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 153, 255)) }), Enabled = false, Rotation = 90 })
			I[5] = new("UIGradient", I[2], "Xp", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 242)), ColorSequenceKeypoint.new(0.2266436, Color3.fromRGB(255, 113, 186)), ColorSequenceKeypoint.new(0.5484429, Color3.fromRGB(255, 183, 0)), ColorSequenceKeypoint.new(0.7283737, Color3.fromRGB(255, 183, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 106, 0)) }), Enabled = false, Rotation = 15 })
		I[6] = new("Configuration", I[1], "settings", nil, { ["boundsX"] = Vector2.new(65, 175) })
		I[7] = new("UIListLayout", I[1], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
		I[8] = new("ImageLabel", I[1], "icon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://108767181763013"), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.2593221, 1.0000001) })
	return I[1]
end

return build
