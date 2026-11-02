-- Generated from ui/ServerStorage/CarGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "CarGui", { ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Frame", { BackgroundColor3 = Color3.fromRGB(102, 102, 102), Position = UDim2.fromScale(0.3660915, 0.7219451), Size = UDim2.fromScale(0.2670668, 0.1533666) })
			I[3] = new("TextLabel", I[2], "carName", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2643312, 0), Size = UDim2.fromScale(0.4713376, 0.2189349), Text = "CAR NAME", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[4] = new("UITextSizeConstraint", I[3], "UITextSizeConstraint", { MaxTextSize = 24 })
			I[5] = new("UICorner", I[2], "UICorner")
			I[6] = new("TextLabel", I[2], "MPH", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2109605, 0.2845528), Size = UDim2.fromScale(0.5780792, 0.2189349), Text = "60 mph", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[7] = new("UITextSizeConstraint", I[6], "UITextSizeConstraint", { MaxTextSize = 24 })
			I[8] = new("Frame", I[2], "FuelBG", { BackgroundColor3 = Color3.fromRGB(144, 144, 144), Position = UDim2.fromScale(0.1797753, 0.5853658), Size = UDim2.fromScale(0.7696629, 0.2601626) })
				I[9] = new("UICorner", I[8], "UICorner")
				I[10] = new("Frame", I[8], "FuelOverlay", { BackgroundColor3 = Color3.fromRGB(243, 150, 0), Position = UDim2.fromScale(0, 0.008337), Size = UDim2.fromScale(1, 0.9916639) })
					I[11] = new("UICorner", I[10], "UICorner")
			I[12] = new("ImageLabel", I[2], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://11751731820"), Position = UDim2.fromScale(0.0365169, 0.5258456), Size = UDim2.fromScale(0.1264045, 0.3658537) })
	return I[1]
end

return build
