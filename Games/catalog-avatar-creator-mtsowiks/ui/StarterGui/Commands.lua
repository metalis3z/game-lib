-- Generated from ui/StarterGui/Commands.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Commands", { DisplayOrder = 20, Enabled = false, ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, nil, { "Themed" })
		I[2] = new("CanvasGroup", I[1], "palette", { AnchorPoint = Vector2.new(0.5, 0), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.12), Size = UDim2.fromScale(0.4, 0.5) })
			I[3] = new("UIPadding", I[2], "UIPadding", { PaddingBottom = UDim.new(0, 3), PaddingLeft = UDim.new(0, 3), PaddingRight = UDim.new(0, 3), PaddingTop = UDim.new(0, 3) })
			I[4] = new("UISizeConstraint", I[2], "UISizeConstraint", { MinSize = Vector2.new(420, 280) })
			I[5] = new("Frame", I[2], "wrapper", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(18, 18, 21), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
				I[6] = new("UICorner", I[5], "UICorner", { BottomLeftRadius = UDim.new(0.0333333, 0), BottomRightRadius = UDim.new(0.0333333, 0), TopLeftRadius = UDim.new(0.0333333, 0), TopRightRadius = UDim.new(0.0333333, 0) })
				I[7] = new("UIPadding", I[5], "UIPadding", { PaddingBottom = UDim.new(0.0266667, 0), PaddingLeft = UDim.new(0.0166667, 0), PaddingRight = UDim.new(0.0166667, 0), PaddingTop = UDim.new(0.0266667, 0) })
				I[8] = new("UIListLayout", I[5], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder })
				I[9] = new("TextBox", I[5], "input", { BackgroundColor3 = Color3.fromRGB(33, 34, 39), BorderSizePixel = 0, ClearTextOnFocus = false, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 1, PlaceholderColor3 = Color3.fromRGB(178, 178, 178), PlaceholderText = "Type a command...", Size = UDim2.fromScale(1, 0.13), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
					I[10] = new("UICorner", I[9], "UICorner", { BottomLeftRadius = UDim.new(0.1666667, 0), BottomRightRadius = UDim.new(0.1666667, 0), TopLeftRadius = UDim.new(0.1666667, 0), TopRightRadius = UDim.new(0.1666667, 0) })
					I[11] = new("UIPadding", I[9], "UIPadding", { PaddingBottom = UDim.new(0.18, 0), PaddingLeft = UDim.new(0.015, 0), PaddingRight = UDim.new(0.015, 0), PaddingTop = UDim.new(0.18, 0) })
					I[12] = new("UIStroke", I[9], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(70, 68, 77), Thickness = 1.5 })
				I[13] = new("ScrollingFrame", I[5], "suggestions", { BackgroundTransparency = 1, BorderSizePixel = 0, CanvasSize = UDim2.fromScale(0, 0), LayoutOrder = 2, ScrollBarThickness = 3, ScrollingDirection = Enum.ScrollingDirection.Y, Size = UDim2.new(1, 0, 0.87, -8) }, nil, { "ScrollingFrameAutomaticSizeFix" })
					I[14] = new("UIListLayout", I[13], "UIListLayout", { Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder })
					I[15] = new("UIPadding", I[13], "UIPadding", { PaddingBottom = UDim.new(0, 2), PaddingLeft = UDim.new(0, 2), PaddingRight = UDim.new(0, 2), PaddingTop = UDim.new(0, 2) })
				I[16] = new("UIStroke", I[5], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(247, 245, 255), Thickness = 3, Transparency = 0.5 })
			I[17] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 1.5 })
	return I[1]
end

return build
