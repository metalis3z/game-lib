-- Generated from ui/StarterGui/Killcam.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Killcam", { Enabled = false, ResetOnSpawn = false })
		I[2] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.new(0.5, 0, 0.9, -100), Size = UDim2.new(0.8, 0, 0.08, 100) })
			I[3] = new("ImageLabel", I[2], "Info", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://5431965152"), Position = UDim2.fromScale(0, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.9, 0.55), SliceCenter = Rect.new(20, 20, 80, 80) })
				I[4] = new("TextLabel", I[3], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.025, 0.1), Size = UDim2.fromScale(0.95, 0.175), Text = "Tagged By", TextColor3 = Color3.fromRGB(255, 46, 137), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
				I[5] = new("TextLabel", I[3], "Username", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.03, 0.225), Rotation = -1, Size = UDim2.fromScale(0.7, 0.45), Text = "Preston!", TextColor3 = Color3.fromRGB(62, 255, 139), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
				I[6] = new("ImageButton", I[3], "Skip", { AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(62, 255, 139), ImageContent = Content.fromUri("rbxassetid://5431965152"), Position = UDim2.new(0.5, 0, 1.55, -1), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.7, 0.9), SliceCenter = Rect.new(20, 20, 80, 80) })
					I[7] = new("TextLabel", I[6], "TextLabel", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(1, 0.6), Text = "Skip!", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 20, TextWrapped = true })
					I[8] = new("TextLabel", I[6], "KeyHint", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.875), Size = UDim2.fromScale(1, 0.175), Text = "[SPACE]", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 20, TextWrapped = true, Visible = false })
				I[9] = new("ImageLabel", I[3], "GunIcon", { AnchorPoint = Vector2.new(1, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://6721352759"), Position = UDim2.fromScale(1.075, 0.9), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.335, 1.1) })
				I[10] = new("TextLabel", I[3], "CareerKills", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.045, 0.725), Size = UDim2.fromScale(0.9, 0.185), Text = "928 Career Tags", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
				I[11] = new("TextLabel", I[3], "Level", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.05, 0.1), Size = UDim2.fromScale(0.725, 0.185), Text = "Level 10", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right })
			I[12] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 2.5 })
	return I[1]
end

return build
