-- Generated from ui/StarterPlayer/StarterPlayerScripts/UserInterface/TaskContractMilestoneSlot.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "TaskContractMilestoneSlot", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = -1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
		I[2] = new("TextLabel", I[1], "Title", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1125, 0.613), Size = UDim2.fromScale(0.7, 0.375), Text = "Assault Rifle • Eliminations", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(31, 31, 31), TextTransparency = 0.25, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 2 })
		I[3] = new("Frame", I[1], "Progress", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.45, 0.813), Size = UDim2.fromScale(0.8, 0.125) })
			I[4] = new("Frame", I[3], "Bar", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(0, 190, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.5), Size = UDim2.new(0.75, 0, 1, 2) })
				I[5] = new("UICorner", I[4], "UICorner")
			I[6] = new("Frame", I[3], "Background", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 0 })
				I[7] = new("UICorner", I[6], "UICorner")
		I[8] = new("Frame", I[1], "Reward", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.975, 0.5), Size = UDim2.fromScale(0.1, 1) })
		I[9] = new("ImageLabel", I[1], "Weapon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://17160682738"), Position = UDim2.fromScale(0.075, 0.362), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.125, 1.6670001), ZIndex = 2 })
		I[10] = new("TextLabel", I[1], "Goal", { AnchorPoint = Vector2.new(1, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.85, 0.613), RichText = true, Size = UDim2.fromScale(0.7, 0.5), Text = "0 <font size=\"7\">/ 5</font>", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(31, 31, 31), TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, ZIndex = 2 })
		I[11] = new("ImageLabel", I[1], "Map", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://103965007372841"), Position = UDim2.fromScale(0.075, 0.362), ScaleType = Enum.ScaleType.Crop, Size = UDim2.fromScale(0.05, 0.5), ZIndex = 2 })
			I[12] = new("UICorner", I[11], "UICorner", { BottomLeftRadius = UDim.new(0, 4), BottomRightRadius = UDim.new(0, 4), TopLeftRadius = UDim.new(0, 4), TopRightRadius = UDim.new(0, 4) })
		I[13] = new("ImageLabel", I[1], "Completed", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(100, 255, 50), ImageContent = Content.fromUri("rbxassetid://17588806026"), Position = UDim2.fromScale(0.925, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.1, 0.75), ZIndex = 2 })
		I[14] = new("TextLabel", I[1], "GoalPercent", { AnchorPoint = Vector2.new(1, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.85, 0.613), Size = UDim2.fromScale(0.7, 0.5), Text = "99.9%", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(31, 31, 31), TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, ZIndex = 2 })
	return I[1]
end

return build
