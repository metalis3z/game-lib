-- Generated from ui/StarterPlayer/StarterPlayerScripts/Scripts/GUIs/Buy Credits/BackdropEffect.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ImageLabel", nil, "BackdropEffect", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=3834644695"), Position = UDim2.fromScale(0.5, 0.475), ScaleType = Enum.ScaleType.Slice, Size = UDim2.new(0.2, 250, 0.25, 150), SliceCenter = Rect.new(10, 10, 40, 40), ZIndex = 0 })
		I[2] = new("UIAspectRatioConstraint", I[1], "UIAspectRatioConstraint", { AspectRatio = 1.2 })
	return I[1]
end

return build
