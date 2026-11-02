-- Generated from ui/StarterGui/SpeedrunTimerGUI.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "SpeedrunTimerGUI")
		I[2] = new("Frame", I[1], "Timer", { AnchorPoint = Vector2.new(1, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(1, 1), Size = UDim2.fromScale(0.3, 0.3) })
			I[3] = new("TextLabel", I[2], "Time", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(-1.6385541, -1.9213485), RichText = true, Size = UDim2.fromScale(1.0602412, 0.209042), Text = "", TextColor3 = Color3.fromRGB(68, 68, 68), TextScaled = true, TextSize = 100, TextTruncate = Enum.TextTruncate.AtEnd, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, TextYAlignment = Enum.TextYAlignment.Bottom })
			I[4] = new("TextLabel", I[2], "Title", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.9999999, 0.73542), RichText = true, Size = UDim2.fromScale(0, 0.0003746), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 40, TextTransparency = 1, TextTruncate = Enum.TextTruncate.AtEnd, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, TextYAlignment = Enum.TextYAlignment.Bottom })
		I[5] = new("TextButton", I[1], "ToggleButton", { AnchorPoint = Vector2.new(1, 1), BackgroundColor3 = Color3.fromRGB(170, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 2, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(1, 0.8), Size = UDim2.fromScale(0.0281928, 0.0046871), Text = "Hide Timer", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, TextTransparency = 1 })
	return I[1]
end

return build
