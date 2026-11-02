-- Generated from ui/StarterGui/ChooseJob.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "ChooseJob")
		I[2] = new("Frame", I[1], "ChooseJob", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 2, Position = UDim2.fromOffset(0, -3), Size = UDim2.fromScale(1, 1), Visible = false })
			I[3] = new("Frame", I[2], "Label", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.fromOffset(0, -36), Size = UDim2.fromScale(1, 0.15), Style = Enum.FrameStyle.DropShadow })
				I[4] = new("TextLabel", I[3], "label", { BackgroundColor3 = Color3.fromRGB(253, 217, 70), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "Choose a Job", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 12, TextWrapped = true })
			I[5] = new("Frame", I[2], "JobName", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.new(0.35, 0, 0.7, -20), Size = UDim2.new(0.3, 0, 0.08, 10), Style = Enum.FrameStyle.DropShadow })
				I[6] = new("TextLabel", I[5], "name", { BackgroundColor3 = Color3.fromRGB(253, 217, 70), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "Pizza Boxer", TextColor3 = Color3.fromRGB(255, 152, 8), TextScaled = true, TextSize = 12, TextWrapped = true })
			I[7] = new("Frame", I[2], "Chooser", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.new(0.2, -30, 0.8, -20), Size = UDim2.new(0.6, 60, 0.15, 25), Style = Enum.FrameStyle.DropShadow })
				I[8] = new("TextButton", I[7], "Choose", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3, 0), Size = UDim2.fromScale(0.4, 1), Style = Enum.ButtonStyle.RobloxRoundButton, Text = "Choose", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextWrapped = true })
					I[9] = new("Frame", I[8], "Frame", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.2, BorderSizePixel = 0, Position = UDim2.fromOffset(-10, -10), Size = UDim2.new(1, 20, 1, 20), Visible = false })
						I[10] = new("ImageLabel", I[9], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://290213591"), Position = UDim2.new(0.5, -75, 0, 0), Size = UDim2.new(0, 150, 1, 0) })
				I[11] = new("ImageButton", I[7], "Next", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=315464751"), Position = UDim2.fromScale(0.85, 0), Rotation = 180, Size = UDim2.fromScale(0.15, 1), Style = Enum.ButtonStyle.RobloxRoundButton })
				I[12] = new("ImageButton", I[7], "Previous", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=315464751"), Size = UDim2.fromScale(0.15, 1), Style = Enum.ButtonStyle.RobloxRoundButton })
				I[13] = new("Frame", I[7], "AButton", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.new(0.5, -125, 0.5, -33), Size = UDim2.fromOffset(250, 66), Visible = false })
					I[14] = new("ImageLabel", I[13], "Icon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://663428369"), Size = UDim2.fromOffset(66, 66) })
					I[15] = new("TextLabel", I[13], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromOffset(71, 0), Size = UDim2.new(1, -66, 0, 66), Text = "Choose", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 32, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 2 })
					I[16] = new("Frame", I[13], "Lock", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.2, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, 20, 2, 20), Visible = false, ZIndex = 3 })
						I[17] = new("ImageLabel", I[16], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://290213591"), Position = UDim2.new(0.5, -75, 0, 0), Size = UDim2.new(0, 150, 1, 0), ZIndex = 3 })
		I[18] = new("Frame", I[1], "Play", { BackgroundColor3 = Color3.fromRGB(31, 31, 31), BackgroundTransparency = 0.5, Position = UDim2.new(0, -10, 0.8, -20), Size = UDim2.new(1, 20, 0.2, 20), Visible = false })
			I[19] = new("TextButton", I[18], "Play", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3, 0.1), Size = UDim2.fromScale(0.4, 0.8), Style = Enum.ButtonStyle.RobloxRoundButton, Text = "Play", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextWrapped = true })
			I[20] = new("Frame", I[18], "AButton", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(170, 66), Visible = false })
				I[21] = new("ImageLabel", I[20], "Icon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://663428369"), Size = UDim2.fromOffset(66, 66) })
				I[22] = new("TextLabel", I[20], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromOffset(71, 0), Size = UDim2.new(1, -66, 0, 66), Text = "Start", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 32, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 10 })
		I[23] = new("Frame", I[1], "ChooseCharacter", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.fromScale(0.3, 0.3), Size = UDim2.fromScale(0.4545454, 0.2352941), Visible = false })
			I[24] = new("TextButton", I[23], "Girl", { BackgroundColor3 = Color3.fromRGB(255, 110, 222), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5454546, 0.1176471), Size = UDim2.fromScale(0.4090909, 0.7333333), Text = "Girl", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 36 })
			I[25] = new("TextButton", I[23], "Boy", { BackgroundColor3 = Color3.fromRGB(96, 178, 255), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.05, 0.118), Size = UDim2.fromScale(0.4090909, 0.7333333), Text = "Boy", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 36 })
			I[26] = new("ImageLabel", I[23], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) })
		I[27] = new("Frame", I[1], "PlugInGamepad", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(31, 31, 31), BackgroundTransparency = 0.5, Position = UDim2.fromScale(0.5, 0.3), Size = UDim2.fromOffset(600, 100), Visible = false })
			I[28] = new("TextLabel", I[27], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(200, 50), Text = "Connect your Xbox controller to your computer to continue.", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 28 })
	return I[1]
end

return build
