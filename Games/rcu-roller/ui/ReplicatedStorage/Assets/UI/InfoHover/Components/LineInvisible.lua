-- Generated from ui/ReplicatedStorage/Assets/UI/InfoHover/Components/LineInvisible.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "LineInvisible", { BackgroundColor3 = Color3.fromRGB(107, 107, 107), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 7, Position = UDim2.fromScale(-0.0187075, 0.7784109), Size = UDim2.fromScale(1.0374149, 0.0183824), ZIndex = 1550 })
		I[2] = new("ImageLabel", I[1], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 32, 54), ImageContent = Content.fromUri("rbxassetid://18137398778"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.97, 3), Visible = false, ZIndex = 1550 })
	return I[1]
end

return build
