-- Generated from ui/ReplicatedStorage/Controllers/LiveboardController/SurfaceGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("SurfaceGui", nil, "SurfaceGui", { ClipsDescendants = true, Face = Enum.NormalId.Back, LightInfluence = 1, MaxDistance = 1000, PixelsPerStud = 25, ResetOnSpawn = false, SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["ViralWorkerRef"] = "vw_db921c4127" })
		I[2] = new("ScrollingFrame", I[1], "ScrollingFrame", { Active = true, AnchorPoint = Vector2.new(0.5, 1), AutomaticCanvasSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, CanvasSize = UDim2.fromScale(0, 0), Position = UDim2.fromScale(0.5, 0.95), ScrollBarThickness = 0, Size = UDim2.fromScale(0.95, 0.765) }, { ["ViralWorkerRef"] = "vw_46360189ac" })
			I[3] = new("Frame", I[2], "GlobalTemplate", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.0032051), Size = UDim2.fromScale(1, 0.275), Visible = false }, { ["ViralWorkerRef"] = "vw_c194cd62e5" })
				I[4] = new("Frame", I[3], "Filler", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(35, 45, 50), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0), Size = UDim2.new(1, -3, 0.95, 0) }, { ["ViralWorkerRef"] = "vw_0680819566" })
					I[5] = new("UIStroke", I[4], "UIStroke", nil, { ["ViralWorkerRef"] = "vw_0add365bae" })
					I[6] = new("ImageLabel", I[4], "PlayerBg", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 2, Position = UDim2.fromScale(0.966, 0.525), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.1244058, 0.537929), ZIndex = 2 }, { ["ViralWorkerRef"] = "vw_89873cc08c" })
						I[7] = new("ImageLabel", I[6], "Headshot", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), ZIndex = 0 }, { ["ViralWorkerRef"] = "vw_2274f1720f" })
						I[8] = new("UIStroke", I[6], "UIStroke", nil, { ["ViralWorkerRef"] = "vw_e81ddd3a55" })
						I[9] = new("TextLabel", I[6], "Username", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.5, -0.2), Size = UDim2.fromScale(1.45, 0.3), Text = "Claimed By", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["ViralWorkerRef"] = "vw_2c1d3b0ef8" })
							I[10] = new("UIStroke", I[9], "UIStroke", { Thickness = 2 }, { ["ViralWorkerRef"] = "vw_2a0e743c0d" })
					I[11] = new("TextLabel", I[4], "Location", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0.4043605, 0.7572966), Size = UDim2.fromScale(0.402945, 0.1639466), Text = "[GLOBAL]", TextColor3 = Color3.fromRGB(86, 211, 74), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left }, { ["ViralWorkerRef"] = "vw_97ea408b0e" })
						I[12] = new("UIStroke", I[11], "UIStroke", { Thickness = 2 }, { ["ViralWorkerRef"] = "vw_366350ef3a" })
					I[13] = new("TextLabel", I[4], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.4890753, 0.2983033), Size = UDim2.fromScale(0.5671282, 0.2489627), Text = "Lucky Sammy Block", TextColor3 = Color3.fromRGB(255, 55, 55), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left }, { ["ViralWorkerRef"] = "vw_44d2f33299" })
						I[14] = new("UIStroke", I[13], "UIStroke", { Thickness = 2 }, { ["ViralWorkerRef"] = "vw_06bacceab5" })
					I[15] = new("ImageLabel", I[4], "BrainrotBg", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 2, Position = UDim2.fromScale(0.0199999, 0.4829202), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.1585106, 0.7147412), ZIndex = 2 }, { ["ViralWorkerRef"] = "vw_c70efef5a4" })
						I[16] = new("ImageLabel", I[15], "Img", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://133401360483558"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), ZIndex = 0 }, { ["ViralWorkerRef"] = "vw_f9659f32f2" })
						I[17] = new("UIStroke", I[15], "UIStroke", { Color = Color3.fromRGB(255, 255, 255) }, { ["ViralWorkerRef"] = "vw_d5e1a42c9d" })
					I[18] = new("Frame", I[4], "Bar", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromScale(1, 0.075) }, { ["ViralWorkerRef"] = "vw_81554a9fba" })
						I[19] = new("Frame", I[18], "Fill", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(36, 217, 33), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(0.75, 1) }, { ["ViralWorkerRef"] = "vw_01243addb5" })
					I[20] = new("TextLabel", I[4], "Spawned", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.4890753, 0.5456194), Size = UDim2.fromScale(0.567, 0.225), Text = "Spawned 43s ago", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left }, { ["ViralWorkerRef"] = "vw_4673b0ecaf" })
						I[21] = new("UIStroke", I[20], "UIStroke", { Thickness = 2 }, { ["ViralWorkerRef"] = "vw_ce1d607c22" })
			I[22] = new("UIListLayout", I[2], "UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder }, { ["ViralWorkerRef"] = "vw_fb354703c9" })
			I[23] = new("Frame", I[2], "ServerTemplate", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.0032051), Size = UDim2.fromScale(1, 0.275), Visible = false }, { ["ViralWorkerRef"] = "vw_b64587765f" })
				I[24] = new("Frame", I[23], "Filler", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(35, 45, 50), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0), Size = UDim2.new(1, -3, 0.95, 0) }, { ["ViralWorkerRef"] = "vw_06c81ff03f" })
					I[25] = new("UIStroke", I[24], "UIStroke", nil, { ["ViralWorkerRef"] = "vw_55249df825" })
					I[26] = new("ImageLabel", I[24], "PlayerBg", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 2, Position = UDim2.fromScale(0.966, 0.525), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.1244058, 0.537929), ZIndex = 2 }, { ["ViralWorkerRef"] = "vw_f810c4d593" })
						I[27] = new("ImageLabel", I[26], "Headshot", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), ZIndex = 0 }, { ["ViralWorkerRef"] = "vw_c6963e41ba" })
						I[28] = new("UIStroke", I[26], "UIStroke", nil, { ["ViralWorkerRef"] = "vw_d8e618445f" })
						I[29] = new("TextLabel", I[26], "Username", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.5, -0.2), Size = UDim2.fromScale(1.45, 0.3), Text = "UNCLAIMED", TextColor3 = Color3.fromRGB(255, 61, 61), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["ViralWorkerRef"] = "vw_8dc93e817b" })
							I[30] = new("UIStroke", I[29], "UIStroke", { Thickness = 2 }, { ["ViralWorkerRef"] = "vw_048c13dae8" })
					I[31] = new("TextLabel", I[24], "Location", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0.4043605, 0.7572966), Size = UDim2.fromScale(0.402945, 0.1639466), Text = "[SERVER]", TextColor3 = Color3.fromRGB(211, 68, 68), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left }, { ["ViralWorkerRef"] = "vw_ccfb79ccc6" })
						I[32] = new("UIStroke", I[31], "UIStroke", { Thickness = 2 }, { ["ViralWorkerRef"] = "vw_7308418c50" })
					I[33] = new("TextLabel", I[24], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.4890753, 0.2983033), Size = UDim2.fromScale(0.5671282, 0.2489627), Text = "Strawberry Elephant", TextColor3 = Color3.fromRGB(64, 172, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left }, { ["ViralWorkerRef"] = "vw_111fb2bbeb" })
						I[34] = new("UIStroke", I[33], "UIStroke", { Thickness = 2 }, { ["ViralWorkerRef"] = "vw_a0a1d1d50f" })
					I[35] = new("ImageLabel", I[24], "BrainrotBg", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 2, Position = UDim2.fromScale(0.0199999, 0.4829202), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.1585106, 0.7147412), ZIndex = 2 }, { ["ViralWorkerRef"] = "vw_f7d825fa3f" })
						I[36] = new("ImageLabel", I[35], "Img", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://100107772563289"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), ZIndex = 0 }, { ["ViralWorkerRef"] = "vw_335166cf33" })
						I[37] = new("UIStroke", I[35], "UIStroke", { Color = Color3.fromRGB(255, 255, 255) }, { ["ViralWorkerRef"] = "vw_999bc4fe25" })
					I[38] = new("Frame", I[24], "Bar", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromScale(1, 0.075) }, { ["ViralWorkerRef"] = "vw_74e04c0cdb" })
						I[39] = new("Frame", I[38], "Fill", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(36, 217, 33), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(0.3, 1) }, { ["ViralWorkerRef"] = "vw_83c8d6d8d4" })
					I[40] = new("TextLabel", I[24], "Spawned", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.4890753, 0.5456194), Size = UDim2.fromScale(0.567, 0.225), Text = "Spawned 30s ago", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left }, { ["ViralWorkerRef"] = "vw_e366567896" })
						I[41] = new("UIStroke", I[40], "UIStroke", { Thickness = 2 }, { ["ViralWorkerRef"] = "vw_75dff4430e" })
		I[42] = new("TextLabel", I[1], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.025), Size = UDim2.fromScale(1, 0.125), Text = "LIVE SPAWNS", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["ViralWorkerRef"] = "vw_c546811580" })
	return I[1]
end

return build
