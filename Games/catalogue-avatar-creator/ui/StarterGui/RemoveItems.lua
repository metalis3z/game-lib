-- Generated from ui/StarterGui/RemoveItems.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "RemoveItems", { DisplayOrder = 12, Enabled = false, ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, nil, { "Themed" })
		I[2] = new("CanvasGroup", I[1], "container", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.6744511, 0.8158683) })
			I[3] = new("UIPadding", I[2], "UIPadding", { PaddingBottom = UDim.new(0, 3), PaddingLeft = UDim.new(0, 3), PaddingRight = UDim.new(0, 3), PaddingTop = UDim.new(0, 3) })
			I[4] = new("Frame", I[2], "wrapper", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(18, 18, 21), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
				I[5] = new("UICorner", I[4], "UICorner", { BottomLeftRadius = UDim.new(0.02625, 0), BottomRightRadius = UDim.new(0.02625, 0), TopLeftRadius = UDim.new(0.02625, 0), TopRightRadius = UDim.new(0.02625, 0) })
				I[6] = new("UIStroke", I[4], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(247, 245, 255), Thickness = 3, Transparency = 0.5 })
				I[7] = new("UIAspectRatioConstraint", I[4], "UIAspectRatioConstraint", { AspectRatio = 1.25 })
				I[8] = new("UIPadding", I[4], "UIPadding", { PaddingBottom = UDim.new(0.0275, 0), PaddingLeft = UDim.new(0.022, 0), PaddingRight = UDim.new(0.022, 0), PaddingTop = UDim.new(0.0275, 0) })
				I[9] = new("TextLabel", I[4], "title", { BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), Size = UDim2.fromScale(0.5, 0.06), Text = "Remove Items", TextColor3 = Color3.fromRGB(247, 247, 248), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
				I[10] = new("TextButton", I[4], "closeButton", { AnchorPoint = Vector2.new(1, 0), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(33, 34, 39), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(1.0115, -0.0146), Size = UDim2.fromScale(0.085, 0.085), Text = "", TextTransparency = 1, ZIndex = 100 }, nil, { "UIEffect" })
					I[11] = new("UICorner", I[10], "UICorner", { BottomLeftRadius = UDim.new(0.225, 0), BottomRightRadius = UDim.new(0.225, 0), TopLeftRadius = UDim.new(0.225, 0), TopRightRadius = UDim.new(0.225, 0) })
					I[12] = new("UIAspectRatioConstraint", I[10], "UIAspectRatioConstraint", { DominantAxis = Enum.DominantAxis.Height })
					I[13] = new("ImageLabel", I[10], "image", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://81024172191247"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.9) })
				I[14] = new("Frame", I[4], "preview", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(33, 34, 39), BorderSizePixel = 0, Position = UDim2.fromScale(1, 0.0891005), Size = UDim2.fromScale(0.5669875, 0.781799) })
					I[15] = new("UICorner", I[14], "UICorner", { BottomLeftRadius = UDim.new(0.0225, 0), BottomRightRadius = UDim.new(0.0225, 0), TopLeftRadius = UDim.new(0.0225, 0), TopRightRadius = UDim.new(0.0225, 0) })
					I[16] = new("ImageLabel", I[14], "background", { BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(236, 235, 255), ImageContent = Content.fromUri("rbxassetid://83570005866923"), Size = UDim2.fromScale(1, 1) })
						I[17] = new("UICorner", I[16], "UICorner", { BottomLeftRadius = UDim.new(0.0225, 0), BottomRightRadius = UDim.new(0.0225, 0), TopLeftRadius = UDim.new(0.0225, 0), TopRightRadius = UDim.new(0.0225, 0) })
					I[18] = new("ViewportFrame", I[14], "viewport", { Ambient = Color3.fromRGB(202, 202, 202), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderSizePixel = 0, LightColor = Color3.fromRGB(221, 221, 221), LightDirection = Vector3.new(0.5, -1, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
						I[19] = new("UICorner", I[18], "UICorner", { BottomLeftRadius = UDim.new(0.0225, 0), BottomRightRadius = UDim.new(0.0225, 0), TopLeftRadius = UDim.new(0.0225, 0), TopRightRadius = UDim.new(0.0225, 0) })
					I[20] = new("TextButton", I[14], "detector", { AutoButtonColor = false, BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "", ZIndex = -1 })
				I[21] = new("Frame", I[4], "categoriesSection", { BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.0891005), Size = UDim2.fromScale(0.41, 0.781799) })
					I[22] = new("ScrollingFrame", I[21], "scroll", { AnchorPoint = Vector2.new(0.5, 0.5), AutomaticCanvasSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, BorderSizePixel = 0, CanvasSize = UDim2.fromScale(0, 0), Position = UDim2.fromScale(0.5, 0.5), ScrollBarThickness = 3, ScrollingDirection = Enum.ScrollingDirection.Y, Size = UDim2.fromScale(1, 1) })
						I[23] = new("UIPadding", I[22], "UIPadding", { PaddingBottom = UDim.new(0, 2), PaddingLeft = UDim.new(0, 2), PaddingRight = UDim.new(0, 2), PaddingTop = UDim.new(0, 2) })
						I[24] = new("UIListLayout", I[22], "UIListLayout", { Padding = UDim.new(0.015, 0), SortOrder = Enum.SortOrder.LayoutOrder })
				I[25] = new("TextButton", I[4], "removeButton", { AnchorPoint = Vector2.new(0.5, 1), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 95, 92), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromScale(0.24, 0.1), Text = "Remove Items", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true })
					I[26] = new("UICorner", I[25], "UICorner", { BottomLeftRadius = UDim.new(0.15, 0), BottomRightRadius = UDim.new(0.15, 0), TopLeftRadius = UDim.new(0.15, 0), TopRightRadius = UDim.new(0.15, 0) })
					I[27] = new("UIStroke", I[25], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(70, 68, 77), Thickness = 1.5, Transparency = 0.4 })
					I[28] = new("UIPadding", I[25], "UIPadding", { PaddingBottom = UDim.new(0.22, 0), PaddingLeft = UDim.new(0.08, 0), PaddingRight = UDim.new(0.08, 0), PaddingTop = UDim.new(0.22, 0) })
			I[29] = new("UISizeConstraint", I[2], "UISizeConstraint", { MinSize = Vector2.new(300, 300) })
	return I[1]
end

return build
