-- Generated from ui/ServerStorage/Admin.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ImageButton", nil, "Admin", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, HoverImageContent = Content.fromUri("rbxassetid://15313055120"), ImageContent = Content.fromUri("rbxassetid://8465866782"), ImageTransparency = 0.15, LayoutOrder = 99, Position = UDim2.fromScale(-0.0353642, 0.8742938), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromOffset(50, 50) })
	return I[1]
end

return build
