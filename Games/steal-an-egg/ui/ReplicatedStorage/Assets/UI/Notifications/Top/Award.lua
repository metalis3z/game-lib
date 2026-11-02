-- Generated from ui/ReplicatedStorage/Assets/UI/Notifications/Top/Award.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Award", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) })
		I[2] = new("TextLabel", I[1], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 0.25), Text = "Achievement Completed!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextWrapped = true })
			I[3] = new("UIStroke", I[2], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2.5 })
		I[4] = new("TextLabel", I[1], "Subtitle", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.275), Size = UDim2.fromScale(1, 0.2), Text = "\"Monkey Madness\"", TextColor3 = Color3.fromRGB(192, 255, 253), TextScaled = true, TextSize = 18, TextWrapped = true })
			I[5] = new("UIStroke", I[4], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2.5 })
		I[6] = new("Frame", I[1], "Reward", { AnchorPoint = Vector2.new(0.5, 0), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = 10, Position = UDim2.fromScale(0.5, 0.525), Size = UDim2.fromScale(1, 0.475) })
			I[7] = new("TextButton", I[6], "Pet", { AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 1, Size = UDim2.new(0, 100, 1, 0), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 18, ZIndex = 2 }, { ["Tick"] = 0 })
				I[8] = new("ImageLabel", I[7], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://128976258131547"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.95, 0.95), ZIndex = 5 })
				I[9] = new("ImageLabel", I[7], "scribble", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://116224895983496"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1.25, 1.25), ZIndex = 2 })
				I[10] = new("TextLabel", I[7], "Quantity", { AnchorPoint = Vector2.new(0, 1), AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LineHeight = 0.9, Position = UDim2.fromScale(0, 1.0250001), Size = UDim2.fromScale(1, 0.3063557), Text = "x999", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextStrokeColor3 = Color3.fromRGB(19, 48, 57), TextStrokeTransparency = 0, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, ZIndex = 10 })
					I[11] = new("UIStroke", I[10], "UIStroke", { Color = Color3.fromRGB(45, 45, 45), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2.5 })
				I[12] = new("UIAspectRatioConstraint", I[7], "UIAspectRatioConstraint")
			I[13] = new("UIListLayout", I[6], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.05, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
			I[14] = new("TextButton", I[6], "Pet_2", { AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 1, Size = UDim2.new(0, 100, 1, 0), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 18, ZIndex = 2 }, { ["Tick"] = 0 })
				I[15] = new("ImageLabel", I[14], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://128976258131547"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.95, 0.95), ZIndex = 5 })
				I[16] = new("ImageLabel", I[14], "scribble", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://116224895983496"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1.25, 1.25), ZIndex = 2 })
				I[17] = new("TextLabel", I[14], "Quantity", { AnchorPoint = Vector2.new(0, 1), AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LineHeight = 0.9, Position = UDim2.fromScale(0, 1.0250001), Size = UDim2.fromScale(1, 0.3063557), Text = "x999", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextStrokeColor3 = Color3.fromRGB(19, 48, 57), TextStrokeTransparency = 0, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, ZIndex = 10 })
					I[18] = new("UIStroke", I[17], "UIStroke", { Color = Color3.fromRGB(45, 45, 45), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2.5 })
				I[19] = new("UIAspectRatioConstraint", I[14], "UIAspectRatioConstraint")
		I[20] = new("TextLabel", I[1], "Extra", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.new(0, 0, 1, -2), Size = UDim2.fromScale(1, 0.15), Text = "+3 more", TextColor3 = Color3.fromRGB(192, 255, 253), TextScaled = true, TextSize = 18, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, Visible = false })
			I[21] = new("UIStroke", I[20], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2 })
	return I[1]
end

return build
