-- Generated from ui/ReplicatedStorage/Systems/Player/UI/Menus/Achievements/Templates/Achievement.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ImageLabel", nil, "Achievement", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://19000746528"), Position = UDim2.fromScale(0.525, 0.0325), Size = UDim2.fromScale(0.99, 0.175) })
		I[2] = new("TextLabel", I[1], "Title", { AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/AccanthisADFStd.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.18, 0.125), RichText = true, Size = UDim2.fromScale(0.75, 0.3), Text = "Achievement Name", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 36, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
		I[3] = new("ImageLabel", I[1], "IconBackground", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://123631799697059"), Position = UDim2.fromScale(0.1, 0.51), Size = UDim2.fromScale(0.15, 0.925) })
			I[4] = new("UIAspectRatioConstraint", I[3], "UIAspectRatioConstraint")
		I[5] = new("TextLabel", I[1], "Description", { AnchorPoint = Vector2.new(0, 1), AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/AccanthisADFStd.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.18, 0.65), RichText = true, Size = UDim2.fromScale(0.75, 0.225), Text = "Achievement Description", TextColor3 = Color3.fromRGB(190, 190, 190), TextScaled = true, TextSize = 36, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
		I[6] = new("TextLabel", I[1], "Progress", { AnchorPoint = Vector2.new(0, 1), AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/AccanthisADFStd.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.18, 0.875), RichText = true, Size = UDim2.fromScale(0.11, 0.2), Text = "100/100", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 36, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
		I[7] = new("ImageLabel", I[1], "ProgressBar", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(145, 145, 145), ImageContent = Content.fromUri("rbxassetid://18818548751"), Position = UDim2.fromScale(0.3, 0.75), Size = UDim2.new(0.65, 0, 0.025, 4) })
			I[8] = new("Frame", I[7], "Clipping", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Size = UDim2.fromScale(1, 1) })
				I[9] = new("ImageLabel", I[8], "Top", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://18818548751"), Size = UDim2.fromScale(1, 1) })
		I[10] = new("ImageLabel", I[1], "IncompleteOverlay", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://19000746528"), ImageTransparency = 0.35, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 15 })
		I[11] = new("ImageLabel", I[1], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(30, 30, 30), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), Position = UDim2.fromScale(0.1, 0.51), Size = UDim2.fromScale(0.15, 0.8), ZIndex = 0 })
			I[12] = new("UIAspectRatioConstraint", I[11], "UIAspectRatioConstraint")
			I[13] = new("UICorner", I[11], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
		I[14] = new("ImageLabel", I[1], "RewardOverlay", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://19000746528"), ImageTransparency = 0.35, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 15 })
			I[15] = new("TextLabel", I[14], "Title", { AnchorPoint = Vector2.new(0.5, 0), AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/AccanthisADFStd.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.175), RichText = true, Size = UDim2.fromScale(1, 0.25), Text = "Reward:", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 36, TextWrapped = true })
			I[16] = new("TextLabel", I[14], "RewardTitle", { AnchorPoint = Vector2.new(0.5, 1), AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/AccanthisADFStd.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.825), RichText = true, Size = UDim2.fromScale(1, 0.35), Text = "IDK", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 36, TextWrapped = true })
	return I[1]
end

return build
