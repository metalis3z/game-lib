-- Generated from ui/ReplicatedFirst/Loading/DeviceSelect.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "DeviceSelect", { DisplayOrder = 4, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets })
		I[2] = new("Frame", I[1], "Container", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), SizeConstraint = Enum.SizeConstraint.RelativeYY })
			I[3] = new("TextLabel", I[2], "Warning2", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(-0.5, 0.4), Size = UDim2.fromScale(1, 0.04), Text = "Rejoin if you select the wrong device", TextColor3 = Color3.fromRGB(212, 24, 24), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[4] = new("TextLabel", I[2], "Warning", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(-0.5, 0.35), Size = UDim2.fromScale(1, 0.05), Text = "Warning: Choosing the wrong device will mess up your menu", TextColor3 = Color3.fromRGB(212, 24, 24), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[5] = new("TextLabel", I[2], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(-0.5, -0.45), Size = UDim2.fromScale(1, 0.1), Text = "Choose Your Device", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[6] = new("Frame", I[2], "Phone", { BackgroundColor3 = Color3.fromRGB(56, 214, 93), BorderColor3 = Color3.fromRGB(40, 157, 68), BorderSizePixel = 5, Position = UDim2.fromScale(0.02, -0.3), Size = UDim2.fromScale(0.5, 0.6) })
				I[7] = new("TextLabel", I[6], "Title", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.8, 0.8), Size = UDim2.fromScale(0.2, 0.08), Text = "Beta", TextColor3 = Color3.fromRGB(178, 255, 119), TextScaled = true, TextSize = 36, TextStrokeTransparency = 0.7, TextWrapped = true, ZIndex = 2 })
				I[8] = new("TextLabel", I[6], "Last", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 0.1), Text = "Previous Device", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 36, TextStrokeTransparency = 0.3, TextWrapped = true, Visible = false, ZIndex = 2 })
				I[9] = new("TextLabel", I[6], "Switch", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 0.1), Text = "Touch to switch", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 36, TextStrokeTransparency = 0.3, TextWrapped = true, Visible = false, ZIndex = 4 })
				I[10] = new("Frame", I[6], "Cover", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.2, BorderSizePixel = 0, Position = UDim2.fromOffset(-5, -5), Size = UDim2.new(1, 10, 1, 10), Visible = false, ZIndex = 3 })
				I[11] = new("TextButton", I[6], "Button", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "", TextSize = 14, ZIndex = 3 })
				I[12] = new("TextLabel", I[6], "Title", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.8, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.8), Size = UDim2.fromScale(1, 0.2), Text = "Phone", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 36, TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 2 })
				I[13] = new("ImageLabel", I[6], "Icon", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.9, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://466240313"), Position = UDim2.fromScale(0.05, 0.05), Size = UDim2.fromScale(0.9, 0.9), SizeConstraint = Enum.SizeConstraint.RelativeXX, ZIndex = 2 })
			I[14] = new("Frame", I[2], "Tablet", { BackgroundColor3 = Color3.fromRGB(57, 156, 221), BorderColor3 = Color3.fromRGB(32, 92, 129), BorderSizePixel = 5, Position = UDim2.fromScale(-0.52, -0.3), Size = UDim2.fromScale(0.5, 0.6) })
				I[15] = new("TextLabel", I[14], "Switch", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 0.1), Text = "Touch to switch", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 36, TextStrokeTransparency = 0.3, TextWrapped = true, Visible = false, ZIndex = 4 })
				I[16] = new("TextLabel", I[14], "Last", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 0.1), Text = "Previous Device", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 36, TextStrokeTransparency = 0.3, TextWrapped = true, Visible = false, ZIndex = 2 })
				I[17] = new("Frame", I[14], "Cover", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.1, BorderSizePixel = 0, Position = UDim2.fromOffset(-5, -5), Size = UDim2.new(1, 10, 1, 10), Visible = false, ZIndex = 3 })
				I[18] = new("TextButton", I[14], "Button", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "", TextSize = 14, ZIndex = 3 })
				I[19] = new("TextLabel", I[14], "Title", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.8, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.8), Size = UDim2.fromScale(1, 0.2), Text = "Tablet", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 36, TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 2 })
				I[20] = new("ImageLabel", I[14], "Icon", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.9, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://466263397"), Position = UDim2.fromScale(0.05, 0.05), Size = UDim2.fromScale(0.9, 0.9), SizeConstraint = Enum.SizeConstraint.RelativeXX, ZIndex = 2 })
		I[21] = new("Frame", I[1], "BG", { BackgroundColor3 = Color3.fromRGB(12, 12, 12), Size = UDim2.fromScale(1, 1) })
	return I[1]
end

return build
