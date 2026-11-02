-- Generated from ui/ServerStorage/e/Recipes.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Recipes", { BackgroundColor3 = Color3.fromRGB(25, 25, 25), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.new(1, -130, 0, 0), Size = UDim2.new(0, 0, 1, -46) })
		I[2] = new("Frame", I[1], "Container", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), ClipsDescendants = true, Size = UDim2.fromScale(1, 1), Style = Enum.FrameStyle.DropShadow, ZIndex = 2 })
			I[3] = new("ScrollingFrame", I[2], "ScrollFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ScrollBarThickness = 11, Size = UDim2.fromScale(1, 1), ZIndex = 5 })
	return I[1]
end

return build
