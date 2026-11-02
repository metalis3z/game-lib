-- Generated from ui/StarterGui/Photobooth.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Photobooth", { Enabled = false, ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, nil, { "Themed" })
		I[2] = new("TextButton", I[1], "exit", { AnchorPoint = Vector2.new(1, 1), BackgroundColor3 = Color3.fromRGB(255, 95, 92), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.new(1, -12, 0.9999999, -12), Size = UDim2.fromScale(0.1157266, 0.0858024), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14 }, nil, { "UIEffect" })
			I[3] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 2.23, AspectType = Enum.AspectType.ScaleWithParentSize, DominantAxis = Enum.DominantAxis.Height })
			I[4] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0.15, 0), BottomRightRadius = UDim.new(0.15, 0), TopLeftRadius = UDim.new(0.15, 0), TopRightRadius = UDim.new(0.15, 0) })
			I[5] = new("ImageLabel", I[2], "image", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://109292854789233"), Position = UDim2.fromScale(0.025, 0.5), Size = UDim2.fromScale(0.3923768, 0.8750001) })
				I[6] = new("UIAspectRatioConstraint", I[5], "UIAspectRatioConstraint")
				I[7] = new("UIScale", I[5], "UIScale", { Scale = 0.89 })
			I[8] = new("TextLabel", I[2], "label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.6292047, 0.5), Size = UDim2.fromScale(0.5415886, 0.75), Text = "Exit", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true })
		I[9] = new("Frame", I[1], "toggleConfigure", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(18, 18, 21), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.new(1, -12, 0, 12), Size = UDim2.fromScale(0.168, 0.077) })
			I[10] = new("UICorner", I[9], "UICorner", { BottomLeftRadius = UDim.new(0.15, 0), BottomRightRadius = UDim.new(0.15, 0), TopLeftRadius = UDim.new(0.15, 0), TopRightRadius = UDim.new(0.15, 0) })
			I[11] = new("ImageLabel", I[9], "image", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://104158605161291"), Position = UDim2.fromScale(0.03, 0.5), Size = UDim2.fromScale(0.3923768, 0.8750001), ZIndex = 2 })
				I[12] = new("UIAspectRatioConstraint", I[11], "UIAspectRatioConstraint")
				I[13] = new("UIScale", I[11], "UIScale", { Scale = 0.82 })
			I[14] = new("TextButton", I[9], "button", { AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(18, 18, 21), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14 }, nil, { "UIEffectSoundOnly" })
				I[15] = new("UICorner", I[14], "UICorner", { BottomLeftRadius = UDim.new(0.15, 0), BottomRightRadius = UDim.new(0.15, 0), TopLeftRadius = UDim.new(0.15, 0), TopRightRadius = UDim.new(0.15, 0) })
				I[16] = new("TextLabel", I[14], "label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5963477, 0.5000001), Size = UDim2.fromScale(0.6817822, 0.7500001), Text = "Configure", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[17] = new("UIStroke", I[9], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(255, 255, 255), StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.04, Transparency = 0.75 })
			I[18] = new("UIAspectRatioConstraint", I[9], "UIAspectRatioConstraint", { AspectRatio = 3.45 })
		I[19] = new("Frame", I[1], "container", { AnchorPoint = Vector2.new(1, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(18, 18, 21), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.new(1, -12, 0, 12), Size = UDim2.fromScale(0.4798451, 0.3391498), SizeConstraint = Enum.SizeConstraint.RelativeYY })
			I[20] = new("UICorner", I[19], "UICorner", { BottomLeftRadius = UDim.new(0.0340558, 0), BottomRightRadius = UDim.new(0.0340558, 0), TopLeftRadius = UDim.new(0.0340558, 0), TopRightRadius = UDim.new(0.0340558, 0) })
			I[21] = new("ScrollingFrame", I[19], "wrapper", { AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, CanvasSize = UDim2.fromScale(0, 0), ClipsDescendants = false, HorizontalScrollBarInset = Enum.ScrollBarInset.ScrollBar, ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0), ScrollBarImageTransparency = 1, ScrollBarThickness = 0, ScrollingEnabled = false, Selectable = false, Size = UDim2.fromScale(1, 0), SizeConstraint = Enum.SizeConstraint.RelativeXX })
				I[22] = new("UIListLayout", I[21], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder })
				I[23] = new("Frame", I[21], "divider", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.95, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.085), Size = UDim2.new(0.95, 0, 0, 2), SizeConstraint = Enum.SizeConstraint.RelativeXX })
				I[24] = new("Frame", I[21], "header", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 0.13), SizeConstraint = Enum.SizeConstraint.RelativeXX })
					I[25] = new("TextLabel", I[24], "label", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0332911, 0.1421777), Size = UDim2.fromScale(0.6665338, 0.7819775), Text = "Configure Scene", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
					I[26] = new("TextButton", I[24], "closeButton", { AnchorPoint = Vector2.new(1, 0), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(33, 34, 39), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 20, Position = UDim2.fromScale(0.99, 0.075), Size = UDim2.fromScale(0.046, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, TextTransparency = 1 }, { ["isStatic"] = true }, { "UIEffect" })
						I[27] = new("UICorner", I[26], "UICorner", { BottomLeftRadius = UDim.new(0.175, 0), BottomRightRadius = UDim.new(0.175, 0), TopLeftRadius = UDim.new(0.175, 0), TopRightRadius = UDim.new(0.175, 0) })
						I[28] = new("ImageLabel", I[26], "image", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://81024172191247"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.9, 0.9) })
							I[29] = new("UIAspectRatioConstraint", I[28], "UIAspectRatioConstraint")
						I[30] = new("UIAspectRatioConstraint", I[26], "UIAspectRatioConstraint", { AspectType = Enum.AspectType.ScaleWithParentSize, DominantAxis = Enum.DominantAxis.Height })
						I[31] = new("UIScale", I[26], "UIScale", { Scale = 0.85 })
				I[32] = new("Frame", I[21], "options", { AnchorPoint = Vector2.new(0.5, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 2, Position = UDim2.fromScale(0.4999998, 0.1066332), Size = UDim2.fromScale(0.95, 0.2), SizeConstraint = Enum.SizeConstraint.RelativeXX })
					I[33] = new("UIListLayout", I[32], "UIListLayout", { Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder })
				I[34] = new("Frame", I[21], "buffer", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 9999, Size = UDim2.fromScale(1, 0.01), SizeConstraint = Enum.SizeConstraint.RelativeXX })
			I[35] = new("UIStroke", I[19], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(255, 255, 255), Thickness = 3, Transparency = 0.75 })
	return I[1]
end

return build
