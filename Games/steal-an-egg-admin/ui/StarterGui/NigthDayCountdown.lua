-- Generated from ui/StarterGui/NigthDayCountdown.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "NigthDayCountdown", { Enabled = false, ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["_lemonadeUniqueId"] = "plasYl91plas" })
		I[2] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.9017857, 0.9305556), Size = UDim2.fromScale(0.1003401, 0.0798611) }, { ["_lemonadeUniqueId"] = "2sBpQ4H92sBp" })
			I[3] = new("TextLabel", I[2], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "3", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false }, { ["_lemonadeUniqueId"] = "QHHHp9btQHHH" })
			I[4] = new("ImageLabel", I[2], "DayIcon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://86038047961937"), ImageTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1.5) }, { ["_lemonadeUniqueId"] = "WTX3PqD3WTX3" })
			I[5] = new("TextLabel", I[2], "NightTimer", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(1.03, 0.5), Size = UDim2.fromScale(1, 1), Text = "3s", TextColor3 = Color3.fromRGB(83, 83, 83), TextScaled = true, TextSize = 14, TextTransparency = 1, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left }, { ["_lemonadeUniqueId"] = "n4H8jh1tn4H8" })
				I[6] = new("UIStroke", I[5], "UIStroke", { Thickness = 3.7, Transparency = 1 }, { ["_lemonadeUniqueId"] = "VMDLapZ9VMDL" })
			I[7] = new("ImageLabel", I[2], "SleepIcon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://113226921125172"), Position = UDim2.fromScale(0.0506329, -0.0441176), Size = UDim2.fromScale(0.431, 1.0735294) }, { ["_lemonadeUniqueId"] = "bVzf8ppJbVzf" })
	return I[1]
end

return build
