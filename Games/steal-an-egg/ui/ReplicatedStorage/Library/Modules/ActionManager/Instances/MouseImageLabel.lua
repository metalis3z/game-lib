-- Generated from ui/ReplicatedStorage/Library/Modules/ActionManager/Instances/MouseImageLabel.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ImageLabel", nil, "MouseImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxasset://textures/ui/Controls/key_single.png"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(24, 32) }, { ["__syncback_sanitization_auto_save"] = "MouseImageLabel" })
	return I[1]
end

return build
