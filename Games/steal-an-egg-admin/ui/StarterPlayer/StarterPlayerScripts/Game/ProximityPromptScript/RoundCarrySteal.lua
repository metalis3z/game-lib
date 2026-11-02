-- Generated from ui/StarterPlayer/StarterPlayerScripts/Game/ProximityPromptScript/RoundCarrySteal.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "RoundCarrySteal", { Active = true, AlwaysOnTop = true, MaxDistance = math.huge, Size = UDim2.fromOffset(193, 72) }, { ["Theme"] = "", ["_lemonadeUniqueId"] = "bMP34eJ5bMP3" })
		I[2] = new("TextButton", I[1], "TextButton", { BackgroundTransparency = 1, Selectable = false, Size = UDim2.fromScale(1, 1), TextTransparency = 1 }, { ["_lemonadeUniqueId"] = "Mcs7CA86Mcs7" })
		I[3] = new("ImageLabel", I[1], "PromptFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.35, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), ImageTransparency = 1, Size = UDim2.fromScale(1, 1) }, { ["_lemonadeUniqueId"] = "Ep9a4qmIEp9a" })
			I[4] = new("Frame", I[3], "InputFrame", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), SizeConstraint = Enum.SizeConstraint.RelativeYY }, { ["_lemonadeUniqueId"] = "xl6ap7sMxl6a" })
				I[5] = new("Frame", I[4], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(169, 44, 171), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) }, { ["_lemonadeUniqueId"] = "8pDZexRF8pDZ" })
					I[6] = new("UIScale", I[5], "UIScale", nil, { ["_lemonadeUniqueId"] = "jkY5dbH1jkY5" })
					I[7] = new("Frame", I[5], "ProgressBar", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, -14, 1, -14) }, { ["_lemonadeUniqueId"] = "3xx6umQ43xx6" })
						I[8] = new("Frame", I[7], "LeftGradient", { BackgroundTransparency = 1, ClipsDescendants = true, Size = UDim2.fromScale(0.5, 1) }, { ["_lemonadeUniqueId"] = "XIkTgcosXIkT" })
							I[9] = new("ImageLabel", I[8], "ProgressBarImage", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxasset://textures/ui/Controls/RadialFill.png"), Size = UDim2.fromScale(2, 1) }, { ["_lemonadeUniqueId"] = "Nwf4xLOINwf4" })
								I[10] = new("UIGradient", I[9], "UIGradient", { Rotation = 180, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.4999, 0), NumberSequenceKeypoint.new(0.5, 1), NumberSequenceKeypoint.new(1, 1) }) }, { ["_lemonadeUniqueId"] = "FmlkvD0YFmlk" })
						I[11] = new("Frame", I[7], "RightGradient", { BackgroundTransparency = 1, ClipsDescendants = true, Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(0.5, 1) }, { ["_lemonadeUniqueId"] = "4cdxqMBz4cdx" })
							I[12] = new("ImageLabel", I[11], "ProgressBarImage", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxasset://textures/ui/Controls/RadialFill.png"), Position = UDim2.fromScale(-1, 0), Size = UDim2.fromScale(2, 1) }, { ["_lemonadeUniqueId"] = "Q7nIbBLVQ7nI" })
								I[13] = new("UIGradient", I[12], "UIGradient", { Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.4999, 0), NumberSequenceKeypoint.new(0.5, 1), NumberSequenceKeypoint.new(1, 1) }) }, { ["_lemonadeUniqueId"] = "iPDe37m4iPDe" })
						I[14] = new("NumberValue", I[7], "Progress", nil, { ["_lemonadeUniqueId"] = "LRqsfqYmLRqs" })
					I[15] = new("ImageLabel", I[5], "ButtonFrame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 0.5, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), ImageTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, -24, 1, -24) }, { ["_lemonadeUniqueId"] = "OaUYIa5rOaUY" })
						I[16] = new("UICorner", I[15], "UICorner", { BottomLeftRadius = UDim.new(0.5, 0), BottomRightRadius = UDim.new(0.5, 0), TopLeftRadius = UDim.new(0.5, 0), TopRightRadius = UDim.new(0.5, 0) }, { ["_lemonadeUniqueId"] = "siaV3NSgsiaV" })
					I[17] = new("ImageLabel", I[5], "ButtonImage", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxasset://textures/ui/Controls/key_single.png"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, -44, 1, -42) }, { ["_lemonadeUniqueId"] = "e2JadwHZe2Ja" })
					I[18] = new("ImageLabel", I[5], "ButtonTextImage", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxasset://textures/ui/Controls/shift.png"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, -48, 1, -48), Visible = false }, { ["_lemonadeUniqueId"] = "TZsrz4u8TZsr" })
					I[19] = new("TextLabel", I[5], "ButtonText", { BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(0, -1), Size = UDim2.fromScale(1, 1), Text = "E", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 24 }, { ["_lemonadeUniqueId"] = "pMXTkUMopMXT" })
			I[20] = new("UICorner", I[3], "UICorner", nil, { ["_lemonadeUniqueId"] = "ljcE8xhdljcE" })
			I[21] = new("TextLabel", I[3], "ActionText", { BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0.5, -24, 0, 9), RichText = true, Size = UDim2.fromScale(1, 1), Text = "😂 STEAL", TextColor3 = Color3.fromRGB(255, 0, 0), TextSize = 28, TextXAlignment = Enum.TextXAlignment.Left }, { ["_lemonadeUniqueId"] = "z3AmJZAYz3Am" })
				I[22] = new("UIStroke", I[21], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Thickness = 2 }, { ["_lemonadeUniqueId"] = "N2pSmcGAN2pS" })
			I[23] = new("TextLabel", I[3], "ObjectText", { BackgroundColor3 = Color3.fromRGB(249, 248, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0.5, -24, 0, -16), Size = UDim2.fromScale(1, 1), Text = "Object Text", TextColor3 = Color3.fromRGB(178, 178, 178), TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left }, { ["_lemonadeUniqueId"] = "5uP645fb5uP6" })
				I[24] = new("UIStroke", I[23], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Thickness = 1.5 }, { ["_lemonadeUniqueId"] = "1UPVsmCe1UPV" })
			I[25] = new("UIGradient", I[3], "RainbowGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 189, 85)), ColorSequenceKeypoint.new(0.0023545, Color3.fromRGB(255, 192, 84)), ColorSequenceKeypoint.new(0.0852561, Color3.fromRGB(255, 255, 88)), ColorSequenceKeypoint.new(0.1750661, Color3.fromRGB(112, 255, 102)), ColorSequenceKeypoint.new(0.2666033, Color3.fromRGB(96, 255, 255)), ColorSequenceKeypoint.new(0.3598675, Color3.fromRGB(23, 147, 255)), ColorSequenceKeypoint.new(0.4410419, Color3.fromRGB(107, 88, 255)), ColorSequenceKeypoint.new(0.5273977, Color3.fromRGB(164, 90, 255)), ColorSequenceKeypoint.new(0.606845, Color3.fromRGB(220, 92, 255)), ColorSequenceKeypoint.new(0.696655, Color3.fromRGB(220, 92, 255)), ColorSequenceKeypoint.new(0.786465, Color3.fromRGB(255, 83, 115)), ColorSequenceKeypoint.new(0.786465, Color3.fromRGB(255, 83, 115)), ColorSequenceKeypoint.new(0.8486412, Color3.fromRGB(255, 70, 70)), ColorSequenceKeypoint.new(0.9211801, Color3.fromRGB(255, 83, 115)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 189, 85)) }), Rotation = 21 }, { ["GRAD_ANCESTOR"] = "Container_MainShop", ["_lemonadeUniqueId"] = "czB62CDHczB6" })
			I[26] = new("UIStroke", I[3], "UIStroke", { BorderStrokePosition = Enum.BorderStrokePosition.Center, Color = Color3.fromRGB(255, 255, 255), Thickness = 2.9000001, ZIndex = 3 }, { ["_lemonadeUniqueId"] = "HM2NAhfPHM2N" })
				I[27] = new("UIGradient", I[26], "RainbowGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 189, 85)), ColorSequenceKeypoint.new(0.0023545, Color3.fromRGB(255, 192, 84)), ColorSequenceKeypoint.new(0.0852561, Color3.fromRGB(255, 255, 88)), ColorSequenceKeypoint.new(0.1750661, Color3.fromRGB(112, 255, 102)), ColorSequenceKeypoint.new(0.2666033, Color3.fromRGB(96, 255, 255)), ColorSequenceKeypoint.new(0.3598675, Color3.fromRGB(23, 147, 255)), ColorSequenceKeypoint.new(0.4410419, Color3.fromRGB(107, 88, 255)), ColorSequenceKeypoint.new(0.5273977, Color3.fromRGB(164, 90, 255)), ColorSequenceKeypoint.new(0.606845, Color3.fromRGB(220, 92, 255)), ColorSequenceKeypoint.new(0.696655, Color3.fromRGB(220, 92, 255)), ColorSequenceKeypoint.new(0.786465, Color3.fromRGB(255, 83, 115)), ColorSequenceKeypoint.new(0.786465, Color3.fromRGB(255, 83, 115)), ColorSequenceKeypoint.new(0.8486412, Color3.fromRGB(255, 70, 70)), ColorSequenceKeypoint.new(0.9211801, Color3.fromRGB(255, 83, 115)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 189, 85)) }), Rotation = 42 }, { ["GRAD_ANCESTOR"] = "Container_MainShop", ["_lemonadeUniqueId"] = "yrXTt50IyrXT" })
			I[28] = new("UIStroke", I[3], "UIStroke_2", { Color = Color3.fromRGB(255, 255, 255), Thickness = 4.6999998, ZIndex = 2 }, { ["_lemonadeUniqueId"] = "eOr9WM8WeOr9" })
	return I[1]
end

return build
