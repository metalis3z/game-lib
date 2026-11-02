-- Generated from ui/StarterGui/Mobile.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Mobile", { DisplayOrder = 11, Enabled = false, ResetOnSpawn = false })
		I[2] = new("ImageButton", I[1], "Shoot", { Active = false, AnchorPoint = Vector2.new(1, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=4010083981"), ImageTransparency = 0.5, Position = UDim2.new(0.975, 0, 0.52, 3), ScaleType = Enum.ScaleType.Slice, Size = UDim2.new(0.425, 0, 0.9, -40), SliceCenter = Rect.new(10, 10, 40, 40), ZIndex = 3 })
			I[3] = new("ImageLabel", I[2], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://4456755759"), ImageTransparency = 0.5, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.new(0.25, 15, 1, 10), ZIndex = 3 })
				I[4] = new("UIAspectRatioConstraint", I[3], "UIAspectRatioConstraint")
			I[5] = new("ImageLabel", I[2], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://5431965152"), ImageTransparency = 0.5, ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(20, 20, 80, 80), ZIndex = 2 })
		I[6] = new("ImageButton", I[1], "Leaderboard", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://5431965152"), Position = UDim2.fromScale(1, 0), ScaleType = Enum.ScaleType.Slice, Size = UDim2.new(0.2, 0, 0.0715333, 20), SliceCenter = Rect.new(20, 20, 80, 80) })
			I[7] = new("UIAspectRatioConstraint", I[6], "UIAspectRatioConstraint")
			I[8] = new("ImageLabel", I[6], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://4352720065"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.8, 0.8) })
		I[9] = new("UIPadding", I[1], "UIPadding", { PaddingBottom = UDim.new(0.005, 4), PaddingLeft = UDim.new(0.003, 4), PaddingRight = UDim.new(0.003, 4), PaddingTop = UDim.new(0.005, 4) })
		I[10] = new("ImageButton", I[1], "ADS", { Active = false, AnchorPoint = Vector2.new(0, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=4010083981"), ImageTransparency = 0.5, Position = UDim2.new(0.025, 10, 0.54, 0), ScaleType = Enum.ScaleType.Slice, Size = UDim2.new(0.05, 25, 0, 200), SliceCenter = Rect.new(10, 10, 40, 40), ZIndex = 2 })
			I[11] = new("UIAspectRatioConstraint", I[10], "UIAspectRatioConstraint")
			I[12] = new("ImageLabel", I[10], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://4456755833"), ImageTransparency = 0.5, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.8, 0.8), ZIndex = 2 })
				I[13] = new("UIAspectRatioConstraint", I[12], "UIAspectRatioConstraint")
			I[14] = new("ImageLabel", I[10], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://5431965152"), ImageTransparency = 0.5, ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(20, 20, 80, 80) })
	return I[1]
end

return build
