-- Generated from ui/StarterPlayer/StarterPlayerScripts/UserInterface/BossHealthBar.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "BossHealthBar", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.new(0.05, 0, 0.95, -12), Size = UDim2.fromScale(3, 3) })
		I[2] = new("UIAspectRatioConstraint", I[1], "UIAspectRatioConstraint", { AspectRatio = 32 })
		I[3] = new("Frame", I[1], "Health", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(75, 127, 50), BackgroundTransparency = 0.5, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, -2, 1, -2), ZIndex = 2 })
			I[4] = new("Frame", I[3], "Bar", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(100, 255, 50), BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.new(0, -1, 0.5, 0), Size = UDim2.new(0.5, 2, 1, 2) })
				I[5] = new("UICorner", I[4], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
				I[6] = new("Frame", I[4], "Value", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(1, 0.5), Size = UDim2.fromScale(1, 1), SizeConstraint = Enum.SizeConstraint.RelativeYY })
					I[7] = new("TextLabel", I[6], "Title", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.875, 0.5), Size = UDim2.fromScale(3, 1), SizeConstraint = Enum.SizeConstraint.RelativeYY, Text = "150", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextTransparency = 0.75, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right })
				I[8] = new("UIStroke", I[4], "UIStroke", { Color = Color3.fromRGB(100, 255, 50), Thickness = 2 })
			I[9] = new("UICorner", I[3], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
			I[10] = new("UIStroke", I[3], "UIStroke", { Color = Color3.fromRGB(75, 127, 50), Thickness = 4 })
		I[11] = new("Frame", I[1], "Outline", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.25, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1.016, 2, 1.48, 2), ZIndex = -1 })
			I[12] = new("UICorner", I[11], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
		I[13] = new("TextLabel", I[1], "Title", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0, 0, 1.24, 2), Size = UDim2.fromScale(1, 1.5), Text = "Sensei Bot", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, ZIndex = 3 })
			I[14] = new("UIStroke", I[13], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 3, Transparency = 0.25 })
	return I[1]
end

return build
