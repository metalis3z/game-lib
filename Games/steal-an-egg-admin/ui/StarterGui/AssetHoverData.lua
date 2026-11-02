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
	I[1] = new("ScreenGui", nil, "AssetHoverData", { DisplayOrder = -1000, Enabled = false, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["_lemonadeUniqueId"] = "Ifze5OCWIfze", ["bruh"] = true })
		I[2] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0.3, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Interactable = false, Position = UDim2.fromScale(0.5000001, 0.5), Size = UDim2.fromScale(0.1353896, 0.1290497) }, { ["_lemonadeUniqueId"] = "RI0LM6BjRI0L" })
			I[3] = new("CanvasGroup", I[2], "CanvasGroup", { AnchorPoint = Vector2.new(0.5, 0.5), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.4999999, 0.3847494), Size = UDim2.fromScale(1.4, 1.4305011) }, { ["_lemonadeUniqueId"] = "YWY2gAnfYWY2" })
				I[4] = new("UIListLayout", I[3], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.055, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center }, { ["_lemonadeUniqueId"] = "ohDM00jxohDM" })
				I[5] = new("TextLabel", I[3], "Weight", { AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0, 0.3287291), Size = UDim2.fromScale(1, 0.2734849), Text = "10 Kg", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "dhDlFVYqdhDl" })
					I[6] = new("UIStroke", I[5], "UIStroke1", { Thickness = 2.5 }, { ["_lemonadeUniqueId"] = "UYizMBIkUYiz", ["oldp_Thickness"] = 2.5 })
				I[7] = new("ImageLabel", I[3], "Gender", { AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://88627876961976"), Position = UDim2.fromScale(0, -0.004121), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 0.2734849) }, { ["_lemonadeUniqueId"] = "HxMpkch7HxMp" })
			I[8] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 2.5411789 }, { ["_lemonadeUniqueId"] = "mYlaW9cCmYla" })
	return I[1]
end

return build
