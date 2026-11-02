-- Generated from ui/StarterGui/Settings.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Settings", { DisplayOrder = 10, Enabled = false, ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, nil, { "Themed" })
		I[2] = new("CanvasGroup", I[1], "container", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(31, 33, 37), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.785, 0.785) })
			I[3] = new("UIPadding", I[2], "UIPadding", { PaddingBottom = UDim.new(0, 3), PaddingLeft = UDim.new(0, 3), PaddingRight = UDim.new(0, 3), PaddingTop = UDim.new(0, 3) })
			I[4] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 0.9 })
			I[5] = new("Frame", I[2], "wrapper", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(18, 18, 21), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
				I[6] = new("TextButton", I[5], "_", { Active = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Interactable = false, Selectable = false, Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, ZIndex = -1 })
				I[7] = new("Frame", I[5], "header", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.0000001, 0), Size = UDim2.fromScale(1.0000001, 0.0815969) })
					I[8] = new("TextLabel", I[7], "title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.7, 0.6), Text = "Settings", TextColor3 = Color3.fromRGB(244, 244, 244), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[9] = new("TextButton", I[7], "closeButton", { AnchorPoint = Vector2.new(1, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(33, 34, 39), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 20, Position = UDim2.fromScale(0.988, 0.5), Size = UDim2.fromScale(0.736, 0.736), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, TextTransparency = 1 }, nil, { "UIEffect" })
						I[10] = new("UIAspectRatioConstraint", I[9], "UIAspectRatioConstraint", { AspectType = Enum.AspectType.ScaleWithParentSize, DominantAxis = Enum.DominantAxis.Height })
						I[11] = new("ImageLabel", I[9], "image", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://81024172191247"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(0.85, 1, 0.85, 0) })
						I[12] = new("UICorner", I[9], "UICorner", { BottomLeftRadius = UDim.new(0.27, 0), BottomRightRadius = UDim.new(0.27, 0), TopLeftRadius = UDim.new(0.27, 0), TopRightRadius = UDim.new(0.27, 0) })
					I[13] = new("TextButton", I[7], "returnButton", { AnchorPoint = Vector2.new(0, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 20, Position = UDim2.fromScale(0.012, 0.5), Size = UDim2.fromScale(0.736, 0.736), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, TextTransparency = 1 }, { ["SkipTheme"] = true }, { "UIEffect" })
						I[14] = new("UICorner", I[13], "UICorner", { BottomLeftRadius = UDim.new(0.27, 0), BottomRightRadius = UDim.new(0.27, 0), TopLeftRadius = UDim.new(0.27, 0), TopRightRadius = UDim.new(0.27, 0) })
						I[15] = new("ImageLabel", I[13], "image", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(33, 34, 39), ImageContent = Content.fromUri("rbxassetid://119399595654092"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.8, 0.8) }, { ["SkipThemeImage"] = true })
						I[16] = new("UIAspectRatioConstraint", I[13], "UIAspectRatioConstraint", { AspectRatio = 1.5, AspectType = Enum.AspectType.ScaleWithParentSize, DominantAxis = Enum.DominantAxis.Height })
				I[17] = new("Frame", I[5], "current", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromScale(1, 0.913438) })
				I[18] = new("UIStroke", I[5], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(247, 245, 255), Thickness = 3, Transparency = 0.5 })
				I[19] = new("UICorner", I[5], "UICorner", { BottomLeftRadius = UDim.new(0.03, 0), BottomRightRadius = UDim.new(0.03, 0), TopLeftRadius = UDim.new(0.03, 0), TopRightRadius = UDim.new(0.03, 0) })
	return I[1]
end

return build
