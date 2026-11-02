-- Generated from ui/StarterGui/GreatBloomBanner.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "GreatBloomBanner", { DisplayOrder = 6, Enabled = false, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["_lemonadeUniqueId"] = "m0Q4qMaQm0Q4" })
		I[2] = new("Frame", I[1], "Banner", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(150, 70, 200), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.24), Size = UDim2.fromScale(1, 0.165) }, { ["_lemonadeUniqueId"] = "dT8I3r88dT8I" })
			I[3] = new("TextLabel", I[2], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.34), Size = UDim2.fromScale(0.9, 0.52), Text = "🌸 The Great Bloom has begun! 🌸", TextColor3 = Color3.fromRGB(255, 120, 210), TextScaled = true, TextWrapped = true }, { ["_lemonadeUniqueId"] = "6KrKnDQE6KrK" })
				I[4] = new("UIStroke", I[3], "UIStroke", { Color = Color3.fromRGB(60, 10, 60), Thickness = 4 }, { ["_lemonadeUniqueId"] = "yQfvoxa4yQfv" })
				I[5] = new("UIGradient", I[3], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 190, 235)), ColorSequenceKeypoint.new(0.45, Color3.fromRGB(255, 130, 215)), ColorSequenceKeypoint.new(1, Color3.fromRGB(235, 60, 170)) }), Rotation = 90 }, { ["_lemonadeUniqueId"] = "ONqU2mNjONqU" })
			I[6] = new("TextLabel", I[2], "Subtitle", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.76), Size = UDim2.fromScale(0.9, 0.3), Text = "Break trees, collect crystals, mutate your eggs!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true }, { ["_lemonadeUniqueId"] = "jnLJpAwKjnLJ" })
				I[7] = new("UIStroke", I[6], "UIStroke", { Color = Color3.fromRGB(60, 10, 60), Thickness = 3 }, { ["_lemonadeUniqueId"] = "KtdBjXVJKtdB" })
	return I[1]
end

return build
