-- Generated from ui/Lighting/Assets/GUI/NYPDLL.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "NYPDLL", { ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "NYPD", { BackgroundColor3 = Color3.fromRGB(111, 111, 111), Position = UDim2.fromScale(0.2474048, 0.2668329), Size = UDim2.fromScale(0.5043253, 0.4650873) })
			I[3] = new("ImageLabel", I[2], "Logo", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=7315479030"), Position = UDim2.fromScale(0.0411664, 0.0241287), Size = UDim2.fromScale(0.1972556, 0.308311) })
			I[4] = new("UICorner", I[2], "UICorner")
			I[5] = new("TextLabel", I[2], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Bangers.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3740652, 0), Size = UDim2.fromScale(0.4442539, 0.150134), Text = "NYPD License Lookup", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[6] = new("UITextSizeConstraint", I[5], "UITextSizeConstraint", { MaxTextSize = 32 })
			I[7] = new("TextLabel", I[2], "PlayerNameText", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0411664, 0.3576013), Size = UDim2.fromScale(0.1953713, 0.075067), Text = "Player Name", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[8] = new("UITextSizeConstraint", I[7], "UITextSizeConstraint", { MaxTextSize = 24 })
			I[9] = new("TextBox", I[2], "PlayerName", { BackgroundColor3 = Color3.fromRGB(72, 72, 72), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), PlaceholderColor3 = Color3.fromRGB(178, 178, 178), Position = UDim2.fromScale(0.0188679, 0.4316354), Size = UDim2.fromScale(0.2416434, 0.0911528), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[10] = new("UICorner", I[9], "UICorner")
				I[11] = new("UITextSizeConstraint", I[9], "UITextSizeConstraint", { MaxTextSize = 34 })
			I[12] = new("TextButton", I[2], "Search", { BackgroundColor3 = Color3.fromRGB(88, 88, 88), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Modal = true, Position = UDim2.fromScale(0.0360206, 0.5442359), Size = UDim2.fromScale(0.2073678, 0.075067), Text = "🔎 Search", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[13] = new("UICorner", I[12], "UICorner")
				I[14] = new("UITextSizeConstraint", I[12], "UITextSizeConstraint", { MaxTextSize = 27 })
			I[15] = new("TextLabel", I[2], "LicenseNameText", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0394481, 0.6551884), Size = UDim2.fromScale(0.1953713, 0.075067), Text = "License Plate", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[16] = new("UITextSizeConstraint", I[15], "UITextSizeConstraint", { MaxTextSize = 24 })
			I[17] = new("TextButton", I[2], "SearchLicenses", { BackgroundColor3 = Color3.fromRGB(88, 88, 88), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Modal = true, Position = UDim2.fromScale(0.0343023, 0.841823), Size = UDim2.fromScale(0.2073678, 0.075067), Text = "🔎 Search", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[18] = new("UICorner", I[17], "UICorner")
				I[19] = new("UITextSizeConstraint", I[17], "UITextSizeConstraint", { MaxTextSize = 27 })
			I[20] = new("TextBox", I[2], "LicenseText", { BackgroundColor3 = Color3.fromRGB(72, 72, 72), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), PlaceholderColor3 = Color3.fromRGB(178, 178, 178), Position = UDim2.fromScale(0.0171497, 0.7292225), Size = UDim2.fromScale(0.2416434, 0.0911528), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[21] = new("UICorner", I[20], "UICorner")
				I[22] = new("UITextSizeConstraint", I[20], "UITextSizeConstraint", { MaxTextSize = 34 })
			I[23] = new("Folder", I[2], "Licenses")
				I[24] = new("ScrollingFrame", I[23], "ScrollingFrame", { Active = true, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.2607204, 0.2091153), ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0), Size = UDim2.fromScale(0.670669, 0.7479893), Visible = false })
					I[25] = new("UICorner", I[24], "UICorner")
					I[26] = new("UIListLayout", I[24], "UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder })
				I[27] = new("TextLabel", I[23], "LicensePlate", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.6775301, 0.1313673), Size = UDim2.fromScale(0.1406518, 0.0616622), Text = "Plate", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false })
					I[28] = new("UITextSizeConstraint", I[27], "UITextSizeConstraint", { MaxTextSize = 23 })
				I[29] = new("TextLabel", I[23], "Plr", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2898799, 0.1313673), Size = UDim2.fromScale(0.1406518, 0.0616622), Text = "Player", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false })
					I[30] = new("UITextSizeConstraint", I[29], "UITextSizeConstraint", { MaxTextSize = 23 })
				I[31] = new("TextLabel", I[23], "Car", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.490566, 0.1313673), Size = UDim2.fromScale(0.1406518, 0.0616622), Text = "Car", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false })
					I[32] = new("UITextSizeConstraint", I[31], "UITextSizeConstraint", { MaxTextSize = 23 })
			I[33] = new("Folder", I[2], "License")
				I[34] = new("ImageLabel", I[33], "PlrThumbnail", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.3178028, 0.2605152), Size = UDim2.fromScale(0.2525096, 0.3946732), Visible = false })
				I[35] = new("TextLabel", I[33], "Owner", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.6037431, 0.2584056), Size = UDim2.fromScale(0.2500975, 0.0960943), Text = "Owner: [NAME]", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false })
					I[36] = new("UITextSizeConstraint", I[35], "UITextSizeConstraint", { MaxTextSize = 24 })
				I[37] = new("TextLabel", I[33], "Vehicle", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.6037431, 0.3826014), Size = UDim2.fromScale(0.2500975, 0.0960943), Text = "Vehicle: [NAME]", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false })
					I[38] = new("UITextSizeConstraint", I[37], "UITextSizeConstraint", { MaxTextSize = 24 })
				I[39] = new("TextLabel", I[33], "Stolen", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.6037431, 0.5220116), Size = UDim2.fromScale(0.2500975, 0.0960943), Text = "Reported Stolen: No", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false })
					I[40] = new("UITextSizeConstraint", I[39], "UITextSizeConstraint", { MaxTextSize = 24 })
		I[41] = new("UIAspectRatioConstraint", I[1], "UIAspectRatioConstraint", { AspectRatio = 1.4426434 })
	return I[1]
end

return build
