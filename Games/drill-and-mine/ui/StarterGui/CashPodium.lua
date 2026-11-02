-- Generated from ui/StarterGui/CashPodium.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "CashPodium", { Active = true, MaxDistance = 75, Size = UDim2.fromScale(10, 2.5), StudsOffset = Vector3.new(0, 1.7, 0), ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["BillboardCenteringApplied"] = true })
		I[2] = new("UIListLayout", I[1], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.02, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
		I[3] = new("TextLabel", I[1], "Income", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.0878769, 0.8674056), RichText = true, Selectable = true, Size = UDim2.fromScale(0.95, 0.5), Text = "$20/s", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 32, TextWrapped = true, ZIndex = 2 })
			I[4] = new("TextLabel", I[3], "Inner", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0.5, 0.45), RichText = true, Selectable = true, Size = UDim2.fromScale(1, 1), Text = "$20/s", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 32, TextWrapped = true, ZIndex = 2 })
				I[5] = new("UIGradient", I[4], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(212, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(21, 255, 0)) }), Rotation = 90 })
				I[6] = new("UIStroke", I[4], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 3 })
			I[7] = new("UIStroke", I[3], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 3 })
		I[8] = new("TextLabel", I[1], "OfflineReward", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0.0878769, 0.8674056), RichText = true, Selectable = true, Size = UDim2.fromScale(0.95, 0.3), Text = "Offline Cash: $1.0k", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 32, TextWrapped = true, ZIndex = 2 })
			I[9] = new("TextLabel", I[8], "Inner", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0.5, 0.45), RichText = true, Selectable = true, Size = UDim2.fromScale(1, 1), Text = "Offline Cash: $1.0k", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 32, TextWrapped = true, ZIndex = 2 })
				I[10] = new("UIGradient", I[9], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(159, 159, 159)), ColorSequenceKeypoint.new(1, Color3.fromRGB(89, 89, 89)) }), Rotation = 90 })
				I[11] = new("UIStroke", I[9], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 3 })
			I[12] = new("UIStroke", I[8], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 3 })
		I[13] = new("UIAspectRatioConstraint", I[1], "UIAspectRatioConstraint", { AspectRatio = 4.0149999 })
	return I[1]
end

return build
