-- Generated from ui/ServerScriptService/WelcomeGUI/Welcome.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Welcome", { ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets })
		I[2] = new("Frame", I[1], "Warning", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) })
			I[3] = new("Frame", I[2], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.6, 0.4) })
				I[4] = new("UIListLayout", I[3], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 15), VerticalAlignment = Enum.VerticalAlignment.Center })
				I[5] = new("TextLabel", I[3], "TextLabel", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 0.2), Text = "Zombie Survival", TextColor3 = Color3.fromRGB(85, 170, 255), TextScaled = true, TextSize = 42, TextWrapped = true })
				I[6] = new("TextLabel", I[3], "TextLabel", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 0.4), Text = "This experience contains flashing lights. It is intended for entertainment purposes only.", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextWrapped = true })
			I[7] = new("TextButton", I[2], "Close", { BackgroundColor3 = Color3.fromRGB(0, 170, 255), BorderColor3 = Color3.fromRGB(0, 170, 255), FontFace = Font.new("rbxasset://fonts/families/Balthazar.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Modal = true, Position = UDim2.fromScale(0.2489282, 0.6788155), RichText = true, Size = UDim2.fromScale(0.5, 0.0455581), Style = Enum.ButtonStyle.RobloxRoundDefaultButton, Text = "Close", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextWrapped = true })
	return I[1]
end

return build
