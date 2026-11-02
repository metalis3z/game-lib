-- Generated from ui/StarterGui/Shutdown.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Shutdown", { DisplayOrder = 10, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "EffectFrame", { BackgroundColor3 = Color3.fromRGB(13, 13, 13), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) })
			I[3] = new("Frame", I[2], "TopFrame", { BackgroundColor3 = Color3.fromRGB(13, 13, 13), BorderSizePixel = 0, Position = UDim2.fromScale(0, -0.5), Size = UDim2.fromScale(1, 0.5) })
			I[4] = new("Frame", I[2], "BottomFrame", { BackgroundColor3 = Color3.fromRGB(13, 13, 13), BorderSizePixel = 0, Position = UDim2.fromScale(0, 1), Size = UDim2.fromScale(1, 0.5) })
		I[5] = new("Frame", I[1], "LabelsFrame", { BackgroundColor3 = Color3.fromRGB(13, 13, 13), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) })
			I[6] = new("ImageLabel", I[5], "Icon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=13129552354"), ImageTransparency = 1, Position = UDim2.fromScale(0.3429093, 0.3569136), Size = UDim2.fromScale(0.314, 0.286) })
			I[7] = new("TextLabel", I[5], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3081141, 0.5775679), Size = UDim2.fromScale(0.3837719, 0), Text = "THE SERVER IS GETTING UPDATED", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextTransparency = 1, TextWrapped = true })
			I[8] = new("TextLabel", I[5], "CoreInfo", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0069444, 0.980037), Size = UDim2.fromScale(0.3837719, 0.0123457), Text = "Quantoun V2", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextTransparency = 1, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
			I[9] = new("TextLabel", I[5], "AnimatingLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3081141, 0.6146049), Size = UDim2.fromScale(0.3837719, 0.0160494), Text = "you are being teleported", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextTransparency = 1, TextWrapped = true })
	return I[1]
end

return build
