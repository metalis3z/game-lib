-- Generated from ui/ReplicatedStorage/Assets/Skins/Survivors/TwoTime/!BabyTwoTime/Config/Sidebarbackupbackup.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Sidebarbackupbackup", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(1, 0.5), Size = UDim2.fromScale(1, 0.523), ZIndex = -100 })
		I[2] = new("ImageLabel", I[1], "Display", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://119735494294262"), ImageRectOffset = Vector2.new(2, 2), ImageRectSize = Vector2.new(166, 791), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1.5823653, 1.6965147), ZIndex = 2 })
			I[3] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 1.85 })
			I[4] = new("UIScale", I[2], "UIScale", { Scale = 0.75 })
		I[5] = new("ImageLabel", I[1], "Full", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://76885930478939"), ImageRectOffset = Vector2.new(2, 2), ImageRectSize = Vector2.new(251, 864), Position = UDim2.fromScale(0.9095634, 0.5258706), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1.5823653, 1.6965147), Visible = false, ZIndex = 2 })
			I[6] = new("ImageLabel", I[5], "vine instance ", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://93860737248045"), ImageRectOffset = Vector2.new(2, 2), ImageRectSize = Vector2.new(151, 547), Position = UDim2.fromScale(0.5404553, 0.5640761), Size = UDim2.fromScale(0.0902328, 0.6698895), ZIndex = 3 })
				I[7] = new("UIScale", I[6], "UIScale", { Scale = 0.9 })
			I[8] = new("ImageLabel", I[5], "wings instance ", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://103226950779563"), ImageRectOffset = Vector2.new(292, 2), ImageRectSize = Vector2.new(285, 196), Position = UDim2.fromScale(0.4995773, 0.2031281), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.236124, 0.2520576), ZIndex = -15 })
				I[9] = new("UIScale", I[8], "UIScale")
			I[10] = new("UIAspectRatioConstraint", I[5], "UIAspectRatioConstraint", { AspectRatio = 1.85 })
			I[11] = new("UIScale", I[5], "UIScale", { Scale = 0.75 })
		I[12] = new("Frame", I[1], "Bar", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.8981289, 0.1731343), Size = UDim2.fromScale(0.024255, 0.7701492) })
			I[13] = new("Frame", I[12], "Inner", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(112, 35, 188), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromScale(1, 0) })
	return I[1]
end

return build
