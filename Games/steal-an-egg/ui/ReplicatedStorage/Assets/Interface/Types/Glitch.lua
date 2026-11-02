-- Generated from ui/ReplicatedStorage/Assets/Interface/Types/Glitch.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("TextLabel", nil, "Glitch", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LayoutOrder = -2, Size = UDim2.fromScale(1, 0.2), Text = "ELECTRIC", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
		I[2] = new("UIGradient", I[1], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 4)), ColorSequenceKeypoint.new(0.140138, Color3.fromRGB(240, 0, 4)), ColorSequenceKeypoint.new(0.143599, Color3.fromRGB(33, 0, 217)), ColorSequenceKeypoint.new(0.285467, Color3.fromRGB(0, 0, 224)), ColorSequenceKeypoint.new(0.290657, Color3.fromRGB(60, 255, 0)), ColorSequenceKeypoint.new(0.467128, Color3.fromRGB(60, 255, 0)), ColorSequenceKeypoint.new(0.472318, Color3.fromRGB(238, 0, 234)), ColorSequenceKeypoint.new(0.650519, Color3.fromRGB(238, 0, 234)), ColorSequenceKeypoint.new(0.655709, Color3.fromRGB(251, 255, 0)), ColorSequenceKeypoint.new(0.83218, Color3.fromRGB(251, 255, 0)), ColorSequenceKeypoint.new(0.840831, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) }), Rotation = 90 })
		I[3] = new("UIStroke", I[1], "UIStroke", { Thickness = 3 })
	return I[1]
end

return build
