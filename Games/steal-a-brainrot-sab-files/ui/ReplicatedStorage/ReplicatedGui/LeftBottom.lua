-- Generated from ui/ReplicatedStorage/ReplicatedGui/LeftBottom.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "LeftBottom", { ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["_lemonadeUniqueId"] = "Bp3587zDBp35" }, { "ScreenGui" })
		I[2] = new("Frame", I[1], "LeftBottom", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 1), Size = UDim2.fromScale(1, 1) }, { ["_lemonadeUniqueId"] = "rtpJpw9PrtpJ" })
			I[3] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 2.1500001 }, { ["_lemonadeUniqueId"] = "8yeR1VYY8yeR" })
			I[4] = new("Frame", I[2], "Cashout", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.03, 0.872), Size = UDim2.fromScale(0.14, 0.1763474) }, { ["_lemonadeUniqueId"] = "L8j16PVBL8j1" })
				I[5] = new("UIListLayout", I[4], "UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Bottom }, { ["_lemonadeUniqueId"] = "6QeJW1Tn6QeJ" })
				I[6] = new("TextLabel", I[4], "Template", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 3, Position = UDim2.fromScale(0.01, 0.98), Size = UDim2.fromScale(1, 0.25), Text = "$30,000", TextColor3 = Color3.fromRGB(173, 0, 3), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, Visible = false }, { ["_lemonadeUniqueId"] = "4DfaqUg04Dfa" })
					I[7] = new("UIStroke", I[6], "UIStroke", { Thickness = 2.6611111 }, { ["OriginalThickness"] = 3, ["_lemonadeUniqueId"] = "P5u4tmEaP5u4" }, { "ScreenStroke", "UIStroke" })
			I[8] = new("TextLabel", I[2], "FriendBoost", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 3, Position = UDim2.fromScale(0.011687, 0.9899747), Size = UDim2.fromScale(0.16, 0.035), Text = "Friend Boost: +0%", TextColor3 = Color3.fromRGB(238, 238, 238), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left }, { ["_lemonadeUniqueId"] = "XvfYw6bVXvfY" })
				I[9] = new("UIStroke", I[8], "UIStroke", { Thickness = 1.7740741 }, { ["OriginalThickness"] = 2, ["_lemonadeUniqueId"] = "f8TjyVegf8Tj" }, { "ScreenStroke", "UIStroke" })
			I[10] = new("TextLabel", I[2], "Currency", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 3, Position = UDim2.fromScale(0.0091565, 0.968), Size = UDim2.fromScale(0.1596927, 0.095857), Text = "$100", TextColor3 = Color3.fromRGB(115, 255, 0), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left }, { ["_lemonadeUniqueId"] = "X42ubRbNX42u" })
				I[11] = new("UIStroke", I[10], "UIStroke", { Thickness = 2.6611111 }, { ["OriginalThickness"] = 3, ["_lemonadeUniqueId"] = "inYJhQ8IinYJ" }, { "ScreenStroke", "UIStroke" })
			I[12] = new("TextLabel", I[2], "CC", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 3, Position = UDim2.fromScale(0.011687, 0.9899747), Size = UDim2.fromScale(0.16, 0.035), Text = "CC Server", TextColor3 = Color3.fromRGB(238, 238, 238), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, Visible = false }, { ["_lemonadeUniqueId"] = "bw5JIshnbw5J" })
				I[13] = new("UIStroke", I[12], "UIStroke", { Thickness = 1.7740741 }, { ["OriginalThickness"] = 2, ["_lemonadeUniqueId"] = "C9gKPP9NC9gK" }, { "ScreenStroke", "UIStroke" })
			I[14] = new("TextLabel", I[2], "Speed", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 3, Position = UDim2.fromScale(0.04, 0.875), Size = UDim2.fromScale(0.139, 0.065), Text = "20", TextColor3 = Color3.fromRGB(105, 197, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, Visible = false }, { ["_lemonadeUniqueId"] = "mCWhfeQamCWh" })
				I[15] = new("UIStroke", I[14], "UIStroke", { Thickness = 2.6611111 }, { ["OriginalThickness"] = 3, ["_lemonadeUniqueId"] = "L3VFX5WCL3VF" }, { "ScreenStroke", "UIStroke" })
				I[16] = new("ImageLabel", I[14], "ImageLabel", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://79571919459802"), Position = UDim2.fromScale(-0.025, 0), Size = UDim2.fromScale(1, 1), SizeConstraint = Enum.SizeConstraint.RelativeYY }, { ["_lemonadeUniqueId"] = "ziXFOxG4ziXF" })
			I[17] = new("TextLabel", I[2], "CurrencyBrotinho", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 3, Position = UDim2.fromScale(0.04, 0.875), Size = UDim2.fromScale(0.139, 0.07), Text = "0", TextColor3 = Color3.fromRGB(255, 204, 1), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, Visible = false }, { ["_lemonadeUniqueId"] = "OtuZzcUOOtuZ" })
				I[18] = new("UIStroke", I[17], "UIStroke", { Thickness = 2.6611111 }, { ["OriginalThickness"] = 3, ["_lemonadeUniqueId"] = "aASm6hHPaASm" }, { "ScreenStroke", "UIStroke" })
				I[19] = new("ImageLabel", I[17], "ImageLabel", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://84857908414689"), Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(1.1, 1.1), SizeConstraint = Enum.SizeConstraint.RelativeYY }, { ["_lemonadeUniqueId"] = "fwAD2jlBfwAD" })
	return I[1]
end

return build
