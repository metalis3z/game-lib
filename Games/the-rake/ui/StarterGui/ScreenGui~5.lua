-- Generated from ui/StarterGui/ScreenGui~5.rbxm by _tools/rbxm2lua.luau
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
		I[2] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.4991394), Size = UDim2.fromScale(1, 1) })
			I[3] = new("ImageButton", I[2], "ImageButton", { AnchorPoint = Vector2.new(1, 1), BackgroundColor3 = Color3.fromRGB(68, 68, 68), BackgroundTransparency = 0.4, BorderColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=5912368763"), ImageTransparency = 0.3, Position = UDim2.fromScale(1, 1), Size = UDim2.fromScale(0.0360465, 0.0724613) })
				I[4] = new("UIAspectRatioConstraint", I[3], "UIAspectRatioConstraint", { AspectRatio = 1.0308793 })
			I[5] = new("ScrollingFrame", I[2], "ScrollingFrame", { Active = true, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.7, BorderColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.fromScale(0.514, 0.5), ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0), ScrollBarThickness = 32, Size = UDim2.fromScale(0.63, 0.787), Visible = false })
				I[6] = new("UIAspectRatioConstraint", I[5], "UIAspectRatioConstraint", { AspectRatio = 1.6588846 })
				I[7] = new("TextLabel", I[5], "Lighting", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Light, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0500976, 0.1335263), Size = UDim2.fromOffset(136, 36), Text = "Lighting", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[8] = new("UIAspectRatioConstraint", I[7], "UIAspectRatioConstraint", { AspectRatio = 3.7777777 })
				I[9] = new("TextLabel", I[5], "Others", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Light, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0500976, 0.0259531), Size = UDim2.fromOffset(136, 36), Text = "Others", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false })
					I[10] = new("UIAspectRatioConstraint", I[9], "UIAspectRatioConstraint", { AspectRatio = 3.7777777 })
				I[11] = new("TextButton", I[5], "Global_Shadows", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.7, BorderColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/RomanAntique.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0500976, 0.083552), Size = UDim2.fromScale(0.2858717, 0.0395847), Text = "Global Shadows", TextColor3 = Color3.fromRGB(0, 255, 0), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[12] = new("UIAspectRatioConstraint", I[11], "UIAspectRatioConstraint", { AspectRatio = 4.7141604 })
				I[13] = new("TextButton", I[5], ":>", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.7, BorderColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(-0.0013183, 0.9783273), Size = UDim2.fromScale(0.0696613, 0.042909), Text = ":>", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[14] = new("UIAspectRatioConstraint", I[13], "UIAspectRatioConstraint", { AspectRatio = 1.0597514 })
	return I[1]
end

return build
