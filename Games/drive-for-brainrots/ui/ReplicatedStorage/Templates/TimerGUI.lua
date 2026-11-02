-- Generated from ui/ReplicatedStorage/Templates/TimerGUI.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "TimerGUI", { Active = true, AlwaysOnTop = true, ClipsDescendants = true, MaxDistance = 128, Size = UDim2.fromScale(5, 1), SizeOffset = Vector2.new(0, 2) }, nil, { "CarHUD", "Appearable" })
		I[2] = new("Frame", I[1], "Bar", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.9), ZIndex = 5 })
			I[3] = new("Frame", I[2], "Progress", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(0.5, 1), ZIndex = 6 })
				I[4] = new("UIGradient", I[3], "Gradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 85, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 0)) }), Rotation = -90 })
				I[5] = new("UIStroke", I[3], "Stroke", { Color = Color3.fromRGB(120, 40, 0), Thickness = 3 })
			I[6] = new("UIStroke", I[2], "Stroke", { Thickness = 3 })
			I[7] = new("TextLabel", I[2], "Text", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.975, 0.75), Text = "10s", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 7 })
				I[8] = new("UIStroke", I[7], "Stroke", { Thickness = 3 })
	return I[1]
end

return build
