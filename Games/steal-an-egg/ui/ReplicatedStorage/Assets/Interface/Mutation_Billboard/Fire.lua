-- Generated from ui/ReplicatedStorage/Assets/Interface/Mutation_Billboard/Fire.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("TextLabel", nil, "Fire", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LayoutOrder = 6, Size = UDim2.fromScale(0.06, 1), Text = "FIRE", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
		I[2] = new("UIGradient", I[1], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 183, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 38, 0)) }), Rotation = 90 })
		I[3] = new("UIStroke", I[1], "UIStroke", { Thickness = 2.4000001 })
	return I[1]
end

return build
