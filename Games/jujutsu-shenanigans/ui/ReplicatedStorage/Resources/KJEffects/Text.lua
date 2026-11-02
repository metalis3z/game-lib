-- Generated from ui/ReplicatedStorage/Resources/KJEffects/Text.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Text", { ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("ImageLabel", I[1], "Frame1", { BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=17082594577"), Size = UDim2.fromScale(1, 1), Visible = false })
		I[3] = new("ImageLabel", I[1], "Frame10", { BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=17082592741"), Size = UDim2.fromScale(1, 1), Visible = false })
		I[4] = new("ImageLabel", I[1], "Frame11", { BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=17082592541"), Size = UDim2.fromScale(1, 1), Visible = false })
		I[5] = new("ImageLabel", I[1], "Frame12", { BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=17082592286"), Size = UDim2.fromScale(1, 1), Visible = false })
		I[6] = new("ImageLabel", I[1], "Frame13", { BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=17082592073"), Size = UDim2.fromScale(1, 1), Visible = false })
		I[7] = new("ImageLabel", I[1], "Frame14", { BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=17082591876"), Size = UDim2.fromScale(1, 1), Visible = false })
		I[8] = new("ImageLabel", I[1], "Frame15", { BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=17082591635"), Size = UDim2.fromScale(1, 1), Visible = false })
		I[9] = new("ImageLabel", I[1], "Frame16", { BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=17082591387"), Size = UDim2.fromScale(1, 1), Visible = false })
		I[10] = new("ImageLabel", I[1], "Frame2", { BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=17082594407"), Size = UDim2.fromScale(1, 1), Visible = false })
		I[11] = new("ImageLabel", I[1], "Frame3", { BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=17082594116"), Size = UDim2.fromScale(1, 1), Visible = false })
		I[12] = new("ImageLabel", I[1], "Frame4", { BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=17082593962"), Size = UDim2.fromScale(1, 1), Visible = false })
		I[13] = new("ImageLabel", I[1], "Frame5", { BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=17082593830"), Size = UDim2.fromScale(1, 1), Visible = false })
		I[14] = new("ImageLabel", I[1], "Frame6", { BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=17082593575"), Size = UDim2.fromScale(1, 1), Visible = false })
		I[15] = new("ImageLabel", I[1], "Frame7", { BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=17082593325"), Size = UDim2.fromScale(1, 1), Visible = false })
		I[16] = new("ImageLabel", I[1], "Frame8", { BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=17082593092"), Size = UDim2.fromScale(1, 1), Visible = false })
		I[17] = new("ImageLabel", I[1], "Frame9", { BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=17082592898"), Size = UDim2.fromScale(1, 1), Visible = false })
	return I[1]
end

return build
