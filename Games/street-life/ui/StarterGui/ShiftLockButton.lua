-- Generated from ui/StarterGui/ShiftLockButton.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "ShiftLockButton", { ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("ImageButton", I[1], "ImageButton", { AnchorPoint = Vector2.new(1, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxasset://textures/ui/mouseLock_off@2x.png"), Position = UDim2.fromScale(0.0585632, 0.7755519), Size = UDim2.fromScale(0.0282665, 0.0284307), SizeConstraint = Enum.SizeConstraint.RelativeXX, Visible = false })
			I[3] = new("RemoteEvent", I[2], "RemoteEvent")
	return I[1]
end

return build
