-- Generated from ui/ReplicatedStorage/Systems/Player/UI/Menus/Settings/SettingConnections/DeafMode/Indicator.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Indicator", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 179, 0), BackgroundTransparency = 1, Size = UDim2.fromScale(0.038, 0.038), SizeConstraint = Enum.SizeConstraint.RelativeYY })
		I[2] = new("UICorner", I[1], "UICorner", { BottomLeftRadius = UDim.new(0.5, 0), BottomRightRadius = UDim.new(0.5, 0), TopLeftRadius = UDim.new(0.5, 0), TopRightRadius = UDim.new(0.5, 0) })
		I[3] = new("Frame", I[1], "ArrowFrame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 179, 0), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
			I[4] = new("ImageLabel", I[3], "ArrowImage", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 179, 0), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(255, 179, 0), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=8213161276"), ImageTransparency = 1, Position = UDim2.fromScale(0.5, 0.01), Size = UDim2.fromScale(1, 0.58) })
		I[5] = new("ImageLabel", I[1], "IconImage", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 179, 0), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(255, 179, 0), ImageTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.87, 0.87) })
			I[6] = new("UICorner", I[5], "UICorner", { BottomLeftRadius = UDim.new(0.5, 0), BottomRightRadius = UDim.new(0.5, 0), TopLeftRadius = UDim.new(0.5, 0), TopRightRadius = UDim.new(0.5, 0) })
	return I[1]
end

return build
