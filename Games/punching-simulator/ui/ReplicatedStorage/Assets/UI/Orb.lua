-- Generated from ui/ReplicatedStorage/Assets/UI/Orb.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "Orb", { Active = true, MaxDistance = math.huge, ResetOnSpawn = false, Size = UDim2.fromScale(2, 2), StudsOffset = Vector3.new(0, 1, 0) })
		I[2] = new("Frame", I[1], "Main", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) })
			I[3] = new("ImageLabel", I[2], "ObjectImg", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://10498883656"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.9), ZIndex = 2 })
			I[4] = new("ImageLabel", I[2], "SunburstImg", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://8678464764"), Position = UDim2.fromScale(0.5, 0.5), Rotation = 135, Size = UDim2.fromScale(2, 2) })
	return I[1]
end

return build
