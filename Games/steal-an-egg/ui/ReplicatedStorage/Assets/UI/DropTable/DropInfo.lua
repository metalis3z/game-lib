-- Generated from ui/ReplicatedStorage/Assets/UI/DropTable/DropInfo.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "DropInfo", { Active = true, AlwaysOnTop = true, MaxDistance = 100, ResetOnSpawn = false, Size = UDim2.fromScale(16, 20), StudsOffset = Vector3.new(0, 10, 0) })
		I[2] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.1), Size = UDim2.fromScale(0.95, 0.7) })
			I[3] = new("ImageLabel", I[2], "Pointer_Down", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://94836978140510"), Position = UDim2.fromScale(0.5, 1), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 0.1) })
				I[4] = new("UIAspectRatioConstraint", I[3], "UIAspectRatioConstraint")
			I[5] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0.1, 0), BottomRightRadius = UDim.new(0.1, 0), TopLeftRadius = UDim.new(0.1, 0), TopRightRadius = UDim.new(0.1, 0) })
			I[6] = new("TextLabel", I[2], "Title", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, -0.02), Size = UDim2.fromScale(1, 0.125), Text = "Possible Loot:", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextWrapped = true })
				I[7] = new("UIStroke", I[6], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 3 })
			I[8] = new("Frame", I[2], "Items", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
				I[9] = new("Frame", I[8], "Container", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) })
					I[10] = new("Frame", I[9], "Item", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 0.9) })
						I[11] = new("UIAspectRatioConstraint", I[10], "UIAspectRatioConstraint")
						I[12] = new("Frame", I[10], "Holder", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) })
						I[13] = new("TextLabel", I[10], "Chance", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LineHeight = 0.9, Size = UDim2.fromScale(1, 0.25), Text = "30%", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, TextYAlignment = Enum.TextYAlignment.Bottom, ZIndex = 1000 })
							I[14] = new("UIStroke", I[13], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2.5 })
					I[15] = new("Frame", I[9], "Item_2", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 0.9) })
						I[16] = new("UIAspectRatioConstraint", I[15], "UIAspectRatioConstraint")
						I[17] = new("Frame", I[15], "Holder", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) })
						I[18] = new("TextLabel", I[15], "Chance", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LineHeight = 0.9, Size = UDim2.fromScale(1, 0.25), Text = "30%", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, TextYAlignment = Enum.TextYAlignment.Bottom, ZIndex = 1000 })
							I[19] = new("UIStroke", I[18], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2.5 })
					I[20] = new("Frame", I[9], "Item_3", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 0.9) })
						I[21] = new("UIAspectRatioConstraint", I[20], "UIAspectRatioConstraint")
						I[22] = new("Frame", I[20], "Holder", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) })
						I[23] = new("TextLabel", I[20], "Chance", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LineHeight = 0.9, Size = UDim2.fromScale(1, 0.25), Text = "30%", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, TextYAlignment = Enum.TextYAlignment.Bottom, ZIndex = 1000 })
							I[24] = new("UIStroke", I[23], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2.5 })
					I[25] = new("Frame", I[9], "Item_4", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 0.9) })
						I[26] = new("UIAspectRatioConstraint", I[25], "UIAspectRatioConstraint")
						I[27] = new("Frame", I[25], "Holder", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) })
						I[28] = new("TextLabel", I[25], "Chance", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LineHeight = 0.9, Size = UDim2.fromScale(1, 0.25), Text = "30%", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, TextYAlignment = Enum.TextYAlignment.Bottom, ZIndex = 1000 })
							I[29] = new("UIStroke", I[28], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2.5 })
					I[30] = new("Frame", I[9], "Item_5", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 0.9) })
						I[31] = new("UIAspectRatioConstraint", I[30], "UIAspectRatioConstraint")
						I[32] = new("Frame", I[30], "Holder", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) })
						I[33] = new("TextLabel", I[30], "Chance", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LineHeight = 0.9, Size = UDim2.fromScale(1, 0.25), Text = "30%", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, TextYAlignment = Enum.TextYAlignment.Bottom, ZIndex = 1000 })
							I[34] = new("UIStroke", I[33], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2.5 })
					I[35] = new("Frame", I[9], "Item_6", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 0.9) })
						I[36] = new("UIAspectRatioConstraint", I[35], "UIAspectRatioConstraint")
						I[37] = new("Frame", I[35], "Holder", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) })
						I[38] = new("TextLabel", I[35], "Chance", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LineHeight = 0.9, Size = UDim2.fromScale(1, 0.25), Text = "30%", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, TextYAlignment = Enum.TextYAlignment.Bottom, ZIndex = 1000 })
							I[39] = new("UIStroke", I[38], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2.5 })
					I[40] = new("Frame", I[9], "Item_7", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 0.9) })
						I[41] = new("UIAspectRatioConstraint", I[40], "UIAspectRatioConstraint")
						I[42] = new("Frame", I[40], "Holder", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) })
						I[43] = new("TextLabel", I[40], "Chance", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LineHeight = 0.9, Size = UDim2.fromScale(1, 0.25), Text = "30%", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, TextYAlignment = Enum.TextYAlignment.Bottom, ZIndex = 1000 })
							I[44] = new("UIStroke", I[43], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2.5 })
					I[45] = new("Frame", I[9], "Item_8", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 0.9) })
						I[46] = new("UIAspectRatioConstraint", I[45], "UIAspectRatioConstraint")
						I[47] = new("Frame", I[45], "Holder", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) })
						I[48] = new("TextLabel", I[45], "Chance", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LineHeight = 0.9, Size = UDim2.fromScale(1, 0.25), Text = "30%", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, TextYAlignment = Enum.TextYAlignment.Bottom, ZIndex = 1000 })
							I[49] = new("UIStroke", I[48], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2.5 })
					I[50] = new("Frame", I[9], "Item_9", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 0.9) })
						I[51] = new("UIAspectRatioConstraint", I[50], "UIAspectRatioConstraint")
						I[52] = new("Frame", I[50], "Holder", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) })
						I[53] = new("TextLabel", I[50], "Chance", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LineHeight = 0.9, Size = UDim2.fromScale(1, 0.25), Text = "30%", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, TextYAlignment = Enum.TextYAlignment.Bottom, ZIndex = 1000 })
							I[54] = new("UIStroke", I[53], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2.5 })
					I[55] = new("UIGridLayout", I[9], "UIGridLayout", { CellPadding = UDim2.fromOffset(3, 3), CellSize = UDim2.new(0.33, -3, 0.33, -3), FillDirectionMaxCells = 3, SortOrder = Enum.SortOrder.LayoutOrder })
					I[56] = new("UIPadding", I[9], "UIPadding", { PaddingBottom = UDim.new(0, 5), PaddingLeft = UDim.new(0, 5), PaddingRight = UDim.new(0, 5), PaddingTop = UDim.new(0, 5) })
			I[57] = new("TextLabel", I[2], "PageNumber", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 1.01), Size = UDim2.fromScale(0.95, 0.06), Text = "3/5", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right })
				I[58] = new("UIStroke", I[57], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 1.5 })
			I[59] = new("TextLabel", I[2], "Rolls", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 1.01), Size = UDim2.fromScale(0.95, 0.06), Text = "5 Rolls!", TextColor3 = Color3.fromRGB(255, 188, 252), TextScaled = true, TextSize = 18, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
				I[60] = new("UIStroke", I[59], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 1.5 })
			I[61] = new("ImageLabel", I[2], "Pointer_Right", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://94836978140510"), Position = UDim2.fromScale(1, 0.5), Rotation = 270, ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 0.1), Visible = false })
				I[62] = new("UIAspectRatioConstraint", I[61], "UIAspectRatioConstraint")
			I[63] = new("ImageLabel", I[2], "Pointer_Left", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://94836978140510"), Position = UDim2.fromScale(0, 0.5), Rotation = 90, ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 0.1), Visible = false })
				I[64] = new("UIAspectRatioConstraint", I[63], "UIAspectRatioConstraint")
	return I[1]
end

return build
