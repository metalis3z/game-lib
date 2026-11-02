-- Generated from ui/ReplicatedStorage/CallFrame.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "CallFrame", { BackgroundColor3 = Color3.fromRGB(0, 64, 194), BackgroundTransparency = 0.55, Position = UDim2.fromScale(0.0330882, 0.0000001), Size = UDim2.fromScale(0.9669118, 0.124424) })
		I[2] = new("TextLabel", I[1], "uname", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.026616, 0), Size = UDim2.fromScale(0.3079848, 0.983071), Text = "Kneeskins", TextColor3 = Color3.fromRGB(255, 0, 0), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
		I[3] = new("TextLabel", I[1], "reasonforcall", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4258555, 0), Size = UDim2.fromScale(0.4714829, 0.983071), Text = "Test", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
		I[4] = new("TextButton", I[1], "act", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.4, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1749049, 1), Size = UDim2.fromScale(0.3764259, 0.3969957), Text = "Accept", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true })
		I[5] = new("TextButton", I[1], "close", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.4, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5855514, 1), Size = UDim2.fromScale(0.3764259, 0.3969957), Text = "Close", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true })
		I[6] = new("IntValue", I[1], "CALLID")
	return I[1]
end

return build
