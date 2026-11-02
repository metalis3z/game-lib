-- Generated from ui/ReplicatedStorage/Resources/Sunrise/ImpactFrame.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "ImpactFrame", { ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("ImageLabel", I[1], "1", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://16042830962"), Size = UDim2.fromScale(1, 1), Visible = false })
		I[3] = new("ImageLabel", I[1], "10", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://16042830626"), Size = UDim2.fromScale(1, 1), Visible = false })
		I[4] = new("ImageLabel", I[1], "11", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://16042833831"), Size = UDim2.fromScale(1, 1), Visible = false })
		I[5] = new("ImageLabel", I[1], "12", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://16042834411"), Size = UDim2.fromScale(1, 1), Visible = false })
		I[6] = new("ImageLabel", I[1], "2", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://16042831168"), Size = UDim2.fromScale(1, 1), Visible = false })
		I[7] = new("ImageLabel", I[1], "3", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://16042831574"), Size = UDim2.fromScale(1, 1), Visible = false })
		I[8] = new("ImageLabel", I[1], "4", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://16042831829"), Size = UDim2.fromScale(1, 1), Visible = false })
		I[9] = new("ImageLabel", I[1], "5", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://16042832058"), Size = UDim2.fromScale(1, 1), Visible = false })
		I[10] = new("ImageLabel", I[1], "6", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://16042832395"), Size = UDim2.fromScale(1, 1), Visible = false })
		I[11] = new("ImageLabel", I[1], "7", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://16042832710"), Size = UDim2.fromScale(1, 1), Visible = false })
		I[12] = new("ImageLabel", I[1], "8", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://16042833093"), Size = UDim2.fromScale(1, 1), Visible = false })
		I[13] = new("ImageLabel", I[1], "9", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://16042833348"), Size = UDim2.fromScale(1, 1), Visible = false })
	return I[1]
end

return build
