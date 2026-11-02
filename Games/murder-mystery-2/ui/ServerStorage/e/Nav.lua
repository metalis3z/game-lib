-- Generated from ui/ServerStorage/e/Nav.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Nav", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), Size = UDim2.fromScale(0.2, 1), Style = Enum.FrameStyle.DropShadow, Visible = false })
		I[2] = new("TextButton", I[1], "Weapons", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.new(1, 0, 0, 50), Style = Enum.ButtonStyle.RobloxRoundDefaultButton, Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 18, TextStrokeTransparency = 0.7, TextXAlignment = Enum.TextXAlignment.Right })
			I[3] = new("ImageLabel", I[2], "Icon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), ImageContent = Content.fromUri("https://www.roblox.com/asset/?id=198453499"), Position = UDim2.fromOffset(-5, -2), Size = UDim2.fromScale(1.2, 1.2), SizeConstraint = Enum.SizeConstraint.RelativeYY })
			I[4] = new("TextLabel", I[2], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(1, 0.05), Size = UDim2.fromScale(-0.7, 1), Text = "Weapons", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.7, TextWrapped = true })
		I[5] = new("Frame", I[1], "Codes", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), Size = UDim2.fromScale(1, 1), Visible = false })
			I[6] = new("TextButton", I[5], "Redeem", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 1), Size = UDim2.new(1, 0, 0, -30), Style = Enum.ButtonStyle.RobloxRoundButton, Text = "Redeem", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 18, TextStrokeTransparency = 0.7 })
			I[7] = new("TextBox", I[5], "CodeBox", { BackgroundColor3 = Color3.fromRGB(57, 57, 57), BorderColor3 = Color3.fromRGB(38, 38, 38), BorderSizePixel = 2, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), PlaceholderColor3 = Color3.fromRGB(178, 178, 178), Position = UDim2.new(0, 4, 1, -30), Size = UDim2.new(1, -8, 0, -25), Text = "Enter Code", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 18, TextWrapped = true })
	return I[1]
end

return build
