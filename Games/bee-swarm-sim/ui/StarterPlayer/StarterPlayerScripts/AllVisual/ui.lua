-- Generated from ui/StarterPlayer/StarterPlayerScripts/AllVisual/ui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "ui", { Active = true, ClipsDescendants = true, MaxDistance = math.huge, Size = UDim2.fromScale(5, 5), StudsOffset = Vector3.new(0, 2, 0), ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("ImageLabel", I[1], "Icon", { Active = true, AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(99, 144, 184), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://9656864988"), Position = UDim2.fromScale(0.5, 1) })
	return I[1]
end

return build
