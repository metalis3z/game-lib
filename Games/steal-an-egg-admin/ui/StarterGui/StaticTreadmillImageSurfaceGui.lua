-- Generated from ui/StarterGui/StaticTreadmillImageSurfaceGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("SurfaceGui", nil, "StaticTreadmillImageSurfaceGui", { ClipsDescendants = true, LightInfluence = 1, MaxDistance = 1000, ResetOnSpawn = false, SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["_lemonadeUniqueId"] = "ygCHMquEygCH" })
		I[2] = new("Frame", I[1], "VideoFrame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) }, { ["_lemonadeUniqueId"] = "HJw8YIG2HJw8" })
			I[3] = new("ImageLabel", I[2], "StopPlay", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://87443731918082"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.4, 0.2), Visible = false, ZIndex = 3 }, { ["_lemonadeUniqueId"] = "btxZRbm2btxZ" })
			I[4] = new("Frame", I[2], "Loading", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(66, 66, 66), BackgroundTransparency = 0.2, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 4 }, { ["_lemonadeUniqueId"] = "4ixwB8r94ixw" })
				I[5] = new("ImageLabel", I[4], "Spin", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://114843845676955"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.5, 0.25) }, { ["_lemonadeUniqueId"] = "W0J09Xw4W0J0" })
			I[6] = new("ImageLabel", I[2], "Image", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://87443731918082"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), ZIndex = 2 }, { ["_lemonadeUniqueId"] = "9Cq3rwDv9Cq3" })
	return I[1]
end

return build
