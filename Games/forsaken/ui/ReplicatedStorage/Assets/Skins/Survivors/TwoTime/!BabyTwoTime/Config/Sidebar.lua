-- Generated from ui/ReplicatedStorage/Assets/Skins/Survivors/TwoTime/!BabyTwoTime/Config/Sidebar.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Sidebar", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(1.175, 0.5), Size = UDim2.fromScale(1, 0.4), ZIndex = -100 })
		I[2] = new("Frame", I[1], "Bar", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.8981291, 0.1449144), Size = UDim2.fromScale(0.024, 0.827027) })
			I[3] = new("Frame", I[2], "Inner", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(112, 35, 188), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromScale(1, 1) })
		I[4] = new("UIAspectRatioConstraint", I[1], "UIAspectRatioConstraint", { AspectRatio = 3 })
		I[5] = new("ImageLabel", I[1], "Full", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://76885930478939"), ImageRectOffset = Vector2.new(2, 2), ImageRectSize = Vector2.new(251, 864), Position = UDim2.fromScale(0.9095634, 0.5258706), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1.5823653, 1.6965147), Visible = false, ZIndex = 2 })
			I[6] = new("UIScale", I[5], "UIScale", { Scale = 0.75 })
			I[7] = new("UIAspectRatioConstraint", I[5], "UIAspectRatioConstraint", { AspectRatio = 1.85 })
			I[8] = new("ImageLabel", I[5], "Wings", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://122852977547687"), ImageRectSize = Vector2.new(322, 322), Position = UDim2.fromScale(0.4995774, 0.4124148), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.2624116, 0.3084703), SizeConstraint = Enum.SizeConstraint.RelativeXX, ZIndex = -15 })
				I[9] = new("UIScale", I[8], "UIScale", { Scale = 0.8 })
			I[10] = new("ImageLabel", I[5], "Vines", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://93860737248045"), ImageRectOffset = Vector2.new(2, 2), ImageRectSize = Vector2.new(151, 547), Position = UDim2.fromScale(0.5404553, 0.5640761), Size = UDim2.fromScale(0.1375839, 0.9220396), ZIndex = 3 })
				I[11] = new("UIScale", I[10], "UIScale", { Scale = 0.6 })
				I[12] = new("UIAspectRatioConstraint", I[10], "UIAspectRatioConstraint", { AspectRatio = 0.3, AspectType = Enum.AspectType.ScaleWithParentSize, DominantAxis = Enum.DominantAxis.Height })
		I[13] = new("ImageLabel", I[1], "Display", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://119735494294262"), ImageRectOffset = Vector2.new(2, 2), ImageRectSize = Vector2.new(166, 791), Position = UDim2.fromScale(0.9085587, 0.4820895), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1.1, 1), SizeConstraint = Enum.SizeConstraint.RelativeXX, ZIndex = 4 })
			I[14] = new("UIAspectRatioConstraint", I[13], "UIAspectRatioConstraint", { AspectRatio = 1.85 })
			I[15] = new("UIScale", I[13], "UIScale", { Scale = 0.68 })
	return I[1]
end

return build
