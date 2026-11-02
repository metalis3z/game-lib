-- Generated from ui/ReplicatedStorage/Assets/UI/Hatch.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Hatch", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.2183851, 0.1776859) })
		I[2] = new("TextLabel", I[1], "Pet", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1.0000002, 0.3653707), Text = "Dawg", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[3] = new("UIStroke", I[2], "UIStroke", { Color = Color3.fromRGB(0, 32, 54), Thickness = 4 })
		I[4] = new("Frame", I[1], "State", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(199, 199, 199), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 3, Position = UDim2.fromScale(0.5, 0.8280241), Size = UDim2.fromScale(0.7867029, 0.3124104), ZIndex = 1550 })
			I[5] = new("UIListLayout", I[4], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.04, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
			I[6] = new("TextLabel", I[4], "Shiny", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(-0.051, 0.1296296), Size = UDim2.fromScale(0.384, 0.7407407), Text = "Shiny", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false })
				I[7] = new("UIStroke", I[6], "UIStroke", { Color = Color3.fromRGB(96, 104, 140), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 4 })
					I[8] = new("UIGradient", I[7], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(213, 255, 251)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(213, 255, 251)) }), Rotation = 60 })
				I[9] = new("UIGradient", I[6], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(213, 255, 251)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(213, 255, 251)) }), Rotation = 60 })
			I[10] = new("TextLabel", I[4], "Craft", { AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0.505, 0.1296296), Size = UDim2.fromScale(0.01, 0.741), Text = "Golden", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 44, Visible = false })
				I[11] = new("UIStroke", I[10], "UIStroke", { Color = Color3.fromRGB(93, 63, 37), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 4 })
					I[12] = new("UIGradient", I[11], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(244, 255, 26)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 143, 16)) }), Rotation = 90 })
				I[13] = new("UIGradient", I[10], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(244, 255, 26)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 143, 16)) }), Rotation = 90 })
		I[14] = new("TextLabel", I[1], "Rarity", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0.5, 0.525), Size = UDim2.fromScale(0.7867029, 0.2644852), Text = "Ultimate", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[15] = new("UIStroke", I[14], "UIStroke", { Color = Color3.fromRGB(61, 61, 61), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 4 })
				I[16] = new("UIGradient", I[15], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 44, 90)), ColorSequenceKeypoint.new(0.150519, Color3.fromRGB(255, 166, 42)), ColorSequenceKeypoint.new(0.295848, Color3.fromRGB(251, 255, 42)), ColorSequenceKeypoint.new(0.458478, Color3.fromRGB(71, 255, 61)), ColorSequenceKeypoint.new(0.586505, Color3.fromRGB(66, 214, 255)), ColorSequenceKeypoint.new(0.738754, Color3.fromRGB(64, 163, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 57, 245)) }), Rotation = 82 })
			I[17] = new("UIGradient", I[14], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 44, 90)), ColorSequenceKeypoint.new(0.150519, Color3.fromRGB(255, 166, 42)), ColorSequenceKeypoint.new(0.295848, Color3.fromRGB(251, 255, 42)), ColorSequenceKeypoint.new(0.458478, Color3.fromRGB(71, 255, 61)), ColorSequenceKeypoint.new(0.586505, Color3.fromRGB(66, 214, 255)), ColorSequenceKeypoint.new(0.738754, Color3.fromRGB(64, 163, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 57, 245)) }), Rotation = 82 })
		I[18] = new("TextLabel", I[1], "Archived", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, -0.16), Size = UDim2.fromScale(1.0000002, 0.1800953), Text = "(Archived)", TextColor3 = Color3.fromRGB(255, 32, 32), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false })
			I[19] = new("UIStroke", I[18], "UIStroke", { Color = Color3.fromRGB(0, 32, 54), LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 3 })
	return I[1]
end

return build
