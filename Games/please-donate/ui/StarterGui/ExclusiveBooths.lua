-- Generated from ui/StarterGui/ExclusiveBooths.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("SurfaceGui", nil, "ExclusiveBooths", { ClipsDescendants = true, Face = Enum.NormalId.Right, LightInfluence = 0.5, PixelsPerStud = 40, SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("ScrollingFrame", I[1], "Badges", { Active = true, AnchorPoint = Vector2.new(0.5, 0.5), AutomaticCanvasSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, CanvasSize = UDim2.fromScale(0, 0), Position = UDim2.fromScale(0.5, 0.5), ScrollBarImageColor3 = Color3.fromRGB(197, 197, 197), ScrollBarThickness = 8, ScrollingDirection = Enum.ScrollingDirection.Y, Selectable = false, Size = UDim2.fromScale(1, 1) })
			I[3] = new("UIPadding", I[2], "UIPadding", { PaddingBottom = UDim.new(0, 50), PaddingLeft = UDim.new(0, 20), PaddingRight = UDim.new(0, 20), PaddingTop = UDim.new(0, 50) })
			I[4] = new("UIGridLayout", I[2], "UIGridLayout", { CellPadding = UDim2.fromOffset(20, 20), CellSize = UDim2.fromOffset(325, 250), HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder })
			I[5] = new("Frame", I[2], "Quantoun", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, ClipsDescendants = true, LayoutOrder = -1, Size = UDim2.fromScale(0.40625, 0.4166667), ZIndex = 16205978 }, { ["Type"] = "Group" })
				I[6] = new("UIListLayout", I[5], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder })
				I[7] = new("UICorner", I[5], "UICorner", { BottomLeftRadius = UDim.new(0, 25), BottomRightRadius = UDim.new(0, 25), TopLeftRadius = UDim.new(0, 25), TopRightRadius = UDim.new(0, 25) })
				I[8] = new("Frame", I[5], "Info", { AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 0.6), ZIndex = 2 })
					I[9] = new("TextLabel", I[8], "Description", { AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal), LayoutOrder = 2, Size = UDim2.fromScale(1, 0), Text = "It woud really suport us :)", TextColor3 = Color3.fromRGB(93, 93, 93), TextSize = 16, TextWrapped = true })
					I[10] = new("TextLabel", I[8], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Size = UDim2.new(1, 0, 0, 22), Text = "Like the game!", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[11] = new("UIListLayout", I[8], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 5), SortOrder = Enum.SortOrder.LayoutOrder })
					I[12] = new("Frame", I[8], "Seperator", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = 3, Size = UDim2.fromOffset(0, 8) })
					I[13] = new("TextLabel", I[8], "Experience", { AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal), LayoutOrder = 1, RichText = true, Size = UDim2.fromScale(1, 0), Text = "From <b>Modded Donations</b>", TextColor3 = Color3.fromRGB(17, 111, 0), TextSize = 16, TextWrapped = true })
					I[14] = new("UIPadding", I[8], "UIPadding", { PaddingBottom = UDim.new(0, 25), PaddingLeft = UDim.new(0, 25), PaddingRight = UDim.new(0, 25), PaddingTop = UDim.new(0, 25) })
					I[15] = new("TextLabel", I[8], "Owned", { AnchorPoint = Vector2.new(1, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(23, 135, 255), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), LayoutOrder = 4, Position = UDim2.new(1, -15, 0, 15), Size = UDim2.fromOffset(72, 0), Text = "OWNED", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 12, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, Visible = false })
						I[16] = new("UIPadding", I[15], "UIPadding", { PaddingBottom = UDim.new(0, 4), PaddingLeft = UDim.new(0, 7), PaddingRight = UDim.new(0, 4), PaddingTop = UDim.new(0, 4) })
						I[17] = new("UICorner", I[15], "UICorner", { BottomLeftRadius = UDim.new(0, 4), BottomRightRadius = UDim.new(0, 4), TopLeftRadius = UDim.new(0, 4), TopRightRadius = UDim.new(0, 4) })
						I[18] = new("ImageButton", I[15], "check", { AnchorPoint = Vector2.new(1, 0.5), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://3926311105"), ImageRectOffset = Vector2.new(4, 836), ImageRectSize = Vector2.new(48, 48), LayoutOrder = 3, Position = UDim2.fromScale(1, 0.5), Size = UDim2.fromOffset(12, 12), ZIndex = 2 })
							I[19] = new("UICorner", I[18], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
				I[20] = new("UIGradient", I[5], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(235, 235, 235)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }), Rotation = 50 })
				I[21] = new("Frame", I[5], "Top", { BackgroundColor3 = Color3.fromRGB(17, 111, 0), LayoutOrder = -1, Size = UDim2.fromScale(1, 0.4) })
					I[22] = new("ImageLabel", I[21], "BadgeIcon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://12564060793"), Position = UDim2.fromScale(0.5, 0.75), Size = UDim2.fromOffset(100, 100), ZIndex = 2 })
						I[23] = new("UIStroke", I[22], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(255, 255, 255), Thickness = 4.5 })
						I[24] = new("UICorner", I[22], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
					I[25] = new("UICorner", I[21], "UICorner", { BottomLeftRadius = UDim.new(0, 25), BottomRightRadius = UDim.new(0, 25), TopLeftRadius = UDim.new(0, 25), TopRightRadius = UDim.new(0, 25) })
					I[26] = new("Frame", I[21], "Frame", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(17, 111, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 1), Size = UDim2.fromScale(1, 0.5) })
	return I[1]
end

return build
