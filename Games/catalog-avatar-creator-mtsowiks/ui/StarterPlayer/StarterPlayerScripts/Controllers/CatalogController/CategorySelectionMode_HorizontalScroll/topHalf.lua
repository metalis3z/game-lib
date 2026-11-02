-- Generated from ui/StarterPlayer/StarterPlayerScripts/Controllers/CatalogController/CategorySelectionMode_HorizontalScroll/topHalf.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "topHalf", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(-0.0000001, 0), Size = UDim2.fromScale(1.0000001, 0.6137941) })
		I[2] = new("Frame", I[1], "categories", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 3, Size = UDim2.fromScale(0.6, 1) })
			I[3] = new("ScrollingFrame", I[2], "container", { Active = true, AutomaticCanvasSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, CanvasSize = UDim2.fromScale(0, 0), ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0), ScrollBarThickness = 0, ScrollingDirection = Enum.ScrollingDirection.X, Size = UDim2.fromScale(1, 1) })
				I[4] = new("TextButton", I[3], "featured", { AnchorPoint = Vector2.new(0, 0.5), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0000033, 0.5), RichText = true, Size = UDim2.fromScale(0, 0.9), SizeConstraint = Enum.SizeConstraint.RelativeYY, Text = "", TextColor3 = Color3.fromRGB(244, 244, 244), TextSize = 14, TextWrapped = true }, { ["margin"] = 2 })
					I[5] = new("UIPadding", I[4], "UIPadding", { PaddingBottom = UDim.new(0.125, 0), PaddingTop = UDim.new(0.125, 0) })
					I[6] = new("TextLabel", I[4], "label", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.5), Size = UDim2.new(0, 150, 0.9, 0), Text = "Featured", TextColor3 = Color3.fromRGB(208, 208, 217), TextScaled = true, TextSize = 14, TextWrapped = true }, nil, { "ScaledTextSizeAutomaticSizeFix" })
				I[7] = new("UIListLayout", I[3], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
				I[8] = new("TextButton", I[3], "featured", { AnchorPoint = Vector2.new(0, 0.5), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0000033, 0.5), RichText = true, Size = UDim2.fromScale(0, 0.9), SizeConstraint = Enum.SizeConstraint.RelativeYY, Text = "", TextColor3 = Color3.fromRGB(244, 244, 244), TextSize = 14, TextWrapped = true }, { ["margin"] = 2 })
					I[9] = new("UIPadding", I[8], "UIPadding", { PaddingBottom = UDim.new(0.125, 0), PaddingTop = UDim.new(0.125, 0) })
					I[10] = new("TextLabel", I[8], "label", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.5), Size = UDim2.new(0, 150, 0.9, 0), Text = "Accessories", TextColor3 = Color3.fromRGB(208, 208, 217), TextScaled = true, TextSize = 14, TextWrapped = true }, nil, { "ScaledTextSizeAutomaticSizeFix" })
				I[11] = new("TextButton", I[3], "featured", { AnchorPoint = Vector2.new(0, 0.5), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0000033, 0.5), RichText = true, Size = UDim2.fromScale(0, 0.9), SizeConstraint = Enum.SizeConstraint.RelativeYY, Text = "", TextColor3 = Color3.fromRGB(244, 244, 244), TextSize = 14, TextWrapped = true }, { ["margin"] = 2 })
					I[12] = new("UIPadding", I[11], "UIPadding", { PaddingBottom = UDim.new(0.125, 0), PaddingTop = UDim.new(0.125, 0) })
					I[13] = new("TextLabel", I[11], "label", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.5), Size = UDim2.new(0, 150, 0.9, 0), Text = "Clothing", TextColor3 = Color3.fromRGB(208, 208, 217), TextScaled = true, TextSize = 14, TextWrapped = true }, nil, { "ScaledTextSizeAutomaticSizeFix" })
				I[14] = new("TextButton", I[3], "featured", { AnchorPoint = Vector2.new(0, 0.5), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0000033, 0.5), RichText = true, Size = UDim2.fromScale(0, 0.9), SizeConstraint = Enum.SizeConstraint.RelativeYY, Text = "", TextColor3 = Color3.fromRGB(244, 244, 244), TextSize = 14, TextWrapped = true }, { ["margin"] = 2 })
					I[15] = new("UIPadding", I[14], "UIPadding", { PaddingBottom = UDim.new(0.125, 0), PaddingTop = UDim.new(0.125, 0) })
					I[16] = new("TextLabel", I[14], "label", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.5), Size = UDim2.new(0, 150, 0.9, 0), Text = "Faces", TextColor3 = Color3.fromRGB(208, 208, 217), TextScaled = true, TextSize = 14, TextWrapped = true }, nil, { "ScaledTextSizeAutomaticSizeFix" })
				I[17] = new("TextButton", I[3], "featured", { AnchorPoint = Vector2.new(0, 0.5), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0000033, 0.5), RichText = true, Size = UDim2.fromScale(0, 0.9), SizeConstraint = Enum.SizeConstraint.RelativeYY, Text = "", TextColor3 = Color3.fromRGB(244, 244, 244), TextSize = 14, TextWrapped = true }, { ["margin"] = 2 })
					I[18] = new("UIPadding", I[17], "UIPadding", { PaddingBottom = UDim.new(0.125, 0), PaddingTop = UDim.new(0.125, 0) })
					I[19] = new("TextLabel", I[17], "label", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.5), Size = UDim2.new(0, 150, 0.9, 0), Text = "Characters", TextColor3 = Color3.fromRGB(208, 208, 217), TextScaled = true, TextSize = 14, TextWrapped = true }, nil, { "ScaledTextSizeAutomaticSizeFix" })
				I[20] = new("TextButton", I[3], "featured", { AnchorPoint = Vector2.new(0, 0.5), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0000033, 0.5), RichText = true, Size = UDim2.fromScale(0, 0.9), SizeConstraint = Enum.SizeConstraint.RelativeYY, Text = "", TextColor3 = Color3.fromRGB(244, 244, 244), TextSize = 14, TextWrapped = true }, { ["margin"] = 2 })
					I[21] = new("UIPadding", I[20], "UIPadding", { PaddingBottom = UDim.new(0.125, 0), PaddingTop = UDim.new(0.125, 0) })
					I[22] = new("TextLabel", I[20], "label", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.5), Size = UDim2.new(0, 150, 0.9, 0), Text = "Featured", TextColor3 = Color3.fromRGB(208, 208, 217), TextScaled = true, TextSize = 14, TextWrapped = true }, nil, { "ScaledTextSizeAutomaticSizeFix" })
				I[23] = new("Folder", I[3], "exclusions")
					I[24] = new("Frame", I[23], "container", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 0.9) })
		I[25] = new("UIListLayout", I[1], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalFlex = Enum.UIFlexAlignment.Fill, Padding = UDim.new(0.01, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
		I[26] = new("UIPadding", I[1], "UIPadding", { PaddingBottom = UDim.new(0.15, 0), PaddingLeft = UDim.new(0.01, 0), PaddingRight = UDim.new(0.01, 0), PaddingTop = UDim.new(0.16, 0) })
	return I[1]
end

return build
