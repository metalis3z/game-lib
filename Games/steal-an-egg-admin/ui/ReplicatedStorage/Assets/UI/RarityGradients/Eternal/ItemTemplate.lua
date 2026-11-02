-- Generated from ui/ReplicatedStorage/Assets/UI/RarityGradients/Eternal/ItemTemplate.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("TextButton", nil, "ItemTemplate", { AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 18, ZIndex = 5 }, { ["Tick"] = 0, ["_lemonadeUniqueId"] = "zQmkaMjTzQmk" })
		I[2] = new("ImageLabel", I[1], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.9, 0.8), ZIndex = 6 }, { ["_lemonadeUniqueId"] = "aPvPSH4AaPvP" })
		I[3] = new("ImageLabel", I[1], "scribble", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1.25, 1.25), ZIndex = 5 }, { ["_lemonadeUniqueId"] = "x5XCWZeWx5XC" })
			I[4] = new("UIGradient", I[3], "Gradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(16, 73, 124)), ColorSequenceKeypoint.new(0.0237071, Color3.fromRGB(0, 16, 90)), ColorSequenceKeypoint.new(0.0237071, Color3.fromRGB(0, 16, 90)), ColorSequenceKeypoint.new(0.0914154, Color3.fromRGB(175, 201, 213)), ColorSequenceKeypoint.new(0.1955821, Color3.fromRGB(224, 240, 255)), ColorSequenceKeypoint.new(0.3414154, Color3.fromRGB(255, 180, 255)), ColorSequenceKeypoint.new(0.490721, Color3.fromRGB(68, 0, 127)), ColorSequenceKeypoint.new(0.521971, Color3.fromRGB(5, 1, 9)), ColorSequenceKeypoint.new(0.5271793, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.7424571, Color3.fromRGB(180, 255, 243)), ColorSequenceKeypoint.new(0.9646793, Color3.fromRGB(39, 159, 175)), ColorSequenceKeypoint.new(1, Color3.fromRGB(16, 73, 124)) }), Rotation = -90 }, { ["__gradient_style"] = "ChromeStroke", ["_lemonadeUniqueId"] = "rBdjFJHtrBdj" })
		I[5] = new("ImageLabel", I[1], "Select", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 0, 0), Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 5 }, { ["_lemonadeUniqueId"] = "NqktSk6YNqkt" })
		I[6] = new("TextLabel", I[1], "Quantity", { AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LineHeight = 0.9, Position = UDim2.fromScale(0.075, 0.05), Size = UDim2.fromScale(0.925, 0.2), Text = "x10k", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextStrokeColor3 = Color3.fromRGB(19, 48, 57), TextStrokeTransparency = 0, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, TextYAlignment = Enum.TextYAlignment.Top, ZIndex = 9 }, { ["_lemonadeUniqueId"] = "XbMtCoEgXbMt" })
			I[7] = new("UIStroke", I[6], "UIStroke", { Color = Color3.fromRGB(45, 45, 45), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2.5 }, { ["_lemonadeUniqueId"] = "RhBdSKqWRhBd" })
		I[8] = new("TextLabel", I[1], "Strength", { AnchorPoint = Vector2.new(1, 0.5), AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 2, LineHeight = 0.89, Position = UDim2.fromScale(1, 0.9), Size = UDim2.fromScale(1, 0.375), Text = "999", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextStrokeColor3 = Color3.fromRGB(19, 48, 57), TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, Visible = false, ZIndex = 8 }, { ["_lemonadeUniqueId"] = "y1P3pADdy1P3" })
			I[9] = new("UIStroke", I[8], "UIStroke", { Color = Color3.fromRGB(90, 90, 90), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 3 }, { ["_lemonadeUniqueId"] = "yGjLwIxxyGjL" })
				I[10] = new("UIGradient", I[9], "Tier Gradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 48, 95)), ColorSequenceKeypoint.new(0.0155709, Color3.fromRGB(45, 48, 95)), ColorSequenceKeypoint.new(0.0570934, Color3.fromRGB(93, 34, 145)), ColorSequenceKeypoint.new(0.2214533, Color3.fromRGB(211, 62, 184)), ColorSequenceKeypoint.new(0.2681661, Color3.fromRGB(255, 105, 240)), ColorSequenceKeypoint.new(0.3131488, Color3.fromRGB(211, 62, 184)), ColorSequenceKeypoint.new(0.3702422, Color3.fromRGB(175, 73, 200)), ColorSequenceKeypoint.new(1, Color3.fromRGB(45, 48, 95)) }), Offset = Vector2.new(0, -0.1), Rotation = -92 }, { ["_lemonadeUniqueId"] = "3GWNPyBL3GWN" })
		I[11] = new("ImageLabel", I[1], "Locked", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(254, 204, 38), Position = UDim2.fromScale(0.2, 0.15), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.25, 0.25), Visible = false, ZIndex = 11 }, { ["_lemonadeUniqueId"] = "tYB7TGzhtYB7" })
		I[12] = new("ImageLabel", I[1], "star", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageTransparency = 1, LayoutOrder = 1, Position = UDim2.fromScale(-0.0304348, 0.1931863), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.4608695, 0.3135465), ZIndex = 8 }, { ["_lemonadeUniqueId"] = "O7Ip9MQSO7Ip" })
		I[13] = new("TextLabel", I[1], "Level", { AnchorPoint = Vector2.new(0.5, 0.5), AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LineHeight = 0.9, Position = UDim2.fromScale(0.5, 0.8), Size = UDim2.fromScale(0.925, 0.2), Text = "x10k", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextStrokeColor3 = Color3.fromRGB(19, 48, 57), TextStrokeTransparency = 0, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, TextYAlignment = Enum.TextYAlignment.Top, Visible = false, ZIndex = 8 }, { ["_lemonadeUniqueId"] = "MEunBdffMEun" })
			I[14] = new("UIStroke", I[13], "UIStroke", { Color = Color3.fromRGB(45, 45, 45), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2.5 }, { ["_lemonadeUniqueId"] = "8y06hhsw8y06" })
	return I[1]
end

return build
