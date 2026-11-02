-- Generated from ui/ReplicatedStorage/Systems/Player/UI/DialogHandler/DialogMain.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "DialogMain", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.9), Size = UDim2.fromScale(0.5, 0.25) })
		I[2] = new("Folder", I[1], "Viewports")
			I[3] = new("ViewportFrame", I[2], "Player", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageTransparency = 1, LightColor = Color3.fromRGB(255, 255, 255), LightDirection = Vector3.new(7.5, -7.5, 10), Position = UDim2.fromScale(0.95, 1.4), Size = UDim2.fromScale(0.55, 2.75) })
			I[4] = new("ViewportFrame", I[2], "NPC", { AnchorPoint = Vector2.new(1, 1), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageTransparency = 1, LightColor = Color3.fromRGB(255, 255, 255), LightDirection = Vector3.new(7.5, -7.5, 10), Position = UDim2.fromScale(0.05, 1.4), Size = UDim2.fromScale(0.55, 2.75) })
		I[5] = new("TextButton", I[1], "ContinueButton", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, TextTransparency = 1 })
			I[6] = new("ImageLabel", I[5], "ContinueNotice", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(234, 234, 255), ImageContent = Content.fromUri("rbxassetid://17385953945"), ImageTransparency = 0.25, Position = UDim2.fromScale(0.5, 0.95), Size = UDim2.fromScale(0.05, 0.05), Visible = false })
				I[7] = new("UIGradient", I[6], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(177, 177, 177)) }), Rotation = 90 })
		I[8] = new("TextLabel", I[1], "Dialog", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/RobotoCondensed.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.925), Size = UDim2.fromScale(0.8, 0.725), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 32, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top })
		I[9] = new("Frame", I[1], "Background", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.2, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1.95, 1), ZIndex = 0 })
			I[10] = new("UIGradient", I[9], "UIGradient", { Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.1, 0.25), NumberSequenceKeypoint.new(0.25, 0), NumberSequenceKeypoint.new(0.75, 0), NumberSequenceKeypoint.new(0.9, 0.25), NumberSequenceKeypoint.new(1, 1) }) })
		I[11] = new("Frame", I[1], "NameFrame", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.05, 0), Size = UDim2.fromScale(0.3, 0.25) })
			I[12] = new("TextLabel", I[11], "Label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/RobotoCondensed.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "NAME", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, TextWrapped = true, ZIndex = 3 })
				I[13] = new("UIPadding", I[12], "UIPadding", { PaddingBottom = UDim.new(0, 5), PaddingLeft = UDim.new(0.2, 0), PaddingRight = UDim.new(0.2, 0), PaddingTop = UDim.new(0, 7) })
			I[14] = new("ImageLabel", I[11], "Front", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(165, 165, 180), ImageContent = Content.fromUri("rbxassetid://17385171522"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(128, 128, 384, 128), ZIndex = 2 })
				I[15] = new("UIGradient", I[14], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(177, 177, 177)) }) })
			I[16] = new("ImageLabel", I[11], "Back", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(110, 110, 120), ImageContent = Content.fromUri("rbxassetid://17385171522"), Position = UDim2.new(0.5, 3, 0.5, 3), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(128, 128, 384, 128) })
				I[17] = new("UIGradient", I[16], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(177, 177, 177)) }) })
	return I[1]
end

return build
