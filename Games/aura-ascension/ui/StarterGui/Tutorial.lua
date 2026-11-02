-- Generated from ui/StarterGui/Tutorial.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Tutorial", { Enabled = false, ResetOnSpawn = false, SafeAreaCompatibility = Enum.SafeAreaCompatibility.None, ScreenInsets = Enum.ScreenInsets.None, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("CanvasGroup", I[1], "Canvas", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.7), Size = UDim2.fromScale(0.3028362, 0.115942), Visible = false })
			I[3] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
			I[4] = new("UIStroke", I[2], "UIStroke", { Thickness = 3500, Transparency = 0.21 })
			I[5] = new("Frame", I[2], "Aura", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.4891965, 0.5346431), Size = UDim2.fromScale(0.978393, 0.839286) })
				I[6] = new("UICorner", I[5], "UICorner", { BottomLeftRadius = UDim.new(0, 12), BottomRightRadius = UDim.new(0, 12), TopLeftRadius = UDim.new(0, 12), TopRightRadius = UDim.new(0, 12) })
				I[7] = new("ImageLabel", I[5], "Icon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://80985659773685"), LayoutOrder = 5, Position = UDim2.fromScale(-0.0794051, -0.0502754), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.4490348, 1.0862768) })
				I[8] = new("TextLabel", I[5], "Count", { AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), LayoutOrder = 10, Position = UDim2.fromScale(0.2724073, 0.0548719), Size = UDim2.fromScale(0.6700673, 0.847), Text = "Get 1K Aura", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
					I[9] = new("UIStroke", I[8], "UIStroke", { Thickness = 3 })
					I[10] = new("UIPadding", I[8], "UIPadding", { PaddingTop = UDim.new(0, 5) })
					I[11] = new("UIGradient", I[8], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(202, 78, 255)), ColorSequenceKeypoint.new(0.3546713, Color3.fromRGB(199, 121, 255)), ColorSequenceKeypoint.new(0.583045, Color3.fromRGB(154, 27, 245)), ColorSequenceKeypoint.new(0.8408305, Color3.fromRGB(209, 12, 216)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 191)) }), Rotation = 90 })
				I[12] = new("Frame", I[5], "Divider", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 19, Size = UDim2.fromScale(0.03, 1) })
			I[13] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 5.9107141 })
		I[14] = new("ImageLabel", I[1], "Arrow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, ImageContent = Content.fromUri("rbxassetid://112617528948143"), LayoutOrder = 1, Position = UDim2.fromScale(0.4991031, 0.5466333), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.1573028, -0.1562087), Visible = false, ZIndex = 15 })
	return I[1]
end

return build
