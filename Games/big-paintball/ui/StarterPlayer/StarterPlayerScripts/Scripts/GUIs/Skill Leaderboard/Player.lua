-- Generated from ui/StarterPlayer/StarterPlayerScripts/Scripts/GUIs/Skill Leaderboard/Player.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ImageLabel", nil, "Player", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://5431965152"), LayoutOrder = 2, ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(10, 10, 40, 40) })
		I[2] = new("UIAspectRatioConstraint", I[1], "UIAspectRatioConstraint")
		I[3] = new("ImageLabel", I[1], "PlayerImg", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("https://www.roblox.com/headshot-thumbnail/image?userId=19717956&width=100&height=100&format=png true"), Size = UDim2.fromScale(1, 1) })
			I[4] = new("UICorner", I[3], "UICorner", { BottomLeftRadius = UDim.new(0, 9), BottomRightRadius = UDim.new(0, 9), TopLeftRadius = UDim.new(0, 9), TopRightRadius = UDim.new(0, 9) })
		I[5] = new("UIPadding", I[1], "UIPadding", { PaddingBottom = UDim.new(0, 2), PaddingLeft = UDim.new(0, 2), PaddingRight = UDim.new(0, 2), PaddingTop = UDim.new(0, 2) })
		I[6] = new("TextLabel", I[1], "Sidetitle", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.025, 0.975), Rotation = -6, Size = UDim2.fromScale(0.2, 0.25), Text = "#", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 20, TextStrokeTransparency = 0, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Bottom, ZIndex = 3 })
			I[7] = new("TextLabel", I[6], "shadow", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(1, 1), Size = UDim2.fromScale(1, 1), Text = "#", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 20, TextStrokeTransparency = 0, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Bottom })
		I[8] = new("TextLabel", I[1], "Rank", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.19, 1.025), Size = UDim2.fromScale(0.5, 0.5), Text = "2", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 20, TextStrokeTransparency = 0, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Bottom, ZIndex = 3 })
			I[9] = new("TextLabel", I[8], "shadow", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(2, 2), Size = UDim2.fromScale(1, 1), Text = "2", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 20, TextStrokeTransparency = 0, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Bottom })
		I[10] = new("TextLabel", I[1], "Tags", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(0.9, 0.3), Text = "999", TextColor3 = Color3.fromRGB(255, 34, 119), TextScaled = true, TextSize = 20, TextStrokeTransparency = 0, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Top, ZIndex = 3 })
			I[11] = new("TextLabel", I[10], "shadow", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(2, 2), Size = UDim2.fromScale(1, 1), Text = "999", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 20, TextStrokeTransparency = 0, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Top })
	return I[1]
end

return build
