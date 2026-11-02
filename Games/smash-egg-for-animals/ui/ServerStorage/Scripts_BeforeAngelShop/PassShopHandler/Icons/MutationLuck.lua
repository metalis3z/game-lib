-- Generated from ui/ServerStorage/Scripts_BeforeAngelShop/PassShopHandler/Icons/MutationLuck.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "MutationLuck", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(64, 64), ZIndex = 2 })
		I[2] = new("ImageLabel", I[1], "LuckImage", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://132289482504067"), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1) })
	return I[1]
end

return build
