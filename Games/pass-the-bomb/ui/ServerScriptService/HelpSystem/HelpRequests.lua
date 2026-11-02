-- Generated from ui/ServerScriptService/HelpSystem/HelpRequests.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "HelpRequests", { ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromScale(1, 1) })
			I[3] = new("Frame", I[2], "Buttons", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.004, 0.992), Size = UDim2.fromScale(0.0733187, 0.3712848) })
				I[4] = new("UIListLayout", I[3], "UIListLayout", { Padding = UDim.new(0.05, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Bottom })
				I[5] = new("TextButton", I[3], "Help", { Active = false, AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(40, 40, 40), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.805), Size = UDim2.fromScale(1, 0.111), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextTransparency = 1, TextWrapped = true })
					I[6] = new("UICorner", I[5], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
					I[7] = new("TextButton", I[5], "Button", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(65, 65, 65), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.35), Size = UDim2.fromScale(1, 1), Text = "HELP", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
						I[8] = new("UICorner", I[7], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
						I[9] = new("UIPadding", I[7], "UIPadding", { PaddingBottom = UDim.new(0.175, 0), PaddingLeft = UDim.new(0.175, 0), PaddingRight = UDim.new(0.175, 0), PaddingTop = UDim.new(0.175, 0) })
				I[10] = new("UIAspectRatioConstraint", I[3], "UIAspectRatioConstraint", { AspectRatio = 0.4285714 })
			I[11] = new("Frame", I[2], "Container", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(65, 65, 65), BackgroundTransparency = 1, BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.4649187, 0.5433093), Visible = false })
				I[12] = new("UICorner", I[11], "UICorner", { BottomLeftRadius = UDim.new(0.075, 0), BottomRightRadius = UDim.new(0.075, 0), TopLeftRadius = UDim.new(0.075, 0), TopRightRadius = UDim.new(0.075, 0) })
				I[13] = new("Frame", I[11], "Header", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(46, 46, 46), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.1604023), Size = UDim2.fromScale(1, 0.3226817), ZIndex = 2 })
					I[14] = new("UICorner", I[13], "UICorner", { BottomLeftRadius = UDim.new(0.25, 0), BottomRightRadius = UDim.new(0.25, 0), TopLeftRadius = UDim.new(0.25, 0), TopRightRadius = UDim.new(0.25, 0) })
					I[15] = new("Frame", I[13], "Frame", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(46, 46, 46), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromScale(1, 0.3836666) })
					I[16] = new("TextLabel", I[13], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4523105, 0.3902889), Size = UDim2.fromScale(0.8082717, 0.3297278), Text = "SUBMIT A HELP REQUEST", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextTransparency = 1, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
					I[17] = new("TextLabel", I[13], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4523105, 0.6526917), Size = UDim2.fromScale(0.8082717, 0.2247668), Text = "Need assistance? Submit a request here!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextTransparency = 1, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
				I[18] = new("Frame", I[11], "Screens", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.4999647, 0.6605589), Size = UDim2.fromScale(1.0000705, 0.6776316), ZIndex = 2 })
					I[19] = new("Frame", I[18], "Submission", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9999295, 1) })
						I[20] = new("TextBox", I[19], "TextBox", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(59, 59, 59), BackgroundTransparency = 1, BorderSizePixel = 0, ClearTextOnFocus = false, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), PlaceholderColor3 = Color3.fromRGB(178, 178, 178), PlaceholderText = "Enter your issue here!", Position = UDim2.fromScale(0.5, 0.381), Size = UDim2.fromScale(0.9295121, 0.6105475), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextTransparency = 1, TextWrapped = true })
							I[21] = new("UICorner", I[20], "UICorner", { BottomLeftRadius = UDim.new(0.075, 0), BottomRightRadius = UDim.new(0.075, 0), TopLeftRadius = UDim.new(0.075, 0), TopRightRadius = UDim.new(0.075, 0) })
							I[22] = new("UIPadding", I[20], "UIPadding", { PaddingBottom = UDim.new(0.1, 0), PaddingLeft = UDim.new(0.05, 0), PaddingRight = UDim.new(0.05, 0), PaddingTop = UDim.new(0.1, 0) })
						I[23] = new("TextButton", I[19], "Submit", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(3, 218, 198), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2591367, 0.8484232), Size = UDim2.fromScale(0.4506725, 0.1427254), Text = "SUBMIT", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextTransparency = 1, TextWrapped = true })
							I[24] = new("UICorner", I[23], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
						I[25] = new("TextButton", I[19], "Cancel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(207, 102, 121), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.7379763, 0.8484232), Size = UDim2.fromScale(0.4506725, 0.1427254), Text = "CANCEL", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextTransparency = 1, TextWrapped = true })
							I[26] = new("UICorner", I[25], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
					I[27] = new("Frame", I[18], "Success", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(65, 65, 65), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromScale(0.9999295, 1), ZIndex = 2 })
						I[28] = new("TextButton", I[27], "Cancel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(59, 59, 59), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4992782, 0.8484232), Size = UDim2.fromScale(0.9280685, 0.1427254), Text = "CLOSE", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextTransparency = 1, TextWrapped = true })
							I[29] = new("UICorner", I[28], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
						I[30] = new("TextLabel", I[27], "TextLabel", { Active = true, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(59, 59, 59), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.381), RichText = true, Selectable = true, Size = UDim2.fromScale(0.929512, 0.6105475), Text = "<b><font color='#03dac6'>SUCCESS!</font></b> \nYour help request was successfully submitted. You may now close this menu.", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextTransparency = 1, TextWrapped = true })
							I[31] = new("UICorner", I[30], "UICorner", { BottomLeftRadius = UDim.new(0.075, 0), BottomRightRadius = UDim.new(0.075, 0), TopLeftRadius = UDim.new(0.075, 0), TopRightRadius = UDim.new(0.075, 0) })
							I[32] = new("UIPadding", I[30], "UIPadding", { PaddingBottom = UDim.new(0.1, 0), PaddingLeft = UDim.new(0.05, 0), PaddingRight = UDim.new(0.05, 0), PaddingTop = UDim.new(0.1, 0) })
						I[33] = new("UICorner", I[27], "UICorner", { BottomLeftRadius = UDim.new(0.11, 0), BottomRightRadius = UDim.new(0.11, 0), TopLeftRadius = UDim.new(0.11, 0), TopRightRadius = UDim.new(0.11, 0) })
					I[34] = new("Frame", I[18], "Error", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(65, 65, 65), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromScale(0.9999295, 1), ZIndex = 2 })
						I[35] = new("TextButton", I[34], "Cancel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(59, 59, 59), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4992782, 0.8484232), Size = UDim2.fromScale(0.9280685, 0.1427254), Text = "CLOSE", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextTransparency = 1, TextWrapped = true })
							I[36] = new("UICorner", I[35], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
						I[37] = new("TextLabel", I[34], "TextLabel", { Active = true, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(59, 59, 59), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.381), RichText = true, Selectable = true, Size = UDim2.fromScale(0.929512, 0.6105475), Text = "You are currently on cooldown!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextTransparency = 1, TextWrapped = true })
							I[38] = new("UICorner", I[37], "UICorner", { BottomLeftRadius = UDim.new(0.075, 0), BottomRightRadius = UDim.new(0.075, 0), TopLeftRadius = UDim.new(0.075, 0), TopRightRadius = UDim.new(0.075, 0) })
							I[39] = new("UIPadding", I[37], "UIPadding", { PaddingBottom = UDim.new(0.1, 0), PaddingLeft = UDim.new(0.05, 0), PaddingRight = UDim.new(0.05, 0), PaddingTop = UDim.new(0.1, 0) })
						I[40] = new("UICorner", I[34], "UICorner", { BottomLeftRadius = UDim.new(0.11, 0), BottomRightRadius = UDim.new(0.11, 0), TopLeftRadius = UDim.new(0.11, 0), TopRightRadius = UDim.new(0.11, 0) })
				I[41] = new("UIAspectRatioConstraint", I[11], "UIAspectRatioConstraint", { AspectRatio = 1.8571428 })
		I[42] = new("Folder", I[1], "Modules")
	return I[1]
end

return build
