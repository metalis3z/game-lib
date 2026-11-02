-- Generated from ui/ReplicatedStorage/Assets/LightingHit.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "LightingHit", { Active = true, Brightness = 10, ClipsDescendants = true, Enabled = false, MaxDistance = math.huge, ResetOnSpawn = false, Size = UDim2.fromScale(15, 7.5) })
		I[2] = new("ImageLabel", I[1], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(93, 115, 255), ImageContent = Content.fromUri("rbxassetid://7731367965"), Size = UDim2.fromScale(1, 1) })
	return I[1]
end

return build
