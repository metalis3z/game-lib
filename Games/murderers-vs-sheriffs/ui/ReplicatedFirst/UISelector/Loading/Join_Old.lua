-- Generated from ui/ReplicatedFirst/UISelector/Loading/Join_Old.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Join_Old", { DisplayOrder = 11 })
		I[2] = new("Frame", I[1], "BG", { BackgroundColor3 = Color3.fromRGB(12, 12, 12), Size = UDim2.fromScale(1, 1) })
		I[3] = new("Frame", I[1], "Friends", { Active = true, BackgroundColor3 = Color3.fromRGB(86, 86, 86), BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.new(0.5, -200, 0.5, -200), Size = UDim2.fromOffset(400, 400) })
			I[4] = new("TextLabel", I[3], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(0, -50), Size = UDim2.new(1, 0, 0, 50), Text = "Joining a friend?", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 36 })
			I[5] = new("ScrollingFrame", I[3], "Scroll", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), ScrollingDirection = Enum.ScrollingDirection.Y, Size = UDim2.fromScale(1, 1) })
				I[6] = new("Frame", I[5], "Container", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.new(1, -13, 1, 0) })
			I[7] = new("TextButton", I[3], "Play", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0, -3, 1, 0), Size = UDim2.new(1, 6, 0, 50), Style = Enum.ButtonStyle.RobloxRoundDefaultButton, Text = "Play", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 28, TextStrokeTransparency = 0.7 })
		I[8] = new("TextLabel", I[1], "Loading", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "Loading", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 48, Visible = false, ZIndex = 2 })
		I[9] = new("Frame", I[1], "Retry", { Active = true, BackgroundColor3 = Color3.fromRGB(44, 44, 44), BorderColor3 = Color3.fromRGB(20, 20, 20), BorderSizePixel = 5, Position = UDim2.new(0.5, -200, 0.5, -100), Size = UDim2.fromOffset(400, 200), Visible = false })
			I[10] = new("TextButton", I[9], "Retry", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0, 3, 1, -53), Size = UDim2.new(1, -6, 0, 50), Style = Enum.ButtonStyle.RobloxRoundButton, Text = "Cancel", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 28, TextStrokeTransparency = 0.7 })
			I[11] = new("TextLabel", I[9], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.new(1, 0, 0, 30), Text = "Error: Server is full or player has left.", TextColor3 = Color3.fromRGB(255, 90, 93), TextSize = 28, TextStrokeTransparency = 0.7, TextWrapped = true })
			I[12] = new("TextLabel", I[9], "Retrying", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(0, 30), Size = UDim2.new(1, 0, 0, 30), Text = "Retrying...", TextColor3 = Color3.fromRGB(179, 179, 179), TextSize = 28, TextStrokeTransparency = 0.7, TextWrapped = true })
			I[13] = new("ImageLabel", I[9], "Spinner", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("https://www.roblox.com/asset/?id=337617808"), Position = UDim2.new(0.5, -25, 0, 70), Size = UDim2.fromOffset(50, 50) })
	return I[1]
end

return build
