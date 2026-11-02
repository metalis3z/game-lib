-- Generated from ui/ReplicatedStorage/News.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ImageButton", nil, "News", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, HoverImageContent = Content.fromUri("rbxassetid://86947637796850"), ImageContent = Content.fromUri("rbxassetid://79371787677745"), LayoutOrder = 6, Position = UDim2.fromScale(2.6527314, 0.582956), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 0.2931583) })
		I[2] = new("ImageLabel", I[1], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://87463359438228"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.85, 0.85), ZIndex = 0 })
		I[3] = new("TextLabel", I[1], "Txt", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4771573, 0.9367086), Size = UDim2.fromScale(1, 0.2278481), Text = "Info", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[4] = new("UIStroke", I[3], "UIStroke", { Thickness = 1.8685185, Transparency = 0.35 }, { ["OriginalThickness"] = 2 }, { "ScreenStroke", "UIStroke" })
	return I[1]
end

return build
