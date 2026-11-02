-- Generated from ui/ReplicatedStorage/Assets/UI/Leaderboard/CellTemplate.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "CellTemplate", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 0.125) })
		I[2] = new("ImageLabel", I[1], "User", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(128, 255, 82), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 171, 221), ImageContent = Content.fromUri("rbxassetid://9857249030"), Position = UDim2.fromScale(0.2, 0.525), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.5, 0.15), SizeConstraint = Enum.SizeConstraint.RelativeXX, SliceCenter = Rect.new(22, 47, 429, 62) })
			I[3] = new("TextLabel", I[2], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1, 0.15), Size = UDim2.fromScale(0.8, 0.7), Text = "", TextColor3 = Color3.fromRGB(249, 249, 249), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
				I[4] = new("UIStroke", I[3], "UIStroke", { Color = Color3.fromRGB(58, 58, 58), Thickness = 1.5 })
		I[5] = new("ImageLabel", I[1], "Rank", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(128, 255, 82), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(255, 225, 117), ImageContent = Content.fromUri("rbxassetid://9857249030"), Position = UDim2.fromScale(0.025, 0.525), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.15, 0.15), SizeConstraint = Enum.SizeConstraint.RelativeXX, SliceCenter = Rect.new(22, 19, 429, 91) })
			I[6] = new("TextLabel", I[5], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.05, 0.1), Size = UDim2.fromScale(0.9, 0.8), Text = "#1", TextColor3 = Color3.fromRGB(249, 249, 249), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
				I[7] = new("UIStroke", I[6], "UIStroke", { Color = Color3.fromRGB(58, 58, 58), Thickness = 1.5 })
		I[8] = new("ImageLabel", I[1], "Value", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(128, 255, 82), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 171, 221), ImageContent = Content.fromUri("rbxassetid://9857249030"), Position = UDim2.fromScale(0.725, 0.525), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.25, 0.15), SizeConstraint = Enum.SizeConstraint.RelativeXX, SliceCenter = Rect.new(22, 47, 429, 62) })
			I[9] = new("TextLabel", I[8], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.05, 0.1), Size = UDim2.fromScale(0.9, 0.8), Text = "1M", TextColor3 = Color3.fromRGB(249, 249, 249), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
				I[10] = new("UIStroke", I[9], "UIStroke", { Color = Color3.fromRGB(58, 58, 58), Thickness = 1.5 })
	return I[1]
end

return build
