-- Generated from ui/ReplicatedStorage/Assets/Interface/Index/Template.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Template", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromOffset(100, 100) })
		I[2] = new("ImageLabel", I[1], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://80024000248680"), LayoutOrder = 2, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.8, 0.8), ZIndex = 2 })
			I[3] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint")
		I[4] = new("TextLabel", I[1], "Rarity", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.95), RichText = true, Size = UDim2.fromScale(0.85, 0.17), Text = "1 / 1", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(255, 255, 255), TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, ZIndex = 5 })
			I[5] = new("UIStroke", I[4], "UIStroke", { Thickness = 2 })
		I[6] = new("Frame", I[1], "Back", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
			I[7] = new("UIStroke", I[6], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 3 })
		I[8] = new("TextButton", I[1], "Button", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, ZIndex = 15 })
		I[9] = new("UIGradient", I[1], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(115, 138, 151)), ColorSequenceKeypoint.new(1, Color3.fromRGB(66, 89, 102)) }), Rotation = 90 })
		I[10] = new("Frame", I[1], "Lock", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 4 })
			I[11] = new("ImageLabel", I[10], "Icon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://89325563727424"), LayoutOrder = 2, Position = UDim2.fromScale(0.05, 0.05), Size = UDim2.fromScale(0.3, 0.3), ZIndex = 5 })
				I[12] = new("UIGradient", I[11], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 234, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 162, 0)) }), Rotation = 90 })
				I[13] = new("UIAspectRatioConstraint", I[11], "UIAspectRatioConstraint")
			I[14] = new("UIGradient", I[10], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 234, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 162, 0)) }), Rotation = 90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0.59375) }) })
	return I[1]
end

return build
