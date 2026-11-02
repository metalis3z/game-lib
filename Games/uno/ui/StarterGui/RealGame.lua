-- Generated from ui/StarterGui/RealGame.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "RealGame", { DisplayOrder = 1, ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "GameFrames", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) })
			I[3] = new("Frame", I[2], "Cards", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.93), Size = UDim2.fromScale(0.16, 0.225), SizeConstraint = Enum.SizeConstraint.RelativeYY })
			I[4] = new("Frame", I[2], "SkipPopper", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.93), Size = UDim2.fromScale(0.16, 0.225), SizeConstraint = Enum.SizeConstraint.RelativeYY, ZIndex = 99 })
				I[5] = new("ImageLabel", I[4], "Popper", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(240, 75, 75), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=8071990635"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), SizeConstraint = Enum.SizeConstraint.RelativeYY, Visible = false })
		I[6] = new("Frame", I[1], "PlayerCons", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) })
		I[7] = new("Frame", I[1], "BigPoppers", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1.5, 0.15), SizeConstraint = Enum.SizeConstraint.RelativeYY, ZIndex = 2 })
			I[8] = new("ImageLabel", I[7], "ImagePopper", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), SizeConstraint = Enum.SizeConstraint.RelativeYY, Visible = false })
			I[9] = new("TextLabel", I[7], "TextPopper", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/HighwayGothic.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), RichText = true, Size = UDim2.fromScale(1, 1), Text = "+2", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(255, 255, 255), TextWrapped = true, Visible = false })
				I[10] = new("TextLabel", I[9], "Dark", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/HighwayGothic.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.48), RichText = true, Size = UDim2.fromScale(1, 1), Text = "+2", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(255, 255, 255), TextWrapped = true, Visible = false, ZIndex = 0 })
		I[11] = new("Frame", I[1], "ColorPicker", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(84, 84, 84), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), SizeConstraint = Enum.SizeConstraint.RelativeYY, ZIndex = 10 })
			I[12] = new("ImageLabel", I[11], "Back", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(72, 72, 72), ImageContent = Content.fromUri("rbxassetid://1008360521"), ImageTransparency = 0.5, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(30, 30, 300, 300) })
			I[13] = new("Frame", I[11], "Colors", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.92) })
		I[14] = new("Frame", I[1], "DrawFrame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 0.15), SizeConstraint = Enum.SizeConstraint.RelativeYY })
			I[15] = new("TextLabel", I[14], "Txt", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), RichText = true, Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[16] = new("TextLabel", I[14], "TxtDark", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.53), RichText = true, Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 0 })
		I[17] = new("Frame", I[1], "NumberPicker", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), SizeConstraint = Enum.SizeConstraint.RelativeYY })
			I[18] = new("ImageLabel", I[17], "Back", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(72, 72, 72), ImageContent = Content.fromUri("rbxassetid://1008360521"), ImageTransparency = 0.5, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(30, 30, 300, 300) })
			I[19] = new("Frame", I[17], "Numbers", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.98, 0.88) })
				I[20] = new("ScrollingFrame", I[19], "Scroller", { Active = true, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, CanvasSize = UDim2.fromScale(2, 0), ScrollBarThickness = 8, Size = UDim2.fromScale(1, 1), ZIndex = 7 })
					I[21] = new("Frame", I[20], "yList", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.new(1.55909, 0, 1, -10), SizeConstraint = Enum.SizeConstraint.RelativeYY })
		I[22] = new("Frame", I[1], "TradeRequests", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ClipsDescendants = true, Position = UDim2.fromScale(0.5, 0.01), Size = UDim2.fromScale(0.35, 0.2), SizeConstraint = Enum.SizeConstraint.RelativeYY })
			I[23] = new("ImageLabel", I[22], "RequestTemp", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(95, 95, 95), ImageContent = Content.fromUri("rbxassetid://1008360521"), Position = UDim2.fromScale(0, -1), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(30, 30, 300, 300) })
				I[24] = new("TextLabel", I[23], "Header", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.07), Size = UDim2.fromScale(1, 0.2), Text = "TRADE REQUEST", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[25] = new("TextLabel", I[23], "Who", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.37), Size = UDim2.fromScale(1, 0.16), Text = "CHUCKNORRISFISHERMAN", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[26] = new("TextButton", I[23], "ViewPew", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.94), SelectionBehaviorLeft = Enum.SelectionBehavior.Stop, SelectionBehaviorRight = Enum.SelectionBehavior.Stop, SelectionGroup = true, Size = UDim2.fromScale(0.93, 0.3), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, ZIndex = 10 })
					I[27] = new("ImageLabel", I[26], "ColorDark", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(64, 153, 194), ImageContent = Content.fromUri("rbxassetid://1008360521"), Position = UDim2.fromScale(0.5, 1), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 0.7), SliceCenter = Rect.new(30, 30, 300, 300), ZIndex = 2 })
					I[28] = new("ImageLabel", I[26], "ColorLight", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(85, 199, 255), ImageContent = Content.fromUri("rbxassetid://1008360521"), Position = UDim2.fromScale(0.5, 0), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 0.94), SliceCenter = Rect.new(30, 30, 300, 300), ZIndex = 3 })
						I[29] = new("TextLabel", I[28], "Txt", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.48), Size = UDim2.fromScale(1, 1.1), Text = "VIEW", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 7 })
						I[30] = new("TextLabel", I[28], "TxtDark", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.52), Size = UDim2.fromScale(1, 1.1), Text = "VIEW", TextColor3 = Color3.fromRGB(152, 152, 152), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 6 })
						I[31] = new("ImageLabel", I[28], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=9726105526"), Position = UDim2.fromScale(0.09, 0.48), Size = UDim2.fromScale(0.7, 0.7), SizeConstraint = Enum.SizeConstraint.RelativeYY, ZIndex = 10 })
						I[32] = new("ImageLabel", I[28], "Dark", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(152, 152, 152), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=9726105526"), Position = UDim2.fromScale(0.09, 0.52), Size = UDim2.fromScale(0.7, 0.7), SizeConstraint = Enum.SizeConstraint.RelativeYY, ZIndex = 9 })
						I[33] = new("ImageLabel", I[28], "Icon", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=9726105526"), Position = UDim2.fromScale(0.97, 0.48), Size = UDim2.fromScale(0.7, 0.7), SizeConstraint = Enum.SizeConstraint.RelativeYY, ZIndex = 10 })
						I[34] = new("ImageLabel", I[28], "Dark", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(152, 152, 152), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=9726105526"), Position = UDim2.fromScale(0.97, 0.52), Size = UDim2.fromScale(0.7, 0.7), SizeConstraint = Enum.SizeConstraint.RelativeYY, ZIndex = 9 })
					I[35] = new("Frame", I[26], "Circles", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ClipsDescendants = true, Size = UDim2.fromScale(1, 1) })
					I[36] = new("Folder", I[26], "MouseInfo")
						I[37] = new("Color3Value", I[36], "OrigCol", { Value = Color3.fromRGB(85, 199, 255) })
						I[38] = new("Color3Value", I[36], "NewCol", { Value = Color3.fromRGB(125, 214, 255) })
						I[39] = new("NumberValue", I[36], "LightDownY", { Value = 0.06 })
						I[40] = new("NumberValue", I[36], "LightUpY")
					I[41] = new("ObjectValue", I[26], "Bind")
	return I[1]
end

return build
