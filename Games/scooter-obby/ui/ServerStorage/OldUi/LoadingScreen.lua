-- Generated from ui/ServerStorage/OldUi/LoadingScreen.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "LoadingScreen", { Enabled = false, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), Visible = false })
			I[3] = new("ImageLabel", I[2], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://15313445978"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.6521084, 0.5506173), ZIndex = 5 })
				I[4] = new("UICorner", I[3], "UICorner")
			I[5] = new("Frame", I[2], "Bar", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(108, 108, 108), Position = UDim2.fromScale(0.5, 0.9297654), Size = UDim2.fromScale(0.3901904, 0.0135802), ZIndex = 5 })
				I[6] = new("UICorner", I[5], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
			I[7] = new("Frame", I[2], "Color2", { BackgroundColor3 = Color3.fromRGB(255, 115, 5), BackgroundTransparency = 0.3, BorderSizePixel = 0, Position = UDim2.fromScale(1, 0), Size = UDim2.fromScale(1, 1), ZIndex = 2 })
			I[8] = new("Frame", I[2], "Color1", { BackgroundColor3 = Color3.fromRGB(255, 115, 5), BackgroundTransparency = 0.8, BorderSizePixel = 0, Position = UDim2.fromScale(-1, 0), Size = UDim2.fromScale(1, 1) })
			I[9] = new("Frame", I[2], "Color3", { BackgroundColor3 = Color3.fromRGB(255, 115, 5), BorderSizePixel = 0, Position = UDim2.fromScale(0, -1), Size = UDim2.fromScale(1, 1), ZIndex = 3 })
		I[10] = new("Sound", I[1], "Sound1", { PlaybackSpeed = 0.75 })
	return I[1]
end

return build
