-- Generated from ui/Lighting/PoliceGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "PoliceGui")
		I[2] = new("Frame", I[1], "IncomingCallFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.76, 0.0859951), Size = UDim2.fromScale(0.2256, 0.3316953) })
			I[3] = new("TextLabel", I[2], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1887128, -0.003722), Size = UDim2.fromScale(0.6369427, 0.177305), Text = "INCOMING CALLS", TextColor3 = Color3.fromRGB(252, 252, 252), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
			I[4] = new("ImageLabel", I[2], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(79, 79, 79), ImageContent = Content.fromUri("rbxassetid://3570695787"), ImageTransparency = 0.5, Position = UDim2.fromScale(0.0509554, 0.14539), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.9171975, 0.8932371), SliceCenter = Rect.new(100, 100, 100, 100), SliceScale = 0.12 })
				I[5] = new("ScrollingFrame", I[4], "ScrollingFrame", { Active = true, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.0246373, 0.0356741), ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0), ScrollBarThickness = 7, Size = UDim2.fromScale(0.9444444, 0.9313304) })
					I[6] = new("UIListLayout", I[5], "UIListLayout", { Padding = UDim.new(0, 30), SortOrder = Enum.SortOrder.LayoutOrder })
			I[7] = new("ImageLabel", I[2], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://8172824106"), Position = UDim2.fromScale(0.0987261, 0.0425532), Size = UDim2.fromScale(0.0828025, 0.0921986) })
			I[8] = new("ImageLabel", I[2], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://386462968"), Position = UDim2.fromScale(0.8280255, 0.0425532), Size = UDim2.fromScale(0.0828025, 0.0921986) })
		I[9] = new("UIAspectRatioConstraint", I[1], "UIAspectRatioConstraint", { AspectRatio = 1.5356265 })
		I[10] = new("Frame", I[1], "Comms", { BackgroundColor3 = Color3.fromRGB(84, 84, 84), BackgroundTransparency = 0.65, Position = UDim2.fromScale(0.0111821, 0.1300613), Size = UDim2.fromScale(0.2995208, 0.3266833) })
			I[11] = new("TextLabel", I[10], "Communications", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2, -0.2024336), Size = UDim2.fromScale(0.6, 0.199115), Text = "COMMUNICATIONS", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[12] = new("TextButton", I[10], "activebutton", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3478095, 0.0132743), Size = UDim2.fromScale(0.3013333, 0.0973451), Text = "INACTIVE (T)", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[13] = new("TextButton", I[10], "distress", { BackgroundColor3 = Color3.fromRGB(255, 11, 15), FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.856, -0.0044248), Size = UDim2.fromScale(0.144, 0.1460177), Text = "!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[14] = new("Frame", I[10], "Talking", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.072, 0.1681416), Size = UDim2.fromScale(0.872, 0.778761) })
				I[15] = new("UIListLayout", I[14], "UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder })
		I[16] = new("Animation", I[1], "Animation", { AnimationContent = Content.fromUri("rbxassetid://11890110878") })
		I[17] = new("Frame", I[1], "Hidden", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.99, Position = UDim2.fromScale(0.4600639, 0), Size = UDim2.fromScale(0.0798722, 0.0355828) })
			I[18] = new("TextButton", I[17], "ComCollapse", { BackgroundColor3 = Color3.fromRGB(74, 74, 74), BackgroundTransparency = 0.35, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(-5.6199999, 1.838877), Size = UDim2.fromScale(0.5508515, 0.8123561), Text = "-", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[19] = new("TextButton", I[17], "CallCollapse", { BackgroundColor3 = Color3.fromRGB(74, 74, 74), BackgroundTransparency = 0.35, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(6.0606995, 1.828177), Size = UDim2.fromScale(0.551, 0.812), Text = "-", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
	return I[1]
end

return build
