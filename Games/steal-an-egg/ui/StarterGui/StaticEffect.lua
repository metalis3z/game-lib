-- Generated from ui/StarterGui/StaticEffect.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "StaticEffect", { DisplayOrder = 10, Enabled = false, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("ImageLabel", I[1], "Static", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://88359247158017"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1.3, 1.1), ZIndex = 3 })
			I[3] = new("Decal", I[2], "Decal", { TextureContent = Content.fromUri("rbxassetid://100135598750223") })
				I[4] = new("Decal", I[3], "Decal", { TextureContent = Content.fromUri("rbxassetid://139730748749543") })
			I[5] = new("Decal", I[2], "Decal", { TextureContent = Content.fromUri("rbxassetid://79301680357265") })
			I[6] = new("Decal", I[2], "Decal", { TextureContent = Content.fromUri("rbxassetid://71457032318822") })
			I[7] = new("Decal", I[2], "Decal", { TextureContent = Content.fromUri("rbxassetid://77783410412430") })
			I[8] = new("Decal", I[2], "Decal", { TextureContent = Content.fromUri("rbxassetid://125098210896739") })
			I[9] = new("Decal", I[2], "Decal", { TextureContent = Content.fromUri("rbxassetid://70969977771959") })
			I[10] = new("Decal", I[2], "Decal", { TextureContent = Content.fromUri("rbxassetid://75612975384626") })
	return I[1]
end

return build
