-- Generated from ui/ReplicatedStorage/ReplicatedGui/BackroomsSpeedUpgrade.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "BackroomsSpeedUpgrade", { ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["ViralWorkerRef"] = "vw_aaedb6d577" }, { "ScreenGui" })
		I[2] = new("Frame", I[1], "BackroomsSpeedUpgrade", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.4480469, 0.5368568), Visible = false, ZIndex = 2 }, { ["ViralWorkerRef"] = "vw_198210f868" })
			I[3] = new("ImageLabel", I[2], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(51, 66, 73), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://76660575181533"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), ZIndex = -1 }, { ["ViralWorkerRef"] = "vw_75d799f903" })
				I[4] = new("UIGradient", I[3], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(51, 66, 73)), ColorSequenceKeypoint.new(1, Color3.fromRGB(51, 66, 73)) }), Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.3), NumberSequenceKeypoint.new(1, 0.3) }) }, { ["ViralWorkerRef"] = "vw_fd969c557d" })
			I[5] = new("Frame", I[2], "Header", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.0012953), Size = UDim2.fromScale(0.9982563, 0.1476684) }, { ["ViralWorkerRef"] = "vw_6dae1bc34e" })
				I[6] = new("ImageButton", I[5], "Close", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, HoverImageContent = Content.fromUri("rbxassetid://137110183435251"), ImageContent = Content.fromUri("rbxassetid://105016554772347"), Position = UDim2.fromScale(0.9502183, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.0873362, 0.877193) }, { ["ViralWorkerRef"] = "vw_c843a811e7" })
					I[7] = new("TextLabel", I[6], "Txt", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 0.56), Text = "X", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["ViralWorkerRef"] = "vw_df35dae5bb" })
						I[8] = new("UIStroke", I[7], "UIStroke", { Thickness = 3 }, { ["ViralWorkerRef"] = "vw_a016965843" })
						I[9] = new("UIPadding", I[7], "UIPadding", { PaddingLeft = UDim.new(0.01, 0), PaddingRight = UDim.new(-0.03, 0) }, { ["ViralWorkerRef"] = "vw_f18100687f" })
				I[10] = new("Frame", I[5], "Txts", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.0218341, 0.5), Size = UDim2.fromScale(0.5, 1) }, { ["ViralWorkerRef"] = "vw_5e80e11fc5" })
					I[11] = new("TextLabel", I[10], "Txt1", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(1.4579537, 0.7986092), Size = UDim2.fromScale(1, 0.7), Text = "Speed Upgrades", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left }, { ["ViralWorkerRef"] = "vw_9f81fa453e" })
						I[12] = new("UIStroke", I[11], "UIStroke", { Thickness = 4 }, { ["ViralWorkerRef"] = "vw_1e25e8d2cb" })
					I[13] = new("UIListLayout", I[10], "UIListLayout", { Padding = UDim.new(0.0350877, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center }, { ["ViralWorkerRef"] = "vw_dff6b0fbc2" })
				I[14] = new("ImageLabel", I[5], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://137573329562191"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), ZIndex = 0 }, { ["ViralWorkerRef"] = "vw_fe98499f84" })
					I[15] = new("UIGradient", I[14], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(85, 112, 127)), ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 112, 127)) }) }, { ["ViralWorkerRef"] = "vw_105199eebf" })
			I[16] = new("Frame", I[2], "Content", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromScale(1, 0.8523316) }, { ["ViralWorkerRef"] = "vw_d3c88985d6" })
				I[17] = new("Frame", I[16], "List", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.8, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.4976751, 0.0055721), Size = UDim2.fromScale(0.9825632, 0.9832829), ZIndex = -1 }, { ["ViralWorkerRef"] = "vw_0a536416f5" })
					I[18] = new("Frame", I[17], "Template", { BackgroundColor3 = Color3.fromRGB(35, 45, 50), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.025, 0), Size = UDim2.fromScale(0.9500001, 0.29956), Visible = false }, { ["ViralWorkerRef"] = "vw_47e6411e61" })
						I[19] = new("ImageLabel", I[18], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageTransparency = 0.21, LayoutOrder = 1, Position = UDim2.fromScale(0.4987811, 0.5005133), Size = UDim2.fromScale(0.9953832, 0.9516516) }, { ["ViralWorkerRef"] = "vw_d38104c5a5" })
							I[20] = new("TextLabel", I[19], "Label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.4804501, 0.1748218), Size = UDim2.fromScale(0.514, 0.27), Text = "+1 Speed", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["ViralWorkerRef"] = "vw_119f8b895a" })
								I[21] = new("UIStroke", I[20], "UIStroke", { Thickness = 3 }, { ["ViralWorkerRef"] = "vw_ab790cbd5b" })
							I[22] = new("TextLabel", I[19], "TargetAmount", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.5938225, 0.606482), RichText = true, Size = UDim2.fromScale(0.1332746, 0.4234076), Text = "104", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right }, { ["ViralWorkerRef"] = "vw_f4e12139af" })
								I[23] = new("UIStroke", I[22], "UIStroke", { Thickness = 3 }, { ["ViralWorkerRef"] = "vw_f10b1e302b" })
							I[24] = new("ImageLabel", I[19], "Vector", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://79571919459802"), Position = UDim2.fromScale(0.12, 0.531), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.193, 1) }, { ["ViralWorkerRef"] = "vw_30813a7478" })
							I[25] = new("ImageLabel", I[19], "Glow", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, ImageColor3 = Color3.fromRGB(33, 185, 255), ImageContent = Content.fromUri("rbxassetid://71100846408511"), ImageTransparency = 0.5, Position = UDim2.fromScale(0.0159433, -0.0553135), Size = UDim2.fromScale(0.2221266, 1.1106268), ZIndex = 0 }, { ["ViralWorkerRef"] = "vw_be0961a694" })
							I[26] = new("ImageButton", I[19], "Buy", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(81, 158, 86), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, HoverImageContent = Content.fromUri("rbxassetid://100703312924377"), ImageContent = Content.fromUri("rbxassetid://83673098636246"), ImageTransparency = 1, Position = UDim2.fromScale(0.833, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.257, 0.395), ZIndex = 2 }, { ["ViralWorkerRef"] = "vw_dfb840297e" })
								I[27] = new("TextLabel", I[26], "Price", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5009794), Size = UDim2.fromScale(0.9, 0.7), Text = "???", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["ViralWorkerRef"] = "vw_88cc8b9460" })
									I[28] = new("UIStroke", I[27], "UIStroke", { Thickness = 3 }, { ["ViralWorkerRef"] = "vw_fb978b4140" })
								I[29] = new("UIStroke", I[26], "UIStroke", { Thickness = 1.5 }, { ["ViralWorkerRef"] = "vw_fe071c0be2" })
							I[30] = new("TextLabel", I[19], "PreviousAmount", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.3779221, 0.606482), RichText = true, Size = UDim2.fromScale(0.1457495, 0.4234076), Text = "104", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left }, { ["ViralWorkerRef"] = "vw_673ff4d7aa" })
								I[31] = new("UIStroke", I[30], "UIStroke", { Thickness = 3 }, { ["ViralWorkerRef"] = "vw_a1bb1e2980" })
						I[32] = new("UIStroke", I[18], "UIStroke", { Thickness = 1.5 }, { ["ViralWorkerRef"] = "vw_2c657c549a" })
						I[33] = new("ImageLabel", I[18], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://102858777932516"), Position = UDim2.fromScale(0.4498054, 0.4282661), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.0722679, 0.3992131) }, { ["ViralWorkerRef"] = "vw_2036b72a87" })
						I[34] = new("Frame", I[18], "Locked", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.2, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 2 }, { ["ViralWorkerRef"] = "vw_befb8dfb31" })
							I[35] = new("TextLabel", I[34], "Txt", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 0.35), Text = "YOU NEED 5 REBIRTHS", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["ViralWorkerRef"] = "vw_8716652746" })
								I[36] = new("UIStroke", I[35], "UIStroke", { Thickness = 4 }, { ["ViralWorkerRef"] = "vw_00392e09ee" })
					I[37] = new("UIListLayout", I[17], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.03, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center }, { ["ViralWorkerRef"] = "vw_7ced824dea" })
			I[38] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 1.4857513 }, { ["ViralWorkerRef"] = "vw_b30efb63ab" })
	return I[1]
end

return build
