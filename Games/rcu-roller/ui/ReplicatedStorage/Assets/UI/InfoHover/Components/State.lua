-- Generated from ui/ReplicatedStorage/Assets/UI/InfoHover/Components/State.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "State", { BackgroundColor3 = Color3.fromRGB(199, 199, 199), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 3, Position = UDim2.fromScale(0.3243838, 0.4872297), Size = UDim2.fromScale(0.7867028, 0.1083448), ZIndex = 1550 })
		I[2] = new("UIListLayout", I[1], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 10), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
		I[3] = new("TextLabel", I[1], "Shiny", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(-0.051, 0.1296296), Size = UDim2.fromScale(0.384, 0.7407407), Text = "Shiny", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 1550 })
			I[4] = new("UIStroke", I[3], "UIStroke", { Color = Color3.fromRGB(96, 104, 140), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 4 })
				I[5] = new("UIGradient", I[4], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(213, 255, 251)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(213, 255, 251)) }), Rotation = 60 })
			I[6] = new("UIGradient", I[3], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(213, 255, 251)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(213, 255, 251)) }), Rotation = 60 })
		I[7] = new("TextLabel", I[1], "Craft", { AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0.505, 0.1296296), Size = UDim2.fromOffset(50, 38), Text = "Toxic", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 36, ZIndex = 1550 })
			I[8] = new("UIGradient", I[7], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(244, 255, 26)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 143, 16)) }), Rotation = 90 })
			I[9] = new("UIStroke", I[7], "UIStroke", { Color = Color3.fromRGB(93, 63, 37), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 4 })
				I[10] = new("UIGradient", I[9], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(244, 255, 26)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 143, 16)) }), Rotation = 90 })
	return I[1]
end

return build
