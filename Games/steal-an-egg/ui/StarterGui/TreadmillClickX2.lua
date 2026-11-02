-- Generated from ui/StarterGui/TreadmillClickX2.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "TreadmillClickX2", { AutoLocalize = false, ClipToDeviceSafeArea = false, ResetOnSpawn = false, SafeAreaCompatibility = Enum.SafeAreaCompatibility.None, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Visible = false })
			I[3] = new("Frame", I[2], "Left", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.202278, 0.5), Size = UDim2.fromScale(0.2001027, 1) })
			I[4] = new("Frame", I[2], "Right", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(1, 0), Size = UDim2.fromScale(0.2001027, 0.6426868) })
			I[5] = new("ImageButton", I[2], "Button", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://97807012114954"), Position = UDim2.fromScale(0.2921184, 0.1474672), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.4, 0.27) })
				I[6] = new("TextLabel", I[5], "CurrentBoost", { AnchorPoint = Vector2.new(0.5, 0.5), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(1.0433943, 0.7900001), Size = UDim2.fromScale(0.8840144, 0.4199998), Text = "x2", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 3 })
					I[7] = new("UIStroke", I[6], "UIStroke", { Thickness = 2.5 })
				I[8] = new("ImageLabel", I[5], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://94349314143333"), Position = UDim2.fromScale(0.496176, 0.4977942), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.6, 0.726) })
				I[9] = new("UIAspectRatioConstraint", I[5], "UIAspectRatioConstraint", { AspectRatio = 1.0683042 })
	return I[1]
end

return build
