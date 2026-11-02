-- Generated from ui/StarterGui/GroupReward.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "GroupReward", { ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["_lemonadeUniqueId"] = "zWBCdZyezWBC" })
		I[2] = new("Frame", I[1], "Tutorial", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 99, Position = UDim2.fromScale(0.5, 0.05), Size = UDim2.fromScale(1, 0.05) }, { ["_lemonadeUniqueId"] = "1QscTXZb1Qsc" })
			I[3] = new("TextLabel", I[2], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 3, Position = UDim2.fromScale(0, 0.7479148), RichText = true, Size = UDim2.fromScale(1, 1), Text = "Like the Game for FREE PETS!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "W3wDpQY2W3wD" })
				I[4] = new("UIStroke", I[3], "UIStroke", { Thickness = 2 }, { ["_lemonadeUniqueId"] = "7wtqs6FN7wtq" })
				I[5] = new("UIGradient", I[3], "RainbowGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 70, 70)), ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 180, 45)), ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 245, 70)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(70, 235, 120)), ColorSequenceKeypoint.new(0.67, Color3.fromRGB(65, 185, 255)), ColorSequenceKeypoint.new(0.83, Color3.fromRGB(140, 90, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 80, 210)) }) }, { ["_lemonadeUniqueId"] = "2D4TGaG82D4T" })
	return I[1]
end

return build
