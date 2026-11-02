-- Generated from ui/StarterGui/HUD.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "HUD", { ResetOnSpawn = false })
		I[2] = new("ImageLabel", I[1], "Cursor", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://2786244971"), ImageTransparency = 1, Position = UDim2.fromScale(0.5, 0.475), Size = UDim2.fromOffset(55, 55) })
		I[3] = new("Frame", I[1], "ScopeFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Visible = false })
			I[4] = new("ImageLabel", I[3], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(20, 26, 13), ImageContent = Content.fromUri("rbxassetid://2030035420"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 2 })
				I[5] = new("UIAspectRatioConstraint", I[4], "UIAspectRatioConstraint", { DominantAxis = Enum.DominantAxis.Height })
				I[6] = new("Frame", I[4], "Frame", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(1, 0), Size = UDim2.fromScale(10, 1), ZIndex = 2 })
				I[7] = new("Frame", I[4], "Frame", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(10, 1), ZIndex = 2 })
				I[8] = new("Frame", I[4], "Frame", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(-2, 1), Size = UDim2.fromScale(10, 10), ZIndex = 2 })
				I[9] = new("Frame", I[4], "Frame", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(-2, 0), Size = UDim2.fromScale(10, 10), ZIndex = 2 })
			I[10] = new("Frame", I[3], "Frame", { BackgroundColor3 = Color3.fromRGB(55, 72, 36), BackgroundTransparency = 0.7, Size = UDim2.fromScale(1, 1) })
		I[11] = new("TextLabel", I[1], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.824, 0.95), Size = UDim2.fromScale(0.1720244, 0.0513157), Text = "Press [Z] to unlock mouse", TextColor3 = Color3.fromRGB(84, 84, 84), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false, ZIndex = 3 })
		I[12] = new("Frame", I[1], "Reload", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.new(0, 0, 1, -120), Size = UDim2.new(1, 0, 0, 20), Visible = false })
			I[13] = new("TextLabel", I[12], "Title", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0), Size = UDim2.new(0, 170, 1, 0), Text = "Press          to reload", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 25, TextStrokeTransparency = 0.8 })
				I[14] = new("ImageLabel", I[13], "Image", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://1794289153"), Position = UDim2.fromOffset(55, -2), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromOffset(25, 25), SliceCenter = Rect.new(10, 10, 241, 241), ZIndex = 2 })
					I[15] = new("ImageLabel", I[14], "Shadow", { BackgroundColor3 = Color3.fromRGB(117, 117, 117), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(154, 154, 154), ImageContent = Content.fromUri("rbxassetid://1794289153"), ScaleType = Enum.ScaleType.Slice, Size = UDim2.new(1, 0, 1, 2), SliceCenter = Rect.new(10, 10, 241, 241) })
					I[16] = new("TextLabel", I[14], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(0, -1), Size = UDim2.new(1, -1, 1, -1), Text = "R", TextColor3 = Color3.fromRGB(129, 129, 129), TextSize = 25, ZIndex = 2 })
		I[17] = new("TextLabel", I[1], "TextLabel2", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.822, 0.949), Size = UDim2.fromScale(0.1720244, 0.0513157), Text = "Press [Z] to unlock mouse", TextColor3 = Color3.fromRGB(203, 203, 203), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false, ZIndex = 3 })
		I[18] = new("ImageLabel", I[1], "Hitmarker", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 0, 0), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://285779644"), ImageTransparency = 1, Position = UDim2.fromScale(0.5, 0.475), Size = UDim2.fromOffset(30, 30) })
	return I[1]
end

return build
