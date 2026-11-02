-- Generated from ui/ReplicatedStorage/Assets/CanHatch.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "CanHatch", { Active = true, AlwaysOnTop = true, MaxDistance = 250, Size = UDim2.fromScale(3.5, 3.5), StudsOffset = Vector3.new(0, 0, -1), StudsOffsetWorldSpace = Vector3.new(0, 2, 0), ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("ImageLabel", I[1], "Icon", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(255, 0, 0), ImageContent = Content.fromUri("rbxassetid://70540601313860"), Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromScale(1, 1) })
	return I[1]
end

return build
