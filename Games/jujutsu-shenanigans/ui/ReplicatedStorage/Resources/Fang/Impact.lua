-- Generated from ui/ReplicatedStorage/Resources/Fang/Impact.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Impact", { Enabled = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("ImageLabel", I[1], "8", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://18810987511"), Size = UDim2.fromScale(1, 1) })
		I[3] = new("ImageLabel", I[1], "9", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://18810988079"), Size = UDim2.fromScale(1, 1) })
		I[4] = new("ImageLabel", I[1], "10", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://18810984802"), Size = UDim2.fromScale(1, 1) })
		I[5] = new("ImageLabel", I[1], "1", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://18810985136"), Size = UDim2.fromScale(1, 1) })
		I[6] = new("ImageLabel", I[1], "2", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://18810985423"), Size = UDim2.fromScale(1, 1) })
		I[7] = new("ImageLabel", I[1], "3", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://18810985821"), Size = UDim2.fromScale(1, 1) })
		I[8] = new("ImageLabel", I[1], "4", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://18810986239"), Size = UDim2.fromScale(1, 1) })
		I[9] = new("ImageLabel", I[1], "5", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://18810986512"), Size = UDim2.fromScale(1, 1) })
		I[10] = new("ImageLabel", I[1], "6", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://18810986733"), Size = UDim2.fromScale(1, 1) })
		I[11] = new("ImageLabel", I[1], "7", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://18810987065"), Size = UDim2.fromScale(1, 1) })
	return I[1]
end

return build
