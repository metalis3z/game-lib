-- Generated from ui/StarterGui/CrouchSystem.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "CrouchSystem", { ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("ImageButton", I[1], "Crouch", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://16174149332"), Position = UDim2.fromScale(0.9447222, 0.6506216), Size = UDim2.fromScale(0.0362245, 0.0639675), Visible = false })
			I[3] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0, 5), BottomRightRadius = UDim.new(0, 5), TopLeftRadius = UDim.new(0, 5), TopRightRadius = UDim.new(0, 5) })
			I[4] = new("Animation", I[2], "Animation", { AnimationContent = Content.fromUri("rbxassetid://16210164256") })
			I[5] = new("UIStroke", I[2], "UIStroke", { Thickness = 1.5 })
	return I[1]
end

return build
