-- Generated from ui/ReplicatedStorage/Assets/UI/IndexReward.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "IndexReward", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(0.4708939, 1), ZIndex = 610 })
		I[2] = new("Frame", I[1], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 611 })
			I[3] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0.1, 0), BottomRightRadius = UDim.new(0.1, 0), TopLeftRadius = UDim.new(0.1, 0), TopRightRadius = UDim.new(0.1, 0) })
			I[4] = new("TextButton", I[2], "Click", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 900 })
				I[5] = new("UITextSizeConstraint", I[4], "UITextSizeConstraint", { MaxTextSize = 14 })
			I[6] = new("UIStroke", I[2], "UIStroke", { Color = Color3.fromRGB(0, 32, 54), Thickness = 5 })
			I[7] = new("TextLabel", I[2], "CollectAmount", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.156), Size = UDim2.fromScale(0.8999998, 0.2221135), Text = "Collect 15 Pets", TextColor3 = Color3.fromRGB(0, 32, 54), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 713 })
			I[8] = new("UIGradient", I[2], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.311419, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(210, 255, 255)) }), Rotation = 60 })
			I[9] = new("Frame", I[2], "Rewards", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.52), Size = UDim2.fromScale(1, 0.3877551), ZIndex = 611 })
				I[10] = new("UIGridLayout", I[9], "UIGridLayout", { CellPadding = UDim2.fromScale(0.05, 0), CellSize = UDim2.fromScale(0.196, 1), HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
			I[11] = new("Folder", I[2], "PromptInfo")
				I[12] = new("TextLabel", I[11], "NeedPets", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.86), Size = UDim2.fromScale(0.9, 0.16), Text = "3 More Pets Needed!", TextColor3 = Color3.fromRGB(255, 64, 74), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false, ZIndex = 713 })
					I[13] = new("UIStroke", I[12], "UIStroke", { Color = Color3.fromRGB(47, 10, 10), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 3.5999999 })
				I[14] = new("TextLabel", I[11], "ClickToClaim", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.86), Size = UDim2.fromScale(0.9, 0.16), Text = "Click To Claim!", TextColor3 = Color3.fromRGB(133, 250, 78), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false, ZIndex = 713 })
					I[15] = new("UIStroke", I[14], "UIStroke", { Color = Color3.fromRGB(6, 62, 3), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 3.5999999 })
				I[16] = new("TextLabel", I[11], "Claimed", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.86), Size = UDim2.fromScale(0.9, 0.16), Text = "Claimed", TextColor3 = Color3.fromRGB(76, 241, 250), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false, ZIndex = 713 })
					I[17] = new("UIStroke", I[16], "UIStroke", { Color = Color3.fromRGB(0, 32, 54), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 3.5999999 })
	return I[1]
end

return build
