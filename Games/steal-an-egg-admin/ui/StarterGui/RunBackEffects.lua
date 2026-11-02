-- Generated from ui/StarterGui/RunBackEffects.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "RunBackEffects", { DisplayOrder = 3, Enabled = false, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["_lemonadeUniqueId"] = "awNcjZP9awNc" })
		I[2] = new("Frame", I[1], "Run", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(77, 0, 1), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.075), Size = UDim2.fromScale(0.2121283, 0.10192) }, { ["_lemonadeUniqueId"] = "Nz4xyobxNz4x" })
			I[3] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0.3, 0), BottomRightRadius = UDim.new(0.3, 0), TopLeftRadius = UDim.new(0.3, 0), TopRightRadius = UDim.new(0.3, 0) }, { ["_lemonadeUniqueId"] = "I5Ec1DNNI5Ec" })
			I[4] = new("UIStroke", I[2], "UIStroke", { Color = Color3.fromRGB(255, 0, 4), Thickness = 2.5999999 }, { ["_lemonadeUniqueId"] = "Ukb3LKltUkb3" })
			I[5] = new("TextLabel", I[2], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "RUN!!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "4PfAfExF4PfA" })
				I[6] = new("UIStroke", I[5], "UIStroke", { Color = Color3.fromRGB(255, 0, 0), Thickness = 2.3 }, { ["_lemonadeUniqueId"] = "7IdO3yHf7IdO" })
			I[7] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 4.6561537 }, { ["_lemonadeUniqueId"] = "cKDuJSE2cKDu" })
		I[8] = new("ImageLabel", I[1], "Blur", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://92781008886078"), ImageTransparency = 0.62, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) }, { ["_lemonadeUniqueId"] = "RXaGK0LJRXaG" })
	return I[1]
end

return build
