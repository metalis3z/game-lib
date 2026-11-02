-- Generated from ui/StarterGui/Dialogue.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Dialogue", { DisplayOrder = 1, ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.65), Size = UDim2.fromScale(0.65, 0.25) })
			I[3] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 4 })
			I[4] = new("TextLabel", I[2], "textframe", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxassetid://11322590111", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.3475798), RichText = true, Size = UDim2.fromScale(0.885, 0.45), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 20, TextWrapped = true, ZIndex = 10 })
				I[5] = new("UIPadding", I[4], "UIPadding", { PaddingBottom = UDim.new(0.1, 0), PaddingLeft = UDim.new(0.1, 0), PaddingRight = UDim.new(0.1, 0), PaddingTop = UDim.new(0.1, 0) })
				I[6] = new("UITextSizeConstraint", I[4], "UITextSizeConstraint", { MaxTextSize = 36 })
			I[7] = new("Frame", I[2], "stage", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.fromScale(-0.01, -0.3), Selectable = true, Size = UDim2.fromScale(0.2298332, 0.7584494), Visible = false, ZIndex = 3 })
				I[8] = new("TextLabel", I[7], "name", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.7772713), Size = UDim2.fromScale(0.75, 0.3267668), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.5, TextWrapped = true, ZIndex = 10 })
					I[9] = new("UITextSizeConstraint", I[8], "UITextSizeConstraint", { MaxTextSize = 32 })
				I[10] = new("ViewportFrame", I[7], "viewport", { Ambient = Color3.fromRGB(201, 201, 255), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(104, 83, 144), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(255, 249, 240), LightColor = Color3.fromRGB(201, 201, 255), LightDirection = Vector3.new(1, -1, 0), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 4 })
					I[11] = new("UIAspectRatioConstraint", I[10], "UIAspectRatioConstraint")
				I[12] = new("UIAspectRatioConstraint", I[7], "UIAspectRatioConstraint", { DominantAxis = Enum.DominantAxis.Height })
				I[13] = new("ImageLabel", I[7], "spiral", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(152, 84, 255), ImageContent = Content.fromUri("rbxassetid://284872207"), ImageTransparency = 0.1, Size = UDim2.fromScale(1, 1) })
			I[14] = new("ImageLabel", I[2], "white", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://5142824217"), ImageTransparency = 0.1, Position = UDim2.fromScale(0.5, 0.3504658), Size = UDim2.fromScale(0.8045738, 0.9658908), SliceCenter = Rect.new(100, 100, 100, 100), SliceScale = 0.1, Visible = false, ZIndex = 0 })
			I[15] = new("ImageLabel", I[2], "sparkle1", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=37037765"), ImageTransparency = 0.1, Position = UDim2.fromScale(0.8769024, 0.7204262), Size = UDim2.fromScale(0.0287811, 0.1034272), SliceCenter = Rect.new(100, 100, 100, 100), SliceScale = 0.1, Visible = false, ZIndex = 2 })
			I[16] = new("ImageLabel", I[2], "sparkle2", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=37037765"), ImageTransparency = 0.1, Position = UDim2.fromScale(0.8680062, 0.6350241), Size = UDim2.fromScale(0.0287811, 0.1034272), SliceCenter = Rect.new(100, 100, 100, 100), SliceScale = 0.1, Visible = false, ZIndex = 2 })
			I[17] = new("ImageLabel", I[2], "sparkle3", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=37037765"), ImageTransparency = 0.1, Position = UDim2.fromScale(0.8494053, 0.7097511), Size = UDim2.fromScale(0.0206938, 0.0874144), SliceCenter = Rect.new(100, 100, 100, 100), SliceScale = 0.1, Visible = false, ZIndex = 2 })
			I[18] = new("Frame", I[2], "background", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.348), Size = UDim2.fromScale(0.95, 0.65) })
				I[19] = new("UIGradient", I[18], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)) }), Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.2587007, 0.2625), NumberSequenceKeypoint.new(0.5, 0.16875), NumberSequenceKeypoint.new(0.7459397, 0.25625), NumberSequenceKeypoint.new(1, 1) }) })
				I[20] = new("UICorner", I[18], "UICorner", { BottomLeftRadius = UDim.new(0, 10), BottomRightRadius = UDim.new(0, 10), TopLeftRadius = UDim.new(0, 10), TopRightRadius = UDim.new(0, 10) })
				I[21] = new("TextLabel", I[18], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), RichText = true, Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
			I[22] = new("TextLabel", I[2], "nameframe", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://11322590111", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2179073, -0.0287232), RichText = true, Size = UDim2.fromScale(0.3208145, 0.2084458), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 20, TextWrapped = true, Visible = false, ZIndex = 10 })
				I[23] = new("UIPadding", I[22], "UIPadding", { PaddingBottom = UDim.new(0.1, 0), PaddingRight = UDim.new(0.1, 0), PaddingTop = UDim.new(0.1, 0) })
				I[24] = new("UITextSizeConstraint", I[22], "UITextSizeConstraint", { MaxTextSize = 36 })
			I[25] = new("Frame", I[2], "black", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ClipsDescendants = true, Position = UDim2.fromScale(0.5, 0.35), Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 0 })
				I[26] = new("ImageLabel", I[25], "blackSimple", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://1014927013"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(100, 100, 100, 100), SliceScale = 0.1, ZIndex = 0 })
				I[27] = new("ImageLabel", I[25], "back", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(254, 252, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(252, 255, 223), ImageContent = Content.fromUri("rbxassetid://91170459416046"), Position = UDim2.fromScale(0.5, 0.51), Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(100, 100, 100, 100), SliceScale = 0.1, ZIndex = -1 })
				I[28] = new("ImageLabel", I[25], "black", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(252, 255, 223), ImageContent = Content.fromUri("rbxassetid://91170459416046"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(100, 100, 100, 100), SliceScale = 0.1, ZIndex = 0 })
				I[29] = new("ImageLabel", I[25], "lines", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://7793135243"), ImageTransparency = 0.8, Position = UDim2.fromScale(0.4993806, 0.4897405), ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(0.9194848, 0.702474), SliceCenter = Rect.new(100, 100, 100, 100), SliceScale = 0.1, TileSize = UDim2.fromScale(1, 0.125) })
					I[30] = new("Decal", I[29], "Red Line", { TextureContent = Content.fromUri("rbxassetid://7793135243") })
	return I[1]
end

return build
