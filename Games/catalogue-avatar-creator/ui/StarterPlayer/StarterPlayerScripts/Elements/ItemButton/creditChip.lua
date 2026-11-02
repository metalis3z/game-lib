-- Generated from ui/StarterPlayer/StarterPlayerScripts/Elements/ItemButton/creditChip.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "creditChip", { AnchorPoint = Vector2.new(1, 1), BackgroundColor3 = Color3.fromRGB(33, 34, 39), BorderSizePixel = 0, LayoutOrder = 4, Position = UDim2.new(1, 0, 1, 3), Size = UDim2.fromOffset(100, 34) })
		I[2] = new("UICorner", I[1], "UICorner", { BottomLeftRadius = UDim.new(0.17, 0), BottomRightRadius = UDim.new(0.17, 0), TopLeftRadius = UDim.new(0.17, 0), TopRightRadius = UDim.new(0.17, 0) })
		I[3] = new("Frame", I[1], "content", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) })
			I[4] = new("UIListLayout", I[3], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 5), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
			I[5] = new("ImageLabel", I[3], "icon", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://102916047959967"), LayoutOrder = 1, ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0, 0.62) }, { ["SkipThemeImage"] = true })
				I[6] = new("UIAspectRatioConstraint", I[5], "UIAspectRatioConstraint", { AspectType = Enum.AspectType.ScaleWithParentSize, DominantAxis = Enum.DominantAxis.Height })
			I[7] = new("TextLabel", I[3], "amount", { BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 2, Size = UDim2.fromScale(0.62, 0.62), Text = "+0", TextColor3 = Color3.fromRGB(217, 177, 92), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left }, { ["SkipTheme"] = true })
		I[8] = new("Frame", I[1], "shine", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = 3 })
			I[9] = new("UICorner", I[8], "UICorner", { BottomLeftRadius = UDim.new(0.17, 0), BottomRightRadius = UDim.new(0.17, 0), TopLeftRadius = UDim.new(0.17, 0), TopRightRadius = UDim.new(0.17, 0) })
			I[10] = new("UIGradient", I[8], "UIGradient", { Offset = Vector2.new(-0.8, 0), Rotation = 18, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.35, 1), NumberSequenceKeypoint.new(0.5, 0.72), NumberSequenceKeypoint.new(0.65, 1), NumberSequenceKeypoint.new(1, 1) }) })
	return I[1]
end

return build
