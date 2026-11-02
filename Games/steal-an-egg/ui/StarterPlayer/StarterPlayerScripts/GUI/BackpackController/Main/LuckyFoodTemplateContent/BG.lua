-- Generated from ui/StarterPlayer/StarterPlayerScripts/GUI/BackpackController/Main/LuckyFoodTemplateContent/BG.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "BG", { BackgroundColor3 = Color3.fromRGB(17, 19, 20), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Size = UDim2.fromScale(1, 1), ZIndex = -100 })
		I[2] = new("UICorner", I[1], "UICorner")
		I[3] = new("ImageLabel", I[1], "Glow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://126841495627073"), ImageTransparency = 0.7, Position = UDim2.fromScale(0.4723356, 0.6840919), Size = UDim2.fromScale(1.941677, 1.3363403), ZIndex = 21 })
			I[4] = new("UIGradient", I[3], "UIGradient")
	return I[1]
end

return build
