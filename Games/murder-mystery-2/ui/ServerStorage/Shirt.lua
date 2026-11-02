-- Generated from ui/ServerStorage/Shirt.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Shirt")
		I[2] = new("Frame", I[1], "Main", { BackgroundColor3 = Color3.fromRGB(40, 40, 40), BorderColor3 = Color3.fromRGB(24, 24, 24), BorderSizePixel = 5, Position = UDim2.new(0.5, -200, 0.5, -150), Size = UDim2.fromOffset(400, 300) })
			I[3] = new("TextLabel", I[2], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.new(1, 0, 0, 35), Text = "Merch", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 32 })
			I[4] = new("TextLabel", I[2], "L_UserName", { BackgroundColor3 = Color3.fromRGB(56, 56, 56), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(0, 35), Size = UDim2.new(0.25, 0, 0, 35), Text = "Username:", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 18 })
			I[5] = new("TextBox", I[2], "Username", { BackgroundColor3 = Color3.fromRGB(53, 53, 53), BackgroundTransparency = 0.8, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 2, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), PlaceholderColor3 = Color3.fromRGB(178, 178, 178), Position = UDim2.new(0.25, -3, 0, 40), Size = UDim2.new(0.25, 0, 0, 25), Text = "Type Here", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14 })
			I[6] = new("ImageLabel", I[2], "Player", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.7, BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.new(0.5, 5, 0, 38), Size = UDim2.new(0.5, -10, 0.5, -10), SizeConstraint = Enum.SizeConstraint.RelativeXX, ZIndex = 2 })
				I[7] = new("TextLabel", I[6], "UsernameL", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 1), Size = UDim2.new(0.5, -3, 0, 25), Text = "Username:", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 18, TextXAlignment = Enum.TextXAlignment.Right })
				I[8] = new("TextLabel", I[6], "Username", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.new(0.5, 3, 1, 0), Size = UDim2.new(0.5, -3, 0, 25), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 18, TextXAlignment = Enum.TextXAlignment.Left })
				I[9] = new("TextLabel", I[6], "UserIDL", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0, 0, 1, 25), Size = UDim2.new(0.5, -3, 0, 25), Text = "User ID:", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 18, TextXAlignment = Enum.TextXAlignment.Right })
				I[10] = new("TextLabel", I[6], "UserID", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.new(0.5, 3, 1, 25), Size = UDim2.new(0.5, -3, 0, 25), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 18, TextXAlignment = Enum.TextXAlignment.Left })
			I[11] = new("TextLabel", I[2], "L_MerchCode", { BackgroundColor3 = Color3.fromRGB(56, 56, 56), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(0, 70), Size = UDim2.new(0.25, 0, 0, 35), Text = "Merch Code:", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 18 })
			I[12] = new("TextBox", I[2], "MerchCode", { BackgroundColor3 = Color3.fromRGB(53, 53, 53), BackgroundTransparency = 0.8, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 2, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), PlaceholderColor3 = Color3.fromRGB(178, 178, 178), Position = UDim2.new(0.25, -3, 0, 75), Size = UDim2.new(0.25, 0, 0, 25), Text = "Type Here", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14 })
			I[13] = new("TextLabel", I[2], "MerchName", { BackgroundColor3 = Color3.fromRGB(56, 56, 56), BackgroundTransparency = 0.5, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Italic), Position = UDim2.fromOffset(2, 105), Size = UDim2.new(0.5, 0, 0, 30), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 18 })
			I[14] = new("TextLabel", I[2], "L_Amount", { BackgroundColor3 = Color3.fromRGB(56, 56, 56), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(0, 135), Size = UDim2.new(0.25, 0, 0, 35), Text = "Quantity:", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 18 })
			I[15] = new("TextBox", I[2], "Quantity", { BackgroundColor3 = Color3.fromRGB(53, 53, 53), BackgroundTransparency = 0.8, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 2, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), PlaceholderColor3 = Color3.fromRGB(178, 178, 178), Position = UDim2.new(0.25, -3, 0, 142), Size = UDim2.new(0.25, 0, 0, 25), Text = "Type Here", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14 })
			I[16] = new("TextButton", I[2], "Confirm", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0, 2, 1, -109), Size = UDim2.new(0.5, 0, 0, 40), Style = Enum.ButtonStyle.RobloxRoundButton, Text = "Confirm", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 28, TextStrokeTransparency = 0.7 })
			I[17] = new("TextLabel", I[2], "PreviewName", { BackgroundColor3 = Color3.fromRGB(195, 195, 195), BackgroundTransparency = 0.95, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(70, 235), Size = UDim2.new(0.5, -70, 0, 62), Text = "", TextColor3 = Color3.fromRGB(255, 0, 255), TextSize = 24, TextStrokeTransparency = 0.7, TextWrapped = true })
			I[18] = new("ImageLabel", I[2], "PreviewIcon", { BackgroundColor3 = Color3.fromRGB(67, 67, 67), BackgroundTransparency = 0.7, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromOffset(3, 235), Size = UDim2.fromOffset(62, 62), SizeConstraint = Enum.SizeConstraint.RelativeXX, ZIndex = 2 })
			I[19] = new("TextLabel", I[2], "Saving", { Active = true, BackgroundColor3 = Color3.fromRGB(27, 27, 27), BackgroundTransparency = 0.1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "Saving...", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 36, Visible = false, ZIndex = 2 })
	return I[1]
end

return build
