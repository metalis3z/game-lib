-- Generated from ui/ReplicatedStorage/Assets/Billboards/EvilFaces/EvilTrollface_6.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "EvilTrollface_6", { Active = true, AlwaysOnTop = true, ClipsDescendants = true, LightInfluence = 1, MaxDistance = 67, Size = UDim2.fromScale(2.5, 2), ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("UIPadding", I[1], "UIPadding", { PaddingLeft = UDim.new(0.05, 0), PaddingRight = UDim.new(0.05, 0) })
		I[3] = new("ImageLabel", I[1], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://125924161980189"), Size = UDim2.fromScale(1, 1) })
	return I[1]
end

return build
