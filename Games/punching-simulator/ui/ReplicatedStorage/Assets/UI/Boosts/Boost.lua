-- Generated from ui/ReplicatedStorage/Assets/UI/Boosts/Boost.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Boost", { BackgroundColor3 = Color3.fromRGB(28, 69, 82), BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.new(1, 0, 0.02, 10) })
		I[2] = new("UICorner", I[1], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
		I[3] = new("TextLabel", I[1], "TimeLeft", { AnchorPoint = Vector2.new(1, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(1, 1), Size = UDim2.fromScale(1, 0.33), Text = "30m", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Bottom, ZIndex = 2 })
			I[4] = new("UIStroke", I[3], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2 })
		I[5] = new("UIAspectRatioConstraint", I[1], "UIAspectRatioConstraint")
		I[6] = new("ImageLabel", I[1], "Icon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://13815215971"), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1) })
	return I[1]
end

return build
