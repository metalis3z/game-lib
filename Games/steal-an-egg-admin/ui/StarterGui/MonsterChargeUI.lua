-- Generated from ui/StarterGui/MonsterChargeUI.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "MonsterChargeUI", { DisplayOrder = 25, Enabled = false, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["MonsterParasitePlaceholder"] = true, ["_lemonadeUniqueId"] = "LikQxU0sLikQ" })
		I[2] = new("Frame", I[1], "Root", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(39, 25, 51), Position = UDim2.fromScale(0.5, 0.045), Size = UDim2.fromOffset(440, 112) }, { ["_lemonadeUniqueId"] = "59cHFhp359cH" })
			I[3] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0, 22), BottomRightRadius = UDim.new(0, 22), TopLeftRadius = UDim.new(0, 22), TopRightRadius = UDim.new(0, 22) }, { ["_lemonadeUniqueId"] = "KCh7kp2SKCh7" })
			I[4] = new("UIStroke", I[2], "UIStroke", { Color = Color3.fromRGB(143, 255, 84), Thickness = 4 }, { ["_lemonadeUniqueId"] = "BrZYLTgEBrZY" })
			I[5] = new("UIGradient", I[2], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(62, 38, 80)), ColorSequenceKeypoint.new(1, Color3.fromRGB(26, 18, 34)) }), Rotation = 90 }, { ["_lemonadeUniqueId"] = "338RvaP1338R" })
			I[6] = new("TextLabel", I[2], "Status", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(20, 8), Size = UDim2.new(0.62, 0, 0, 30), Text = "MONSTER CHARGE", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 22, TextStrokeColor3 = Color3.fromRGB(31, 15, 42), TextStrokeTransparency = 0 }, { ["_lemonadeUniqueId"] = "8eTfnLNP8eTf" })
			I[7] = new("TextLabel", I[2], "Timer", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.new(0.68, 0, 0, 10), Size = UDim2.new(0.3, 0, 0, 26), Text = "7d 0h", TextColor3 = Color3.fromRGB(209, 255, 137), TextSize = 18, TextStrokeColor3 = Color3.fromRGB(31, 15, 42), TextStrokeTransparency = 0 }, { ["_lemonadeUniqueId"] = "usxLMQjtusxL" })
			I[8] = new("Frame", I[2], "Bar", { BackgroundColor3 = Color3.fromRGB(18, 13, 25), ClipsDescendants = true, Position = UDim2.fromOffset(20, 49), Size = UDim2.new(1, -40, 0, 43) }, { ["_lemonadeUniqueId"] = "Xk6WqJlVXk6W" })
				I[9] = new("UICorner", I[8], "UICorner", { BottomLeftRadius = UDim.new(0, 14), BottomRightRadius = UDim.new(0, 14), TopLeftRadius = UDim.new(0, 14), TopRightRadius = UDim.new(0, 14) }, { ["_lemonadeUniqueId"] = "4pQ3KUEC4pQ3" })
				I[10] = new("UIStroke", I[8], "UIStroke", { Color = Color3.fromRGB(15, 10, 20), Thickness = 3 }, { ["_lemonadeUniqueId"] = "aqUxeJ9laqUx" })
				I[11] = new("Frame", I[8], "Fill", { BackgroundColor3 = Color3.fromRGB(116, 235, 69), BorderSizePixel = 0, Size = UDim2.fromScale(0, 1) }, { ["_lemonadeUniqueId"] = "ayJhFZZDayJh" })
					I[12] = new("UICorner", I[11], "UICorner", { BottomLeftRadius = UDim.new(0, 12), BottomRightRadius = UDim.new(0, 12), TopLeftRadius = UDim.new(0, 12), TopRightRadius = UDim.new(0, 12) }, { ["_lemonadeUniqueId"] = "YXyYUfmmYXyY" })
					I[13] = new("UIGradient", I[11], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(81, 191, 53)), ColorSequenceKeypoint.new(0.55, Color3.fromRGB(198, 255, 73)), ColorSequenceKeypoint.new(1, Color3.fromRGB(74, 229, 149)) }) }, { ["_lemonadeUniqueId"] = "aSagQ5FdaSag" })
			I[14] = new("TextLabel", I[2], "Percent", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(20, 49), Size = UDim2.new(1, -40, 0, 43), Text = "0%", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 24, TextStrokeColor3 = Color3.fromRGB(31, 15, 42), TextStrokeTransparency = 0, ZIndex = 4 }, { ["_lemonadeUniqueId"] = "14FHWUcQ14FH" })
			I[15] = new("UIScale", I[2], "UIScale", nil, { ["_lemonadeUniqueId"] = "7pcwVCQK7pcw" })
			I[16] = new("UIShadow", I[2], "UIShadow", nil, { ["_lemonadeUniqueId"] = "sHufs3y6sHuf" })
	return I[1]
end

return build
