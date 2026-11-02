-- Generated from ui/StarterGui/DragonEggEventUI.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "DragonEggEventUI", { Enabled = false, ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["_lemonadeUniqueId"] = "wf0N4U0Ywf0N" })
		I[2] = new("TextLabel", I[1], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0), RichText = true, Size = UDim2.fromScale(0.7283348, 0.057613), Text = "The Dragon Lair has opened!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 60, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Top, ZIndex = 5 }, { ["_lemonadeUniqueId"] = "nH5NdfKUnH5N" })
			I[3] = new("UIStroke", I[2], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.0645161 }, { ["_lemonadeUniqueId"] = "D1uX0z6qD1uX" })
			I[4] = new("UIGradient", I[2], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 157, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(243, 0, 0)) }), Rotation = 90 }, { ["_lemonadeUniqueId"] = "GrKjUlG4GrKj" })
		I[5] = new("TextLabel", I[1], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.06), RichText = true, Size = UDim2.fromScale(0.728, 0.0327708), Text = "Steal eggs and bring them back to your nest!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 60, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Top, ZIndex = 5 }, { ["_lemonadeUniqueId"] = "JKBYCe4gJKBY" })
			I[6] = new("UIStroke", I[5], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.1176471 }, { ["_lemonadeUniqueId"] = "nmMUoqO6nmMU" })
	return I[1]
end

return build
