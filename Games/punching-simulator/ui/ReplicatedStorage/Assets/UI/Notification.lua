-- Generated from ui/ReplicatedStorage/Assets/UI/Notification.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("TextLabel", nil, "Notification", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.475), Size = UDim2.fromScale(1.5, 0.3), Text = "You need 39.8K Strength to use this Training Area!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 35, TextStrokeColor3 = Color3.fromRGB(72, 72, 72), TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 4 })
		I[2] = new("UIStroke", I[1], "UIStroke", { Thickness = 3 })
		I[3] = new("UIScale", I[1], "UIScale")
		I[4] = new("UIGradient", I[1], "White", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(182, 182, 182)), ColorSequenceKeypoint.new(0.545, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }), Rotation = -90 })
	return I[1]
end

return build
