-- Generated from ui/ServerStorage/DisabledOldAdminSystem/StarterGui/Commands.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Commands", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 0.85) }, { ["DisabledFrom"] = "StarterGui.CrossPlatform.CreatorWindow.Commands" })
		I[2] = new("ScrollingFrame", I[1], "List", { Active = true, AutomaticCanvasSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, CanvasSize = UDim2.fromScale(0, 0), LayoutOrder = 2, ScrollBarImageColor3 = Color3.fromRGB(145, 145, 145), ScrollingDirection = Enum.ScrollingDirection.Y, Size = UDim2.fromScale(1, 1), VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar })
			I[3] = new("UIListLayout", I[2], "UIListLayout", { Padding = UDim.new(0, 5), SortOrder = Enum.SortOrder.LayoutOrder })
			I[4] = new("UIPadding", I[2], "UIPadding", { PaddingBottom = UDim.new(0, 5), PaddingLeft = UDim.new(0, 5), PaddingRight = UDim.new(0, 5), PaddingTop = UDim.new(0, 5) })
			I[5] = new("Frame", I[2], "MurdererCommand", { AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(67, 67, 67), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 1, Size = UDim2.new(1, 0, 0, 30) })
				I[6] = new("TextLabel", I[5], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.new(1, 0, 0, 26), Text = "/murderer [PlayerName]", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
					I[7] = new("UIStroke", I[6], "UIStroke")
				I[8] = new("UIPadding", I[5], "UIPadding", { PaddingBottom = UDim.new(0, 3), PaddingLeft = UDim.new(0, 6), PaddingRight = UDim.new(0, 6), PaddingTop = UDim.new(0, 3) })
				I[9] = new("UIListLayout", I[5], "UIListLayout", { Padding = UDim.new(0, 3), SortOrder = Enum.SortOrder.LayoutOrder })
				I[10] = new("TextLabel", I[5], "Description", { AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 2, Size = UDim2.new(1, 0, 0, 18), Text = "[PlayerName] will become murderer next round.", TextColor3 = Color3.fromRGB(152, 152, 152), TextSize = 18, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
					I[11] = new("UIStroke", I[10], "UIStroke", { Transparency = 0.5 })
			I[12] = new("Frame", I[2], "SheriffCommand", { AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(67, 67, 67), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 1, Size = UDim2.new(1, 0, 0, 30) })
				I[13] = new("TextLabel", I[12], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.new(1, 0, 0, 26), Text = "/sheriff [PlayerName]", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
					I[14] = new("UIStroke", I[13], "UIStroke")
					I[15] = new("TextLabel", I[13], "PrivateServer", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "Private Servers Only", TextColor3 = Color3.fromRGB(138, 138, 138), TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, Visible = false })
				I[16] = new("UIPadding", I[12], "UIPadding", { PaddingBottom = UDim.new(0, 3), PaddingLeft = UDim.new(0, 6), PaddingRight = UDim.new(0, 6), PaddingTop = UDim.new(0, 3) })
				I[17] = new("UIListLayout", I[12], "UIListLayout", { Padding = UDim.new(0, 3), SortOrder = Enum.SortOrder.LayoutOrder })
				I[18] = new("TextLabel", I[12], "Description", { AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 2, Size = UDim2.new(1, 0, 0, 18), Text = "[PlayerName] will become sheriff next round.", TextColor3 = Color3.fromRGB(152, 152, 152), TextSize = 18, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
					I[19] = new("UIStroke", I[18], "UIStroke", { Transparency = 0.5 })
			I[20] = new("Frame", I[2], "MapCommand", { AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(67, 67, 67), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 1, Size = UDim2.new(1, 0, 0, 30) })
				I[21] = new("TextLabel", I[20], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.new(1, 0, 0, 26), Text = "/map [MapName]", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
					I[22] = new("UIStroke", I[21], "UIStroke")
				I[23] = new("UIPadding", I[20], "UIPadding", { PaddingBottom = UDim.new(0, 3), PaddingLeft = UDim.new(0, 6), PaddingRight = UDim.new(0, 6), PaddingTop = UDim.new(0, 3) })
				I[24] = new("UIListLayout", I[20], "UIListLayout", { Padding = UDim.new(0, 3), SortOrder = Enum.SortOrder.LayoutOrder })
				I[25] = new("TextLabel", I[20], "Description", { AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 2, Size = UDim2.new(1, 0, 0, 18), Text = "[MapName] will be set as the server's map until removed.", TextColor3 = Color3.fromRGB(152, 152, 152), TextSize = 18, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
					I[26] = new("UIStroke", I[25], "UIStroke", { Transparency = 0.5 })
			I[27] = new("Frame", I[2], "TrapCommand", { AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(67, 67, 67), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 1, Size = UDim2.new(1, 0, 0, 30) })
				I[28] = new("TextLabel", I[27], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.new(1, 0, 0, 26), Text = "/trapinfinite", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
					I[29] = new("UIStroke", I[28], "UIStroke")
				I[30] = new("UIPadding", I[27], "UIPadding", { PaddingBottom = UDim.new(0, 3), PaddingLeft = UDim.new(0, 6), PaddingRight = UDim.new(0, 6), PaddingTop = UDim.new(0, 3) })
				I[31] = new("UIListLayout", I[27], "UIListLayout", { Padding = UDim.new(0, 3), SortOrder = Enum.SortOrder.LayoutOrder })
				I[32] = new("TextLabel", I[27], "Description", { AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 2, Size = UDim2.new(1, 0, 0, 18), Text = "Toggle that allows you to place infinite traps", TextColor3 = Color3.fromRGB(152, 152, 152), TextSize = 18, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
					I[33] = new("UIStroke", I[32], "UIStroke", { Transparency = 0.5 })
			I[34] = new("Frame", I[2], "GhostCommand", { AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(67, 67, 67), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 1, Size = UDim2.new(1, 0, 0, 30) })
				I[35] = new("TextLabel", I[34], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.new(1, 0, 0, 26), Text = "/ghostinfinite", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
					I[36] = new("UIStroke", I[35], "UIStroke")
				I[37] = new("UIPadding", I[34], "UIPadding", { PaddingBottom = UDim.new(0, 3), PaddingLeft = UDim.new(0, 6), PaddingRight = UDim.new(0, 6), PaddingTop = UDim.new(0, 3) })
				I[38] = new("UIListLayout", I[34], "UIListLayout", { Padding = UDim.new(0, 3), SortOrder = Enum.SortOrder.LayoutOrder })
				I[39] = new("TextLabel", I[34], "Description", { AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 2, Size = UDim2.new(1, 0, 0, 18), Text = "Toggle that allows you to stay invisible with the ghost perk infinitely", TextColor3 = Color3.fromRGB(152, 152, 152), TextSize = 18, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
					I[40] = new("UIStroke", I[39], "UIStroke", { Transparency = 0.5 })
		I[41] = new("UIPadding", I[1], "UIPadding", { PaddingBottom = UDim.new(0, 5) })
	return I[1]
end

return build
