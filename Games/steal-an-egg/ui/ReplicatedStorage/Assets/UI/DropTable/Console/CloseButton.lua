-- Generated from ui/ReplicatedStorage/Assets/UI/DropTable/Console/CloseButton.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ImageButton", nil, "CloseButton", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://136642335648912"), Position = UDim2.fromScale(0.991, 0), PressedImageContent = Content.fromUri("rbxassetid://99586707926066"), ScaleType = Enum.ScaleType.Slice, Selectable = false, Size = UDim2.new(1, 0, 0.06, 45), SliceCenter = Rect.new(55, 55, 55, 55), Visible = false, ZIndex = 50 })
		I[2] = new("UIAspectRatioConstraint", I[1], "UIAspectRatioConstraint")
		I[3] = new("UIGradient", I[1], "red gradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 2, 61)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 39, 125)) }), Rotation = -90 })
		I[4] = new("ImageLabel", I[1], "shadow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://130304595536693"), ImageTransparency = 0.75, Position = UDim2.fromScale(0.5, 0.6), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1.1), SliceCenter = Rect.new(50, 50, 150, 150), SliceScale = 0.75, ZIndex = 49 })
		I[5] = new("TextLabel", I[1], "PSLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.48), Size = UDim2.fromScale(0.9, 0.6), Text = "O", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextWrapped = true, Visible = false, ZIndex = 50 })
			I[6] = new("UIStroke", I[5], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 3 })
		I[7] = new("TextLabel", I[1], "XboxLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.52, 0.49), Size = UDim2.fromScale(0.9, 0.6), Text = "B", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextWrapped = true, Visible = false, ZIndex = 50 })
			I[8] = new("UIStroke", I[7], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 3 })
	return I[1]
end

return build
