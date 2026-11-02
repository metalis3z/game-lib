-- Generated from ui/StarterPlayer/StarterPlayerScripts/UserInterface/BanLogSlot.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "BanLogSlot", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 0.125) })
		I[2] = new("TextLabel", I[1], "Reason", { AnchorPoint = Vector2.new(0.5, 0.5), AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.6125, 0.5), Size = UDim2.fromScale(0.45, 0.5), Text = "requesting for exploits", TextColor3 = Color3.fromRGB(255, 50, 50), TextScaled = true, TextSize = 14, TextWrapped = true })
		I[3] = new("TextLabel", I[1], "Date", { AnchorPoint = Vector2.new(0.5, 0.5), AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.25, 0.7), Size = UDim2.fromScale(0.2, 0.4), Text = "02/28/21", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
		I[4] = new("TextLabel", I[1], "Duration", { AnchorPoint = Vector2.new(0.5, 0.5), AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.925, 0.5), Size = UDim2.fromScale(0.1, 0.5), Text = "1 DAY", TextColor3 = Color3.fromRGB(0, 190, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
		I[5] = new("TextLabel", I[1], "Moderator", { AnchorPoint = Vector2.new(0.5, 0.5), AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.25, 0.3), Size = UDim2.fromScale(0.2, 0.4), Text = "SenseiWarrior", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
		I[6] = new("ImageLabel", I[1], "Picture", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("https://www.roblox.com/headshot-thumbnail/image?userId=1&width=180&height=180&format=png"), Position = UDim2.new(0.07, 2, 0.5, 0), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.1, 1), ZIndex = 5 })
			I[7] = new("UICorner", I[6], "UICorner")
	return I[1]
end

return build
