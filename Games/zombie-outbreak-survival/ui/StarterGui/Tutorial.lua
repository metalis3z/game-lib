-- Generated from ui/StarterGui/Tutorial.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Tutorial", { Enabled = false, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets })
		I[2] = new("Frame", I[1], "Frame", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.1614217, 0.2373148), Size = UDim2.fromScale(0.675887, 0.5245538) })
			I[3] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0, 20), BottomRightRadius = UDim.new(0, 20), TopLeftRadius = UDim.new(0, 20), TopRightRadius = UDim.new(0, 20) })
			I[4] = new("TextButton", I[2], "Next", { BackgroundColor3 = Color3.fromRGB(221, 221, 221), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.8594155, 0.8815166), Size = UDim2.fromScale(0.1322948, 0.0947867), Text = "Next", TextColor3 = Color3.fromRGB(33, 33, 33), TextScaled = true, TextSize = 22, TextWrapped = true })
			I[5] = new("TextButton", I[2], "Previous", { BackgroundColor3 = Color3.fromRGB(221, 221, 221), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0110524, 0.8815166), Size = UDim2.fromScale(0.1322947, 0.0947867), Text = "Previous", TextColor3 = Color3.fromRGB(33, 33, 33), TextScaled = true, TextSize = 22, TextWrapped = true })
			I[6] = new("ImageLabel", I[2], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(240, 240, 240), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://18872171323"), Position = UDim2.fromScale(0.3463938, 0.1174804), Size = UDim2.fromScale(0.3063285, 0.5402377) })
			I[7] = new("TextLabel", I[2], "Page", { BackgroundColor3 = Color3.fromRGB(221, 221, 221), FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1438637, 0.8814914), Size = UDim2.fromScale(0.7167395, 0.0948121), Text = "Page 1 / 1", TextColor3 = Color3.fromRGB(33, 33, 33), TextScaled = true, TextSize = 1, TextStrokeColor3 = Color3.fromRGB(255, 255, 255), TextWrapped = true })
			I[8] = new("TextLabel", I[2], "TextLabel", { BackgroundColor3 = Color3.fromRGB(240, 240, 240), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0000002, 0.6577182), Size = UDim2.fromScale(0.9999994, 0.2153407), Text = "Testing!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 1, TextStrokeColor3 = Color3.fromRGB(255, 255, 255), TextWrapped = true })
			I[9] = new("TextLabel", I[2], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2904001, 0.0587403), RichText = true, Size = UDim2.fromScale(0.5807997, 0.1174804), Text = "Tutorial", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(255, 255, 255), TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
	return I[1]
end

return build
