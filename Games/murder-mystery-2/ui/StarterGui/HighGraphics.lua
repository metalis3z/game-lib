-- Generated from ui/StarterGui/HighGraphics.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "HighGraphics", { DisplayOrder = 999999999, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets })
		I[2] = new("ImageButton", I[1], "Main", { AnchorPoint = Vector2.new(0, 1), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxasset://textures/ui/TopBar/iconBase.png"), Position = UDim2.fromOffset(145, 36), Size = UDim2.fromOffset(32, 32), ZIndex = 2 })
			I[3] = new("UIGradient", I[2], "UIGradient", { Enabled = false })
			I[4] = new("ImageLabel", I[2], "IconImage", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(255, 0, 4), ImageContent = Content.fromUri("rbxassetid://12809887054"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(24, 24), ZIndex = 2 })
			I[5] = new("ImageLabel", I[2], "Notification", { BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=4871790969"), Position = UDim2.new(0.45, 0, 0, -2), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 0.7), Visible = false, ZIndex = 4 })
				I[6] = new("TextLabel", I[5], "Amount", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.25, 0.15), Size = UDim2.fromScale(0.5, 0.7), Text = "1", TextColor3 = Color3.fromRGB(31, 33, 35), TextScaled = true, TextWrapped = true, ZIndex = 5 })
			I[7] = new("ImageLabel", I[2], "StateOverlay", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageTransparency = 1, ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(8, 8, 8, 8), ZIndex = 5 })
				I[8] = new("UICorner", I[7], "UICorner")
		I[9] = new("Frame", I[1], "ConfettiPosAndSizeFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.new(0.196633, -10, 0.7321804, -5), Size = UDim2.new(0.6, 20, 0.15, 10), Visible = false })
		I[10] = new("ImageButton", I[1], "Main2", { AnchorPoint = Vector2.new(0, 1), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxasset://textures/ui/TopBar/iconBase.png"), Position = UDim2.fromOffset(145, 36), Size = UDim2.fromOffset(32, 32), Visible = false, ZIndex = 2 })
			I[11] = new("UIGradient", I[10], "UIGradient", { Enabled = false })
			I[12] = new("ImageLabel", I[10], "IconImage", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(255, 0, 4), ImageContent = Content.fromUri("rbxassetid://12809887054"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(24, 24), ZIndex = 2 })
			I[13] = new("ImageLabel", I[10], "Notification", { BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=4871790969"), Position = UDim2.new(0.45, 0, 0, -2), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 0.7), Visible = false, ZIndex = 4 })
				I[14] = new("TextLabel", I[13], "Amount", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.25, 0.15), Size = UDim2.fromScale(0.5, 0.7), Text = "1", TextColor3 = Color3.fromRGB(31, 33, 35), TextScaled = true, TextWrapped = true, ZIndex = 5 })
			I[15] = new("ImageLabel", I[10], "StateOverlay", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageTransparency = 1, ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(8, 8, 8, 8), ZIndex = 5 })
				I[16] = new("UICorner", I[15], "UICorner")
	return I[1]
end

return build
