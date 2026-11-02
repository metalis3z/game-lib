-- Generated from ui/ReplicatedStorage/Assets/UI/Rarity/Mythical/ItemSlot.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("TextButton", nil, "ItemSlot", { AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 2, Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 18, ZIndex = 5 }, { ["Tick"] = 0 })
		I[2] = new("ImageLabel", I[1], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://128976258131547"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.9, 0.8), ZIndex = 6 })
		I[3] = new("ImageLabel", I[1], "scribble", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://116224895983496"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1.25, 1.25), ZIndex = 5 })
			I[4] = new("UIGradient", I[3], "RarityGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(240, 0, 0)) }), Rotation = 100 })
		I[5] = new("ImageLabel", I[1], "Select", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://83127733180293"), Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 5 })
		I[6] = new("TextLabel", I[1], "Quantity", { AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LineHeight = 0.9, Position = UDim2.fromScale(0.075, 0.05), Size = UDim2.fromScale(0.925, 0.2), Text = "x10k", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextStrokeColor3 = Color3.fromRGB(19, 48, 57), TextStrokeTransparency = 0, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, TextYAlignment = Enum.TextYAlignment.Top, ZIndex = 9 })
			I[7] = new("UIStroke", I[6], "UIStroke", { Color = Color3.fromRGB(45, 45, 45), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2.5 })
		I[8] = new("TextLabel", I[1], "Strength", { AnchorPoint = Vector2.new(1, 0.5), AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 2, LineHeight = 0.89, Position = UDim2.fromScale(1, 0.9), Size = UDim2.fromScale(1, 0.375), Text = "999", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextStrokeColor3 = Color3.fromRGB(19, 48, 57), TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, Visible = false, ZIndex = 8 })
			I[9] = new("UIStroke", I[8], "UIStroke", { Color = Color3.fromRGB(90, 90, 90), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 3 })
				I[10] = new("UIGradient", I[9], "Tier Gradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 110, 110)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 43, 100)) }), Rotation = 100 })
		I[11] = new("ImageLabel", I[1], "Locked", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(254, 204, 38), ImageContent = Content.fromUri("rbxassetid://72318121063950"), Position = UDim2.fromScale(0.2, 0.15), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.25, 0.25), Visible = false, ZIndex = 11 })
		I[12] = new("ImageLabel", I[1], "star", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageTransparency = 1, LayoutOrder = 1, Position = UDim2.fromScale(-0.0304348, 0.1931863), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.4608695, 0.3135465), ZIndex = 8 })
		I[13] = new("TextLabel", I[1], "Level", { AnchorPoint = Vector2.new(0.5, 0.5), AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LineHeight = 0.9, Position = UDim2.fromScale(0.5, 0.8), Size = UDim2.fromScale(0.925, 0.2), Text = "x10k", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextStrokeColor3 = Color3.fromRGB(19, 48, 57), TextStrokeTransparency = 0, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, TextYAlignment = Enum.TextYAlignment.Top, Visible = false, ZIndex = 8 })
			I[14] = new("UIStroke", I[13], "UIStroke", { Color = Color3.fromRGB(45, 45, 45), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2.5 })
	return I[1]
end

return build
