-- Generated from ui/ReplicatedStorage/Controllers/ItemController/PaintballGunController/Paint.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ImageLabel", nil, "Paint", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://8598810246"), Position = UDim2.fromScale(0.5229419, 0.4229543), Size = UDim2.fromScale(0.2361673, 0.3719447) }, { ["_lemonadeUniqueId"] = "Ku358nWUKu35" })
		I[2] = new("UIAspectRatioConstraint", I[1], "UIAspectRatioConstraint", nil, { ["_lemonadeUniqueId"] = "E98O0UZXE98O" })
	return I[1]
end

return build
