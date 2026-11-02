-- Generated from ui/StarterGui/SpawnGlow.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "SpawnGlow", { DisplayOrder = 4, Enabled = false, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets })
		I[2] = new("ImageLabel", I[1], "Border", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(82, 255, 108), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=4233696467"), ImageTransparency = 0.25, Size = UDim2.new(1, 0, 0.1, 20) })
		I[3] = new("ImageLabel", I[1], "Border", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(82, 255, 108), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=4233696467"), ImageTransparency = 0.25, Position = UDim2.fromScale(0, 1), Rotation = 180, Size = UDim2.new(1, 0, 0.1, 20) })
		I[4] = new("ImageLabel", I[1], "Border", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(82, 255, 108), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=4233784453"), ImageTransparency = 0.25, Size = UDim2.new(0.1, 20, 1, 0) })
		I[5] = new("ImageLabel", I[1], "Border", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(82, 255, 108), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=4233784453"), ImageTransparency = 0.25, Position = UDim2.fromScale(1, 0), Rotation = 180, Size = UDim2.new(0.1, 20, 1, 0) })
		I[6] = new("Frame", I[1], "Frame", { BackgroundColor3 = Color3.fromRGB(82, 255, 108), BackgroundTransparency = 0.9, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) })
	return I[1]
end

return build
