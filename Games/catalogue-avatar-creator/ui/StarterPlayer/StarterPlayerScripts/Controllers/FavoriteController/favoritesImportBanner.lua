-- Generated from ui/StarterPlayer/StarterPlayerScripts/Controllers/FavoriteController/favoritesImportBanner.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "favoritesImportBanner", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = -1, Position = UDim2.fromScale(0.0000001, 0), Size = UDim2.fromScale(0.9999998, 0.1749069) })
		I[2] = new("Frame", I[1], "container", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(33, 34, 39), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.4764322), Size = UDim2.fromScale(0.8, 0.6333356) })
			I[3] = new("UICorner", I[2], "UICorner")
			I[4] = new("UIStroke", I[2], "UIStroke", { Color = Color3.fromRGB(59, 58, 66) })
			I[5] = new("TextLabel", I[2], "label", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0175636, 0.5000001), RichText = true, Size = UDim2.fromScale(0.7614617, 0.65), Text = "Missing something? Feel free to import your <b>Roblox favorites</b>!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
			I[6] = new("TextButton", I[2], "import", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.987, 0.5), Size = UDim2.fromScale(0.171777, 0.6499996), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14 })
				I[7] = new("UICorner", I[6], "UICorner", { BottomLeftRadius = UDim.new(0, 5), BottomRightRadius = UDim.new(0, 5), TopLeftRadius = UDim.new(0, 5), TopRightRadius = UDim.new(0, 5) })
				I[8] = new("TextLabel", I[6], "label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.611782, 0.4999999), Size = UDim2.fromScale(0.5774112, 0.6999999), Text = "Import", TextColor3 = Color3.fromRGB(33, 34, 39), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right })
				I[9] = new("ImageLabel", I[6], "icon", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(33, 34, 39), ImageContent = Content.fromUri("rbxassetid://88879020555914"), Position = UDim2.fromScale(0.08, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.1904661, 0.7499999) })
		I[10] = new("UIListLayout", I[1], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.01, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
		I[11] = new("ImageButton", I[1], "close", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://81024172191247"), ImageTransparency = 0.61, ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.5, 0.5) })
			I[12] = new("UIAspectRatioConstraint", I[11], "UIAspectRatioConstraint")
		I[13] = new("UIAspectRatioConstraint", I[1], "UIAspectRatioConstraint", { AspectRatio = 10 })
	return I[1]
end

return build
