-- Generated from ui/StarterGui/EmoteGui(R15).rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "EmoteGui(R15)", { ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("TextButton", I[1], "Open/Close", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(-0.0005086, 0.3498641), Size = UDim2.fromScale(0.1507497, 0.0560462), Text = "Emotes(R15)", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[3] = new("Sound", I[2], "UIHoverSound")
			I[4] = new("Sound", I[2], "MouseClickSound")
		I[5] = new("ScrollingFrame", I[1], "ScrollingFrame", { Active = true, BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderSizePixel = 0, Position = UDim2.fromScale(0.1686784, 0.3498641), Size = UDim2.fromScale(0.1503157, 0.3243886), Visible = false })
			I[6] = new("TextButton", I[5], "Emote", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3038366, 0.0621123), Size = UDim2.fromOffset(155, 17), Text = "Griddy", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[7] = new("Animation", I[6], "Animation", { AnimationContent = Content.fromUri("rbxassetid://89204197638140") })
			I[8] = new("TextButton", I[5], "Emote2", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3038366, 0.0759093), Size = UDim2.fromOffset(155, 17), Text = "Smooth Moves", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[9] = new("Animation", I[8], "Animation", { AnimationContent = Content.fromUri("rbxassetid://12861412130") })
			I[10] = new("TextButton", I[5], "Emote3", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3038366, 0.0759093), Size = UDim2.fromOffset(155, 17), Text = "Macarena", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[11] = new("Animation", I[10], "Animation", { AnimationContent = Content.fromUri("rbxassetid://12861415701") })
			I[12] = new("TextButton", I[5], "Emot4", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3038366, 0.0759093), Size = UDim2.fromOffset(155, 17), Text = "Inf Dab", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(255, 255, 255), TextWrapped = true })
				I[13] = new("Animation", I[12], "Animation", { AnimationContent = Content.fromUri("rbxassetid://101884673899024") })
			I[14] = new("TextButton", I[5], "Emote5", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3038366, 0.0759093), Size = UDim2.fromOffset(155, 17), Text = "Take the L", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[15] = new("Animation", I[14], "Animation", { AnimationContent = Content.fromUri("rbxassetid://12861425538") })
			I[16] = new("TextButton", I[5], "Emote6", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3038366, 0.0759093), Size = UDim2.fromOffset(155, 17), Text = "Freestylin", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[17] = new("Animation", I[16], "Animation", { AnimationContent = Content.fromUri("rbxassetid://12861429606") })
			I[18] = new("TextButton", I[5], "Emote7", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3038366, 0.0759093), Size = UDim2.fromOffset(155, 17), Text = "Hype", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[19] = new("Animation", I[18], "Animation", { AnimationContent = Content.fromUri("rbxassetid://12861431879") })
			I[20] = new("TextButton", I[5], "Emote8", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3038366, 0.0759093), Size = UDim2.fromOffset(155, 17), Text = "Electro Swing", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[21] = new("Animation", I[20], "Animation", { AnimationContent = Content.fromUri("rbxassetid://12861434000") })
			I[22] = new("TextButton", I[5], "Emote9", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3038366, 0.0759093), Size = UDim2.fromOffset(155, 17), Text = "Hotline Bling", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[23] = new("Animation", I[22], "Animation", { AnimationContent = Content.fromUri("rbxassetid://12861436981") })
			I[24] = new("TextButton", I[5], "Emote10", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3038366, 0.0759093), Size = UDim2.fromOffset(155, 17), Text = "Fancy Feet", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[25] = new("Animation", I[24], "Animation", { AnimationContent = Content.fromUri("rbxassetid://96366493626350") })
			I[26] = new("UIListLayout", I[5], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder })
			I[27] = new("TextButton", I[5], "Emote11", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3038366, 0.0759093), Size = UDim2.fromOffset(155, 17), Text = "Kazotsky Kick", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[28] = new("Animation", I[27], "Animation", { AnimationContent = Content.fromUri("rbxassetid://72440967178068") })
			I[29] = new("TextButton", I[5], "Emote12", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3038366, 0.0759093), Size = UDim2.fromOffset(155, 17), Text = "Orange Justice", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[30] = new("Animation", I[29], "Animation", { AnimationContent = Content.fromUri("rbxassetid://123167016281072") })
			I[31] = new("TextButton", I[5], "Emote13", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3038366, 0.0759093), Size = UDim2.fromOffset(155, 17), Text = "Breakdown", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[32] = new("Animation", I[31], "Animation", { AnimationContent = Content.fromUri("rbxassetid://12861456611") })
	return I[1]
end

return build
