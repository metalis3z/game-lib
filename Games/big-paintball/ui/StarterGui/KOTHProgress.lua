-- Generated from ui/StarterGui/KOTHProgress.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "KOTHProgress", { DisplayOrder = 5, Enabled = false, ResetOnSpawn = false })
		I[2] = new("ImageLabel", I[1], "Container", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://5431965152"), Position = UDim2.new(0.5, 0, 0.2, 25), ScaleType = Enum.ScaleType.Slice, Size = UDim2.new(0.5, 0, 0.02, 8), SliceCenter = Rect.new(20, 20, 80, 80) })
			I[3] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 14 })
			I[4] = new("ImageLabel", I[2], "Red", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(255, 30, 30), ImageContent = Content.fromUri("rbxassetid://5431965152"), Position = UDim2.fromScale(0, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0, 1), SliceCenter = Rect.new(20, 20, 80, 80), SliceScale = 2, ZIndex = 3 })
			I[5] = new("UIPadding", I[2], "UIPadding", { PaddingBottom = UDim.new(0.1, 1), PaddingLeft = UDim.new(0.01, 1), PaddingRight = UDim.new(0.01, 1), PaddingTop = UDim.new(0.1, 1) })
			I[6] = new("Frame", I[2], "Center", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.5, 1.86), ZIndex = 3 })
				I[7] = new("UICorner", I[6], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
				I[8] = new("UIAspectRatioConstraint", I[6], "UIAspectRatioConstraint")
				I[9] = new("ImageLabel", I[6], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://7596166308"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.75, 1), ZIndex = 4 })
			I[10] = new("ImageLabel", I[2], "Blue", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 255, 255), ImageContent = Content.fromUri("rbxassetid://5431965152"), Position = UDim2.fromScale(1, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0, 1), SliceCenter = Rect.new(20, 20, 80, 80), SliceScale = 2, ZIndex = 3 })
			I[11] = new("Frame", I[2], "GainEffect", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.5, 1.86), Visible = false, ZIndex = 2 })
				I[12] = new("UICorner", I[11], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
				I[13] = new("UIAspectRatioConstraint", I[11], "UIAspectRatioConstraint")
				I[14] = new("UIScale", I[11], "UIScale")
			I[15] = new("TextLabel", I[2], "RedLabel", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(0.425, 0.9), Text = "0%", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextTransparency = 0.15, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, ZIndex = 4 })
			I[16] = new("TextLabel", I[2], "BlueLabel", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.575, 0.5), Size = UDim2.fromScale(0.5, 0.9), Text = "0%", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextTransparency = 0.15, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 4 })
	return I[1]
end

return build
