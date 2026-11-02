-- Generated from ui/StarterGui/ShiftLock.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "ShiftLock", { ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets })
		I[2] = new("BillboardGui", I[1], "BillboardGui", { Active = true, AlwaysOnTop = true, ClipsDescendants = true, Enabled = false, LightInfluence = 1, MaxDistance = math.huge, Size = UDim2.fromScale(7, 7), StudsOffset = Vector3.new(0, -0.35, 0), ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
			I[3] = new("ImageLabel", I[2], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=262619583"), Size = UDim2.fromScale(1, 1) })
		I[4] = new("ImageLabel", I[1], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=6755657357"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.0078616, 0.0114679) })
			I[5] = new("UIAspectRatioConstraint", I[4], "UIAspectRatioConstraint")
		I[6] = new("Frame", I[1], "Xbox", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.new(0, 0, 1, -231), Size = UDim2.fromOffset(125, 231) })
			I[7] = new("Frame", I[6], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(-4.46, -0.7474226), Size = UDim2.fromOffset(157, 52) })
				I[8] = new("ImageLabel", I[7], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://12555335836"), Position = UDim2.new(0.057, 25, 0.5, 0), Size = UDim2.fromOffset(35, 35) })
				I[9] = new("TextLabel", I[7], "TextLabel", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.new(0, 60, 0.5, 0), Size = UDim2.fromOffset(66, 50), Text = "Jump", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 17, TextStrokeTransparency = 0.5, TextXAlignment = Enum.TextXAlignment.Left })
			I[10] = new("Frame", I[6], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(-4.46, 0.0615205), Size = UDim2.fromOffset(157, 52) })
				I[11] = new("ImageLabel", I[10], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://12555335389"), Position = UDim2.new(0.057, 25, 0.5, 0), Size = UDim2.fromOffset(35, 35) })
				I[12] = new("TextLabel", I[10], "TextLabel", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.new(0, 60, 0.5, 0), Size = UDim2.fromOffset(66, 50), Text = "Block", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 17, TextStrokeTransparency = 0.5, TextXAlignment = Enum.TextXAlignment.Left })
			I[13] = new("Frame", I[6], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(-4.46, -0.2189674), Size = UDim2.fromOffset(157, 52) })
				I[14] = new("ImageLabel", I[13], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://12555335237"), Position = UDim2.new(0.057, 25, 0.5, 0), Size = UDim2.fromOffset(35, 35) })
				I[15] = new("TextLabel", I[13], "TextLabel", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.new(0, 60, 0.5, 0), Size = UDim2.fromOffset(66, 50), Text = "Dash", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 17, TextStrokeTransparency = 0.5, TextXAlignment = Enum.TextXAlignment.Left })
			I[16] = new("Frame", I[6], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(-4.46, -0.4913251), Size = UDim2.fromOffset(157, 52) })
				I[17] = new("ImageLabel", I[16], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://12555335624"), Position = UDim2.new(0.057, 25, 0.5, 0), Size = UDim2.fromOffset(35, 35) })
				I[18] = new("TextLabel", I[16], "TextLabel", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.new(0, 60, 0.5, 0), Size = UDim2.fromOffset(66, 50), Text = "Attack", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 17, TextStrokeTransparency = 0.5, TextXAlignment = Enum.TextXAlignment.Left })
			I[19] = new("UIListLayout", I[6], "UIListLayout", { Padding = UDim.new(-0.03, 0), SortOrder = Enum.SortOrder.LayoutOrder })
			I[20] = new("Frame", I[6], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(-4.46, -0.7474226), Size = UDim2.fromOffset(157, 52) })
				I[21] = new("ImageLabel", I[20], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://14996523986"), Position = UDim2.new(0.057, 25, 0.5, 0), Size = UDim2.fromOffset(35, 35) })
				I[22] = new("TextLabel", I[20], "TextLabel", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.new(0, 60, 0.5, 0), Size = UDim2.fromOffset(66, 50), Text = "Lock On", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 17, TextStrokeTransparency = 0.5, TextXAlignment = Enum.TextXAlignment.Left })
		I[23] = new("Frame", I[1], "PS", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.new(0, 0, 1, -231), Size = UDim2.fromOffset(125, 231) })
			I[24] = new("Frame", I[23], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(-4.46, -0.7474226), Size = UDim2.fromOffset(157, 52) })
				I[25] = new("ImageLabel", I[24], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://14995891909"), Position = UDim2.new(0.057, 25, 0.5, 0), Size = UDim2.fromOffset(35, 35) })
				I[26] = new("TextLabel", I[24], "TextLabel", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.new(0, 60, 0.5, 0), Size = UDim2.fromOffset(66, 50), Text = "Jump", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 17, TextStrokeTransparency = 0.5, TextXAlignment = Enum.TextXAlignment.Left })
			I[27] = new("Frame", I[23], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(-4.46, 0.0615205), Size = UDim2.fromOffset(157, 52) })
				I[28] = new("ImageLabel", I[27], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://14995893901"), Position = UDim2.new(0.057, 25, 0.5, 0), Size = UDim2.fromOffset(35, 35) })
				I[29] = new("TextLabel", I[27], "TextLabel", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.new(0, 60, 0.5, 0), Size = UDim2.fromOffset(66, 50), Text = "Block", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 17, TextStrokeTransparency = 0.5, TextXAlignment = Enum.TextXAlignment.Left })
			I[30] = new("Frame", I[23], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(-4.46, -0.2189674), Size = UDim2.fromOffset(157, 52) })
				I[31] = new("ImageLabel", I[30], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://14996048486"), Position = UDim2.new(0.057, 25, 0.5, 0), Size = UDim2.fromOffset(35, 35) })
				I[32] = new("TextLabel", I[30], "TextLabel", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.new(0, 60, 0.5, 0), Size = UDim2.fromOffset(66, 50), Text = "Dash", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 17, TextStrokeTransparency = 0.5, TextXAlignment = Enum.TextXAlignment.Left })
			I[33] = new("Frame", I[23], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(-4.46, -0.4913251), Size = UDim2.fromOffset(157, 52) })
				I[34] = new("ImageLabel", I[33], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://14995977455"), Position = UDim2.new(0.057, 25, 0.5, 0), Size = UDim2.fromOffset(35, 35) })
				I[35] = new("TextLabel", I[33], "TextLabel", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.new(0, 60, 0.5, 0), Size = UDim2.fromOffset(66, 50), Text = "Attack", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 17, TextStrokeTransparency = 0.5, TextXAlignment = Enum.TextXAlignment.Left })
			I[36] = new("UIListLayout", I[23], "UIListLayout", { Padding = UDim.new(-0.03, 0), SortOrder = Enum.SortOrder.LayoutOrder })
			I[37] = new("Frame", I[23], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(-4.46, -0.7474226), Size = UDim2.fromOffset(157, 52) })
				I[38] = new("ImageLabel", I[37], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://12556611614"), Position = UDim2.new(0.057, 25, 0.5, 0), Size = UDim2.fromOffset(35, 35) })
				I[39] = new("TextLabel", I[37], "TextLabel", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.new(0, 60, 0.5, 0), Size = UDim2.fromOffset(66, 50), Text = "Lock On", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 17, TextStrokeTransparency = 0.5, TextXAlignment = Enum.TextXAlignment.Left })
	return I[1]
end

return build
