-- Generated from ui/ServerStorage/UIGridLayout/Template.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ImageButton", nil, "Template", { BackgroundColor3 = Color3.fromRGB(116, 88, 70), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromOffset(100, 100) })
		I[2] = new("UICorner", I[1], "UICorner", { BottomLeftRadius = UDim.new(0, 25), BottomRightRadius = UDim.new(0, 25), TopLeftRadius = UDim.new(0, 25), TopRightRadius = UDim.new(0, 25) })
		I[3] = new("ImageLabel", I[1], "Stick", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://15706955427"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Crop, Size = UDim2.fromScale(1.05, 1.05), SliceCenter = Rect.new(255, 256, 255, 256), SliceScale = 0.15 })
		I[4] = new("ImageLabel", I[1], "ff", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(30, 30, 30), ImageContent = Content.fromUri("rbxassetid://15477428411"), Position = UDim2.fromScale(0.5, 0.8470842), Size = UDim2.fromScale(0.9, 0.2), SliceCenter = Rect.new(536, 476, 536, 476), ZIndex = 0 })
	return I[1]
end

return build
