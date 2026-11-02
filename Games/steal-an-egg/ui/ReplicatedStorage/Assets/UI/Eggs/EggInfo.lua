-- Generated from ui/ReplicatedStorage/Assets/UI/Eggs/EggInfo.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "EggInfo", { Active = true, AlwaysOnTop = true, MaxDistance = 80, ResetOnSpawn = false, Size = UDim2.fromScale(20, 7), StudsOffset = Vector3.new(0, 4, 0) })
		I[2] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.1), Size = UDim2.fromScale(1, 0.7) })
			I[3] = new("Frame", I[2], "Brainrots", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 0.975) })
				I[4] = new("UIPadding", I[3], "UIPadding", { PaddingBottom = UDim.new(0.1, 0), PaddingLeft = UDim.new(0.05, 0), PaddingRight = UDim.new(0.05, 0), PaddingTop = UDim.new(0.065, 0) })
				I[5] = new("UIListLayout", I[3], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
				I[6] = new("Frame", I[3], "BrainrotInfo", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) })
					I[7] = new("UIAspectRatioConstraint", I[6], "UIAspectRatioConstraint")
					I[8] = new("Frame", I[6], "Holder", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) })
					I[9] = new("TextLabel", I[6], "Chance", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxassetid://11702779409", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LineHeight = 0.9, Size = UDim2.fromScale(1, 0.25), Text = "30%", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, TextYAlignment = Enum.TextYAlignment.Bottom, ZIndex = 1000 })
						I[10] = new("UIStroke", I[9], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2.5 })
					I[11] = new("Frame", I[6], "RarityHolder", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), Visible = false })
						I[12] = new("TextLabel", I[11], "RarityLabel", { AnchorPoint = Vector2.new(0.6, 0.6), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.6, 0.6), Size = UDim2.fromScale(0.8, 0.8), Text = "Mythic", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true })
							I[13] = new("TextLabel", I[12], "Label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "Mythic", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true })
							I[14] = new("UIStroke", I[12], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Thickness = 1.5 })
						I[15] = new("UICorner", I[11], "UICorner", { BottomLeftRadius = UDim.new(0.2, 0), BottomRightRadius = UDim.new(0.2, 0), TopLeftRadius = UDim.new(0.2, 0), TopRightRadius = UDim.new(0.2, 0) })
						I[16] = new("UIStroke", I[11], "UIStroke", { Enabled = false, Thickness = 2.5999999 })
			I[17] = new("ImageLabel", I[2], "Pointer", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://94836978140510"), Position = UDim2.fromScale(0.5, 1), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 0.3) })
				I[18] = new("UIAspectRatioConstraint", I[17], "UIAspectRatioConstraint")
			I[19] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0.1, 0), BottomRightRadius = UDim.new(0.1, 0), TopLeftRadius = UDim.new(0.1, 0), TopRightRadius = UDim.new(0.1, 0) })
			I[20] = new("Frame", I[2], "Locked", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), Visible = false })
				I[21] = new("TextLabel", I[20], "Title", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(1, 0), Size = UDim2.fromScale(0.7, 1), Text = "Locked", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextWrapped = true })
				I[22] = new("ImageLabel", I[20], "icon", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://135017205969565"), Position = UDim2.fromScale(0, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.25, 0.8), ZIndex = 2 })
				I[23] = new("UIPadding", I[20], "UIPadding", { PaddingBottom = UDim.new(0.05, 0), PaddingLeft = UDim.new(0.05, 0), PaddingRight = UDim.new(0.05, 0), PaddingTop = UDim.new(0.05, 0) })
			I[24] = new("TextLabel", I[2], "Title", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(18, 255, 14), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 1), Size = UDim2.fromScale(1, 0.25), Text = "4 - Cracked Egg", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextWrapped = true, Visible = false })
				I[25] = new("UIStroke", I[24], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 3 })
			I[26] = new("Frame", I[2], "Modifiers", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, -0.05), Size = UDim2.fromScale(1, 0.4) })
				I[27] = new("UIListLayout", I[26], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 10), SortOrder = Enum.SortOrder.LayoutOrder })
			I[28] = new("TextLabel", I[2], "Overhead", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(18, 255, 14), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 0.75), Text = "Now Hatching!", TextColor3 = Color3.fromRGB(53, 255, 8), TextScaled = true, TextSize = 18, TextWrapped = true, Visible = false })
				I[29] = new("UIStroke", I[28], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 3 })
	return I[1]
end

return build
