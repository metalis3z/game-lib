-- Generated from ui/ReplicatedStorage/Utils/Choso/Switch.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "Switch", { Active = true, Brightness = 155, MaxDistance = math.huge, Size = UDim2.fromScale(1, 1), StudsOffset = Vector3.new(0, 0, 1), ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("ImageLabel", I[1], "Eye1", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(255, 0, 0), ImageContent = Content.fromUri("rbxassetid://9953839287"), Position = UDim2.fromScale(0.4, 0.5), Rotation = -90, Size = UDim2.fromScale(0.3, 0.02), ZIndex = 2 })
		I[3] = new("ImageLabel", I[1], "Eye3", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(255, 0, 0), ImageContent = Content.fromUri("rbxassetid://9953839287"), Position = UDim2.fromScale(0.6, 0.5), Rotation = -90, Size = UDim2.fromScale(0.3, 0.02), ZIndex = 2 })
		I[4] = new("ImageLabel", I[1], "Eye2", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(255, 0, 0), ImageContent = Content.fromUri("rbxassetid://9953839287"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.6, 0.02), ZIndex = 2 })
	return I[1]
end

return build
