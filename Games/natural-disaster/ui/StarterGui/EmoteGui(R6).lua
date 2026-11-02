-- Generated from ui/StarterGui/EmoteGui(R6).rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "EmoteGui(R6)", { ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("TextButton", I[1], "Open/Close2", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(-0.0005086, 0.422894), Size = UDim2.fromScale(0.1507497, 0.0560462), Text = "Emotes(R6)", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[3] = new("Sound", I[2], "UIHoverSound")
			I[4] = new("Sound", I[2], "MouseClickSound")
		I[5] = new("ScrollingFrame", I[1], "ScrollingFrame2", { Active = true, BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderSizePixel = 0, Position = UDim2.fromScale(0.1686784, 0.3498641), Size = UDim2.fromScale(0.1503157, 0.3243886), Visible = false })
			I[6] = new("TextButton", I[5], "Emote", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3038366, 0.0621123), Size = UDim2.fromOffset(155, 17), Text = "Anthony", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[7] = new("Animation", I[6], "Animation", { AnimationContent = Content.fromUri("rbxassetid://12940685345") })
			I[8] = new("UIListLayout", I[5], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder })
			I[9] = new("TextButton", I[5], "Emote2", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3038366, 0.0621123), Size = UDim2.fromOffset(155, 17), Text = "Peter Parker", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[10] = new("Animation", I[9], "Animation", { AnimationContent = Content.fromUri("rbxassetid://12940687889") })
			I[11] = new("TextButton", I[5], "Emote3", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3038366, 0.0621123), Size = UDim2.fromOffset(155, 17), Text = "T-Pose", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[12] = new("Animation", I[11], "Animation", { AnimationContent = Content.fromUri("rbxassetid://12940691748") })
			I[13] = new("TextButton", I[5], "Emote4", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3038366, 0.0621123), Size = UDim2.fromOffset(155, 17), Text = "Helicopter", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[14] = new("Animation", I[13], "Animation", { AnimationContent = Content.fromUri("rbxassetid://12940694325") })
			I[15] = new("TextButton", I[5], "Emote5", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3038366, 0.0621123), Size = UDim2.fromOffset(155, 17), Text = "Spin", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[16] = new("Animation", I[15], "Animation", { AnimationContent = Content.fromUri("rbxassetid://12940696666") })
			I[17] = new("TextButton", I[5], "Emote6", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3038366, 0.0621123), Size = UDim2.fromOffset(155, 17), Text = "Default Dance", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[18] = new("Animation", I[17], "Animation", { AnimationContent = Content.fromUri("rbxassetid://12940699168") })
			I[19] = new("TextButton", I[5], "Emote7", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3038366, 0.0621123), Size = UDim2.fromOffset(155, 17), Text = "Kazotsky Kick", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[20] = new("Animation", I[19], "Animation", { AnimationContent = Content.fromUri("rbxassetid://12940702283") })
			I[21] = new("TextButton", I[5], "Emote8", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3038366, 0.0621123), Size = UDim2.fromOffset(155, 17), Text = "AeroStep", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[22] = new("Animation", I[21], "Animation", { AnimationContent = Content.fromUri("rbxassetid://12940707050") })
			I[23] = new("TextButton", I[5], "Emote9", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3038366, 0.0621123), Size = UDim2.fromOffset(155, 17), Text = "Thriller", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[24] = new("Animation", I[23], "Animation", { AnimationContent = Content.fromUri("rbxassetid://12940711224") })
			I[25] = new("TextButton", I[5], "Emote10", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3038366, 0.0621123), Size = UDim2.fromOffset(155, 17), Text = "Loud Laugh", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[26] = new("Animation", I[25], "Animation", { AnimationContent = Content.fromUri("rbxassetid://12940714420") })
			I[27] = new("TextButton", I[5], "Emote11", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3038366, 0.0621123), Size = UDim2.fromOffset(155, 17), Text = "Floss", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[28] = new("Animation", I[27], "Animation", { AnimationContent = Content.fromUri("rbxassetid://12940717601") })
			I[29] = new("TextButton", I[5], "Emote12", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3038366, 0.0621123), Size = UDim2.fromOffset(155, 17), Text = "Take The L", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[30] = new("Animation", I[29], "Animation", { AnimationContent = Content.fromUri("rbxassetid://12940720025") })
			I[31] = new("TextButton", I[5], "Emote13", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3038366, 0.0621123), Size = UDim2.fromOffset(155, 17), Text = "Headless", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[32] = new("Animation", I[31], "Animation", { AnimationContent = Content.fromUri("rbxassetid://12940722292") })
			I[33] = new("TextButton", I[5], "Emote14", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3038366, 0.0621123), Size = UDim2.fromOffset(155, 17), Text = "Sea Santis", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[34] = new("Animation", I[33], "Animation", { AnimationContent = Content.fromUri("rbxassetid://12940726305") })
			I[35] = new("TextButton", I[5], "Emote15", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3038366, 0.0621123), Size = UDim2.fromOffset(155, 17), Text = "Clean Groove", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[36] = new("Animation", I[35], "Animation", { AnimationContent = Content.fromUri("rbxassetid://12940728990") })
			I[37] = new("TextButton", I[5], "Emote16", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3038366, 0.0621123), Size = UDim2.fromOffset(155, 17), Text = "Hello World", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[38] = new("Animation", I[37], "Animation", { AnimationContent = Content.fromUri("rbxassetid://12940731416") })
			I[39] = new("TextButton", I[5], "Emote17", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3038366, 0.0621123), Size = UDim2.fromOffset(155, 17), Text = "PP Music", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[40] = new("Animation", I[39], "Animation", { AnimationContent = Content.fromUri("rbxassetid://12940734501") })
			I[41] = new("TextButton", I[5], "Emote18", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3038366, 0.0621123), Size = UDim2.fromOffset(155, 17), Text = "Griddy", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[42] = new("Animation", I[41], "Animation", { AnimationContent = Content.fromUri("rbxassetid://12940756605") })
	return I[1]
end

return build
