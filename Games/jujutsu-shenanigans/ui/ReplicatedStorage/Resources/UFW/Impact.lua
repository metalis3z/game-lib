-- Generated from ui/ReplicatedStorage/Resources/UFW/Impact.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Impact", { ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("ImageLabel", I[1], "Screen", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), Size = UDim2.fromScale(1, 1), Visible = false })
		I[3] = new("Folder", I[1], "Frames")
			I[4] = new("ImageLabel", I[3], "2", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://132041598730582"), Size = UDim2.fromScale(1, 1), Visible = false })
			I[5] = new("ImageLabel", I[3], "1", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://88479946788220"), Size = UDim2.fromScale(1, 1), Visible = false })
	return I[1]
end

return build
