-- Generated from ui/StarterGui/Tools_shop.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Tools_shop", { Enabled = false, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets })
		I[2] = new("Frame", I[1], "Frame", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.1614217, 0.2373148), Size = UDim2.fromScale(0.675887, 0.5245538) })
			I[3] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0, 20), BottomRightRadius = UDim.new(0, 20), TopLeftRadius = UDim.new(0, 20), TopRightRadius = UDim.new(0, 20) })
			I[4] = new("ScrollingFrame", I[2], "List", { Active = true, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(24, 24, 24), BackgroundTransparency = 0.7, BorderSizePixel = 0, CanvasSize = UDim2.fromScale(0, 0), Position = UDim2.fromScale(0.4997415, 0.5509999), ScrollBarThickness = 5, ScrollingDirection = Enum.ScrollingDirection.X, Size = UDim2.fromScale(0.9461209, 0.7939999) })
				I[5] = new("UIListLayout", I[4], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder })
				I[6] = new("Frame", I[4], "Template", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(20, 21, 20), BorderSizePixel = 0, Position = UDim2.fromScale(0.1583143, 0.5000001), Size = UDim2.fromScale(0.3166286, 1.0000002), Visible = false })
					I[7] = new("UICorner", I[6], "UICorner")
					I[8] = new("TextButton", I[6], "Buy", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(34, 43, 34), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4942619, 0.9052361), Size = UDim2.fromScale(0.9251457, 0.1408173), Text = "Buy", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
						I[9] = new("UICorner", I[8], "UICorner")
					I[10] = new("UIAspectRatioConstraint", I[6], "UIAspectRatioConstraint", { AspectRatio = 0.697 })
					I[11] = new("TextButton", I[6], "Price", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(34, 43, 34), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4942619, 0.7521306), Size = UDim2.fromScale(0.9251457, 0.127208), Text = "1343", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
						I[12] = new("UICorner", I[11], "UICorner")
					I[13] = new("TextButton", I[6], "ItemName", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(34, 43, 34), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4942619, 0.3499881), Size = UDim2.fromScale(0.9251457, 0.6422937), Text = "ItemName", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
						I[14] = new("UICorner", I[13], "UICorner")
					I[15] = new("TextLabel", I[6], "VIPLabel", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.new(1, -35, 0, 2), Size = UDim2.fromOffset(30, 16), Text = "VIP", TextColor3 = Color3.fromRGB(255, 200, 0), TextScaled = true, TextSize = 12, TextWrapped = true, Visible = false })
			I[16] = new("TextLabel", I[2], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3041595, 0.07), RichText = true, Size = UDim2.fromScale(0.5614224, 0.112), Text = "Shop", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
	return I[1]
end

return build
