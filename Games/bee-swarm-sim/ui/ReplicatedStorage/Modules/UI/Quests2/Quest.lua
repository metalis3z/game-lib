-- Generated from ui/ReplicatedStorage/Modules/UI/Quests2/Quest.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Quest", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(115, 90, 71), Position = UDim2.fromScale(0.5, 0), Size = UDim2.new(1, 0, 0, 100) })
		I[2] = new("UICorner", I[1], "UICorner", { BottomLeftRadius = UDim.new(0.1, 0), BottomRightRadius = UDim.new(0.1, 0), TopLeftRadius = UDim.new(0.1, 0), TopRightRadius = UDim.new(0.1, 0) })
		I[3] = new("TextLabel", I[1], "TextLabel", { BackgroundColor3 = Color3.fromRGB(207, 159, 127), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromOffset(378, 31), Text = "Speedy Bee: Starter", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right })
			I[4] = new("UICorner", I[3], "UICorner")
			I[5] = new("UIGradient", I[3], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(207, 207, 207)), ColorSequenceKeypoint.new(0.046589, Color3.fromRGB(207, 207, 207)), ColorSequenceKeypoint.new(0.0515807, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.5990016, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.6039933, Color3.fromRGB(207, 207, 207)), ColorSequenceKeypoint.new(0.7204659, Color3.fromRGB(207, 207, 207)), ColorSequenceKeypoint.new(0.7254575, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.9151414, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.9251248, Color3.fromRGB(207, 207, 207)), ColorSequenceKeypoint.new(1, Color3.fromRGB(207, 207, 207)) }), Offset = Vector2.new(-0.3, 0), Rotation = 45 })
			I[6] = new("ImageLabel", I[3], "BearIcon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://14826050508"), Rotation = -1, Size = UDim2.fromScale(0.1190476, 1.4516129) })
		I[7] = new("TextLabel", I[1], "B2", { BackgroundColor3 = Color3.fromRGB(136, 105, 83), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromOffset(378, 39), Text = "", TextColor3 = Color3.fromRGB(68, 68, 68), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 0 })
			I[8] = new("UICorner", I[7], "UICorner")
		I[9] = new("TextLabel", I[1], "B", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.9, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromOffset(380, 45), Text = "", TextColor3 = Color3.fromRGB(68, 68, 68), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = -1 })
			I[10] = new("UICorner", I[9], "UICorner")
		I[11] = new("Frame", I[1], "Tasks", { Active = true, AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.new(0.5, 0, 0, 45), Size = UDim2.new(0.936, 0, 0, 35) })
			I[12] = new("UIListLayout", I[11], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 10), SortOrder = Enum.SortOrder.LayoutOrder })
			I[13] = new("UICorner", I[11], "UICorner")
			I[14] = new("UIStroke", I[11], "UIStroke", { Thickness = 6, Transparency = 1 })
	return I[1]
end

return build
