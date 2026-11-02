-- Generated from ui/StarterGui/ScreenGui~2.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "ScreenGui")
		I[2] = new("Frame", I[1], "Text", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.1, 0.2) })
			I[3] = new("TextLabel", I[2], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/RomanAntique.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(-1.33, -0.02), Size = UDim2.fromOffset(365, 105), Text = "YOU DIED", TextColor3 = Color3.fromRGB(255, 0, 0), TextScaled = true, TextSize = 14, TextTransparency = 1, TextWrapped = true, Visible = false })
		I[4] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 85, 85), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(5, 5) })
		I[5] = new("TextButton", I[1], "ModalOption", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Text = " ", TextSize = 14 })
		I[6] = new("Sound", I[1], "Death1", { RollOffMaxDistance = 20, Volume = 1 })
			I[7] = new("DistortionSoundEffect", I[6], "DistortionSoundEffect", { Level = 0.34 })
		I[8] = new("Sound", I[1], "Death3", { RollOffMaxDistance = 20, Volume = 1 })
			I[9] = new("DistortionSoundEffect", I[8], "DistortionSoundEffect", { Level = 0.34 })
		I[10] = new("Sound", I[1], "Death2", { RollOffMaxDistance = 20, RollOffMinDistance = 10000, Volume = 1 })
			I[11] = new("DistortionSoundEffect", I[10], "DistortionSoundEffect", { Level = 0.34 })
	return I[1]
end

return build
