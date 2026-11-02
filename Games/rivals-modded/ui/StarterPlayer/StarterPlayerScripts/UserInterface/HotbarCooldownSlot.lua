-- Generated from ui/StarterPlayer/StarterPlayerScripts/UserInterface/HotbarCooldownSlot.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "HotbarCooldownSlot", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = -1, Size = UDim2.fromScale(1, 1) })
		I[2] = new("Frame", I[1], "Bar", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(200, 200, 200), BackgroundTransparency = 0.5, BorderSizePixel = 0, Position = UDim2.fromScale(1, 0.5), Size = UDim2.fromScale(0.667, 0.2) })
			I[3] = new("Frame", I[2], "Bar", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(0.5, 1.5) })
				I[4] = new("UICorner", I[3], "UICorner")
			I[5] = new("UICorner", I[2], "UICorner")
			I[6] = new("UIStroke", I[2], "UIStroke", { StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.5, Transparency = 0.875 })
		I[7] = new("ImageLabel", I[1], "Icon", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://17139984194"), Position = UDim2.fromScale(0, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.333, 1) })
	return I[1]
end

return build
