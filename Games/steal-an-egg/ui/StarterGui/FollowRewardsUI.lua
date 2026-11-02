-- Generated from ui/StarterGui/FollowRewardsUI.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "FollowRewardsUI", { ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["_lemonadeUniqueId"] = "tlu7cuuEtlu7" })
		I[2] = new("ImageLabel", I[1], "FollowUI", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://125638505353872"), Position = UDim2.fromScale(0.5, 0.51), Size = UDim2.fromScale(0.5167125, 0.412), Visible = false }, { ["_lemonadeUniqueId"] = "OKD0UpEUOKD0" })
			I[3] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 2 }, { ["_lemonadeUniqueId"] = "BwfWog7hBwfW" })
			I[4] = new("UICorner", I[2], "UICorner", nil, { ["_lemonadeUniqueId"] = "nGt73KQUnGt7" })
			I[5] = new("Frame", I[2], "HeaderFrame", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(67, 39, 34), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, -0.1348082), Size = UDim2.fromScale(0.434816, 0.1528342) }, { ["_lemonadeUniqueId"] = "QrA0Y13DQrA0" })
				I[6] = new("UICorner", I[5], "UICorner", nil, { ["_lemonadeUniqueId"] = "VUzaFZJNVUza" })
				I[7] = new("UIStroke", I[5], "UIStroke", { Color = Color3.fromRGB(33, 16, 16), Enabled = false, Thickness = 5.375 }, { ["_lemonadeUniqueId"] = "oIqnQzXhoIqn" }, { "ScaledUIStroke" })
				I[8] = new("TextLabel", I[5], "ItemName", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Kalam.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 2.4570692), Size = UDim2.fromScale(0.841551, 1.310854), Text = "Follow the owner and like the game for rewards !", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true }, { ["_lemonadeUniqueId"] = "jdkT52qcjdkT" })
					I[9] = new("UIStroke", I[8], "UIStroke", { Thickness = 3.5833333 }, { ["_lemonadeUniqueId"] = "3fOGjqea3fOG" }, { "ScaledUIStroke" })
				I[10] = new("TextButton", I[5], "ClaimButton", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(124, 229, 55), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Kalam.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5000001, 7.0607376), Size = UDim2.fromScale(0.8744171, 1.0319002), Text = "Claim", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 }, { ["_lemonadeUniqueId"] = "e9jbq2UIe9jb" })
					I[11] = new("UIStroke", I[10], "UIStroke", { Thickness = 3.5833333 }, { ["_lemonadeUniqueId"] = "Vo44SHI4Vo44" }, { "ScaledUIStroke" })
					I[12] = new("UICorner", I[10], "UICorner", { BottomLeftRadius = UDim.new(0.3, 0), BottomRightRadius = UDim.new(0.3, 0), TopLeftRadius = UDim.new(0.3, 0), TopRightRadius = UDim.new(0.3, 0) }, { ["_lemonadeUniqueId"] = "dIPyLnU8dIPy" })
				I[13] = new("TextLabel", I[5], "ItemName", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Kalam.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4505721, 5.2375293), Size = UDim2.fromScale(0.8415509, 0.5483326), Text = "@Silent_modss", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true }, { ["_lemonadeUniqueId"] = "NXEh7sfBNXEh" })
					I[14] = new("UIStroke", I[13], "UIStroke", { Thickness = 4 }, { ["_lemonadeUniqueId"] = "hFUE4jUAhFUE" }, { "ScaledUIStroke" })
				I[15] = new("TextLabel", I[5], "ItemName", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Kalam.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4175004, 6.0288377), Size = UDim2.fromScale(0.8415509, 1.0065372), Text = "FREE ADMIN PANEL!!!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true }, { ["_lemonadeUniqueId"] = "ufova71Jufov" })
					I[16] = new("UIStroke", I[15], "UIStroke", { Thickness = 3.5833333 }, { ["_lemonadeUniqueId"] = "mRQeKAvBmRQe" }, { "ScaledUIStroke" })
					I[17] = new("UIGradient", I[15], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(26, 0, 255)), ColorSequenceKeypoint.new(0.009932, Color3.fromRGB(17, 0, 255)), ColorSequenceKeypoint.new(0.1991682, Color3.fromRGB(0, 255, 255)), ColorSequenceKeypoint.new(0.3675709, Color3.fromRGB(4, 255, 0)), ColorSequenceKeypoint.new(0.541182, Color3.fromRGB(255, 255, 0)), ColorSequenceKeypoint.new(0.7026404, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(0.7026404, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(0.853682, Color3.fromRGB(157, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(26, 0, 255)) }), Rotation = 45 }, { ["_lemonadeUniqueId"] = "DVWIbjzXDVWI" })
				I[18] = new("ImageLabel", I[5], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://112132277624764"), Position = UDim2.fromScale(0.8181564, 4.7136674), Size = UDim2.fromOffset(75, 75) }, { ["_lemonadeUniqueId"] = "3u2ZdOfx3u2Z" })
				I[19] = new("TextLabel", I[5], "Verified", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Kalam.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.7150363, 5.3156166), Size = UDim2.fromScale(0.2373043, 0.5581841), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true }, { ["_lemonadeUniqueId"] = "1TyqWIBZ1Tyq" })
					I[20] = new("UIStroke", I[19], "UIStroke", { Thickness = 3.5833333 }, { ["_lemonadeUniqueId"] = "5rsvaAIC5rsv" }, { "ScaledUIStroke" })
				I[21] = new("TextLabel", I[5], "ItemName", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Kalam.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(1.1295596, 4.2993522), Size = UDim2.fromScale(0.841551, 1.310854), Text = "Don't forget to join the discord server!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true }, { ["_lemonadeUniqueId"] = "KLewR5hLKLew" })
					I[22] = new("UIStroke", I[21], "UIStroke", { Thickness = 3.5833333 }, { ["_lemonadeUniqueId"] = "TGL8APWoTGL8" }, { "ScaledUIStroke" })
			I[23] = new("TextButton", I[2], "CloseButton", { BackgroundColor3 = Color3.fromRGB(138, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Modal = true, Position = UDim2.fromScale(0.9568093, -0.0364005), Size = UDim2.fromScale(0.0836283, 0.1196013), Text = "X", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "GwAXFwZvGwAX" })
				I[24] = new("UIAspectRatioConstraint", I[23], "UIAspectRatioConstraint", nil, { ["_lemonadeUniqueId"] = "fQ5TLSwgfQ5T" })
				I[25] = new("UICorner", I[23], "UICorner", { BottomLeftRadius = UDim.new(0.2, 0), BottomRightRadius = UDim.new(0.2, 0), TopLeftRadius = UDim.new(0.2, 0), TopRightRadius = UDim.new(0.2, 0) }, { ["_lemonadeUniqueId"] = "1ZxLMJdZ1ZxL" })
			I[26] = new("ImageLabel", I[2], "Profile", { BackgroundColor3 = Color3.fromRGB(35, 35, 35), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), Position = UDim2.fromScale(0.4177479, 0.2565066), Size = UDim2.fromScale(0.1632005, 0.3314672) }, { ["_lemonadeUniqueId"] = "ufkYgMk4ufkY" })
				I[27] = new("UICorner", I[26], "UICorner", { BottomLeftRadius = UDim.new(0, 100), BottomRightRadius = UDim.new(0, 100), TopLeftRadius = UDim.new(0, 100), TopRightRadius = UDim.new(0, 100) }, { ["_lemonadeUniqueId"] = "sZaGDxpjsZaG" })
	return I[1]
end

return build
