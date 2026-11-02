-- Generated from ui/ReplicatedStorage/Assets/UI/Misc/Info/Blocks/Rarity.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Rarity", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = 5, Size = UDim2.new(1, 0, 0, 22) }, { ["_lemonadeUniqueId"] = "4FIkWkVX4FIk" })
		I[2] = new("TextLabel", I[1], "title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LineHeight = 0.9, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "Rare", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 22, TextWrapped = true }, { ["_lemonadeUniqueId"] = "P5O8G5VVP5O8" })
			I[3] = new("UIStroke", I[2], "UIStroke", { Color = Color3.fromRGB(76, 76, 76), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2 }, { ["_lemonadeUniqueId"] = "x6aIVuCkx6aI" })
				I[4] = new("UIGradient", I[3], "Tier Gradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(113, 255, 62)), ColorSequenceKeypoint.new(1, Color3.fromRGB(113, 255, 62)) }), Rotation = 100 }, { ["_lemonadeUniqueId"] = "Ki0IA0jRKi0I" })
			I[5] = new("UIGradient", I[2], "Tier Gradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(113, 255, 62)), ColorSequenceKeypoint.new(1, Color3.fromRGB(113, 255, 62)) }), Rotation = 100 }, { ["_lemonadeUniqueId"] = "GMnOsQFLGMnO" })
	return I[1]
end

return build
