-- Generated from ui/ReplicatedStorage/Assets/Billboards/EternalOverhead.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "EternalOverhead", { Active = true, MaxDistance = 80, ResetOnSpawn = false, Size = UDim2.fromScale(15, 6), StudsOffset = Vector3.new(0, 3.5, 0) })
		I[2] = new("TextLabel", I[1], "DisplayName", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.6), Size = UDim2.fromScale(1.0470001, 0.2), Text = "ETERNAL", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["DefaultState"] = true })
			I[3] = new("UIStroke", I[2], "UIStroke", { Thickness = 2, Transparency = 0.35 })
			I[4] = new("UIGradient", I[2], "Gradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(16, 73, 124)), ColorSequenceKeypoint.new(0.0237071, Color3.fromRGB(0, 16, 90)), ColorSequenceKeypoint.new(0.0237071, Color3.fromRGB(0, 16, 90)), ColorSequenceKeypoint.new(0.0914154, Color3.fromRGB(175, 201, 213)), ColorSequenceKeypoint.new(0.1955821, Color3.fromRGB(224, 240, 255)), ColorSequenceKeypoint.new(0.3414154, Color3.fromRGB(255, 180, 255)), ColorSequenceKeypoint.new(0.490721, Color3.fromRGB(68, 0, 127)), ColorSequenceKeypoint.new(0.521971, Color3.fromRGB(5, 1, 9)), ColorSequenceKeypoint.new(0.5271793, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.7424571, Color3.fromRGB(180, 255, 243)), ColorSequenceKeypoint.new(0.9646793, Color3.fromRGB(39, 159, 175)), ColorSequenceKeypoint.new(1, Color3.fromRGB(16, 73, 124)) }), Rotation = -90 }, { ["__gradient_style"] = "ChromeStroke" })
	return I[1]
end

return build
