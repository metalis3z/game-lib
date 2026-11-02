-- Generated from ui/ReplicatedStorage/PlayersListPlus/Assets/PlayersList.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "PlayersList", { DisplayOrder = 5, ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.new(0.5, 0, 0.5, 5), Size = UDim2.fromScale(0.985, 1) })
			I[3] = new("CanvasGroup", I[2], "SelectPlayer", { AnchorPoint = Vector2.new(1, 0), AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = 1, Position = UDim2.new(0.86, 0, 0, 5), Size = UDim2.fromScale(0.1, 0.9), Visible = false })
				I[4] = new("Frame", I[3], "Top", { BackgroundColor3 = Color3.fromRGB(30, 30, 30), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = -1, Size = UDim2.fromScale(1, 0.35), SizeConstraint = Enum.SizeConstraint.RelativeXX, ZIndex = 2 })
					I[5] = new("ImageLabel", I[4], "PlayerIcon", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(80, 80, 80), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxthumb://type=AvatarHeadShot&id=374169534&w=150&h=150"), Position = UDim2.fromScale(0.05, 0.5), Size = UDim2.fromScale(0.75, 0.75) })
						I[6] = new("UIAspectRatioConstraint", I[5], "UIAspectRatioConstraint")
						I[7] = new("UICorner", I[5], "UICorner", { BottomLeftRadius = UDim.new(0, 10), BottomRightRadius = UDim.new(0, 10), TopLeftRadius = UDim.new(0, 10), TopRightRadius = UDim.new(0, 10) })
						I[8] = new("UIStroke", I[5], "UIStroke", { Color = Color3.fromRGB(50, 50, 50), Thickness = 2 })
					I[9] = new("Frame", I[4], "NameFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.3533333, 0.1952381), Size = UDim2.fromScale(0.6, 0.3606339), ZIndex = 3 })
						I[10] = new("UIListLayout", I[9], "UIListLayout", { Padding = UDim.new(0.05, 0), SortOrder = Enum.SortOrder.LayoutOrder })
						I[11] = new("TextBox", I[9], "DisplayName", { Active = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClearTextOnFocus = false, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 1, PlaceholderColor3 = Color3.fromRGB(178, 178, 178), Position = UDim2.fromScale(0.35, 0.2), Selectable = false, Size = UDim2.fromScale(0.9, 0.475), Text = "MiniDev", TextColor3 = Color3.fromRGB(255, 255, 255), TextEditable = false, TextSize = 16, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
							I[12] = new("UITextSizeConstraint", I[11], "UITextSizeConstraint", { MaxTextSize = 25, MinTextSize = 5 })
						I[13] = new("TextBox", I[9], "PlayerName", { Active = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClearTextOnFocus = false, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 2, PlaceholderColor3 = Color3.fromRGB(178, 178, 178), Position = UDim2.fromScale(0.35, 0.3), Selectable = false, Size = UDim2.fromScale(0.9, 0.475), Text = "@youtub62", TextColor3 = Color3.fromRGB(100, 100, 100), TextEditable = false, TextSize = 16, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
							I[14] = new("UITextSizeConstraint", I[13], "UITextSizeConstraint", { MaxTextSize = 25, MinTextSize = 5 })
					I[15] = new("Frame", I[4], "Tags", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.3533333, 0.6285715), Size = UDim2.fromScale(0.6, 0.12), ZIndex = 3 })
						I[16] = new("UIListLayout", I[15], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0.025, 0), SortOrder = Enum.SortOrder.LayoutOrder })
				I[17] = new("ScrollingFrame", I[3], "ScrollingFrame", { Active = true, AutomaticCanvasSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, CanvasSize = UDim2.fromScale(0, 0), ClipsDescendants = false, ScrollBarThickness = 4, ScrollingDirection = Enum.ScrollingDirection.Y, Size = UDim2.fromScale(1, 1) })
					I[18] = new("Frame", I[17], "ActionFrame", { AnchorPoint = Vector2.new(0.5, 0), AutoLocalize = false, AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.3, BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(1, 0) })
						I[19] = new("UICorner", I[18], "UICorner", { BottomLeftRadius = UDim.new(0, 10), BottomRightRadius = UDim.new(0, 10), TopLeftRadius = UDim.new(0, 10), TopRightRadius = UDim.new(0, 10) })
						I[20] = new("CanvasGroup", I[18], "ActionList", { AnchorPoint = Vector2.new(0.5, 0), AutoLocalize = false, AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(1, 1) })
							I[21] = new("UIListLayout", I[20], "UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder })
							I[22] = new("UICorner", I[20], "UICorner", { BottomLeftRadius = UDim.new(0, 10), BottomRightRadius = UDim.new(0, 10), TopLeftRadius = UDim.new(0, 10), TopRightRadius = UDim.new(0, 10) })
							I[23] = new("Frame", I[20], "Top", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = -1, Size = UDim2.fromScale(1, 0.35), SizeConstraint = Enum.SizeConstraint.RelativeXX })
				I[24] = new("UISizeConstraint", I[3], "UISizeConstraint", { MinSize = Vector2.new(300, 0) })
				I[25] = new("UICorner", I[3], "UICorner", { BottomLeftRadius = UDim.new(0, 10), BottomRightRadius = UDim.new(0, 10), TopLeftRadius = UDim.new(0, 10), TopRightRadius = UDim.new(0, 10) })
			I[26] = new("CanvasGroup", I[2], "PlayerListMaster", { AnchorPoint = Vector2.new(1, 0), AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = 2, Position = UDim2.new(0.998, 0, 0, 5), Size = UDim2.fromScale(0.1, 0.35) })
				I[27] = new("UICorner", I[26], "UICorner", { BottomLeftRadius = UDim.new(0, 10), BottomRightRadius = UDim.new(0, 10), TopLeftRadius = UDim.new(0, 10), TopRightRadius = UDim.new(0, 10) })
				I[28] = new("UISizeConstraint", I[26], "UISizeConstraint", { MinSize = Vector2.new(300, 0) })
				I[29] = new("ScrollingFrame", I[26], "ScrollingFrame", { Active = true, AutomaticCanvasSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, CanvasSize = UDim2.fromScale(0, 0), ClipsDescendants = false, Position = UDim2.fromScale(0, 0.01), ScrollBarThickness = 8, ScrollingDirection = Enum.ScrollingDirection.Y, Size = UDim2.fromScale(1, 1) })
					I[30] = new("Frame", I[29], "PlayerFrame", { AnchorPoint = Vector2.new(0.5, 0), AutoLocalize = false, AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.3, BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(1, 0) })
						I[31] = new("UICorner", I[30], "UICorner", { BottomLeftRadius = UDim.new(0, 10), BottomRightRadius = UDim.new(0, 10), TopLeftRadius = UDim.new(0, 10), TopRightRadius = UDim.new(0, 10) })
						I[32] = new("CanvasGroup", I[30], "PlayerList", { AnchorPoint = Vector2.new(0.5, 0), AutoLocalize = false, AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(1, 1) })
							I[33] = new("UIListLayout", I[32], "UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder })
							I[34] = new("UICorner", I[32], "UICorner", { BottomLeftRadius = UDim.new(0, 10), BottomRightRadius = UDim.new(0, 10), TopLeftRadius = UDim.new(0, 10), TopRightRadius = UDim.new(0, 10) })
							I[35] = new("Frame", I[32], "Top", { BackgroundColor3 = Color3.fromRGB(30, 30, 30), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = -1, Size = UDim2.fromScale(0.985, 0.125), SizeConstraint = Enum.SizeConstraint.RelativeXX })
								I[36] = new("UIPadding", I[35], "UIPadding", { PaddingLeft = UDim.new(0, 8) })
				I[37] = new("TextButton", I[26], "Top", { AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(30, 30, 30), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = -1, Selectable = false, Size = UDim2.fromScale(1, 0.15), SizeConstraint = Enum.SizeConstraint.RelativeXX, Text = "", ZIndex = 1000 })
					I[38] = new("UIListLayout", I[37], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
					I[39] = new("Folder", I[37], "Folder")
						I[40] = new("Frame", I[39], "Bar", { Active = true, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 1), Selectable = true, Size = UDim2.fromScale(1.5, 0), SizeConstraint = Enum.SizeConstraint.RelativeXX })
							I[41] = new("UIStroke", I[40], "UIStroke", { Color = Color3.fromRGB(80, 80, 80), Transparency = 0.75 })
					I[42] = new("UIPadding", I[37], "UIPadding", { PaddingLeft = UDim.new(0, 8) })
					I[43] = new("Frame", I[37], "PlayerName", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(0.5, 1) })
						I[44] = new("UIListLayout", I[43], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
						I[45] = new("ImageLabel", I[43], "Icon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://17457502427"), LayoutOrder = -1, Size = UDim2.fromScale(0.6, 0.6) }, { ["resize"] = false })
							I[46] = new("UIAspectRatioConstraint", I[45], "UIAspectRatioConstraint")
						I[47] = new("ImageLabel", I[43], "IconSeparator", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = -1, Size = UDim2.fromScale(0.1, 0.1) }, { ["resize"] = false })
							I[48] = new("UIAspectRatioConstraint", I[47], "UIAspectRatioConstraint")
						I[49] = new("TextLabel", I[43], "PlayerName", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(0.5, 1), Text = "People", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 16, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
							I[50] = new("UITextSizeConstraint", I[49], "UITextSizeConstraint", { MaxTextSize = 12, MinTextSize = 5 })
			I[51] = new("UIListLayout", I[2], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Right, Padding = UDim.new(0.005, 0), SortOrder = Enum.SortOrder.LayoutOrder })
			I[52] = new("Folder", I[2], "Folder")
				I[53] = new("TextButton", I[52], "Open", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.3, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(1.085, 0), Size = UDim2.fromScale(0.1, 0.035), TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, Visible = false, ZIndex = 1000 })
					I[54] = new("UICorner", I[53], "UICorner", { BottomLeftRadius = UDim.new(0.2, 0), BottomRightRadius = UDim.new(0.2, 0), TopLeftRadius = UDim.new(0.2, 0), TopRightRadius = UDim.new(0.2, 0) })
					I[55] = new("ImageLabel", I[53], "ImageLabel", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://17452141517"), Position = UDim2.fromScale(0.05, 0.5), Size = UDim2.fromScale(0.6, 0.6) })
						I[56] = new("UIAspectRatioConstraint", I[55], "UIAspectRatioConstraint")
	return I[1]
end

return build
