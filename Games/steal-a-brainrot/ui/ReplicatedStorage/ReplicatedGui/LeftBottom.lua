-- Generated from ui/ReplicatedStorage/ReplicatedGui/LeftBottom.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "LeftBottom", { ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["ViralWorkerRef"] = "vw_4624cd1832" }, { "ScreenGui" })
		I[2] = new("Frame", I[1], "LeftBottom", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 1), Size = UDim2.fromScale(1, 1) }, { ["ViralWorkerRef"] = "vw_f00b8c1602" })
			I[3] = new("TextLabel", I[2], "FriendBoost", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), LayoutOrder = 3, Position = UDim2.fromScale(0.0113517, 0.9899748), Size = UDim2.fromScale(0.1388003, 0.0297711), Text = "Friend Boost: +0%", TextColor3 = Color3.fromRGB(238, 238, 238), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left }, { ["ViralWorkerRef"] = "vw_48cfac7d0b" })
				I[4] = new("UIStroke", I[3], "UIStroke", { Thickness = 1.1092592 }, { ["OriginalThickness"] = 2, ["ViralWorkerRef"] = "vw_e1402067c8" }, { "ScreenStroke", "UIStroke" })
			I[5] = new("TextLabel", I[2], "Currency", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/DenkOne.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), LayoutOrder = 3, Position = UDim2.fromScale(0.0091565, 0.971283), Size = UDim2.fromScale(0.1196819, 0.0852207), Text = "$30,000", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left }, { ["ViralWorkerRef"] = "vw_64913f6f47" })
				I[6] = new("UIFlexItem", I[5], "UIFlexItem", { FlexMode = Enum.UIFlexMode.Grow }, { ["ViralWorkerRef"] = "vw_6c1c5ebad5" })
				I[7] = new("UIStroke", I[5], "UIStroke", { Color = Color3.fromRGB(4, 71, 6), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 3.5 }, { ["ViralWorkerRef"] = "vw_8331ca764c" })
					I[8] = new("UIGradient", I[7], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(229, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(11, 225, 0)) }), Rotation = 90 }, { ["ViralWorkerRef"] = "vw_aa21b4fb37" })
				I[9] = new("UIGradient", I[5], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(229, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(11, 225, 0)) }), Rotation = 90 }, { ["ViralWorkerRef"] = "vw_e28a2c4fbf" })
			I[10] = new("TextLabel", I[2], "CC", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), LayoutOrder = 3, Position = UDim2.fromScale(0.0113517, 0.9899748), Size = UDim2.fromScale(0.1388003, 0.0297711), Text = "CC Server", TextColor3 = Color3.fromRGB(238, 238, 238), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, Visible = false }, { ["ViralWorkerRef"] = "vw_f63511e11c" })
				I[11] = new("UIStroke", I[10], "UIStroke", { Thickness = 1.1092592 }, { ["OriginalThickness"] = 2, ["ViralWorkerRef"] = "vw_408a2b7b38" }, { "ScreenStroke", "UIStroke" })
			I[12] = new("TextLabel", I[2], "Speed", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), LayoutOrder = 3, Position = UDim2.fromScale(0.0385158, 0.8921771), Size = UDim2.fromScale(0.1205827, 0.0552891), Text = "20", TextColor3 = Color3.fromRGB(105, 197, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, Visible = false }, { ["ViralWorkerRef"] = "vw_5e3e5abe1d" })
				I[13] = new("ImageLabel", I[12], "ImageLabel", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://79571919459802"), Position = UDim2.fromScale(-0.025, 0), Size = UDim2.fromScale(1, 1), SizeConstraint = Enum.SizeConstraint.RelativeYY }, { ["ViralWorkerRef"] = "vw_167ccb6a3c" })
				I[14] = new("UIStroke", I[12], "UIStroke", { Thickness = 1.6638889 }, { ["OriginalThickness"] = 3, ["ViralWorkerRef"] = "vw_39e3b268c8" }, { "ScreenStroke", "UIStroke" })
			I[15] = new("TextLabel", I[2], "CurrencyGoldCoins", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), LayoutOrder = 3, Position = UDim2.fromScale(0.0359133, 0.8921772), Size = UDim2.fromScale(0.1205827, 0.0595421), Text = "0", TextColor3 = Color3.fromRGB(255, 204, 1), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, Visible = false }, { ["ViralWorkerRef"] = "vw_32b7736708" })
				I[16] = new("ImageLabel", I[15], "ImageLabel", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://116762624882914"), Position = UDim2.fromScale(-0.02, 0.55), Size = UDim2.fromScale(0.9, 0.9), SizeConstraint = Enum.SizeConstraint.RelativeYY }, { ["ViralWorkerRef"] = "vw_0b9f6c720e" })
				I[17] = new("UIStroke", I[15], "UIStroke", { Thickness = 2.6611111 }, { ["OriginalThickness"] = 3, ["ViralWorkerRef"] = "vw_6445ab6ed2" }, { "ScreenStroke", "UIStroke" })
			I[18] = new("TextLabel", I[2], "CurrencyBunnyCoins", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), LayoutOrder = 3, Position = UDim2.fromScale(0.0359133, 0.8921772), Size = UDim2.fromScale(0.1205827, 0.0595421), Text = "0", TextColor3 = Color3.fromRGB(255, 204, 1), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, Visible = false }, { ["ViralWorkerRef"] = "vw_c134a2eb69" })
				I[19] = new("ImageLabel", I[18], "ImageLabel", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://104580984078313"), Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(1.1, 1.1), SizeConstraint = Enum.SizeConstraint.RelativeYY }, { ["ViralWorkerRef"] = "vw_7de2db9551" })
				I[20] = new("UIStroke", I[18], "UIStroke", { Thickness = 3 }, { ["OriginalThickness"] = 3, ["ViralWorkerRef"] = "vw_92051ba88e" }, { "ScreenStroke", "UIStroke" })
			I[21] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 2.1500001 }, { ["ViralWorkerRef"] = "vw_795b5e3103" })
			I[22] = new("Frame", I[2], "Cashout", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.03, 0.872), Size = UDim2.fromScale(0.14, 0.1763474) }, { ["ViralWorkerRef"] = "vw_442f8c43d5" })
				I[23] = new("TextLabel", I[22], "Template", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 3, Position = UDim2.fromScale(0.01, 0.98), Size = UDim2.fromScale(1, 0.25), Text = "$30,000", TextColor3 = Color3.fromRGB(173, 0, 3), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, Visible = false }, { ["ViralWorkerRef"] = "vw_ec41a9a4b1" })
					I[24] = new("UIStroke", I[23], "UIStroke", { Thickness = 1.6638889 }, { ["OriginalThickness"] = 3, ["ViralWorkerRef"] = "vw_e0bcbac143" }, { "ScreenStroke", "UIStroke" })
				I[25] = new("UIListLayout", I[22], "UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Bottom }, { ["ViralWorkerRef"] = "vw_955075d96a" })
	return I[1]
end

return build
