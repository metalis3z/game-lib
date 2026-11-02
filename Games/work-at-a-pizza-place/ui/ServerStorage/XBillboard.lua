-- Generated from ui/ServerStorage/XBillboard.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "XBillboard", { AlwaysOnTop = true, MaxDistance = math.huge, Size = UDim2.fromScale(3, 3) })
		I[2] = new("Frame", I[1], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) })
			I[3] = new("ImageLabel", I[2], "X", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=168397389"), Size = UDim2.fromScale(1, 1), ZIndex = 2 })
	return I[1]
end

return build
