-- Generated from ui/StarterPlayer/StarterPlayerScripts/ProximityPromptScript/Default.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "Default", { Active = true, AlwaysOnTop = true, MaxDistance = math.huge, Size = UDim2.fromOffset(193, 72) })
		I[2] = new("TextButton", I[1], "TextButton", { BackgroundTransparency = 1, Selectable = false, Size = UDim2.fromScale(1, 1), TextTransparency = 1 })
		I[3] = new("ImageLabel", I[1], "PromptFrame", { BackgroundColor3 = Color3.fromRGB(0, 148, 255), ImageColor3 = Color3.fromRGB(0, 148, 255), Size = UDim2.fromScale(1, 1) })
			I[4] = new("Frame", I[3], "InputFrame", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), SizeConstraint = Enum.SizeConstraint.RelativeYY })
				I[5] = new("Frame", I[4], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(169, 44, 171), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
					I[6] = new("UIScale", I[5], "UIScale")
					I[7] = new("Frame", I[5], "ProgressBar", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(2, 147, 252), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(2, 147, 252), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, -14, 1, -14) })
						I[8] = new("Frame", I[7], "LeftGradient", { BackgroundColor3 = Color3.fromRGB(0, 148, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 148, 255), ClipsDescendants = true, Size = UDim2.fromScale(0.5, 1) })
							I[9] = new("ImageLabel", I[8], "ProgressBarImage", { BackgroundColor3 = Color3.fromRGB(2, 147, 252), BorderColor3 = Color3.fromRGB(0, 148, 255), ImageColor3 = Color3.fromRGB(0, 148, 255), Size = UDim2.fromScale(2, 1) })
								I[10] = new("UIGradient", I[9], "UIGradient", { Rotation = 180, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.4999, 0), NumberSequenceKeypoint.new(0.5, 1), NumberSequenceKeypoint.new(1, 1) }) })
								I[11] = new("UICorner", I[9], "UICorner", { BottomLeftRadius = UDim.new(0, 7), BottomRightRadius = UDim.new(0, 7), TopLeftRadius = UDim.new(0, 7), TopRightRadius = UDim.new(0, 7) })
						I[12] = new("Frame", I[7], "RightGradient", { BackgroundColor3 = Color3.fromRGB(0, 148, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 148, 255), ClipsDescendants = true, Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(0.5, 1) })
							I[13] = new("ImageLabel", I[12], "ProgressBarImage", { BackgroundColor3 = Color3.fromRGB(2, 147, 252), BorderColor3 = Color3.fromRGB(0, 148, 255), ImageColor3 = Color3.fromRGB(0, 148, 255), Position = UDim2.fromScale(-1, 0), Size = UDim2.fromScale(2, 1) })
								I[14] = new("UIGradient", I[13], "UIGradient", { Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.4999, 0), NumberSequenceKeypoint.new(0.5, 1), NumberSequenceKeypoint.new(1, 1) }) })
								I[15] = new("UICorner", I[13], "UICorner", { BottomLeftRadius = UDim.new(0, 7), BottomRightRadius = UDim.new(0, 7), TopLeftRadius = UDim.new(0, 7), TopRightRadius = UDim.new(0, 7) })
						I[16] = new("NumberValue", I[7], "Progress")
					I[17] = new("ImageLabel", I[5], "ButtonFrame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(252, 250, 255), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, -24, 1, -24) })
						I[18] = new("UICorner", I[17], "UICorner", { BottomLeftRadius = UDim.new(0, 7), BottomRightRadius = UDim.new(0, 7), TopLeftRadius = UDim.new(0, 7), TopRightRadius = UDim.new(0, 7) })
					I[19] = new("ImageLabel", I[5], "ButtonImage", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(2, 147, 252), ImageContent = Content.fromUri("rbxasset://textures/ui/Controls/key_single.png"), ImageTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, -44, 1, -42) })
					I[20] = new("ImageLabel", I[5], "ButtonTextImage", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(2, 147, 252), ImageContent = Content.fromUri("rbxasset://textures/ui/Controls/shift.png"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, -48, 1, -48), Visible = false })
					I[21] = new("TextLabel", I[5], "ButtonText", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(0, -1), Size = UDim2.fromScale(1, 1), Text = "E", TextColor3 = Color3.fromRGB(6, 142, 242), TextSize = 32 })
			I[22] = new("TextLabel", I[3], "ActionText", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.new(0.5, -24, 0, 9), Size = UDim2.fromScale(1, 1), Text = "Action Text", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left })
			I[23] = new("TextLabel", I[3], "ObjectText", { BackgroundColor3 = Color3.fromRGB(249, 248, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.new(0.5, -24, 0, -10), Size = UDim2.fromScale(1, 1), Text = "Object Text", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 19, TextXAlignment = Enum.TextXAlignment.Left })
			I[24] = new("UIGradient", I[3], "UIGradient", { Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 0.5) }) })
			I[25] = new("UICorner", I[3], "UICorner", { BottomLeftRadius = UDim.new(0, 10), BottomRightRadius = UDim.new(0, 10), TopLeftRadius = UDim.new(0, 10), TopRightRadius = UDim.new(0, 10) })
	return I[1]
end

return build
