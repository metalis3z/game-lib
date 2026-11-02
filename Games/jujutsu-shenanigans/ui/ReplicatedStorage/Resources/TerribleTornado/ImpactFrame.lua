-- Generated from ui/ReplicatedStorage/Resources/TerribleTornado/ImpactFrame.rbxm by _tools/rbxm2lua.luau
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
		I[2] = new("ImageLabel", I[1], "2", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://17276089013"), Size = UDim2.fromScale(1, 1), Visible = false })
		I[3] = new("ImageLabel", I[1], "3", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://17276089280"), Size = UDim2.fromScale(1, 1), Visible = false })
		I[4] = new("ImageLabel", I[1], "4", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://17276088758"), Size = UDim2.fromScale(1, 1), Visible = false })
		I[5] = new("Frame", I[1], "5", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), Visible = false })
		I[6] = new("Frame", I[1], "1", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), Visible = false })
	return I[1]
end

return build
