-- Generated from ui/StarterPlayer/StarterPlayerScripts/UserInterface/AmmoDisplay.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "AmmoDisplay", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, LayoutOrder = -1, Position = UDim2.new(0.65, -24, 0.95, 0), Size = UDim2.fromScale(0.275, 0.275) })
		I[2] = new("ImageLabel", I[1], "AmmoIcon", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://16539130428"), Position = UDim2.new(1.075, 135, 0.4, 0), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.4, 0.25) })
		I[3] = new("ImageLabel", I[1], "WeaponIcon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://13197584241"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Crop, Size = UDim2.fromScale(3, 3), SliceCenter = Rect.new(15, 15, 16, 16), ZIndex = 0 })
		I[4] = new("TextLabel", I[1], "Ammo", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(1.075, 0.28), Size = UDim2.fromScale(1.8, 0.9), Text = "∞", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 3 })
			I[5] = new("UIStroke", I[4], "UIStroke", { Transparency = 0.875 })
		I[6] = new("TextLabel", I[1], "Reserve", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(1.075, 77, 0.4, 0), Size = UDim2.fromScale(1.8, 0.25), Text = " / 30", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 3 })
			I[7] = new("UIStroke", I[6], "UIStroke", { Transparency = 0.875 })
		I[8] = new("Frame", I[1], "NameContainer", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.fromScale(1.05, 0.75), Size = UDim2.fromScale(2.5, 0.4) })
			I[9] = new("TextLabel", I[8], "Title", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(14, 1), SizeConstraint = Enum.SizeConstraint.RelativeYY, Text = "Assault Rifle", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
				I[10] = new("UIStroke", I[9], "UIStroke", { Thickness = 2, Transparency = 0.875 })
	return I[1]
end

return build
