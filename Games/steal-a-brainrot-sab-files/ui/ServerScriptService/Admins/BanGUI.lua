-- Generated from ui/ServerScriptService/Admins/BanGUI.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "BanGUI", { ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["_lemonadeUniqueId"] = "7Y9AU6Ks7Y9A" })
		I[2] = new("Frame", I[1], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(58, 58, 58), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.6552749, 0.6253443), Visible = false }, { ["_lemonadeUniqueId"] = "gP24NtrJgP24" })
			I[3] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0, 15), BottomRightRadius = UDim.new(0, 15), TopLeftRadius = UDim.new(0, 15), TopRightRadius = UDim.new(0, 15) }, { ["_lemonadeUniqueId"] = "uqehEmQcuqeh" })
			I[4] = new("Frame", I[2], "Placeholder", { BackgroundColor3 = Color3.fromRGB(40, 40, 40), BorderSizePixel = 0, Position = UDim2.fromScale(0.0315068, 0.0514905), Size = UDim2.fromScale(0.3643835, 0.100271), ZIndex = 3 }, { ["_lemonadeUniqueId"] = "xvpiIHX1xvpi" })
				I[5] = new("UICorner", I[4], "UICorner", { BottomLeftRadius = UDim.new(0, 5), BottomRightRadius = UDim.new(0, 5), TopLeftRadius = UDim.new(0, 5), TopRightRadius = UDim.new(0, 5) }, { ["_lemonadeUniqueId"] = "5RwMv1eM5RwM" })
				I[6] = new("ImageLabel", I[4], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 3, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(79, 79, 79), ImageContent = Content.fromUri("rbxassetid://8051942771"), Position = UDim2.fromScale(0.7857144, -0.135135), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.2736605, 1.2432432) }, { ["_lemonadeUniqueId"] = "mcvvei6Gmcvv" })
					I[7] = new("UIAspectRatioConstraint", I[6], "UIAspectRatioConstraint", { AspectRatio = 1.5824716 }, { ["_lemonadeUniqueId"] = "I4xuz6AqI4xu" })
				I[8] = new("TextLabel", I[4], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 2, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.0810811), Size = UDim2.fromScale(0.5639098, 0.8108108), Text = "Ban Panel", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "bQHVebUkbQHV" })
					I[9] = new("UIAspectRatioConstraint", I[8], "UIAspectRatioConstraint", { AspectRatio = 4.9999995 }, { ["_lemonadeUniqueId"] = "aBIR9UtxaBIR" })
				I[10] = new("UIAspectRatioConstraint", I[4], "UIAspectRatioConstraint", { AspectRatio = 7.1891885 }, { ["_lemonadeUniqueId"] = "swxYgIpJswxY" })
			I[11] = new("Frame", I[2], "Frame", { BackgroundColor3 = Color3.fromRGB(79, 79, 79), BorderSizePixel = 0, Position = UDim2.fromScale(0.0164384, 0.0271003), Size = UDim2.fromScale(0.9643835, 0.9430894) }, { ["_lemonadeUniqueId"] = "4BVizgjV4BVi" })
				I[12] = new("UICorner", I[11], "UICorner", nil, { ["_lemonadeUniqueId"] = "FgNXQ1cgFgNX" })
				I[13] = new("UIAspectRatioConstraint", I[11], "UIAspectRatioConstraint", { AspectRatio = 2.0229883 }, { ["_lemonadeUniqueId"] = "jO7eag7pjO7e" })
			I[14] = new("Frame", I[2], "Players", { BackgroundColor3 = Color3.fromRGB(58, 58, 58), BorderSizePixel = 0, Position = UDim2.fromScale(0.0315068, 0.1788618), Size = UDim2.fromScale(0.3643835, 0.7723577) }, { ["_lemonadeUniqueId"] = "0pbVGIEU0pbV" })
				I[15] = new("UICorner", I[14], "UICorner", nil, { ["_lemonadeUniqueId"] = "Iuc4xXH1Iuc4" })
				I[16] = new("ScrollingFrame", I[14], "ScrollingFrame", { Active = true, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 2, BorderSizePixel = 0, Position = UDim2.fromScale(0.0263158, 0.0210526), ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0), Size = UDim2.fromScale(0.9736842, 0.9543859) }, { ["_lemonadeUniqueId"] = "pyAg0SFTpyAg" })
					I[17] = new("UIListLayout", I[16], "UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder }, { ["_lemonadeUniqueId"] = "l5sscvuAl5ss" })
					I[18] = new("UIAspectRatioConstraint", I[16], "UIAspectRatioConstraint", { AspectRatio = 0.9522058 }, { ["_lemonadeUniqueId"] = "wvDzMGbXwvDz" })
				I[19] = new("UIAspectRatioConstraint", I[14], "UIAspectRatioConstraint", { AspectRatio = 0.9333332 }, { ["_lemonadeUniqueId"] = "2hZKtc7x2hZK" })
			I[20] = new("Frame", I[2], "Ban", { BackgroundColor3 = Color3.fromRGB(58, 58, 58), BorderSizePixel = 0, Position = UDim2.fromScale(0.4095891, 0.0514905), Size = UDim2.fromScale(0.5575342, 0.899729) }, { ["_lemonadeUniqueId"] = "Mpgc5WH3Mpgc" })
				I[21] = new("UICorner", I[20], "UICorner", nil, { ["_lemonadeUniqueId"] = "i8QM9fnbi8QM" })
				I[22] = new("TextLabel", I[20], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 3, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.0813253), Size = UDim2.fromScale(1, 0.0993976), Text = "Ban Player", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "GDcaFBYmGDca" })
					I[23] = new("UIAspectRatioConstraint", I[22], "UIAspectRatioConstraint", { AspectRatio = 12.3333311 }, { ["_lemonadeUniqueId"] = "qthbvPccqthb" })
				I[24] = new("TextBox", I[20], "player", { BackgroundColor3 = Color3.fromRGB(40, 40, 40), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), PlaceholderColor3 = Color3.fromRGB(178, 178, 178), PlaceholderText = "Player Name", Position = UDim2.fromScale(0.031941, 0.2289157), Size = UDim2.fromScale(0.9361179, 0.0963855), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "yrsB9NUGyrsB" })
					I[25] = new("UIAspectRatioConstraint", I[24], "UIAspectRatioConstraint", { AspectRatio = 11.906249 }, { ["_lemonadeUniqueId"] = "yR6c749vyR6c" })
				I[26] = new("TextBox", I[20], "reason", { BackgroundColor3 = Color3.fromRGB(40, 40, 40), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), PlaceholderColor3 = Color3.fromRGB(178, 178, 178), PlaceholderText = "Reason", Position = UDim2.fromScale(0.031941, 0.3524097), Size = UDim2.fromScale(0.9361179, 0.0963855), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "GHm8N4AKGHm8" })
					I[27] = new("UIAspectRatioConstraint", I[26], "UIAspectRatioConstraint", { AspectRatio = 11.906249 }, { ["_lemonadeUniqueId"] = "nOc936XXnOc9" })
				I[28] = new("TextBox", I[20], "time", { BackgroundColor3 = Color3.fromRGB(40, 40, 40), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), PlaceholderColor3 = Color3.fromRGB(178, 178, 178), PlaceholderText = "Days", Position = UDim2.fromScale(0.031941, 0.4849398), Size = UDim2.fromScale(0.3144963, 0.0963855), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "I6DOyzKqI6DO" })
					I[29] = new("UIAspectRatioConstraint", I[28], "UIAspectRatioConstraint", { AspectRatio = 3.9999995 }, { ["_lemonadeUniqueId"] = "XdSXYGlVXdSX" })
				I[30] = new("TextButton", I[20], "ban", { BackgroundColor3 = Color3.fromRGB(145, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1400491, 0.6566265), Size = UDim2.fromScale(0.3439804, 0.0963855), Text = "BAN", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "Yto8reUeYto8" })
					I[31] = new("UIAspectRatioConstraint", I[30], "UIAspectRatioConstraint", { AspectRatio = 4.375 }, { ["_lemonadeUniqueId"] = "LXUEWgiCLXUE" })
				I[32] = new("TextButton", I[20], "unban", { BackgroundColor3 = Color3.fromRGB(38, 145, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5208845, 0.6566265), Size = UDim2.fromScale(0.3439804, 0.0963855), Text = "UNBAN", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "3LOBwXMc3LOB" })
					I[33] = new("UIAspectRatioConstraint", I[32], "UIAspectRatioConstraint", { AspectRatio = 4.375 }, { ["_lemonadeUniqueId"] = "ThWRXoXJThWR" })
				I[34] = new("TextLabel", I[20], "status", { BackgroundColor3 = Color3.fromRGB(255, 217, 0), BackgroundTransparency = 2.9400001, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.8403614), Size = UDim2.fromScale(1, 0.0722892), Text = "STATUS: OK", TextColor3 = Color3.fromRGB(255, 247, 0), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "ZlJwk44KZlJw" })
					I[35] = new("UIAspectRatioConstraint", I[34], "UIAspectRatioConstraint", { AspectRatio = 16.9583302 }, { ["_lemonadeUniqueId"] = "xN360ZUwxN36" })
				I[36] = new("UIAspectRatioConstraint", I[20], "UIAspectRatioConstraint", { AspectRatio = 1.2259034 }, { ["_lemonadeUniqueId"] = "YMfN1vwYYMfN" })
			I[37] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 1.9783196 }, { ["_lemonadeUniqueId"] = "VAumQjTHVAum" })
		I[38] = new("Folder", I[1], "Template", nil, { ["_lemonadeUniqueId"] = "YjCWH1DfYjCW" })
			I[39] = new("TextButton", I[38], "player", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 2, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.0000001), Size = UDim2.fromScale(0.9351926, 0.0454441), Text = "OnlyTwentyCharacters", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false }, { ["_lemonadeUniqueId"] = "215vu9wO215v" })
		I[40] = new("Folder", I[1], "Scripts", nil, { ["_lemonadeUniqueId"] = "xQkeQFNJxQke" })
		I[41] = new("RemoteEvent", I[1], "Ban", nil, { ["_lemonadeUniqueId"] = "6u0nP8iu6u0n" })
		I[42] = new("RemoteEvent", I[1], "Unban", nil, { ["_lemonadeUniqueId"] = "W91Tv2N9W91T" })
		I[43] = new("TextButton", I[1], "Open", { BackgroundColor3 = Color3.fromRGB(21, 0, 255), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.7699724), Size = UDim2.fromOffset(124, 26), Text = "Open Ban Menu", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "nyvfU1p7nyvf" })
			I[44] = new("UIAspectRatioConstraint", I[43], "UIAspectRatioConstraint", { AspectRatio = 4.7692308 }, { ["_lemonadeUniqueId"] = "0Rm7O0Cs0Rm7" })
			I[45] = new("UICorner", I[43], "UICorner", nil, { ["_lemonadeUniqueId"] = "WbZlD9qaWbZl" })
	return I[1]
end

return build
