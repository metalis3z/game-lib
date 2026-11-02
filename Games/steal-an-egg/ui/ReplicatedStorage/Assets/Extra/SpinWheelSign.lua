-- Generated from ui/ReplicatedStorage/Assets/Extra/SpinWheelSign.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "SpinWheelSign", { Active = true, LightInfluence = 1, MaxDistance = 100, ResetOnSpawn = false, Size = UDim2.fromScale(15, 5), StudsOffsetWorldSpace = Vector3.new(0, 10.5, 0), ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("TextLabel", I[1], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 0.5), Text = "Bloodmoon Spin", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[3] = new("UIGradient", I[2], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 28, 28)), ColorSequenceKeypoint.new(1, Color3.fromRGB(229, 0, 0)) }), Rotation = 90 })
			I[4] = new("UIStroke", I[2], "UIStroke", { Thickness = 2.5 })
		I[5] = new("TextLabel", I[1], "Timer", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.62), Size = UDim2.fromScale(1.2, 0.3), Text = "Free Spin In 25m 57s", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[6] = new("UIStroke", I[5], "UIStroke", { Thickness = 2.5 })
	return I[1]
end

return build
