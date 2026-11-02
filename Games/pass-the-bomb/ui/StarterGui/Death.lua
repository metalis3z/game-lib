-- Generated from ui/StarterGui/Death.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Death", { Enabled = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets })
		I[2] = new("Frame", I[1], "Frame", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.3, Size = UDim2.fromScale(1, 1) })
			I[3] = new("TextLabel", I[2], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4265786, 0.2776413), Size = UDim2.fromScale(0.1468429, 0.0614251), Text = "KIA", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 50 })
			I[4] = new("TextLabel", I[2], "Random", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1490455, 0.3390663), Size = UDim2.fromScale(0.7019089, 0.0356265), Text = "haha death - ed", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 50, TextWrapped = true })
			I[5] = new("TextLabel", I[2], "Time", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4265786, 0.5442261), Size = UDim2.fromScale(0.1468429, 0.0958231), Text = "20", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 50, TextWrapped = true })
			I[6] = new("TextLabel", I[2], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4265786, 0.5294841), Size = UDim2.fromScale(0.1468429, 0.0233415), Text = "RESPAWNING IN", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 50, TextWrapped = true })
		I[7] = new("Sound", I[1], "SoundOld", { TimePosition = 1.5 })
		I[8] = new("Sound", I[1], "Sound")
	return I[1]
end

return build
