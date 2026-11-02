-- Generated from ui/StarterPlayer/StarterPlayerScripts/Controllers/DialogController/choiceDialog.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("CanvasGroup", nil, "choiceDialog", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.4, 0.538) })
		I[2] = new("UIPadding", I[1], "UIPadding", { PaddingBottom = UDim.new(0, 3), PaddingLeft = UDim.new(0, 3), PaddingRight = UDim.new(0, 3), PaddingTop = UDim.new(0, 3) })
		I[3] = new("UISizeConstraint", I[1], "UISizeConstraint", { MinSize = Vector2.new(340, 0) })
		I[4] = new("Frame", I[1], "wrapper", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(18, 18, 21), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
			I[5] = new("UICorner", I[4], "UICorner", { BottomLeftRadius = UDim.new(0.03, 0), BottomRightRadius = UDim.new(0.03, 0), TopLeftRadius = UDim.new(0.03, 0), TopRightRadius = UDim.new(0.03, 0) })
			I[6] = new("UIStroke", I[4], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(247, 245, 255), Thickness = 3, Transparency = 0.5 })
			I[7] = new("UIPadding", I[4], "UIPadding", { PaddingBottom = UDim.new(0.0371747, 0), PaddingLeft = UDim.new(0.028125, 0), PaddingRight = UDim.new(0.028125, 0), PaddingTop = UDim.new(0.0371747, 0) })
			I[8] = new("UIListLayout", I[4], "UIListLayout", { Padding = UDim.new(0.0401606, 0), SortOrder = Enum.SortOrder.LayoutOrder })
			I[9] = new("TextLabel", I[4], "title", { BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), LayoutOrder = 1, Size = UDim2.fromScale(1, 0.0923695), Text = "Choose an option", TextColor3 = Color3.fromRGB(247, 247, 248), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
			I[10] = new("ScrollingFrame", I[4], "choices", { BackgroundTransparency = 1, BorderSizePixel = 0, CanvasSize = UDim2.fromScale(0, 0), LayoutOrder = 3, ScrollBarThickness = 3, ScrollingDirection = Enum.ScrollingDirection.Y, Size = UDim2.fromScale(1, 0.8674699) }, nil, { "ScrollingFrameAutomaticSizeFix" })
				I[11] = new("UIListLayout", I[10], "UIListLayout", { Padding = UDim.new(0.0300926, 0), SortOrder = Enum.SortOrder.LayoutOrder })
				I[12] = new("UIPadding", I[10], "UIPadding", { PaddingBottom = UDim.new(0, 2), PaddingLeft = UDim.new(0, 2), PaddingRight = UDim.new(0, 2), PaddingTop = UDim.new(0, 2) })
			I[13] = new("TextBox", I[4], "input", { BackgroundColor3 = Color3.fromRGB(33, 34, 39), BorderSizePixel = 0, ClearTextOnFocus = false, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 4, PlaceholderColor3 = Color3.fromRGB(178, 178, 178), PlaceholderText = "Type your own…", Size = UDim2.fromScale(1, 0.1130137), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
				I[14] = new("UICorner", I[13], "UICorner", { BottomLeftRadius = UDim.new(0.12, 0), BottomRightRadius = UDim.new(0.12, 0), TopLeftRadius = UDim.new(0.12, 0), TopRightRadius = UDim.new(0.12, 0) })
				I[15] = new("UIStroke", I[13], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(70, 68, 77), Thickness = 1.5 })
				I[16] = new("UIPadding", I[13], "UIPadding", { PaddingBottom = UDim.new(0.2466667, 0), PaddingLeft = UDim.new(0.0242583, 0), PaddingRight = UDim.new(0.0242583, 0), PaddingTop = UDim.new(0.2466667, 0) })
			I[17] = new("TextLabel", I[4], "subtitle", { BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 2, Size = UDim2.fromScale(1, 0.1), Text = "Subtitle", TextColor3 = Color3.fromRGB(213, 215, 221), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, Visible = false })
		I[18] = new("TextButton", I[1], "closeButton", { AnchorPoint = Vector2.new(1, 0), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(33, 34, 39), BorderSizePixel = 0, Position = UDim2.fromScale(0.9859375, 0.0185874), Size = UDim2.fromScale(0.085, 1), Text = "", ZIndex = 100 }, nil, { "UIEffect" })
			I[19] = new("UIAspectRatioConstraint", I[18], "UIAspectRatioConstraint")
			I[20] = new("UICorner", I[18], "UICorner", { BottomLeftRadius = UDim.new(0.17, 0), BottomRightRadius = UDim.new(0.17, 0), TopLeftRadius = UDim.new(0.17, 0), TopRightRadius = UDim.new(0.17, 0) })
			I[21] = new("ImageLabel", I[18], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://81024172191247"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.9) })
	return I[1]
end

return build
