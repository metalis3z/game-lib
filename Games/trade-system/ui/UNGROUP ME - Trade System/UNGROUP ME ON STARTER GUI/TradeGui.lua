-- Generated from ui/UNGROUP ME - Trade System/UNGROUP ME ON STARTER GUI/TradeGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "TradeGui", { DisplayOrder = 25, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets })
		I[2] = new("ImageButton", I[1], "OpenTradeButton", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(30, 30, 40), ImageContent = Content.fromUri("rbxassetid://0"), Position = UDim2.new(0, 20, 1, -240), Size = UDim2.fromOffset(90, 90) })
			I[3] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0, 16), BottomRightRadius = UDim.new(0, 16), TopLeftRadius = UDim.new(0, 16), TopRightRadius = UDim.new(0, 16) })
			I[4] = new("TextLabel", I[2], "Label", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0, 0, 1, -22), Size = UDim2.fromScale(1, 0.3), Text = "Trade", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true })
		I[5] = new("Frame", I[1], "SearchFrame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(24, 24, 32), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(420, 520), Visible = false })
			I[6] = new("UICorner", I[5], "UICorner", { BottomLeftRadius = UDim.new(0, 16), BottomRightRadius = UDim.new(0, 16), TopLeftRadius = UDim.new(0, 16), TopRightRadius = UDim.new(0, 16) })
			I[7] = new("UIStroke", I[5], "UIStroke", { Color = Color3.fromRGB(90, 200, 255), Thickness = 2 })
			I[8] = new("TextLabel", I[5], "Title", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(20, 10), Size = UDim2.new(1, -60, 0, 50), Text = "Search Player", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
			I[9] = new("TextButton", I[5], "CloseButton", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(200, 50, 50), FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(1, -14, 0, 14), Size = UDim2.fromOffset(36, 36), Text = "X", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true })
				I[10] = new("UICorner", I[9], "UICorner")
			I[11] = new("TextBox", I[5], "SearchBox", { BackgroundColor3 = Color3.fromRGB(40, 40, 52), ClearTextOnFocus = false, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), PlaceholderText = "User Name here", Position = UDim2.fromOffset(20, 70), Size = UDim2.new(1, -40, 0, 46), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true })
				I[12] = new("UICorner", I[11], "UICorner", { BottomLeftRadius = UDim.new(0, 10), BottomRightRadius = UDim.new(0, 10), TopLeftRadius = UDim.new(0, 10), TopRightRadius = UDim.new(0, 10) })
				I[13] = new("UIPadding", I[11], "UIPadding", { PaddingLeft = UDim.new(0, 12), PaddingRight = UDim.new(0, 12) })
			I[14] = new("ScrollingFrame", I[5], "ResultsList", { AutomaticCanvasSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(18, 18, 24), BorderSizePixel = 0, CanvasSize = UDim2.fromScale(0, 0), Position = UDim2.fromOffset(20, 128), ScrollBarThickness = 6, Size = UDim2.new(1, -40, 1, -148) })
				I[15] = new("UICorner", I[14], "UICorner", { BottomLeftRadius = UDim.new(0, 10), BottomRightRadius = UDim.new(0, 10), TopLeftRadius = UDim.new(0, 10), TopRightRadius = UDim.new(0, 10) })
				I[16] = new("UIListLayout", I[14], "UIListLayout", { Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder })
				I[17] = new("UIPadding", I[14], "UIPadding", { PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8), PaddingTop = UDim.new(0, 8) })
				I[18] = new("Frame", I[14], "PlayerRowTemplate", { BackgroundColor3 = Color3.fromRGB(32, 32, 42), Size = UDim2.new(1, 0, 0, 56), Visible = false })
					I[19] = new("UICorner", I[18], "UICorner")
					I[20] = new("Frame", I[18], "OnlineDot", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(80, 220, 100), Position = UDim2.new(0, 12, 0.5, 0), Size = UDim2.fromOffset(14, 14) })
						I[21] = new("UICorner", I[20], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
					I[22] = new("TextLabel", I[18], "NameLabel", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(36, 0), Size = UDim2.new(1, -140, 1, 0), Text = "PlayerName", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
						I[23] = new("UITextSizeConstraint", I[22], "UITextSizeConstraint", { MaxTextSize = 20 })
					I[24] = new("TextButton", I[18], "SendTradeButton", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(80, 170, 255), FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(1, -10, 0.5, 0), Size = UDim2.fromOffset(92, 40), Text = "Trade", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true })
						I[25] = new("UICorner", I[24], "UICorner")
				I[26] = new("TextLabel", I[14], "EmptyLabel", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = -1, Position = UDim2.fromOffset(8, 8), Size = UDim2.new(1, -16, 0, 60), Text = "No hay otros jugadores en este servidor", TextColor3 = Color3.fromRGB(160, 160, 170), TextScaled = true, TextWrapped = true, Visible = false })
		I[27] = new("Frame", I[1], "RequestPopup", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(24, 24, 32), Position = UDim2.fromScale(0.5, 0.08), Size = UDim2.fromOffset(380, 120), Visible = false })
			I[28] = new("UICorner", I[27], "UICorner", { BottomLeftRadius = UDim.new(0, 14), BottomRightRadius = UDim.new(0, 14), TopLeftRadius = UDim.new(0, 14), TopRightRadius = UDim.new(0, 14) })
			I[29] = new("UIStroke", I[27], "UIStroke", { Color = Color3.fromRGB(255, 210, 60), Thickness = 2 })
			I[30] = new("TextLabel", I[27], "MessageLabel", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(14, 10), Size = UDim2.new(1, -28, 0, 50), Text = "PlayerName Have trade whith you", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true })
			I[31] = new("TextButton", I[27], "AcceptButton", { BackgroundColor3 = Color3.fromRGB(70, 200, 100), FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0, 14, 1, -46), Size = UDim2.new(0.5, -21, 0, 36), Text = "Accept", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true })
				I[32] = new("UICorner", I[31], "UICorner")
			I[33] = new("TextButton", I[27], "DeclineButton", { BackgroundColor3 = Color3.fromRGB(200, 60, 60), FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0.5, 7, 1, -46), Size = UDim2.new(0.5, -21, 0, 36), Text = "Decline", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true })
				I[34] = new("UICorner", I[33], "UICorner")
		I[35] = new("Frame", I[1], "TradeWindow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(22, 22, 30), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(900, 560), Visible = false })
			I[36] = new("UICorner", I[35], "UICorner", { BottomLeftRadius = UDim.new(0, 16), BottomRightRadius = UDim.new(0, 16), TopLeftRadius = UDim.new(0, 16), TopRightRadius = UDim.new(0, 16) })
			I[37] = new("UIStroke", I[35], "UIStroke", { Color = Color3.fromRGB(120, 190, 255), Thickness = 2 })
			I[38] = new("TextLabel", I[35], "TitleLabel", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(24, 12), Size = UDim2.new(1, -80, 0, 34), Text = "Trading with: PlayerName", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
			I[39] = new("TextButton", I[35], "CloseButton", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(200, 50, 50), FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(1, -14, 0, 12), Size = UDim2.fromOffset(36, 36), Text = "X", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true })
				I[40] = new("UICorner", I[39], "UICorner")
			I[41] = new("Frame", I[35], "YourOfferPanel", { BackgroundColor3 = Color3.fromRGB(30, 30, 40), Position = UDim2.new(0.01, 0, 0, 56), Size = UDim2.new(0.32, -12, 0, 220) })
				I[42] = new("UICorner", I[41], "UICorner", { BottomLeftRadius = UDim.new(0, 10), BottomRightRadius = UDim.new(0, 10), TopLeftRadius = UDim.new(0, 10), TopRightRadius = UDim.new(0, 10) })
				I[43] = new("TextLabel", I[41], "PanelTitle", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(10, 6), Size = UDim2.new(1, -20, 0, 26), Text = "Your Offer", TextColor3 = Color3.fromRGB(120, 220, 140), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
				I[44] = new("ScrollingFrame", I[41], "ItemsGrid", { AutomaticCanvasSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(18, 18, 24), BorderSizePixel = 0, CanvasSize = UDim2.fromScale(0, 0), Position = UDim2.fromOffset(8, 36), ScrollBarThickness = 5, Size = UDim2.new(1, -16, 1, -44) })
					I[45] = new("UICorner", I[44], "UICorner")
					I[46] = new("UIGridLayout", I[44], "UIGridLayout", { CellPadding = UDim2.fromOffset(6, 6), CellSize = UDim2.fromOffset(60, 60), SortOrder = Enum.SortOrder.LayoutOrder })
					I[47] = new("UIPadding", I[44], "UIPadding", { PaddingLeft = UDim.new(0, 6), PaddingTop = UDim.new(0, 6) })
			I[48] = new("Frame", I[35], "TheirOfferPanel", { BackgroundColor3 = Color3.fromRGB(30, 30, 40), Position = UDim2.new(0.345, 0, 0, 56), Size = UDim2.new(0.32, -12, 0, 220) })
				I[49] = new("UICorner", I[48], "UICorner", { BottomLeftRadius = UDim.new(0, 10), BottomRightRadius = UDim.new(0, 10), TopLeftRadius = UDim.new(0, 10), TopRightRadius = UDim.new(0, 10) })
				I[50] = new("TextLabel", I[48], "PanelTitle", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(10, 6), Size = UDim2.new(1, -20, 0, 26), Text = "their offer", TextColor3 = Color3.fromRGB(255, 180, 100), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
				I[51] = new("ScrollingFrame", I[48], "ItemsGrid", { AutomaticCanvasSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(18, 18, 24), BorderSizePixel = 0, CanvasSize = UDim2.fromScale(0, 0), Position = UDim2.fromOffset(8, 36), ScrollBarThickness = 5, Size = UDim2.new(1, -16, 1, -44) })
					I[52] = new("UICorner", I[51], "UICorner")
					I[53] = new("UIGridLayout", I[51], "UIGridLayout", { CellPadding = UDim2.fromOffset(6, 6), CellSize = UDim2.fromOffset(60, 60), SortOrder = Enum.SortOrder.LayoutOrder })
					I[54] = new("UIPadding", I[51], "UIPadding", { PaddingLeft = UDim.new(0, 6), PaddingTop = UDim.new(0, 6) })
			I[55] = new("Frame", I[35], "StatusPanel", { BackgroundColor3 = Color3.fromRGB(30, 30, 40), Position = UDim2.new(0.68, 0, 0, 56), Size = UDim2.new(0.32, 0, 0, 220) })
				I[56] = new("UICorner", I[55], "UICorner", { BottomLeftRadius = UDim.new(0, 10), BottomRightRadius = UDim.new(0, 10), TopLeftRadius = UDim.new(0, 10), TopRightRadius = UDim.new(0, 10) })
				I[57] = new("TextLabel", I[55], "StatusLabel", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromOffset(10, 10), Size = UDim2.new(1, -20, 0, 80), Text = "Waiting...", TextColor3 = Color3.fromRGB(220, 220, 220), TextScaled = true, TextWrapped = true })
				I[58] = new("TextButton", I[55], "ReadyButton", { BackgroundColor3 = Color3.fromRGB(70, 200, 100), FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0, 10, 1, -100), Size = UDim2.new(1, -20, 0, 42), Text = "READY", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true })
					I[59] = new("UICorner", I[58], "UICorner")
				I[60] = new("TextButton", I[55], "CancelButton", { BackgroundColor3 = Color3.fromRGB(200, 60, 60), FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0, 10, 1, -50), Size = UDim2.new(1, -20, 0, 42), Text = "CANCEL", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true })
					I[61] = new("UICorner", I[60], "UICorner")
			I[62] = new("Frame", I[35], "InventoryPanel", { BackgroundColor3 = Color3.fromRGB(30, 30, 40), Position = UDim2.new(0.01, 0, 0, 288), Size = UDim2.new(0.98, 0, 1, -300) })
				I[63] = new("UICorner", I[62], "UICorner", { BottomLeftRadius = UDim.new(0, 10), BottomRightRadius = UDim.new(0, 10), TopLeftRadius = UDim.new(0, 10), TopRightRadius = UDim.new(0, 10) })
				I[64] = new("TextLabel", I[62], "PanelTitle", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(10, 6), Size = UDim2.new(1, -20, 0, 26), Text = "Your inventory (click to add to the offer)", TextColor3 = Color3.fromRGB(200, 200, 255), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
				I[65] = new("ScrollingFrame", I[62], "ItemsGrid", { AutomaticCanvasSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(18, 18, 24), BorderSizePixel = 0, CanvasSize = UDim2.fromScale(0, 0), Position = UDim2.fromOffset(8, 36), ScrollBarThickness = 6, Size = UDim2.new(1, -16, 1, -44) })
					I[66] = new("UICorner", I[65], "UICorner")
					I[67] = new("UIGridLayout", I[65], "UIGridLayout", { CellPadding = UDim2.fromOffset(6, 6), CellSize = UDim2.fromOffset(64, 64), SortOrder = Enum.SortOrder.LayoutOrder })
					I[68] = new("UIPadding", I[65], "UIPadding", { PaddingLeft = UDim.new(0, 6), PaddingTop = UDim.new(0, 6) })
		I[69] = new("Folder", I[1], "Templates")
			I[70] = new("ImageButton", I[69], "ItemSlotTemplate", { BackgroundColor3 = Color3.fromRGB(40, 40, 52), Size = UDim2.fromOffset(60, 60), Visible = false })
				I[71] = new("UICorner", I[70], "UICorner")
				I[72] = new("UIStroke", I[70], "RarityStroke", { Color = Color3.fromRGB(150, 150, 150), Thickness = 2 })
				I[73] = new("ImageLabel", I[70], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.8, 0.8) })
				I[74] = new("TextLabel", I[70], "CountLabel", { AnchorPoint = Vector2.new(1, 1), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.3, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(1, -2, 1, -2), Size = UDim2.fromOffset(26, 18), Text = "x1", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true })
					I[75] = new("UICorner", I[74], "UICorner", { BottomLeftRadius = UDim.new(0, 4), BottomRightRadius = UDim.new(0, 4), TopLeftRadius = UDim.new(0, 4), TopRightRadius = UDim.new(0, 4) })
	return I[1]
end

return build
