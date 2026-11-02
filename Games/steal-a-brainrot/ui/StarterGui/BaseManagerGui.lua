-- Generated from ui/StarterGui/BaseManagerGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "BaseManagerGui", { ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["ViralWorkerRef"] = "vw_424ffaeb0a" })
		I[2] = new("Frame", I[1], "Backdrop", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.35, Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 10 }, { ["ViralWorkerRef"] = "vw_c8430eae93" })
			I[3] = new("Frame", I[2], "MainFrame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5028195, 0.4943907), Size = UDim2.fromScale(0.54, 0.5) }, { ["ViralWorkerRef"] = "vw_fc9d32c464" })
				I[4] = new("Frame", I[3], "Header", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.0012953), Size = UDim2.fromScale(1, 0.15) }, { ["ViralWorkerRef"] = "vw_608c20b216" })
					I[5] = new("ImageLabel", I[4], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://137573329562191"), Position = UDim2.fromScale(0.5032409, 0.4840216), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), ZIndex = 0 }, { ["ViralWorkerRef"] = "vw_5190dd165d" })
						I[6] = new("UIGradient", I[5], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(189, 195, 199)), ColorSequenceKeypoint.new(1, Color3.fromRGB(44, 62, 80)) }) }, { ["ViralWorkerRef"] = "vw_5d4b27e855" })
						I[7] = new("UIStroke", I[5], "UIStroke", { Thickness = 3.5 }, { ["ViralWorkerRef"] = "vw_7a16f45318" })
				I[8] = new("UIAspectRatioConstraint", I[3], "UIAspectRatioConstraint", { AspectRatio = 1.4859999 }, { ["ViralWorkerRef"] = "vw_e94ac146c3" })
				I[9] = new("ImageLabel", I[3], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://76660575181533"), Position = UDim2.fromScale(0.5040908, 0.5000001), Size = UDim2.fromScale(0.98, 1), ZIndex = -1 }, { ["ViralWorkerRef"] = "vw_e667a665b5" })
					I[10] = new("UIGradient", I[9], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) }) }, { ["ViralWorkerRef"] = "vw_c80381d824" })
					I[11] = new("UIStroke", I[9], "UIStroke", { Thickness = 2.7 }, { ["ViralWorkerRef"] = "vw_7ca74245fa" })
				I[12] = new("Frame", I[3], "ListFrame", { BackgroundColor3 = Color3.fromRGB(18, 18, 18), BackgroundTransparency = 0.3, BorderSizePixel = 0, Position = UDim2.fromOffset(20, 103), Size = UDim2.new(0.01, 220, 0.963277, -100), ZIndex = 12 }, { ["ViralWorkerRef"] = "vw_ae1a44b98f" })
					I[13] = new("TextLabel", I[12], "ListLabel", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(0, 4), Size = UDim2.new(1, 0, 0.01, 28), Text = "BASES LIBRES", TextColor3 = Color3.fromRGB(180, 180, 180), TextSize = 14, TextStrokeTransparency = 0, ZIndex = 12 }, { ["ViralWorkerRef"] = "vw_476cd0817e" })
					I[14] = new("ScrollingFrame", I[12], "ScrollList", { AutomaticCanvasSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderSizePixel = 0, CanvasSize = UDim2.fromScale(0, 0), Position = UDim2.fromOffset(8, 34), ScrollBarImageTransparency = 0.3, ScrollBarThickness = 4, Size = UDim2.new(1, -16, 1, -42), ZIndex = 12 }, { ["ViralWorkerRef"] = "vw_c683b5c274" })
						I[15] = new("TextButton", I[14], "ItemTemplate", { BackgroundColor3 = Color3.fromRGB(30, 30, 30), BackgroundTransparency = 0.2, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.new(1, 0, 0.01, 42), Text = "Base #1", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 15, TextStrokeTransparency = 0, Visible = false, ZIndex = 13 }, { ["ViralWorkerRef"] = "vw_3dcc7e9c3c" })
							I[16] = new("UIGradient", I[15], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) }) }, { ["ViralWorkerRef"] = "vw_e9a7934175" })
							I[17] = new("UIStroke", I[15], "UIStroke", { Thickness = 1.1 }, { ["ViralWorkerRef"] = "vw_07d54b37a5" })
						I[18] = new("UIListLayout", I[14], "UIListLayout", { Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder }, { ["ViralWorkerRef"] = "vw_425eb5ed2b" })
					I[19] = new("UIStroke", I[12], "UIStroke", { Thickness = 2.7 }, { ["ViralWorkerRef"] = "vw_20e8181a94" })
				I[20] = new("Frame", I[3], "PreviewFrame", { BackgroundColor3 = Color3.fromRGB(18, 18, 18), BackgroundTransparency = 0.3, BorderSizePixel = 0, Position = UDim2.fromOffset(256, 103), Size = UDim2.new(1, -276, 0.963277, -100), ZIndex = 12 }, { ["ViralWorkerRef"] = "vw_cb9859e858" })
					I[21] = new("TextLabel", I[20], "PreviewLabel", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromOffset(16, 16), Size = UDim2.new(1, -32, 0.01, 44), Text = "Choisis une base dans la liste", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 20, TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 12 }, { ["ViralWorkerRef"] = "vw_3ccfe934bf" })
						I[22] = new("UIGradient", I[21], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(189, 195, 199)), ColorSequenceKeypoint.new(1, Color3.fromRGB(44, 62, 80)) }) }, { ["ViralWorkerRef"] = "vw_c19c89884a" })
					I[23] = new("TextLabel", I[20], "InfoLabel", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromOffset(16, 68), Size = UDim2.new(1, -32, 0.01, 80), Text = "Tu garderas tous tes brainrots en changeant de base.", TextColor3 = Color3.fromRGB(160, 160, 160), TextScaled = true, TextSize = 15, TextStrokeTransparency = 0, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, ZIndex = 12 }, { ["ViralWorkerRef"] = "vw_af597f0ba2" })
						I[24] = new("UIGradient", I[23], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(71, 118, 230)), ColorSequenceKeypoint.new(1, Color3.fromRGB(142, 84, 233)) }) }, { ["ViralWorkerRef"] = "vw_6461e339c9" })
					I[25] = new("TextButton", I[20], "ConfirmButton", { Active = false, AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(60, 60, 60), BorderSizePixel = 3, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.new(0, 16, 1, -66), Size = UDim2.new(1, -32, 0.01, 48), Text = "Rejoindre cette base", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 18, TextStrokeTransparency = 0, ZIndex = 12 }, { ["ViralWorkerRef"] = "vw_75bc26d5f0" })
						I[26] = new("UIGradient", I[25], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(71, 118, 230)), ColorSequenceKeypoint.new(1, Color3.fromRGB(142, 84, 233)) }) }, { ["ViralWorkerRef"] = "vw_66b8e3c941" })
						I[27] = new("UIStroke", I[25], "UIStroke", { Thickness = 1.4 }, { ["ViralWorkerRef"] = "vw_6cc0eb9956" })
					I[28] = new("UIGradient", I[20], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 81, 47)), ColorSequenceKeypoint.new(1, Color3.fromRGB(240, 152, 25)) }) }, { ["ViralWorkerRef"] = "vw_ab55539582" })
					I[29] = new("UIStroke", I[20], "UIStroke", { Thickness = 2.4000001 }, { ["ViralWorkerRef"] = "vw_57406a0b47" })
				I[30] = new("TextLabel", I[3], "Title", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromOffset(8, -15), Size = UDim2.new(1, -100, 0.1, 48), Text = "CHOISIS TA BASE", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 62, TextStrokeTransparency = 0, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 12 }, { ["ViralWorkerRef"] = "vw_a285fed173" })
					I[31] = new("UIGradient", I[30], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) }) }, { ["ViralWorkerRef"] = "vw_2cd8de8cf4" })
				I[32] = new("ImageButton", I[3], "CloseButton", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, HoverImageContent = Content.fromUri("rbxassetid://137110183435251"), ImageContent = Content.fromUri("rbxassetid://105016554772347"), Position = UDim2.fromScale(0.9485979, 0.0737912), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.09, 0.13) }, { ["ViralWorkerRef"] = "vw_588ce83b75" })
					I[33] = new("TextLabel", I[32], "Txt", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4915989, 0.4897647), Size = UDim2.fromScale(0.84, 0.74), Text = "X", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["ViralWorkerRef"] = "vw_9394c60a4d" })
						I[34] = new("UIStroke", I[33], "UIStroke", { Thickness = 3 }, { ["OriginalThickness"] = 3, ["ViralWorkerRef"] = "vw_37fe77fd6e" }, { "ScreenStroke", "UIStroke" })
						I[35] = new("UIPadding", I[33], "UIPadding", { PaddingLeft = UDim.new(0.01, 0), PaddingRight = UDim.new(-0.03, 0) }, { ["ViralWorkerRef"] = "vw_003392b8b8" })
					I[36] = new("UIStroke", I[32], "UIStroke", { Thickness = 2.2 }, { ["ViralWorkerRef"] = "vw_b8c6d0aa33" })
		I[37] = new("TextButton", I[1], "ToggleButton", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(-0.0178412, 16, 0.8984199, -66), Size = UDim2.new(0.01, 130, 0.01, 44), Text = "Bases", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 28, TextWrapped = true }, { ["ViralWorkerRef"] = "vw_32ab977f91" })
			I[38] = new("UIStroke", I[37], "UIStroke", { Thickness = 3 }, { ["ViralWorkerRef"] = "vw_bab9b0b9eb" })
	return I[1]
end

return build
