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
		I[2] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, Position = UDim2.fromScale(0.4806379, 0.0710546), Size = UDim2.fromScale(0.1677264, 0.0503889) })
			I[3] = new("UICorner", I[2], "UICorner")
			I[4] = new("Frame", I[2], "FuelBG", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.25, Position = UDim2.fromScale(0.2197847, 0.1340829), Size = UDim2.fromScale(0.7502083, 0.7114455) })
				I[5] = new("UICorner", I[4], "UICorner")
				I[6] = new("Frame", I[4], "FuelOverlay", { BackgroundColor3 = Color3.fromRGB(0, 255, 0), BackgroundTransparency = 0.5, Position = UDim2.fromScale(-0.0000014, 0.0083369), Size = UDim2.fromScale(1, 1) })
					I[7] = new("UICorner", I[6], "UICorner")
					I[8] = new("UIStroke", I[6], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Thickness = 1.5, Transparency = 0.25 })
				I[9] = new("UIStroke", I[4], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Thickness = 2, Transparency = 0.25 })
			I[10] = new("ImageLabel", I[2], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://18316921926"), Position = UDim2.fromScale(0.036517, 0.1340828), Size = UDim2.fromScale(0.1524284, 0.7576159) })
			I[11] = new("UIStroke", I[2], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Thickness = 2, Transparency = 0.25 })
	return I[1]
end

return build
