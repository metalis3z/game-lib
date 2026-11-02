-- Generated from ui/Lighting/Assets/GUI/NYPDBase.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "NYPDBase", { ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "NYPD", { BackgroundColor3 = Color3.fromRGB(111, 111, 111), Position = UDim2.fromScale(0.2474048, 0.2668329), Size = UDim2.fromScale(0.5043253, 0.4650873) })
			I[3] = new("ImageLabel", I[2], "Logo", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=7315479030"), Position = UDim2.fromScale(0.0411664, 0.0241287), Size = UDim2.fromScale(0.1972556, 0.308311) })
			I[4] = new("UICorner", I[2], "UICorner")
			I[5] = new("TextLabel", I[2], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Bangers.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3740652, 0), Size = UDim2.fromScale(0.4442539, 0.150134), Text = "NYPD Criminal Database", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[6] = new("UITextSizeConstraint", I[5], "UITextSizeConstraint", { MaxTextSize = 32 })
			I[7] = new("ScrollingFrame", I[2], "ScrollingFrame", { Active = true, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.2607204, 0.2091153), ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0), Size = UDim2.fromScale(0.670669, 0.7479893) })
				I[8] = new("UICorner", I[7], "UICorner")
				I[9] = new("UIListLayout", I[7], "UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder })
			I[10] = new("TextLabel", I[2], "TLOfficer", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2898799, 0.1313673), Size = UDim2.fromScale(0.1406518, 0.0616622), Text = "Officer", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[11] = new("UITextSizeConstraint", I[10], "UITextSizeConstraint", { MaxTextSize = 23 })
			I[12] = new("TextLabel", I[2], "TLTime", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.490566, 0.1313673), Size = UDim2.fromScale(0.1406518, 0.0616622), Text = "Time", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[13] = new("UITextSizeConstraint", I[12], "UITextSizeConstraint", { MaxTextSize = 23 })
			I[14] = new("TextLabel", I[2], "TLCharges", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.6775301, 0.1313673), Size = UDim2.fromScale(0.1406518, 0.0616622), Text = "Charges", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[15] = new("UITextSizeConstraint", I[14], "UITextSizeConstraint", { MaxTextSize = 23 })
			I[16] = new("TextLabel", I[2], "PlayerNameText", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0411664, 0.3576013), Size = UDim2.fromScale(0.1953713, 0.075067), Text = "Player Name", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[17] = new("UITextSizeConstraint", I[16], "UITextSizeConstraint", { MaxTextSize = 24 })
			I[18] = new("TextBox", I[2], "PlayerName", { BackgroundColor3 = Color3.fromRGB(72, 72, 72), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), PlaceholderColor3 = Color3.fromRGB(178, 178, 178), Position = UDim2.fromScale(0.0188679, 0.4316354), Size = UDim2.fromScale(0.2416434, 0.0911528), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[19] = new("UICorner", I[18], "UICorner")
				I[20] = new("UITextSizeConstraint", I[18], "UITextSizeConstraint", { MaxTextSize = 34 })
			I[21] = new("TextButton", I[2], "Search", { BackgroundColor3 = Color3.fromRGB(88, 88, 88), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Modal = true, Position = UDim2.fromScale(0.0360206, 0.5442359), Size = UDim2.fromScale(0.2073678, 0.075067), Text = "🔎 Search", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[22] = new("UICorner", I[21], "UICorner")
				I[23] = new("UITextSizeConstraint", I[21], "UITextSizeConstraint", { MaxTextSize = 27 })
		I[24] = new("UIAspectRatioConstraint", I[1], "UIAspectRatioConstraint", { AspectRatio = 1.4426434 })
	return I[1]
end

return build
