-- Generated from ui/ReplicatedStorage/Notification.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Notification", { ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(42, 53, 53), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.896), Size = UDim2.fromScale(0.1839685, 0.0682382) })
			I[3] = new("TextLabel", I[2], "Noti", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(50, 65, 66), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5645269, 0.5757846), Size = UDim2.fromScale(0.8244433, 0.5938787), Text = "You have to wait 5 minutes before collecting the reward", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
				I[4] = new("UITextSizeConstraint", I[3], "UITextSizeConstraint", { MaxTextSize = 35 })
			I[5] = new("ImageLabel", I[2], "Logo", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://3926305904"), ImageRectOffset = Vector2.new(844, 564), ImageRectSize = Vector2.new(36, 36), Position = UDim2.fromScale(0.0785405, 0.4892805), Size = UDim2.fromScale(0.1004762, 0.5269696) })
				I[6] = new("UICorner", I[5], "UICorner")
			I[7] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0, 5), BottomRightRadius = UDim.new(0, 5), TopLeftRadius = UDim.new(0, 5), TopRightRadius = UDim.new(0, 5) })
			I[8] = new("TextLabel", I[2], "Ignore", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(50, 65, 66), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2876986, 0.1394226), Size = UDim2.fromScale(0.2707871, 0.2788452), Text = "Notification", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
		I[9] = new("Frame", I[1], "Line", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.902), Size = UDim2.fromScale(0.1839685, 0.0613437), ZIndex = -1 })
			I[10] = new("UICorner", I[9], "UICorner", { BottomLeftRadius = UDim.new(0, 5), BottomRightRadius = UDim.new(0, 5), TopLeftRadius = UDim.new(0, 5), TopRightRadius = UDim.new(0, 5) })
			I[11] = new("Frame", I[9], "Color", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = -1 })
				I[12] = new("UICorner", I[11], "UICorner", { BottomLeftRadius = UDim.new(0, 5), BottomRightRadius = UDim.new(0, 5), TopLeftRadius = UDim.new(0, 5), TopRightRadius = UDim.new(0, 5) })
	return I[1]
end

return build
