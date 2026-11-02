-- Generated from ui/StarterGui/Friend_Notification.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Friend_Notification", { ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.98, 0.1741128), Size = UDim2.fromScale(0.1295014, 0.6758872), Visible = false })
			I[3] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint")
			I[4] = new("UIListLayout", I[2], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Right, Padding = UDim.new(0.1, 0), SortOrder = Enum.SortOrder.LayoutOrder })
			I[5] = new("Frame", I[2], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1.571, 0.963) })
				I[6] = new("ImageLabel", I[5], "Background", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://118094190966237"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1) })
					I[7] = new("Frame", I[6], "Holder", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
						I[8] = new("Frame", I[7], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.4999999, 0.7377774), Size = UDim2.fromScale(1, 0.22), ZIndex = 100 })
							I[9] = new("UIListLayout", I[8], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.025, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
							I[10] = new("ImageButton", I[8], "Decline", { BackgroundColor3 = Color3.fromRGB(255, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.6880384, 0.1147728), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.444, 1) })
								I[11] = new("Frame", I[10], "Hover_Effect", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Visible = false })
									I[12] = new("ImageLabel", I[11], "0_0", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=78700452711905"), ImageTransparency = 1, Position = UDim2.fromScale(0, 0.992551), Size = UDim2.fromScale(0.297701, 0.4190345), ZIndex = 11 })
										I[13] = new("UIAspectRatioConstraint", I[12], "UIAspectRatioConstraint")
									I[14] = new("ImageLabel", I[11], "0_1", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=99240183652324"), ImageTransparency = 1, Position = UDim2.fromScale(0, 0.416004), Size = UDim2.fromScale(0.297701, 0.4190345), ZIndex = 11 })
										I[15] = new("UIAspectRatioConstraint", I[14], "UIAspectRatioConstraint")
									I[16] = new("ImageLabel", I[11], "1_0", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=90260459849924"), ImageTransparency = 1, Position = UDim2.fromScale(0.9, 0.992551), Size = UDim2.fromScale(0.297701, 0.4190345), ZIndex = 11 })
										I[17] = new("UIAspectRatioConstraint", I[16], "UIAspectRatioConstraint")
									I[18] = new("ImageLabel", I[11], "1_1", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=116303632731499"), ImageTransparency = 1, Position = UDim2.fromScale(0.9, 0.416004), Size = UDim2.fromScale(0.297701, 0.4190345), ZIndex = 11 })
										I[19] = new("UIAspectRatioConstraint", I[18], "UIAspectRatioConstraint")
								I[20] = new("TextLabel", I[10], "Description", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = -1, Position = UDim2.fromScale(0.5, 0.5), RichText = true, Size = UDim2.fromScale(0.9, 0.75), Text = "Decline", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 11 })
									I[21] = new("UIPadding", I[20], "UIPadding", { PaddingLeft = UDim.new(0.05, 0), PaddingRight = UDim.new(0.05, 0) })
									I[22] = new("UIStroke", I[20], "UIStroke", { Color = Color3.fromRGB(80, 0, 0), Thickness = 2 })
								I[23] = new("UIStroke", I[10], "UIStroke", { Color = Color3.fromRGB(115, 0, 0), Thickness = 1.8 })
								I[24] = new("UICorner", I[10], "UICorner", { BottomLeftRadius = UDim.new(0.4, 0), BottomRightRadius = UDim.new(0.4, 0), TopLeftRadius = UDim.new(0.4, 0), TopRightRadius = UDim.new(0.4, 0) })
							I[25] = new("ImageButton", I[8], "Accept", { BackgroundColor3 = Color3.fromRGB(17, 255, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.6880384, 0.1147728), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.444, 1) })
								I[26] = new("UIStroke", I[25], "UIStroke", { Color = Color3.fromRGB(25, 115, 0), Thickness = 1.8 })
								I[27] = new("Frame", I[25], "Hover_Effect", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Visible = false })
									I[28] = new("ImageLabel", I[27], "0_0", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=78700452711905"), ImageTransparency = 1, Position = UDim2.fromScale(0, 0.992551), Size = UDim2.fromScale(0.297701, 0.4190345), ZIndex = 11 })
										I[29] = new("UIAspectRatioConstraint", I[28], "UIAspectRatioConstraint")
									I[30] = new("ImageLabel", I[27], "0_1", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=99240183652324"), ImageTransparency = 1, Position = UDim2.fromScale(0, 0.416004), Size = UDim2.fromScale(0.297701, 0.4190345), ZIndex = 11 })
										I[31] = new("UIAspectRatioConstraint", I[30], "UIAspectRatioConstraint")
									I[32] = new("ImageLabel", I[27], "1_0", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=90260459849924"), ImageTransparency = 1, Position = UDim2.fromScale(0.9, 0.992551), Size = UDim2.fromScale(0.297701, 0.4190345), ZIndex = 11 })
										I[33] = new("UIAspectRatioConstraint", I[32], "UIAspectRatioConstraint")
									I[34] = new("ImageLabel", I[27], "1_1", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=116303632731499"), ImageTransparency = 1, Position = UDim2.fromScale(0.9, 0.416004), Size = UDim2.fromScale(0.297701, 0.4190345), ZIndex = 11 })
										I[35] = new("UIAspectRatioConstraint", I[34], "UIAspectRatioConstraint")
								I[36] = new("TextLabel", I[25], "Description", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = -1, Position = UDim2.fromScale(0.5, 0.5), RichText = true, Size = UDim2.fromScale(0.9, 0.75), Text = "Accept", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 11 })
									I[37] = new("UIPadding", I[36], "UIPadding", { PaddingLeft = UDim.new(0.05, 0), PaddingRight = UDim.new(0.05, 0) })
									I[38] = new("UIStroke", I[36], "UIStroke", { Color = Color3.fromRGB(0, 85, 0), Thickness = 2 })
								I[39] = new("UICorner", I[25], "UICorner", { BottomLeftRadius = UDim.new(0.4, 0), BottomRightRadius = UDim.new(0.4, 0), TopLeftRadius = UDim.new(0.4, 0), TopRightRadius = UDim.new(0.4, 0) })
						I[40] = new("Frame", I[7], "Notification_UI", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = -3, Position = UDim2.fromScale(0.5, 0.125), Size = UDim2.fromScale(1, 0.25), ZIndex = 100 })
							I[41] = new("TextLabel", I[40], "TitleTabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), LayoutOrder = 3, Position = UDim2.fromScale(0.5, 0.85), RichText = true, Size = UDim2.fromScale(0.969, 0.7), Text = "Accept new friend?", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 3 })
								I[42] = new("UIStroke", I[41], "UIStroke", { Thickness = 1.5 })
							I[43] = new("NumberValue", I[40], "VAL_OBJ", { Value = 1 })
							I[44] = new("UIScale", I[40], "UIScale")
						I[45] = new("TextLabel", I[7], "BodyLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 3, Position = UDim2.fromScale(0.5, 0.4615825), RichText = true, Size = UDim2.fromScale(0.946, 0.3), Text = "Friend request from\nUserName", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 15, TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 50 })
							I[46] = new("UIStroke", I[45], "UIStroke", { Color = Color3.fromRGB(36, 36, 36), Thickness = 2 })
		I[47] = new("BoolValue", I[1], "Show_VAL")
	return I[1]
end

return build
