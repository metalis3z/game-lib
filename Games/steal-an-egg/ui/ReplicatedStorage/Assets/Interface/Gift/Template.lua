-- Generated from ui/ReplicatedStorage/Assets/Interface/Gift/Template.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Template", { BackgroundColor3 = Color3.fromRGB(66, 89, 102), BackgroundTransparency = 0.25, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 1, Position = UDim2.fromScale(0.0807298, -0.0000001), Size = UDim2.fromScale(0.96, 0.14) })
		I[2] = new("TextLabel", I[1], "PlayerName", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.45, 0.318), Size = UDim2.fromScale(0.5368657, 0.5369324), Text = "CiAxe", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
		I[3] = new("ImageLabel", I[1], "Icon", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), Position = UDim2.fromScale(0.01, 0.5), Size = UDim2.fromScale(1, 1) })
			I[4] = new("UIAspectRatioConstraint", I[3], "UIAspectRatioConstraint")
		I[5] = new("TextLabel", I[1], "PlayerDisplayName", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.45, 0.74), Size = UDim2.fromScale(0.5368657, 0.4130671), Text = "@ciaxe", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
		I[6] = new("UIStroke", I[1], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 3 })
		I[7] = new("Frame", I[1], "Gift", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(47, 216, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.77, 0.5), Size = UDim2.fromScale(0.2, 0.55) })
			I[8] = new("Frame", I[7], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(47, 203, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
				I[9] = new("TextLabel", I[8], "Label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.9), Text = "Gift", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
			I[10] = new("TextButton", I[7], "Button", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, ZIndex = 15 })
	return I[1]
end

return build
