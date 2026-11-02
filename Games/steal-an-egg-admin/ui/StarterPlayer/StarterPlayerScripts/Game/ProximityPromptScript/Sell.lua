-- Generated from ui/StarterPlayer/StarterPlayerScripts/Game/ProximityPromptScript/Sell.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "Sell", { Active = true, AlwaysOnTop = true, Enabled = false, MaxDistance = math.huge, Size = UDim2.fromOffset(193, 72) }, { ["Theme"] = "", ["_lemonadeUniqueId"] = "FDIdK1VtFDId" })
		I[2] = new("TextButton", I[1], "TextButton", { BackgroundTransparency = 1, Selectable = false, Size = UDim2.fromScale(1, 1), TextTransparency = 1 }, { ["_lemonadeUniqueId"] = "W9f56ZFhW9f5" })
		I[3] = new("ImageLabel", I[1], "PromptFrame", { BackgroundColor3 = Color3.fromRGB(189, 0, 3), BackgroundTransparency = 0.2, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), ImageTransparency = 1, Size = UDim2.fromScale(1, 1) }, { ["_lemonadeUniqueId"] = "N6bmY1G4N6bm" })
			I[4] = new("Frame", I[3], "InputFrame", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), SizeConstraint = Enum.SizeConstraint.RelativeYY }, { ["_lemonadeUniqueId"] = "Br0K58vxBr0K" })
				I[5] = new("Frame", I[4], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(169, 44, 171), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) }, { ["_lemonadeUniqueId"] = "zh2hUnmKzh2h" })
					I[6] = new("Frame", I[5], "ProgressBar", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, -14, 1, -14) }, { ["_lemonadeUniqueId"] = "1SJJgRYu1SJJ" })
						I[7] = new("Frame", I[6], "LeftGradient", { BackgroundTransparency = 1, ClipsDescendants = true, Size = UDim2.fromScale(0.5, 1) }, { ["_lemonadeUniqueId"] = "wHKfUSycwHKf" })
							I[8] = new("ImageLabel", I[7], "ProgressBarImage", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxasset://textures/ui/Controls/RadialFill.png"), Size = UDim2.fromScale(2, 1) }, { ["_lemonadeUniqueId"] = "qvtN314eqvtN" })
								I[9] = new("UIGradient", I[8], "UIGradient", { Rotation = 180, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.4999, 0), NumberSequenceKeypoint.new(0.5, 1), NumberSequenceKeypoint.new(1, 1) }) }, { ["_lemonadeUniqueId"] = "RaMWEYKURaMW" })
						I[10] = new("NumberValue", I[6], "Progress", nil, { ["_lemonadeUniqueId"] = "D1KUiKIwD1KU" })
						I[11] = new("Frame", I[6], "RightGradient", { BackgroundTransparency = 1, ClipsDescendants = true, Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(0.5, 1) }, { ["_lemonadeUniqueId"] = "ETtQW35xETtQ" })
							I[12] = new("ImageLabel", I[11], "ProgressBarImage", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxasset://textures/ui/Controls/RadialFill.png"), Position = UDim2.fromScale(-1, 0), Size = UDim2.fromScale(2, 1) }, { ["_lemonadeUniqueId"] = "baON5L7TbaON" })
								I[13] = new("UIGradient", I[12], "UIGradient", { Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.4999, 0), NumberSequenceKeypoint.new(0.5, 1), NumberSequenceKeypoint.new(1, 1) }) }, { ["_lemonadeUniqueId"] = "EstX6xyIEstX" })
					I[14] = new("ImageLabel", I[5], "ButtonFrame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 0.5, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), ImageTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, -24, 1, -24) }, { ["_lemonadeUniqueId"] = "TceH650WTceH" })
						I[15] = new("UICorner", I[14], "UICorner", { BottomLeftRadius = UDim.new(0.5, 0), BottomRightRadius = UDim.new(0.5, 0), TopLeftRadius = UDim.new(0.5, 0), TopRightRadius = UDim.new(0.5, 0) }, { ["_lemonadeUniqueId"] = "FwvV8lzLFwvV" })
					I[16] = new("ImageLabel", I[5], "ButtonImage", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxasset://textures/ui/Controls/key_single.png"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, -44, 1, -42) }, { ["_lemonadeUniqueId"] = "TYMc9o9lTYMc" })
					I[17] = new("ImageLabel", I[5], "ButtonTextImage", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxasset://textures/ui/Controls/shift.png"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, -48, 1, -48), Visible = false }, { ["_lemonadeUniqueId"] = "fc4weYIsfc4w" })
					I[18] = new("TextLabel", I[5], "ButtonText", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.fromOffset(0, -1), Size = UDim2.fromScale(1, 1), Text = "E", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14 }, { ["_lemonadeUniqueId"] = "pWOYqmn5pWOY" })
					I[19] = new("UIScale", I[5], "UIScale", nil, { ["_lemonadeUniqueId"] = "WdUoMgTlWdUo" })
			I[20] = new("TextLabel", I[3], "ActionText", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0.5, -24, 0, 9), Size = UDim2.fromScale(1, 1), Text = "Action Text", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 19, TextXAlignment = Enum.TextXAlignment.Left }, { ["_lemonadeUniqueId"] = "RlqDMTXPRlqD" })
				I[21] = new("UIStroke", I[20], "UIStroke", { Enabled = false, Thickness = 2 }, { ["_lemonadeUniqueId"] = "9VlNgwXT9VlN" })
			I[22] = new("TextLabel", I[3], "ObjectText", { BackgroundColor3 = Color3.fromRGB(249, 248, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.new(0.5, -24, 0, -10), Size = UDim2.fromScale(1, 1), Text = "Object Text", TextColor3 = Color3.fromRGB(178, 178, 178), TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left }, { ["_lemonadeUniqueId"] = "UxizpZ99Uxiz" })
			I[23] = new("UICorner", I[3], "UICorner", nil, { ["_lemonadeUniqueId"] = "EcPdPshlEcPd" })
	return I[1]
end

return build
