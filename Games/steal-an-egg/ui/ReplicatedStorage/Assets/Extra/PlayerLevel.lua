-- Generated from ui/ReplicatedStorage/Assets/Extra/PlayerLevel.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "PlayerLevel", { Active = true, ClipsDescendants = true, LightInfluence = 1, MaxDistance = 200, Size = UDim2.fromScale(5, 0.75), SizeOffset = Vector2.new(0, 1), StudsOffset = Vector3.new(0, 3, 0), ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("TextLabel", I[1], "Display", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "Lvl. 1", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 11 })
			I[3] = new("UIGradient", I[2], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(166, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 255, 0)) }), Enabled = false, Rotation = 80 })
			I[4] = new("UIStroke", I[2], "UIStroke", { Thickness = 2.2 })
	return I[1]
end

return build
