-- Generated from ui/StarterPlayer/StarterPlayerScripts/UserInterface/LeaderboardPlayerSlot.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "LeaderboardPlayerSlot", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 0.25) })
		I[2] = new("Frame", I[1], "Left", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), SizeConstraint = Enum.SizeConstraint.RelativeYY, ZIndex = 2 })
			I[3] = new("ImageLabel", I[2], "Headshot", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("https://www.roblox.com/headshot-thumbnail/image?userId=8034104&width=420&height=420&format=png"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.75, 0.75) })
				I[4] = new("UICorner", I[3], "UICorner")
			I[5] = new("TextLabel", I[2], "DisplayName", { AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(1, 0), Size = UDim2.fromScale(3, 0.4), Text = "Boom", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
			I[6] = new("TextLabel", I[2], "Rank", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.8), Size = UDim2.fromScale(1, 0.4), Text = "#1", TextColor3 = Color3.fromRGB(255, 215, 0), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[7] = new("UIStroke", I[6], "First", { Color = Color3.fromRGB(127, 107, 0), Thickness = 5 })
				I[8] = new("UIStroke", I[6], "Normal", { Color = Color3.fromRGB(31, 31, 31), Thickness = 2, Transparency = 0.875 })
			I[9] = new("TextLabel", I[2], "UserID", { AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(1, 0.65), Size = UDim2.fromScale(2, 0.25), Text = "#123456789", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextTransparency = 0.75, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
			I[10] = new("TextLabel", I[2], "Username", { AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(1, 0.35), Size = UDim2.fromScale(2, 0.3), Text = "@GreatGuyBoom", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextTransparency = 0.75, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
		I[11] = new("Frame", I[1], "Right", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(1, 0), Size = UDim2.fromScale(1, 1), SizeConstraint = Enum.SizeConstraint.RelativeYY })
			I[12] = new("ImageLabel", I[11], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://17094014569"), Position = UDim2.fromScale(0.5, 0.475), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.75, 0.75) })
				I[13] = new("UIGradient", I[12], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 157, 0)) }), Rotation = 980 })
				I[14] = new("TextLabel", I[12], "Value", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.65), Size = UDim2.fromScale(1, 0.75), Text = "27", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
					I[15] = new("UIStroke", I[14], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Thickness = 3 })
						I[16] = new("UIGradient", I[15], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 157, 0)) }), Rotation = 980 })
			I[17] = new("Frame", I[11], "Rank", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
	return I[1]
end

return build
