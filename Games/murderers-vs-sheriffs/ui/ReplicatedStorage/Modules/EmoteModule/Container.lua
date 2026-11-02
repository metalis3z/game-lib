-- Generated from ui/ReplicatedStorage/Modules/EmoteModule/Container.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Container", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(54, 54, 54), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(3, 1), SizeConstraint = Enum.SizeConstraint.RelativeYY })
		I[2] = new("Frame", I[1], "Emote1", { BackgroundColor3 = Color3.fromRGB(54, 54, 54), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 2, Size = UDim2.fromScale(0.333, 1) })
			I[3] = new("Frame", I[2], "Container", { BackgroundColor3 = Color3.fromRGB(68, 68, 68), BackgroundTransparency = 0.1, BorderColor3 = Color3.fromRGB(22, 22, 22), Position = UDim2.fromOffset(4, 4), Size = UDim2.new(1, -8, 1, -8) })
		I[4] = new("Frame", I[1], "Emote2", { BackgroundColor3 = Color3.fromRGB(54, 54, 54), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 2, Position = UDim2.fromScale(0.333, 0), Size = UDim2.fromScale(0.333, 1) })
			I[5] = new("Frame", I[4], "Container", { BackgroundColor3 = Color3.fromRGB(68, 68, 68), BackgroundTransparency = 0.1, BorderColor3 = Color3.fromRGB(22, 22, 22), Position = UDim2.fromOffset(4, 4), Size = UDim2.new(1, -8, 1, -8) })
		I[6] = new("Frame", I[1], "Emote3", { BackgroundColor3 = Color3.fromRGB(54, 54, 54), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 2, Position = UDim2.fromScale(0.666, 0), Size = UDim2.fromScale(0.333, 1) })
			I[7] = new("Frame", I[6], "Container", { BackgroundColor3 = Color3.fromRGB(68, 68, 68), BackgroundTransparency = 0.1, BorderColor3 = Color3.fromRGB(22, 22, 22), Position = UDim2.fromOffset(4, 4), Size = UDim2.new(1, -8, 1, -8) })
	return I[1]
end

return build
