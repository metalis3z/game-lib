-- Generated from ui/ReplicatedStorage/Modules/ClientPassives/Healer/MedicHealth.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "MedicHealth", { Active = true, Brightness = 2, MaxDistance = 25, Size = UDim2.new(4, 50, 0.75, 20), StudsOffset = Vector3.new(0.5, 0, 0), StudsOffsetWorldSpace = Vector3.new(0, 3.75, 0), ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("CanvasGroup", I[1], "Holder", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.8), Size = UDim2.fromScale(1, 0.5) })
			I[3] = new("ImageLabel", I[2], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(73, 194, 65), ImageContent = Content.fromUri("rbxassetid://139024622029957"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.143, 1), ZIndex = 3 })
				I[4] = new("UIGradient", I[3], "UIGradient", { Rotation = 90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.418065, 0), NumberSequenceKeypoint.new(1, 1) }) })
			I[5] = new("UIListLayout", I[2], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0.04, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
			I[6] = new("UIPadding", I[2], "UIPadding", { PaddingBottom = UDim.new(0.1, 0), PaddingTop = UDim.new(0.1, 0) })
			I[7] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 6.96875 })
			I[8] = new("TextLabel", I[2], "HP", { AnchorPoint = Vector2.new(0.5, 0.5), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365769", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), RichText = true, Size = UDim2.fromScale(0, 1), Text = "<font size=\"90\"><font color =\"rgb(73, 194, 65)\">100<font color=\"rgb(255,255,255)\"><font size =\"100\">/100HP</font></font></font></font>", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 100, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
		I[9] = new("CanvasGroup", I[1], "ShieldHolder", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.2), Size = UDim2.fromScale(1, 0.5), Visible = false })
			I[10] = new("ImageLabel", I[9], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(133, 55, 188), ImageContent = Content.fromUri("rbxassetid://480775940"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.143, 1), ZIndex = 3 })
				I[11] = new("UIGradient", I[10], "UIGradient", { Rotation = 90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.418065, 0), NumberSequenceKeypoint.new(1, 1) }) })
			I[12] = new("UIListLayout", I[9], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0.04, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
			I[13] = new("UIPadding", I[9], "UIPadding", { PaddingBottom = UDim.new(0.1, 0), PaddingTop = UDim.new(0.1, 0) })
			I[14] = new("UIAspectRatioConstraint", I[9], "UIAspectRatioConstraint", { AspectRatio = 6.96875 })
			I[15] = new("TextLabel", I[9], "HP", { AnchorPoint = Vector2.new(0.5, 0.5), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365769", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), RichText = true, Size = UDim2.fromScale(0, 1), Text = "<font color=\"rgb(133, 55, 188)\"><font size =\"100\">100/100</font></font>", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 100, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
	return I[1]
end

return build
