-- Generated from ui/StarterGui/AssetHoverData.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "AssetHoverData", { DisplayOrder = -1000, Enabled = false, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["bruh"] = true })
		I[2] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0.3, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Interactable = false, Position = UDim2.fromScale(0.5000001, 0.5), Size = UDim2.fromScale(0.1353896, 0.1290497) })
			I[3] = new("CanvasGroup", I[2], "CanvasGroup", { AnchorPoint = Vector2.new(0.5, 0.5), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.4999999, 0.3847494), Size = UDim2.fromScale(1.4, 1.4305011) })
				I[4] = new("UIListLayout", I[3], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.055, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
				I[5] = new("TextLabel", I[3], "Weight", { AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0, 0.3287291), Size = UDim2.fromScale(1, 0.2734849), Text = "10 Kg", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[6] = new("UIStroke", I[5], "UIStroke1", { Thickness = 2.5 }, { ["oldp_Thickness"] = 2.5 })
				I[7] = new("ImageLabel", I[3], "Gender", { AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://88627876961976"), Position = UDim2.fromScale(0, -0.004121), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 0.2734849) })
				I[8] = new("Frame", I[3], "Steal", { AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 2, Position = UDim2.fromScale(0, 0.6615793), Size = UDim2.fromScale(1, 0.2734849), Visible = false })
					I[9] = new("TextLabel", I[8], "Text", { AnchorPoint = Vector2.new(0.5, 0.5), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 2, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(-0.2389605, 0.5), RichText = true, Size = UDim2.fromScale(0.3244554, 1), Text = "STEAL", TextColor3 = Color3.fromRGB(255, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
						I[10] = new("UIStroke", I[9], "UIStroke", { Thickness = 2 })
					I[11] = new("ImageLabel", I[8], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://111955278473321"), Position = UDim2.fromScale(0.337772, 0.432797), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.1614766, 1.1344064), ZIndex = 3 })
						I[12] = new("UIAspectRatioConstraint", I[11], "UIAspectRatioConstraint", { AspectRatio = 1.157323 })
					I[13] = new("UIListLayout", I[8], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
			I[14] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 2.5411789 })
	return I[1]
end

return build
