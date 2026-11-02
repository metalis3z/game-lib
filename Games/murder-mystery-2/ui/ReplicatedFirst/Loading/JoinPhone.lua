-- Generated from ui/ReplicatedFirst/Loading/JoinPhone.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "JoinPhone", { ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets })
		I[2] = new("Frame", I[1], "Retry", { Active = true, BackgroundColor3 = Color3.fromRGB(44, 44, 44), BorderColor3 = Color3.fromRGB(20, 20, 20), BorderSizePixel = 5, Position = UDim2.new(0.5, -200, 0.15, 0), Size = UDim2.new(0, 400, 0.7, 0), Visible = false })
			I[3] = new("ImageLabel", I[2], "Spinner", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("https://www.roblox.com/asset/?id=337617808"), Position = UDim2.new(0.5, -25, 0.5, 0), Size = UDim2.fromOffset(50, 50) })
			I[4] = new("TextLabel", I[2], "Retrying", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.35, 0.2), Size = UDim2.fromScale(0.3, 0.2), Text = "Retrying...", TextColor3 = Color3.fromRGB(179, 179, 179), TextScaled = true, TextSize = 28, TextStrokeTransparency = 0.7, TextWrapped = true })
			I[5] = new("TextLabel", I[2], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.01, 0), Size = UDim2.fromScale(0.98, 0.2), Text = "Error: Server is full or player has left.", TextColor3 = Color3.fromRGB(255, 90, 93), TextScaled = true, TextSize = 28, TextStrokeTransparency = 0.7, TextWrapped = true })
			I[6] = new("TextButton", I[2], "Retry", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0, 3, 0.8, 0), Size = UDim2.new(1, -6, 0.2, 0), Style = Enum.ButtonStyle.RobloxRoundButton, Text = "Cancel", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 28, TextStrokeTransparency = 0.7 })
		I[7] = new("TextLabel", I[1], "Loading", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "Loading", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 48, Visible = false, ZIndex = 2 })
		I[8] = new("Frame", I[1], "Friends", { Active = true, BackgroundColor3 = Color3.fromRGB(86, 86, 86), BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.new(0.5, -200, 0.15, 0), Size = UDim2.new(0, 400, 0.7, 0) })
			I[9] = new("TextButton", I[8], "Play", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0, -3, 1, 0), Size = UDim2.new(1, 6, 0, 50), Style = Enum.ButtonStyle.RobloxRoundDefaultButton, Text = "Play", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 28, TextStrokeTransparency = 0.7 })
			I[10] = new("ScrollingFrame", I[8], "Scroll", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), Size = UDim2.fromScale(1, 1) })
				I[11] = new("Frame", I[10], "Container", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.new(1, -13, 1, 0) })
			I[12] = new("TextLabel", I[8], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(0, -50), Size = UDim2.new(1, 0, 0, 50), Text = "Joining a friend?", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 36 })
		I[13] = new("Frame", I[1], "BG", { BackgroundColor3 = Color3.fromRGB(12, 12, 12), Size = UDim2.fromScale(1, 1) })
	return I[1]
end

return build
