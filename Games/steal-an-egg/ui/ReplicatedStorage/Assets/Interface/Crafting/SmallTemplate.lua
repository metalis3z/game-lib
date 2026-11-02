-- Generated from ui/ReplicatedStorage/Assets/Interface/Crafting/SmallTemplate.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "SmallTemplate", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = 3 })
		I[2] = new("TextLabel", I[1], "Amount", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromScale(0.85, 0.25), Text = "x2", TextColor3 = Color3.fromRGB(255, 0, 0), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(255, 255, 255), TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, ZIndex = 6 })
			I[3] = new("UIStroke", I[2], "UIStroke", { Thickness = 2 })
		I[4] = new("ImageLabel", I[1], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, LayoutOrder = 2, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.8, 0.8), ZIndex = 5 })
			I[5] = new("UIAspectRatioConstraint", I[4], "UIAspectRatioConstraint")
		I[6] = new("TextLabel", I[1], "ItemName", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 1.2), RichText = true, Size = UDim2.fromScale(1.25, 0.25), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(255, 255, 255), TextWrapped = true, ZIndex = 6 })
			I[7] = new("UIStroke", I[6], "UIStroke", { Thickness = 2 })
		I[8] = new("Frame", I[1], "Back", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1.0599999, 1.0599999), ZIndex = 3 })
			I[9] = new("UIStroke", I[8], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 3 })
				I[10] = new("UIGradient", I[9], "UIGradient", { Rotation = 90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.525), NumberSequenceKeypoint.new(1, 0.41875) }) })
		I[11] = new("Frame", I[1], "Overlay", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.4, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = 5 })
		I[12] = new("ImageLabel", I[1], "Check", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 255, 0), ImageContent = Content.fromUri("rbxassetid://71510167688230"), LayoutOrder = 2, Position = UDim2.fromScale(0.05, 0.95), Size = UDim2.fromScale(0.25, 0.25), Visible = false, ZIndex = 5 })
			I[13] = new("UIAspectRatioConstraint", I[12], "UIAspectRatioConstraint")
		I[14] = new("UIGradient", I[1], "UIGradient", { Rotation = 90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.525), NumberSequenceKeypoint.new(1, 0.41875) }) })
	return I[1]
end

return build
