-- Generated from ui/StarterPlayer/StarterPlayerScripts/Elements/ItemButton/itemOnlyName.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "itemOnlyName", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(0.159, 0.9626351) })
		I[2] = new("Frame", I[1], "preview", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(43, 45, 51), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.4999999, 0), Size = UDim2.fromScale(1, 0.7158489) })
			I[3] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0.075, 0), BottomRightRadius = UDim.new(0.075, 0), TopLeftRadius = UDim.new(0.075, 0), TopRightRadius = UDim.new(0.075, 0) })
			I[4] = new("ImageLabel", I[2], "image", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxthumb://type=Asset&id=31101391&w=420&h=420"), ImageTransparency = 0.98, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1) }, { ["SkipThemeImage"] = true })
			I[5] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectType = Enum.AspectType.ScaleWithParentSize })
			I[6] = new("ViewportFrame", I[2], "viewport", { Ambient = Color3.fromRGB(202, 202, 202), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageTransparency = 1, LightColor = Color3.fromRGB(221, 221, 221), LightDirection = Vector3.new(0.5, -1, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 0 })
				I[7] = new("UICorner", I[6], "UICorner")
		I[8] = new("UIPadding", I[1], "UIPadding", { PaddingLeft = UDim.new(0.01, 0), PaddingRight = UDim.new(0.01, 0) })
		I[9] = new("TextLabel", I[1], "name", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.01, 1), Size = UDim2.fromScale(0.95, 0.10334), Text = "", TextColor3 = Color3.fromRGB(247, 247, 248), TextScaled = true, TextSize = 14, TextTruncate = Enum.TextTruncate.AtEnd, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
		I[10] = new("ImageLabel", I[1], "icon", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://113197611747052"), Position = UDim2.fromScale(-0.02, 0.97), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.15, 0.0879991), Visible = false })
		I[11] = new("TextButton", I[1], "viewItem", { AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(34, 119, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1.0000001), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, ZIndex = 10 }, nil, { "UIEffectSoundOnly" })
		I[12] = new("Frame", I[1], "labels", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 0.716) })
			I[13] = new("UIListLayout", I[12], "UIListLayout", { Padding = UDim.new(0.02, 0), SortOrder = Enum.SortOrder.LayoutOrder })
			I[14] = new("UIPadding", I[12], "UIPadding", { PaddingBottom = UDim.new(0.02, 0), PaddingLeft = UDim.new(0.027, 0), PaddingRight = UDim.new(0.02, 0), PaddingTop = UDim.new(0.04, 0) })
		I[15] = new("Folder", I[1], "skeleton")
			I[16] = new("Frame", I[15], "nameShimmer", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(43, 45, 51), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromScale(1, 0.103), ZIndex = 10 })
				I[17] = new("UICorner", I[16], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
				I[18] = new("UIGradient", I[16], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(199, 199, 199)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }), Offset = Vector2.new(-1, 0) })
			I[19] = new("Frame", I[15], "previewShimmer", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(43, 45, 51), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.4999999, 0), Size = UDim2.fromScale(1, 0.7158489), ZIndex = 10 })
				I[20] = new("UICorner", I[19], "UICorner", { BottomLeftRadius = UDim.new(0.075, 0), BottomRightRadius = UDim.new(0.075, 0), TopLeftRadius = UDim.new(0.075, 0), TopRightRadius = UDim.new(0.075, 0) })
				I[21] = new("UIAspectRatioConstraint", I[19], "UIAspectRatioConstraint", { AspectType = Enum.AspectType.ScaleWithParentSize })
				I[22] = new("UIGradient", I[19], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(199, 199, 199)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }), Offset = Vector2.new(-1, 0) })
	return I[1]
end

return build
