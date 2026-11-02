-- Generated from ui/ReplicatedStorage/Resources/BossHP.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "BossHP", { ResetOnSpawn = false })
		I[2] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.new(0.5, 0, 0, 100), Size = UDim2.fromScale(0.4360842, 0.0200669) })
			I[3] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 29.9444447 })
			I[4] = new("ImageLabel", I[2], "Border", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, ImageContent = Content.fromUri("rbxassetid://18903469656"), Position = UDim2.fromScale(0.5, 0.444), Size = UDim2.fromScale(1, 0.9444444), ZIndex = 3 })
				I[5] = new("ImageLabel", I[4], "Void", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, ImageColor3 = Color3.fromRGB(90, 90, 90), ImageContent = Content.fromUri("rbxassetid://18903674858"), Position = UDim2.fromScale(0.5, 0.444), Size = UDim2.fromScale(0.992, 0.944), ZIndex = 0 })
				I[6] = new("ImageLabel", I[4], "Red", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(255, 84, 84), ImageContent = Content.fromUri("rbxassetid://18903674858"), Position = UDim2.fromScale(0.0055659, 0.4581111), Size = UDim2.fromScale(0.9888683, 0.9162223) })
			I[7] = new("ImageLabel", I[2], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://18905953868"), Position = UDim2.fromScale(0.3131945, -6.4372678), Size = UDim2.fromScale(0.3706443, 11.0987377), ZIndex = 5 })
				I[8] = new("UIAspectRatioConstraint", I[7], "UIAspectRatioConstraint")
	return I[1]
end

return build
