-- Generated from ui/ReplicatedStorage/Assets/Models/Sakura/BloomWaypoint.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "BloomWaypoint", { Active = true, AlwaysOnTop = true, Brightness = 2, ClipsDescendants = true, MaxDistance = 5000, ResetOnSpawn = false, Size = UDim2.fromOffset(220, 70), ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["_lemonadeUniqueId"] = "0Rv7y9Ce0Rv7" })
		I[2] = new("TextLabel", I[1], "DisplayText", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(0.9, 0.4), Text = "🌸 The Great Bloom", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "9BUi5nNp9BUi" })
			I[3] = new("UIGradient", I[2], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 255)), ColorSequenceKeypoint.new(0.1278066, Color3.fromRGB(2, 7, 255)), ColorSequenceKeypoint.new(0.4559585, Color3.fromRGB(0, 170, 255)), ColorSequenceKeypoint.new(0.5595855, Color3.fromRGB(81, 244, 255)), ColorSequenceKeypoint.new(0.5647668, Color3.fromRGB(85, 255, 255)), ColorSequenceKeypoint.new(0.6338515, Color3.fromRGB(0, 170, 255)), ColorSequenceKeypoint.new(0.8411053, Color3.fromRGB(2, 5, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 255)) }), Rotation = 90 }, { ["_lemonadeUniqueId"] = "Je5DjCzDJe5D" })
			I[4] = new("UIStroke", I[2], "UIStroke", { Thickness = 1.5 }, { ["_lemonadeUniqueId"] = "ao4cjOSKao4c" })
		I[5] = new("TextLabel", I[1], "Countdown", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0.5, 0.4), Size = UDim2.fromScale(0.9, 0.3), Text = "500 studs", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "uiI6iOcguiI6" })
			I[6] = new("UIGradient", I[5], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(186, 186, 186)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }), Rotation = 90 }, { ["_lemonadeUniqueId"] = "rKhLeCJHrKhL" })
			I[7] = new("UIStroke", I[5], "UIStroke", { Thickness = 2.3 }, { ["_lemonadeUniqueId"] = "BojCXYAgBojC" })
	return I[1]
end

return build
