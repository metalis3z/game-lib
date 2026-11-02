-- Generated from ui/StarterGui/ScreenGui.rbxm by _tools/rbxm2lua.luau
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
		I[2] = new("Frame", I[1], "Health", { BackgroundColor3 = Color3.fromRGB(20, 20, 20), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.new(-0.0165704, 85, 0.7553099, 0), Size = UDim2.fromScale(0.2016727, 0.0576139), ZIndex = 10 })
			I[3] = new("Frame", I[2], "Bar", { BackgroundColor3 = Color3.fromRGB(115, 115, 115), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.0010679, 0), Size = UDim2.fromScale(0.998932, 1.0000006), ZIndex = 10 })
			I[4] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 7.5702991 })
		I[5] = new("ImageLabel", I[1], "ImageLabelHP", { BackgroundColor3 = Color3.fromRGB(50, 50, 50), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://398940987"), ImageTransparency = 1, Position = UDim2.new(-0.0223577, 35, 0.7553099, 0), Size = UDim2.fromScale(0.0269448, 0.0576139) })
			I[6] = new("UIAspectRatioConstraint", I[5], "UIAspectRatioConstraint", { AspectRatio = 1.0114415 })
		I[7] = new("Frame", I[1], "Stamina", { BackgroundColor3 = Color3.fromRGB(20, 20, 20), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.new(-0.0165704, 85, 0.8405021, 0), Size = UDim2.fromScale(0.2020859, 0.0580752), ZIndex = 10 })
			I[8] = new("Frame", I[7], "Bar", { BackgroundColor3 = Color3.fromRGB(115, 115, 115), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.fromScale(0.0010658, 0), Size = UDim2.fromScale(0.9989341, 1.0276163), ZIndex = 10 })
			I[9] = new("UIAspectRatioConstraint", I[7], "UIAspectRatioConstraint", { AspectRatio = 7.5255542 })
		I[10] = new("ImageLabel", I[1], "ImageLabelSP", { BackgroundColor3 = Color3.fromRGB(50, 50, 50), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://541620958"), ImageTransparency = 1, Position = UDim2.new(-0.0223577, 35, 0.8422454, 0), Size = UDim2.fromScale(0.026828, 0.0576139), ZIndex = 10 })
			I[11] = new("UIAspectRatioConstraint", I[10], "UIAspectRatioConstraint", { AspectRatio = 1.0070581 })
	return I[1]
end

return build
