-- Generated from ui/StarterGui/ScreenGui~4.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "ScreenGui")
		I[2] = new("ImageLabel", I[1], "Darker", { BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=228322184"), Position = UDim2.fromScale(-0.0055, -0.0839354), Size = UDim2.fromScale(1.0055, 1.1), Visible = false })
		I[3] = new("ImageLabel", I[1], "Overlay", { BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=228322184"), ImageTransparency = 0.5, Position = UDim2.fromScale(-0.0055, -0.073902), Size = UDim2.fromScale(1.0055, 1.1) })
	return I[1]
end

return build
