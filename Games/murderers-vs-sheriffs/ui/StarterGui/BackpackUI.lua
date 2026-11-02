-- Generated from ui/StarterGui/BackpackUI.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "BackpackUI", { ClipToDeviceSafeArea = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("InputContext", I[1], "BackpackInputContext")
			I[3] = new("InputAction", I[2], "Item1")
				I[4] = new("InputBinding", I[3], "InputBinding", { KeyCode = Enum.KeyCode.One })
			I[5] = new("InputAction", I[2], "Item2")
				I[6] = new("InputBinding", I[5], "InputBinding", { KeyCode = Enum.KeyCode.Two })
			I[7] = new("InputAction", I[2], "Item3")
				I[8] = new("InputBinding", I[7], "InputBinding", { KeyCode = Enum.KeyCode.Three })
			I[9] = new("InputAction", I[2], "Item4")
				I[10] = new("InputBinding", I[9], "InputBinding", { KeyCode = Enum.KeyCode.Four })
			I[11] = new("InputAction", I[2], "Item5")
				I[12] = new("InputBinding", I[11], "InputBinding", { KeyCode = Enum.KeyCode.Five })
			I[13] = new("InputAction", I[2], "Item6")
				I[14] = new("InputBinding", I[13], "InputBinding", { KeyCode = Enum.KeyCode.Six })
			I[15] = new("InputAction", I[2], "Item7")
				I[16] = new("InputBinding", I[15], "InputBinding", { KeyCode = Enum.KeyCode.Seven })
			I[17] = new("InputAction", I[2], "Item8")
				I[18] = new("InputBinding", I[17], "InputBinding", { KeyCode = Enum.KeyCode.Eight })
			I[19] = new("InputAction", I[2], "Item9")
				I[20] = new("InputBinding", I[19], "InputBinding", { KeyCode = Enum.KeyCode.Nine })
			I[21] = new("InputAction", I[2], "Item10")
				I[22] = new("InputBinding", I[21], "InputBinding", { KeyCode = Enum.KeyCode.Zero })
			I[23] = new("InputAction", I[2], "GamepadRight")
				I[24] = new("InputBinding", I[23], "InputBinding", { KeyCode = Enum.KeyCode.ButtonR1 })
			I[25] = new("InputAction", I[2], "GamepadLeft")
				I[26] = new("InputBinding", I[25], "InputBinding", { KeyCode = Enum.KeyCode.ButtonL1 })
			I[27] = new("InputAction", I[2], "GamepadUnequip")
				I[28] = new("InputBinding", I[27], "InputBinding", { KeyCode = Enum.KeyCode.ButtonB })
		I[29] = new("Frame", I[1], "BackpackFrame", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 1), Size = UDim2.new(645, 0, 0, 70), ZIndex = 10 })
			I[30] = new("UIPadding", I[29], "UIPadding", { PaddingBottom = UDim.new(0, 5), PaddingTop = UDim.new(0, 5) })
			I[31] = new("Frame", I[29], "BackpackItem", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.6, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) })
				I[32] = new("Frame", I[31], "Container", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) })
					I[33] = new("TextLabel", I[32], "Hotkey", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromOffset(18, 18), Text = "1", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, ZIndex = 3 })
					I[34] = new("TextLabel", I[32], "NameLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "Tool", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14, TextWrapped = true, ZIndex = 2 })
					I[35] = new("UIPadding", I[32], "UIPadding", { PaddingBottom = UDim.new(0, 3), PaddingLeft = UDim.new(0, 3), PaddingRight = UDim.new(0, 3), PaddingTop = UDim.new(0, 3) })
					I[36] = new("ImageLabel", I[32], "ToolIcon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://100333266623821"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, -5, 1, -5) })
						I[37] = new("UIAspectRatioConstraint", I[36], "UIAspectRatioConstraint")
				I[38] = new("Frame", I[31], "Equipped", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, -10, 1, -10), Visible = false })
					I[39] = new("UIStroke", I[38], "UIStroke", { Color = Color3.fromRGB(90, 142, 233), LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 5 })
				I[40] = new("UIAspectRatioConstraint", I[31], "UIAspectRatioConstraint")
				I[41] = new("ImageButton", I[31], "EquipButton", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = 10 })
			I[42] = new("UIListLayout", I[29], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 5), SortOrder = Enum.SortOrder.LayoutOrder })
		I[43] = new("Frame", I[1], "Mobile", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(0, 170, 255), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.new(0.5, 0, 1, -5), Size = UDim2.fromOffset(191, 60), Visible = false })
		I[44] = new("Frame", I[1], "Top", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.new(0.5, 0, 1, -75), Size = UDim2.fromOffset(100, 25), Visible = false })
			I[45] = new("UICorner", I[44], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
		I[46] = new("Frame", I[1], "Desktop", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(0, 255, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.new(0.5, 0, 1, -5), Size = UDim2.fromOffset(645, 60), Visible = false })
	return I[1]
end

return build
