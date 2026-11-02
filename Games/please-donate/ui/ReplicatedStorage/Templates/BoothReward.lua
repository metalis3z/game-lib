-- Generated from ui/ReplicatedStorage/Templates/BoothReward.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("TextButton", nil, "BoothReward", { AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 179, 0), FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 0.9), Text = "4", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextTransparency = 0.9, TextWrapped = true })
		I[2] = new("UIAspectRatioConstraint", I[1], "UIAspectRatioConstraint")
		I[3] = new("UICorner", I[1], "UICorner", { BottomLeftRadius = UDim.new(0.11, 0), BottomRightRadius = UDim.new(0.11, 0), TopLeftRadius = UDim.new(0.11, 0), TopRightRadius = UDim.new(0.11, 0) })
		I[4] = new("UIStroke", I[1], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(0, 132, 255), Enabled = false, Thickness = 2 })
		I[5] = new("Frame", I[1], "PrizeInfo", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
			I[6] = new("ImageLabel", I[5], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://12247808162"), ImageTransparency = 0.5, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.8, 0.8) })
				I[7] = new("UIAspectRatioConstraint", I[6], "UIAspectRatioConstraint")
				I[8] = new("UICorner", I[6], "UICorner", { BottomLeftRadius = UDim.new(0.3, 0), BottomRightRadius = UDim.new(0.3, 0), TopLeftRadius = UDim.new(0.3, 0), TopRightRadius = UDim.new(0.3, 0) })
			I[9] = new("TextLabel", I[5], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.8, 0.45), Text = "EXCLUSIVE BOOTH", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 24, TextWrapped = true })
		I[10] = new("Frame", I[1], "Check", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, LayoutOrder = 6, Position = UDim2.fromScale(0.5, 1), Selectable = true, Size = UDim2.fromOffset(25, 25), Visible = false, ZIndex = 2 })
			I[11] = new("ImageButton", I[10], "check_circle", { Active = false, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 132, 255), ImageContent = Content.fromUri("rbxassetid://3926305904"), ImageRectOffset = Vector2.new(284, 924), ImageRectSize = Vector2.new(36, 36), LayoutOrder = 6, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 2 })
			I[12] = new("UICorner", I[10], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
		I[13] = new("TextLabel", I[1], "Streak", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 1.05), Size = UDim2.fromScale(1, 0.15), Text = "DAY 4", TextColor3 = Color3.fromRGB(167, 167, 167), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(255, 255, 255), TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 3 })
	return I[1]
end

return build
