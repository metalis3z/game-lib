-- Generated from ui/StarterGui/Statistics.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Statistics", { DisplayOrder = 15, Enabled = false, ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, nil, { "Themed" })
		I[2] = new("CanvasGroup", I[1], "container", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.72, 0.72) })
			I[3] = new("UIPadding", I[2], "UIPadding", { PaddingBottom = UDim.new(0, 3), PaddingLeft = UDim.new(0, 3), PaddingRight = UDim.new(0, 3), PaddingTop = UDim.new(0, 3) })
			I[4] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint")
			I[5] = new("UISizeConstraint", I[2], "UISizeConstraint", { MinSize = Vector2.new(340, 340) })
			I[6] = new("Frame", I[2], "wrapper", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(18, 18, 21), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
				I[7] = new("UICorner", I[6], "UICorner", { BottomLeftRadius = UDim.new(0.0225, 0), BottomRightRadius = UDim.new(0.0225, 0), TopLeftRadius = UDim.new(0.0225, 0), TopRightRadius = UDim.new(0.0225, 0) })
				I[8] = new("UIStroke", I[6], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(247, 245, 255), Thickness = 3, Transparency = 0.5 })
				I[9] = new("TextLabel", I[6], "title", { BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.025, 0.0275), Size = UDim2.fromScale(0.6, 0.058), Text = "Statistics", TextColor3 = Color3.fromRGB(247, 247, 248), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
				I[10] = new("TextButton", I[6], "closeButton", { AnchorPoint = Vector2.new(1, 0), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(33, 34, 39), BorderSizePixel = 0, Position = UDim2.fromScale(0.984, 0.0176), Size = UDim2.fromScale(0.085, 0.085), Text = "", ZIndex = 100 }, nil, { "UIEffect" })
					I[11] = new("UICorner", I[10], "UICorner", { BottomLeftRadius = UDim.new(0.225, 0), BottomRightRadius = UDim.new(0.225, 0), TopLeftRadius = UDim.new(0.225, 0), TopRightRadius = UDim.new(0.225, 0) })
					I[12] = new("ImageLabel", I[10], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://81024172191247"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.9) })
				I[13] = new("ScrollingFrame", I[6], "grid", { AnchorPoint = Vector2.new(0.5, 0), BackgroundTransparency = 1, BorderSizePixel = 0, CanvasSize = UDim2.fromScale(0, 0), Position = UDim2.fromScale(0.5, 0.14), ScrollBarImageTransparency = 1, ScrollBarThickness = 0, ScrollingDirection = Enum.ScrollingDirection.Y, Size = UDim2.fromScale(0.95, 0.835) }, nil, { "ScrollingFrameAutomaticSizeFix" })
					I[14] = new("UIPadding", I[13], "UIPadding", { PaddingBottom = UDim.new(0, 4), PaddingLeft = UDim.new(0, 4), PaddingRight = UDim.new(0, 4), PaddingTop = UDim.new(0, 4) })
					I[15] = new("UIGridLayout", I[13], "UIGridLayout", { CellPadding = UDim2.fromOffset(8, 8), CellSize = UDim2.new(0.5, -4, 0.2297, 0), FillDirectionMaxCells = 2, HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder })
	return I[1]
end

return build
