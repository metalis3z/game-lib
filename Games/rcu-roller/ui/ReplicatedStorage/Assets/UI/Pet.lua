-- Generated from ui/ReplicatedStorage/Assets/UI/Pet.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Pet", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(0.1157025, 0.5517241), Visible = false, ZIndex = 610 })
		I[2] = new("Frame", I[1], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 611 })
			I[3] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0.13, 0), BottomRightRadius = UDim.new(0.13, 0), TopLeftRadius = UDim.new(0.13, 0), TopRightRadius = UDim.new(0.13, 0) })
			I[4] = new("TextLabel", I[2], "Amount2", { AnchorPoint = Vector2.new(0.5, 0.5), AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.6900002, 0.0566243), Size = UDim2.fromScale(0.678966, 0.2972576), Text = "x1", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, Visible = false, ZIndex = 713 })
				I[5] = new("UIStroke", I[4], "UIStroke", { Color = Color3.fromRGB(0, 32, 54), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 4 })
			I[6] = new("TextButton", I[2], "Click", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 900 })
				I[7] = new("UITextSizeConstraint", I[6], "UITextSizeConstraint", { MaxTextSize = 14 })
			I[8] = new("UIStroke", I[2], "UIStroke", { Color = Color3.fromRGB(0, 32, 54), Thickness = 5 })
				I[9] = new("UIGradient", I[8], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(83, 213, 253)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(124, 170, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(187, 95, 253)) }), Rotation = 60 })
			I[10] = new("ImageLabel", I[2], "Locked", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://106444809528445"), Position = UDim2.fromScale(1, 0.5), Size = UDim2.fromScale(0.38, 0.38), Visible = false, ZIndex = 701 })
			I[11] = new("Frame", I[2], "IconContainer", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 611 })
				I[12] = new("ImageLabel", I[11], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://108292204966876"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 612 })
					I[13] = new("UICorner", I[12], "UICorner", { BottomLeftRadius = UDim.new(0.13, 0), BottomRightRadius = UDim.new(0.13, 0), TopLeftRadius = UDim.new(0.13, 0), TopRightRadius = UDim.new(0.13, 0) })
			I[14] = new("TextLabel", I[2], "Multiplier", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromScale(0.9, 0.297), Text = "1.01M", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 713 })
				I[15] = new("UIStroke", I[14], "UIStroke", { Color = Color3.fromRGB(0, 32, 54), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 4 })
			I[16] = new("UIGradient", I[2], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(205, 231, 227)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(205, 231, 227)) }), Rotation = 60 })
			I[17] = new("ImageLabel", I[2], "Confirm", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://122138044618530"), Position = UDim2.fromScale(0.52, 0.5), Size = UDim2.fromScale(0.78, 0.78), Visible = false, ZIndex = 700 })
			I[18] = new("TextLabel", I[2], "Percentage", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.57, 0.95), Size = UDim2.fromScale(1.0608015, 0.3668752), Text = "1%", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, Visible = false, ZIndex = 720 })
				I[19] = new("UIStroke", I[18], "UIStroke", { Color = Color3.fromRGB(0, 32, 54), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 5 })
			I[20] = new("ImageLabel", I[2], "Checkmark", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://95468754252019"), Position = UDim2.fromScale(0.52, 0.5), Size = UDim2.fromScale(0.74, 0.74), Visible = false, ZIndex = 700 })
			I[21] = new("ImageLabel", I[2], "Quest", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://119785995058042"), Position = UDim2.fromScale(0.025976, 0.0616903), Size = UDim2.fromScale(0.3619713, 0.3619713), Visible = false, ZIndex = 701 })
			I[22] = new("Folder", I[2], "Tiers")
				I[23] = new("ImageLabel", I[22], "Ultimate", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://104250291081047"), Position = UDim2.fromScale(0.048, 0.062), Size = UDim2.fromScale(0.4285714, 0.4285714), Visible = false, ZIndex = 701 })
				I[24] = new("ImageLabel", I[22], "Mythical", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://138740820631153"), Position = UDim2.fromScale(0.025976, 0.0616903), Size = UDim2.fromScale(0.3571429, 0.3571429), Visible = false, ZIndex = 701 })
				I[25] = new("ImageLabel", I[22], "Supreme", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://106491966978040"), Position = UDim2.fromScale(0.025976, 0.0616903), Size = UDim2.fromScale(0.4107143, 0.4107143), Visible = false, ZIndex = 701 })
				I[26] = new("ImageLabel", I[22], "Common", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://112690551488381"), Position = UDim2.fromScale(0.025976, 0.0616903), Size = UDim2.fromScale(0.3214286, 0.3214286), ZIndex = 701 })
				I[27] = new("ImageLabel", I[22], "Uncommon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://112690551488381"), Position = UDim2.fromScale(0.025976, 0.0616903), Size = UDim2.fromScale(0.3214286, 0.3214286), Visible = false, ZIndex = 701 })
				I[28] = new("ImageLabel", I[22], "Rare", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://112690551488381"), Position = UDim2.fromScale(0.025976, 0.0616903), Size = UDim2.fromScale(0.3214286, 0.3214286), Visible = false, ZIndex = 701 })
				I[29] = new("ImageLabel", I[22], "Legendary", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://99054995904743"), Position = UDim2.fromScale(0.08, 0.068), Size = UDim2.fromScale(0.4821429, 0.4821429), ZIndex = 701 })
				I[30] = new("ImageLabel", I[22], "Eternal", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://105556553747413"), Position = UDim2.fromScale(0.025976, 0.0616903), Size = UDim2.fromScale(0.3571429, 0.3571429), Visible = false, ZIndex = 701 })
				I[31] = new("ImageLabel", I[22], "Secret", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://99071526610384"), Position = UDim2.fromScale(0.025976, 0.0616903), Size = UDim2.fromScale(0.3571429, 0.3571429), Visible = false, ZIndex = 701 })
				I[32] = new("ImageLabel", I[22], "Exclusive", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://90747500096066"), Position = UDim2.fromScale(0.025976, 0.0616903), Size = UDim2.fromScale(0.3571429, 0.3571429), Visible = false, ZIndex = 701 })
				I[33] = new("ImageLabel", I[22], "Epic", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://86023258727562"), Position = UDim2.fromScale(0.05, 0.086), Size = UDim2.fromScale(0.4107143, 0.4107143), ZIndex = 701 })
			I[34] = new("ImageLabel", I[2], "Archive", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://122138044618530"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.78, 0.78), Visible = false, ZIndex = 700 })
			I[35] = new("TextLabel", I[2], "Multiplier2", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187373592", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4999998, 0.9402125), Size = UDim2.fromScale(0.9, 0.4165742), Text = "1.01M", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false, ZIndex = 713 })
				I[36] = new("UIStroke", I[35], "UIStroke", { Color = Color3.fromRGB(0, 32, 54), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 4 })
			I[37] = new("TextLabel", I[2], "Amount", { AnchorPoint = Vector2.new(0.5, 0.5), AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.69, 0.03), Size = UDim2.fromScale(0.679, 0.25), Text = "x1", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, ZIndex = 713 })
				I[38] = new("UIStroke", I[37], "UIStroke", { Color = Color3.fromRGB(0, 32, 54), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 4 })
		I[39] = new("UIStroke", I[1], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Enabled = false, Thickness = 10 })
		I[40] = new("UICorner", I[1], "UICorner", { BottomLeftRadius = UDim.new(0.13, 0), BottomRightRadius = UDim.new(0.13, 0), TopLeftRadius = UDim.new(0.13, 0), TopRightRadius = UDim.new(0.13, 0) })
	return I[1]
end

return build
