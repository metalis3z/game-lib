-- Generated from ui/StarterPlayer/StarterPlayerScripts/CL_MAIN_GameScript/Resources/MenuButton.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ImageButton", nil, "MenuButton", { BackgroundColor3 = Color3.fromRGB(0, 170, 255), BackgroundTransparency = 0.3, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderMode = Enum.BorderMode.Inset, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://156579757"), ImageTransparency = 0.75, Position = UDim2.fromScale(0, 0.75), Size = UDim2.fromScale(1, 0.25), ZIndex = 10 })
		I[2] = new("TextLabel", I[1], "Desc", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.25, 0.5), Size = UDim2.fromScale(0.75, 0.8), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.65, TextTransparency = 1, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 10 })
			I[3] = new("UIGradient", I[2], "TextGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.3311148, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(196, 196, 196)) }), Rotation = 90 })
		I[4] = new("ImageLabel", I[1], "Icon", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.25, 0.9), ZIndex = 10 })
			I[5] = new("UIGradient", I[4], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(127, 127, 127)), ColorSequenceKeypoint.new(0.0499168, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.9500831, Color3.fromRGB(127, 127, 127)), ColorSequenceKeypoint.new(1, Color3.fromRGB(64, 64, 64)) }), Rotation = 90 })
		I[6] = new("UICorner", I[1], "UICorner")
		I[7] = new("UIGradient", I[1], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(127, 127, 127)), ColorSequenceKeypoint.new(0.0499168, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.399654, Color3.fromRGB(254, 254, 254)), ColorSequenceKeypoint.new(0.9500831, Color3.fromRGB(127, 127, 127)), ColorSequenceKeypoint.new(1, Color3.fromRGB(64, 64, 64)) }), Rotation = 90 })
	return I[1]
end

return build
