-- Generated from ui/StarterPlayer/StarterPlayerScripts/Elements/DropdownController/dropdownTemplate.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "dropdownTemplate", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 50, Position = UDim2.fromScale(0.499992, 0.0541314), Size = UDim2.fromScale(0.9949633, 0.1082629), SizeConstraint = Enum.SizeConstraint.RelativeXX })
		I[2] = new("TextLabel", I[1], "label", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(-0.0000001, 0.4580002), Size = UDim2.fromScale(0.723, 0.58), Text = "Category Selection Mode", TextColor3 = Color3.fromRGB(244, 244, 244), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
		I[3] = new("Frame", I[1], "dropdown", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(1, 0.5), Size = UDim2.fromScale(0.3911033, 1) })
			I[4] = new("UIPadding", I[3], "UIPadding", { PaddingBottom = UDim.new(0.1, 0), PaddingTop = UDim.new(0.1, 0) })
			I[5] = new("Frame", I[3], "back", { BackgroundColor3 = Color3.fromRGB(33, 34, 39), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) })
				I[6] = new("UICorner", I[5], "UICorner", { BottomLeftRadius = UDim.new(0.3, 0), BottomRightRadius = UDim.new(0.3, 0), TopLeftRadius = UDim.new(0.3, 0), TopRightRadius = UDim.new(0.3, 0) })
				I[7] = new("UIStroke", I[5], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(70, 68, 77), Thickness = 1.5 })
				I[8] = new("UIPadding", I[5], "UIPadding", { PaddingRight = UDim.new(0.0235, 0), PaddingTop = UDim.new(0.05, 0) })
				I[9] = new("ImageLabel", I[5], "image", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(214, 213, 222), ImageContent = Content.fromUri("rbxassetid://97937990215558"), Position = UDim2.fromScale(1, 0.5), Size = UDim2.fromScale(0.7, 0.7) })
					I[10] = new("UIAspectRatioConstraint", I[9], "UIAspectRatioConstraint")
			I[11] = new("Frame", I[3], "dropdown", { AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(33, 34, 39), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.7), Size = UDim2.new(1, 1, 0.3, 0), ZIndex = 0 })
				I[12] = new("UIListLayout", I[11], "UIListLayout", { Padding = UDim.new(0, 2), SortOrder = Enum.SortOrder.LayoutOrder })
				I[13] = new("Frame", I[11], "buffer", { BackgroundColor3 = Color3.fromRGB(30, 45, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = -999999999, Size = UDim2.fromScale(1, 0.1), SizeConstraint = Enum.SizeConstraint.RelativeXX })
				I[14] = new("UICorner", I[11], "UICorner")
				I[15] = new("Frame", I[11], "buffer", { BackgroundColor3 = Color3.fromRGB(30, 45, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 99999, Position = UDim2.fromScale(0, 0.7583923), Size = UDim2.fromScale(1, 0.035), SizeConstraint = Enum.SizeConstraint.RelativeXX })
				I[16] = new("TextButton", I[11], "choice", { AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(33, 34, 39), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.3151424), Size = UDim2.fromScale(1, 0.196436), SizeConstraint = Enum.SizeConstraint.RelativeXX, Text = "Choice", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
					I[17] = new("UIPadding", I[16], "UIPadding", { PaddingBottom = UDim.new(0.175, 0), PaddingLeft = UDim.new(0.035, 0), PaddingTop = UDim.new(0.175, 0) })
				I[18] = new("UIStroke", I[11], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(70, 68, 77), Thickness = 1.5 })
			I[19] = new("TextLabel", I[3], "label", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0370024, 0.5000006), Size = UDim2.fromScale(0.8160474, 0.6650003), Text = "Dropdowns", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 2 })
			I[20] = new("TextButton", I[3], "button", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, TextTransparency = 1 })
	return I[1]
end

return build
