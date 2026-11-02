-- Generated from ui/ServerScriptService/Death Gui/DeathGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "DeathGui")
		I[2] = new("Frame", I[1], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(-0.01, -0.01), Size = UDim2.fromScale(1.1, 1.1) })
			I[3] = new("ImageLabel", I[2], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(100, 0, 7), ImageContent = Content.fromUri("rbxassetid://143854825"), Size = UDim2.fromScale(1, 1) })
		I[4] = new("Frame", I[1], "Frame", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.3357303, 0.4513201), Size = UDim2.fromScale(0.3285394, 0.232588) })
			I[5] = new("TextLabel", I[4], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Italic), Position = UDim2.fromScale(-0.0076649, -0.0426516), Size = UDim2.fromScale(0.9915967, 0.1138048), Text = "Respawning...", TextColor3 = Color3.fromRGB(216, 216, 216), TextScaled = true, TextSize = 96, TextStrokeColor3 = Color3.fromRGB(255, 255, 255), TextWrapped = true })
				I[6] = new("Sound", I[5], "Music", { PlaybackSpeed = 0, RollOffMinDistance = 0 })
				I[7] = new("Sound", I[5], "Beep", { Volume = 0 })
			I[8] = new("TextLabel", I[4], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(-0.0076649, -0.5174551), Size = UDim2.fromScale(0.9915967, 0.649187), Text = "YOU DIED", TextColor3 = Color3.fromRGB(216, 216, 216), TextScaled = true, TextSize = 96, TextStrokeColor3 = Color3.fromRGB(255, 255, 255), TextWrapped = true })
	return I[1]
end

return build
