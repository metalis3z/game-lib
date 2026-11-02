-- Generated from ui/StarterGui/Playerlist.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Playerlist", { DisplayOrder = 10, ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "MainFrame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
			I[3] = new("CanvasGroup", I[2], "MainScroll", { Active = true, AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.9964965, 0.0091807), Size = UDim2.fromScale(0.107, 0.402) })
				I[4] = new("UICorner", I[3], "UICorner")
				I[5] = new("ScrollingFrame", I[3], "PlayerList", { Active = true, AnchorPoint = Vector2.new(0.5, 0.5), AutomaticCanvasSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, CanvasSize = UDim2.fromScale(0, 0), Position = UDim2.fromScale(0.5, 0.5), ScrollBarThickness = 3, Size = UDim2.fromScale(1, 1) })
					I[6] = new("UIListLayout", I[5], "UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder })
				I[7] = new("UIAspectRatioConstraint", I[3], "AspectRatio", { AspectRatio = 0.4535412 })
			I[8] = new("CanvasGroup", I[2], "Information", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, GroupTransparency = 1, Position = UDim2.fromScale(0.5960302, 0.5281135), Size = UDim2.fromScale(0.1923535, 0.2643064), Visible = false })
				I[9] = new("UICorner", I[8], "UICorner")
				I[10] = new("Frame", I[8], "User", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(0.9999999, 0.2729602) })
					I[11] = new("UIStroke", I[10], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Transparency = 0.45 })
					I[12] = new("ImageLabel", I[10], "PlayerIcon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://14707432416"), Position = UDim2.fromScale(0.0157538, 0.0596426), Size = UDim2.fromScale(0.1891275, 0.8687862) })
						I[13] = new("UICorner", I[12], "UICorner", { BottomLeftRadius = UDim.new(0.1111111, 0), BottomRightRadius = UDim.new(0.1111111, 0), TopLeftRadius = UDim.new(0.1111111, 0), TopRightRadius = UDim.new(0.1111111, 0) })
					I[14] = new("TextLabel", I[10], "DisplayName", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2242626, 0.0495259), Size = UDim2.fromScale(0.7587913, 0.4219951), Text = "DisplayName", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
					I[15] = new("TextLabel", I[10], "Username", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.SemiBold, Enum.FontStyle.Italic), Position = UDim2.fromScale(0.2242626, 0.4562705), Size = UDim2.fromScale(0.7587913, 0.15), Text = "@Username", TextColor3 = Color3.fromRGB(182, 182, 182), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
					I[16] = new("ImageLabel", I[10], "Icon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://10885647358"), Position = UDim2.fromScale(0.2236839, 0.6364733), Size = UDim2.fromScale(0.0695148, 0.2919554), Visible = false })
						I[17] = new("UIAspectRatioConstraint", I[16], "UIAspectRatioConstraint")
					I[18] = new("TextButton", I[10], "MoreInfoButton", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14 })
					I[19] = new("ImageLabel", I[10], "Background", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://5679408007"), ImageTransparency = 0.95, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromScale(0.1, 0.1), ZIndex = 0 })
					I[20] = new("ImageLabel", I[10], "Icon2", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=6034287513"), Position = UDim2.fromScale(0.3050787, 0.6364733), Size = UDim2.fromScale(0.0695148, 0.2919554), Visible = false })
						I[21] = new("UIAspectRatioConstraint", I[20], "UIAspectRatioConstraint")
					I[22] = new("ImageLabel", I[10], "Icon3", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://15024010866"), Position = UDim2.fromScale(0.3864734, 0.6364733), Size = UDim2.fromScale(0.0695148, 0.2919554), Visible = false })
						I[23] = new("UIAspectRatioConstraint", I[22], "UIAspectRatioConstraint")
				I[24] = new("UIStroke", I[8], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Transparency = 0.45 })
				I[25] = new("Frame", I[8], "AddFriend", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.274), Size = UDim2.fromScale(0.9999999, 0.1817918) })
					I[26] = new("UIStroke", I[25], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Transparency = 0.45 })
					I[27] = new("TextLabel", I[25], "Header", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.163873, 0.2829333), Size = UDim2.fromScale(0.8008016, 0.4219951), Text = "Add Friend", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
					I[28] = new("TextButton", I[25], "AddFriendButton", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14 })
					I[29] = new("ImageLabel", I[25], "Icon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=6034287513"), Position = UDim2.fromScale(0.0136332, 0.0495255), Size = UDim2.fromScale(0.2055889, 0.8789032) })
						I[30] = new("UIAspectRatioConstraint", I[29], "UIAspectRatioConstraint")
				I[31] = new("Frame", I[8], "InspectAvatar", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.457), Size = UDim2.fromScale(0.9999999, 0.1817918) })
					I[32] = new("UIStroke", I[31], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Transparency = 0.45 })
					I[33] = new("TextLabel", I[31], "Header", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.163873, 0.2829333), Size = UDim2.fromScale(0.8008016, 0.4219951), Text = "Inspect Avatar", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
					I[34] = new("TextButton", I[31], "InspectButton", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14 })
					I[35] = new("ImageLabel", I[31], "Icon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=6031154867"), Position = UDim2.fromScale(0.0136332, 0.0495255), Size = UDim2.fromScale(0.2055889, 0.8789032) })
						I[36] = new("UIAspectRatioConstraint", I[35], "UIAspectRatioConstraint")
				I[37] = new("UIAspectRatioConstraint", I[8], "AspectRatio", { AspectRatio = 1.2400854 })
				I[38] = new("Frame", I[8], "Block", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.6384138), Size = UDim2.fromScale(0.9999999, 0.1817918) })
					I[39] = new("UIStroke", I[38], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Transparency = 0.45 })
					I[40] = new("TextLabel", I[38], "Header", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.163873, 0.2829333), Size = UDim2.fromScale(0.8008016, 0.4219951), Text = "Block", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
					I[41] = new("TextButton", I[38], "BlockButton", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14 })
					I[42] = new("ImageLabel", I[38], "Icon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=6035047387"), Position = UDim2.fromScale(0.0136332, 0.0495255), Size = UDim2.fromScale(0.2055889, 0.8789032) })
						I[43] = new("UIAspectRatioConstraint", I[42], "UIAspectRatioConstraint")
				I[44] = new("Frame", I[8], "MultiOptions", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.8202055), Size = UDim2.fromScale(1, 0.185) })
					I[45] = new("UIStroke", I[44], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Transparency = 0.45 })
					I[46] = new("ImageLabel", I[44], "VoiceUser", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(193, 206, 255), ImageContent = Content.fromUri("rbxassetid://14333877451"), Position = UDim2.fromScale(0.7833376, 0.1584825), Size = UDim2.fromScale(0.0986085, 0.7517864), Visible = false })
						I[47] = new("UIAspectRatioConstraint", I[46], "UIAspectRatioConstraint")
					I[48] = new("TextLabel", I[44], "Header", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.015662, 0.58), Size = UDim2.fromScale(0.60513, 0.2767189), Text = "Arbalest's Playerlist Gui V1", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextTransparency = 0.72, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
					I[49] = new("ImageLabel", I[44], "Close", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(255, 82, 82), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=6031094678"), Position = UDim2.fromScale(0.8835742, 0.1584825), Size = UDim2.fromScale(0.0986085, 0.7517864) })
						I[50] = new("UIAspectRatioConstraint", I[49], "UIAspectRatioConstraint")
						I[51] = new("TextButton", I[49], "Button", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14 })
			I[52] = new("Frame", I[2], "User", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 0.1) })
				I[53] = new("UIStroke", I[52], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Transparency = 0.45 })
				I[54] = new("ImageLabel", I[52], "PlayerIcon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://14707432416"), Size = UDim2.fromScale(0.2180095, 1) })
				I[55] = new("TextLabel", I[52], "DisplayName", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2557703, 0.1926683), Size = UDim2.fromScale(0.551366, 0.421995), Text = "DisplayName", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
				I[56] = new("TextLabel", I[52], "Username", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.SemiBold, Enum.FontStyle.Italic), Position = UDim2.fromScale(0.2557703, 0.5994126), Size = UDim2.fromScale(0.551366, 0.1865115), Text = "@Username", TextColor3 = Color3.fromRGB(182, 182, 182), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
				I[57] = new("ImageLabel", I[52], "Icon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://10885647358"), Position = UDim2.fromScale(0.8354574, 0.1712607), Size = UDim2.fromScale(0.147208, 0.6146634), Visible = false })
					I[58] = new("UIAspectRatioConstraint", I[57], "UIAspectRatioConstraint")
				I[59] = new("TextButton", I[52], "MoreInfoButton", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14 })
	return I[1]
end

return build
