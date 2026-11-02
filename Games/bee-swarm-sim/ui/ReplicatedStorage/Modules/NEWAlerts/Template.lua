-- Generated from ui/ReplicatedStorage/Modules/NEWAlerts/Template.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("TextLabel", nil, "Template", { BackgroundColor3 = Color3.fromRGB(81, 143, 197), BackgroundTransparency = 0.1, BorderColor3 = Color3.fromRGB(74, 130, 179), BorderMode = Enum.BorderMode.Inset, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(-0.5878774, 0.6686504), Size = UDim2.fromOffset(363, 39), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
		I[2] = new("TextLabel", I[1], "TextD", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(96, 166, 231), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(96, 166, 231), BorderMode = Enum.BorderMode.Inset, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.9), Text = "+10000000 Honey", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 42, TextStrokeTransparency = 0.95, TextWrapped = true, Visible = false })
		I[3] = new("IntValue", I[1], "Amount")
		I[4] = new("ImageLabel", I[1], "ImageLabel", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://17044203136"), Position = UDim2.new(0.072, -72, 0.526, 0), Size = UDim2.fromOffset(43, 43) })
		I[5] = new("UICorner", I[1], "UICorner", { BottomLeftRadius = UDim.new(0, 35), BottomRightRadius = UDim.new(0, 35), TopLeftRadius = UDim.new(0, 35), TopRightRadius = UDim.new(0, 35) })
		I[6] = new("UIGradient", I[1], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.4757785, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.482699, Color3.fromRGB(197, 197, 197)), ColorSequenceKeypoint.new(1, Color3.fromRGB(194, 194, 194)) }), Offset = Vector2.new(0, 0.2), Rotation = 86 })
		I[7] = new("UIStroke", I[1], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(35, 35, 35), Thickness = 4, Transparency = 0.4 })
	return I[1]
end

return build
