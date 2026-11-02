-- Generated from ui/ReplicatedStorage/LoadingScreen.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "LoadingScreen", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), ZIndex = 5 })
		I[2] = new("ImageLabel", I[1], "Pizza", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://167850847"), Position = UDim2.new(0, 0, 1, -150), Size = UDim2.fromOffset(150, 150), ZIndex = 6 })
		I[3] = new("TextLabel", I[1], "Loading", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Text = "Loading", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 36 })
	return I[1]
end

return build
