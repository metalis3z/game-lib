-- Generated from ui/StarterGui/Codes.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Codes", { Enabled = false, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets })
		I[2] = new("Sound", I[1], "pop")
		I[3] = new("Frame", I[1], "Frame", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.1614217, 0.2373148), Size = UDim2.fromScale(0.675887, 0.5245538) })
			I[4] = new("UICorner", I[3], "UICorner", { BottomLeftRadius = UDim.new(0, 20), BottomRightRadius = UDim.new(0, 20), TopLeftRadius = UDim.new(0, 20), TopRightRadius = UDim.new(0, 20) })
			I[5] = new("TextLabel", I[3], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3041595, 0.07), RichText = true, Size = UDim2.fromScale(0.5614224, 0.112), Text = "Codes", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
			I[6] = new("TextBox", I[3], "Box", { BackgroundColor3 = Color3.fromRGB(216, 216, 216), ClearTextOnFocus = false, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), PlaceholderColor3 = Color3.fromRGB(178, 178, 178), Position = UDim2.fromScale(0.1457726, 0.5681819), Size = UDim2.fromScale(0.6997085, 0.1590909), Text = "Hi", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[7] = new("TextButton", I[3], "Redeem", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2896825, 0.7795317), Size = UDim2.fromScale(0.4158568, 0.1431957), Text = "Redeem!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[8] = new("TextLabel", I[3], "info", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0812069, 0.126), Size = UDim2.fromScale(0.834529, 0.3929432), Text = "Find Codes In the Game Description And Redeem Them Here for In-Game Rewards!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
	return I[1]
end

return build
