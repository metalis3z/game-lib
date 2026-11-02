-- Generated from ui/StarterPlayer/StarterPlayerScripts/Controllers/OutfitsController/showcaseOutfit.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ViewportFrame", nil, "showcaseOutfit", { Ambient = Color3.fromRGB(202, 202, 202), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, LightColor = Color3.fromRGB(221, 221, 221), LightDirection = Vector3.new(0.5, -1, 0.5), Position = UDim2.fromScale(0.4999998, 0.5438014), Size = UDim2.fromScale(1, 1) })
		I[2] = new("UIAspectRatioConstraint", I[1], "UIAspectRatioConstraint", { AspectRatio = 0.8 })
		I[3] = new("UIGradient", I[1], "UIGradient", { Rotation = 90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.05, 0), NumberSequenceKeypoint.new(0.96, 0), NumberSequenceKeypoint.new(1, 1) }) })
	return I[1]
end

return build
