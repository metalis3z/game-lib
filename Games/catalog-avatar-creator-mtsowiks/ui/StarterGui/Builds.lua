-- Generated from ui/StarterGui/Builds.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Builds", { DisplayOrder = 10, Enabled = false, ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, nil, { "Themed" })
		I[2] = new("CanvasGroup", I[1], "container", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.5, 0.82) })
			I[3] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 0.8, DominantAxis = Enum.DominantAxis.Height })
			I[4] = new("UIPadding", I[2], "UIPadding", { PaddingBottom = UDim.new(0, 3), PaddingLeft = UDim.new(0, 3), PaddingRight = UDim.new(0, 3), PaddingTop = UDim.new(0, 3) })
			I[5] = new("Frame", I[2], "wrapper", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(18, 18, 21), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
				I[6] = new("UICorner", I[5], "UICorner", { BottomLeftRadius = UDim.new(0.02, 0), BottomRightRadius = UDim.new(0.02, 0), TopLeftRadius = UDim.new(0.02, 0), TopRightRadius = UDim.new(0.02, 0) })
				I[7] = new("UIStroke", I[5], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(247, 245, 255), Thickness = 3, Transparency = 0.5 })
				I[8] = new("UIPadding", I[5], "UIPadding", { PaddingBottom = UDim.new(0.012, 0), PaddingLeft = UDim.new(0.015, 0), PaddingRight = UDim.new(0.015, 0), PaddingTop = UDim.new(0.012, 0) })
				I[9] = new("UIListLayout", I[5], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.013, 0), SortOrder = Enum.SortOrder.LayoutOrder })
				I[10] = new("Frame", I[5], "titleBar", { BackgroundTransparency = 1, LayoutOrder = 1, Size = UDim2.fromScale(1, 0.065) })
					I[11] = new("TextLabel", I[10], "title", { AnchorPoint = Vector2.new(0, 0.5), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.4024773), Size = UDim2.fromScale(0.72, 0.82), Text = "Builds", TextColor3 = Color3.fromRGB(247, 247, 248), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
					I[12] = new("TextButton", I[10], "closeButton", { AnchorPoint = Vector2.new(1, 0), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(33, 34, 39), BorderSizePixel = 0, Position = UDim2.fromScale(1, 0), Size = UDim2.fromScale(1, 1), Text = "" }, nil, { "UIEffect" })
						I[13] = new("UIAspectRatioConstraint", I[12], "UIAspectRatioConstraint", { DominantAxis = Enum.DominantAxis.Height })
						I[14] = new("UICorner", I[12], "UICorner", { BottomLeftRadius = UDim.new(0.3, 0), BottomRightRadius = UDim.new(0.3, 0), TopLeftRadius = UDim.new(0.3, 0), TopRightRadius = UDim.new(0.3, 0) })
						I[15] = new("ImageLabel", I[12], "image", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://81024172191247"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.9, 0.9) })
				I[16] = new("ScrollingFrame", I[5], "list", { BackgroundTransparency = 1, BorderSizePixel = 0, CanvasSize = UDim2.fromOffset(0, 281), LayoutOrder = 2, ScrollBarThickness = 3, ScrollingDirection = Enum.ScrollingDirection.Y, Size = UDim2.fromScale(1, 0.834) }, nil, { "ScrollingFrameAutomaticSizeFix" })
					I[17] = new("UIPadding", I[16], "UIPadding", { PaddingBottom = UDim.new(0, 2), PaddingLeft = UDim.new(0, 2), PaddingRight = UDim.new(0, 2), PaddingTop = UDim.new(0, 2) })
					I[18] = new("UIListLayout", I[16], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.014, 0), SortOrder = Enum.SortOrder.LayoutOrder })
					I[19] = new("TextLabel", I[16], "emptyLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.8, 0.08), Text = "No saved builds yet.", TextColor3 = Color3.fromRGB(213, 215, 221), TextScaled = true, TextWrapped = true, Visible = false })
					I[20] = new("Frame", I[16], "rowTemplate", { BackgroundColor3 = Color3.fromRGB(29, 29, 31), BorderSizePixel = 0, LayoutOrder = 9999, Size = UDim2.fromScale(1, 0.13), Visible = false })
						I[21] = new("UICorner", I[20], "UICorner", { BottomLeftRadius = UDim.new(0.1333, 0), BottomRightRadius = UDim.new(0.1333, 0), TopLeftRadius = UDim.new(0.1333, 0), TopRightRadius = UDim.new(0.1333, 0) })
						I[22] = new("UIStroke", I[20], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(70, 68, 77), Transparency = 0.5 })
						I[23] = new("Frame", I[20], "content", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) })
							I[24] = new("UIPadding", I[23], "UIPadding", { PaddingBottom = UDim.new(0.12, 0), PaddingLeft = UDim.new(0.03, 0), PaddingRight = UDim.new(0.03, 0), PaddingTop = UDim.new(0.12, 0) })
							I[25] = new("Frame", I[23], "textBlock", { AnchorPoint = Vector2.new(0, 0.5), BackgroundTransparency = 1, Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(0.36, 1) })
								I[26] = new("UIListLayout", I[25], "UIListLayout", { Padding = UDim.new(0, 2), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
								I[27] = new("TextLabel", I[25], "buildName", { BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), LayoutOrder = 1, Size = UDim2.fromScale(1, 0.46), Text = "rowTemplate", TextColor3 = Color3.fromRGB(247, 247, 248), TextScaled = true, TextTruncate = Enum.TextTruncate.AtEnd, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
								I[28] = new("TextLabel", I[25], "meta", { BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 2, Size = UDim2.fromScale(1, 0.36), Text = "128 parts", TextColor3 = Color3.fromRGB(237, 238, 238), TextScaled = true, TextTruncate = Enum.TextTruncate.AtEnd, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
						I[29] = new("TextButton", I[20], "loadButton", { AnchorPoint = Vector2.new(1, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(0, 216, 134), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.9795, 0.5), Size = UDim2.fromScale(0.18, 0.5), Text = "Load", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextStrokeTransparency = 0.8, TextWrapped = true, ZIndex = 2 }, nil, { "UIEffectSoundOnly" })
							I[30] = new("UICorner", I[29], "UICorner", { BottomLeftRadius = UDim.new(0.2, 0), BottomRightRadius = UDim.new(0.2, 0), TopLeftRadius = UDim.new(0.2, 0), TopRightRadius = UDim.new(0.2, 0) })
							I[31] = new("UIPadding", I[29], "UIPadding", { PaddingBottom = UDim.new(0.24, 0), PaddingLeft = UDim.new(0.06, 0), PaddingRight = UDim.new(0.06, 0), PaddingTop = UDim.new(0.24, 0) })
						I[32] = new("TextButton", I[20], "deleteButton", { AnchorPoint = Vector2.new(1, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 95, 92), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5785, 0.5), Size = UDim2.fromScale(0.18, 0.5), Text = "Delete", TextColor3 = Color3.fromRGB(18, 18, 21), TextScaled = true, TextWrapped = true, ZIndex = 2 }, nil, { "UIEffectSoundOnly" })
							I[33] = new("UICorner", I[32], "UICorner", { BottomLeftRadius = UDim.new(0.2, 0), BottomRightRadius = UDim.new(0.2, 0), TopLeftRadius = UDim.new(0.2, 0), TopRightRadius = UDim.new(0.2, 0) })
							I[34] = new("UIPadding", I[32], "UIPadding", { PaddingBottom = UDim.new(0.24, 0), PaddingLeft = UDim.new(0.06, 0), PaddingRight = UDim.new(0.06, 0), PaddingTop = UDim.new(0.24, 0) })
						I[35] = new("TextButton", I[20], "updateButton", { AnchorPoint = Vector2.new(1, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(39, 163, 216), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.779, 0.5), Size = UDim2.fromScale(0.18, 0.5), Text = "Update", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextStrokeTransparency = 0.8, TextWrapped = true, ZIndex = 2 }, nil, { "UIEffectSoundOnly" })
							I[36] = new("UICorner", I[35], "UICorner", { BottomLeftRadius = UDim.new(0.2, 0), BottomRightRadius = UDim.new(0.2, 0), TopLeftRadius = UDim.new(0.2, 0), TopRightRadius = UDim.new(0.2, 0) })
							I[37] = new("UIPadding", I[35], "UIPadding", { PaddingBottom = UDim.new(0.24, 0), PaddingLeft = UDim.new(0.06, 0), PaddingRight = UDim.new(0.06, 0), PaddingTop = UDim.new(0.24, 0) })
					I[38] = new("Frame", I[16], "Castle Build", { BackgroundColor3 = Color3.fromRGB(29, 29, 31), BorderSizePixel = 0, LayoutOrder = 1, Size = UDim2.fromScale(1, 0.13) })
						I[39] = new("UICorner", I[38], "UICorner", { BottomLeftRadius = UDim.new(0.1333, 0), BottomRightRadius = UDim.new(0.1333, 0), TopLeftRadius = UDim.new(0.1333, 0), TopRightRadius = UDim.new(0.1333, 0) })
						I[40] = new("UIStroke", I[38], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(70, 68, 77), Transparency = 0.5 })
						I[41] = new("Frame", I[38], "content", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) })
							I[42] = new("UIPadding", I[41], "UIPadding", { PaddingBottom = UDim.new(0.12, 0), PaddingLeft = UDim.new(0.03, 0), PaddingRight = UDim.new(0.03, 0), PaddingTop = UDim.new(0.12, 0) })
							I[43] = new("Frame", I[41], "textBlock", { AnchorPoint = Vector2.new(0, 0.5), BackgroundTransparency = 1, Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(0.36, 1) })
								I[44] = new("UIListLayout", I[43], "UIListLayout", { Padding = UDim.new(0, 2), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
								I[45] = new("TextLabel", I[43], "buildName", { BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), LayoutOrder = 1, Size = UDim2.fromScale(1, 0.46), Text = "Castle Build", TextColor3 = Color3.fromRGB(247, 247, 248), TextScaled = true, TextTruncate = Enum.TextTruncate.AtEnd, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
								I[46] = new("TextLabel", I[43], "meta", { BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 2, Size = UDim2.fromScale(1, 0.36), Text = "2841 parts", TextColor3 = Color3.fromRGB(237, 238, 238), TextScaled = true, TextTruncate = Enum.TextTruncate.AtEnd, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
						I[47] = new("TextButton", I[38], "loadButton", { AnchorPoint = Vector2.new(1, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(0, 216, 134), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.9795, 0.5), Size = UDim2.fromScale(0.18, 0.5), Text = "Load", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextStrokeTransparency = 0.8, TextWrapped = true, ZIndex = 2 }, nil, { "UIEffectSoundOnly" })
							I[48] = new("UICorner", I[47], "UICorner", { BottomLeftRadius = UDim.new(0.2, 0), BottomRightRadius = UDim.new(0.2, 0), TopLeftRadius = UDim.new(0.2, 0), TopRightRadius = UDim.new(0.2, 0) })
							I[49] = new("UIPadding", I[47], "UIPadding", { PaddingBottom = UDim.new(0.24, 0), PaddingLeft = UDim.new(0.06, 0), PaddingRight = UDim.new(0.06, 0), PaddingTop = UDim.new(0.24, 0) })
						I[50] = new("TextButton", I[38], "deleteButton", { AnchorPoint = Vector2.new(1, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 95, 92), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5785, 0.5), Size = UDim2.fromScale(0.18, 0.5), Text = "Delete", TextColor3 = Color3.fromRGB(18, 18, 21), TextScaled = true, TextWrapped = true, ZIndex = 2 }, nil, { "UIEffectSoundOnly" })
							I[51] = new("UICorner", I[50], "UICorner", { BottomLeftRadius = UDim.new(0.2, 0), BottomRightRadius = UDim.new(0.2, 0), TopLeftRadius = UDim.new(0.2, 0), TopRightRadius = UDim.new(0.2, 0) })
							I[52] = new("UIPadding", I[50], "UIPadding", { PaddingBottom = UDim.new(0.24, 0), PaddingLeft = UDim.new(0.06, 0), PaddingRight = UDim.new(0.06, 0), PaddingTop = UDim.new(0.24, 0) })
						I[53] = new("TextButton", I[38], "updateButton", { AnchorPoint = Vector2.new(1, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(39, 163, 216), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.779, 0.5), Size = UDim2.fromScale(0.18, 0.5), Text = "Update", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextStrokeTransparency = 0.8, TextWrapped = true, ZIndex = 2 }, nil, { "UIEffectSoundOnly" })
							I[54] = new("UICorner", I[53], "UICorner", { BottomLeftRadius = UDim.new(0.2, 0), BottomRightRadius = UDim.new(0.2, 0), TopLeftRadius = UDim.new(0.2, 0), TopRightRadius = UDim.new(0.2, 0) })
							I[55] = new("UIPadding", I[53], "UIPadding", { PaddingBottom = UDim.new(0.24, 0), PaddingLeft = UDim.new(0.06, 0), PaddingRight = UDim.new(0.06, 0), PaddingTop = UDim.new(0.24, 0) })
					I[56] = new("Frame", I[16], "Spawn Area", { BackgroundColor3 = Color3.fromRGB(29, 29, 31), BorderSizePixel = 0, LayoutOrder = 2, Size = UDim2.fromScale(1, 0.13) })
						I[57] = new("UICorner", I[56], "UICorner", { BottomLeftRadius = UDim.new(0.1333, 0), BottomRightRadius = UDim.new(0.1333, 0), TopLeftRadius = UDim.new(0.1333, 0), TopRightRadius = UDim.new(0.1333, 0) })
						I[58] = new("UIStroke", I[56], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(70, 68, 77), Transparency = 0.5 })
						I[59] = new("Frame", I[56], "content", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) })
							I[60] = new("UIPadding", I[59], "UIPadding", { PaddingBottom = UDim.new(0.12, 0), PaddingLeft = UDim.new(0.03, 0), PaddingRight = UDim.new(0.03, 0), PaddingTop = UDim.new(0.12, 0) })
							I[61] = new("Frame", I[59], "textBlock", { AnchorPoint = Vector2.new(0, 0.5), BackgroundTransparency = 1, Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(0.36, 1) })
								I[62] = new("UIListLayout", I[61], "UIListLayout", { Padding = UDim.new(0, 2), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
								I[63] = new("TextLabel", I[61], "buildName", { BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), LayoutOrder = 1, Size = UDim2.fromScale(1, 0.46), Text = "Spawn Area", TextColor3 = Color3.fromRGB(247, 247, 248), TextScaled = true, TextTruncate = Enum.TextTruncate.AtEnd, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
								I[64] = new("TextLabel", I[61], "meta", { BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 2, Size = UDim2.fromScale(1, 0.36), Text = "640 parts", TextColor3 = Color3.fromRGB(237, 238, 238), TextScaled = true, TextTruncate = Enum.TextTruncate.AtEnd, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
						I[65] = new("TextButton", I[56], "loadButton", { AnchorPoint = Vector2.new(1, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(0, 216, 134), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.9795, 0.5), Size = UDim2.fromScale(0.18, 0.5), Text = "Load", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextStrokeTransparency = 0.8, TextWrapped = true, ZIndex = 2 }, nil, { "UIEffectSoundOnly" })
							I[66] = new("UICorner", I[65], "UICorner", { BottomLeftRadius = UDim.new(0.2, 0), BottomRightRadius = UDim.new(0.2, 0), TopLeftRadius = UDim.new(0.2, 0), TopRightRadius = UDim.new(0.2, 0) })
							I[67] = new("UIPadding", I[65], "UIPadding", { PaddingBottom = UDim.new(0.24, 0), PaddingLeft = UDim.new(0.06, 0), PaddingRight = UDim.new(0.06, 0), PaddingTop = UDim.new(0.24, 0) })
						I[68] = new("TextButton", I[56], "deleteButton", { AnchorPoint = Vector2.new(1, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 95, 92), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5785, 0.5), Size = UDim2.fromScale(0.18, 0.5), Text = "Delete", TextColor3 = Color3.fromRGB(18, 18, 21), TextScaled = true, TextWrapped = true, ZIndex = 2 }, nil, { "UIEffectSoundOnly" })
							I[69] = new("UICorner", I[68], "UICorner", { BottomLeftRadius = UDim.new(0.2, 0), BottomRightRadius = UDim.new(0.2, 0), TopLeftRadius = UDim.new(0.2, 0), TopRightRadius = UDim.new(0.2, 0) })
							I[70] = new("UIPadding", I[68], "UIPadding", { PaddingBottom = UDim.new(0.24, 0), PaddingLeft = UDim.new(0.06, 0), PaddingRight = UDim.new(0.06, 0), PaddingTop = UDim.new(0.24, 0) })
						I[71] = new("TextButton", I[56], "updateButton", { AnchorPoint = Vector2.new(1, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(39, 163, 216), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.779, 0.5), Size = UDim2.fromScale(0.18, 0.5), Text = "Update", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextStrokeTransparency = 0.8, TextWrapped = true, ZIndex = 2 }, nil, { "UIEffectSoundOnly" })
							I[72] = new("UICorner", I[71], "UICorner", { BottomLeftRadius = UDim.new(0.2, 0), BottomRightRadius = UDim.new(0.2, 0), TopLeftRadius = UDim.new(0.2, 0), TopRightRadius = UDim.new(0.2, 0) })
							I[73] = new("UIPadding", I[71], "UIPadding", { PaddingBottom = UDim.new(0.24, 0), PaddingLeft = UDim.new(0.06, 0), PaddingRight = UDim.new(0.06, 0), PaddingTop = UDim.new(0.24, 0) })
					I[74] = new("Frame", I[16], "My House", { BackgroundColor3 = Color3.fromRGB(29, 29, 31), BorderSizePixel = 0, LayoutOrder = 3, Size = UDim2.fromScale(1, 0.13) })
						I[75] = new("UICorner", I[74], "UICorner", { BottomLeftRadius = UDim.new(0.1333, 0), BottomRightRadius = UDim.new(0.1333, 0), TopLeftRadius = UDim.new(0.1333, 0), TopRightRadius = UDim.new(0.1333, 0) })
						I[76] = new("UIStroke", I[74], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(70, 68, 77), Transparency = 0.5 })
						I[77] = new("Frame", I[74], "content", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) })
							I[78] = new("UIPadding", I[77], "UIPadding", { PaddingBottom = UDim.new(0.12, 0), PaddingLeft = UDim.new(0.03, 0), PaddingRight = UDim.new(0.03, 0), PaddingTop = UDim.new(0.12, 0) })
							I[79] = new("Frame", I[77], "textBlock", { AnchorPoint = Vector2.new(0, 0.5), BackgroundTransparency = 1, Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(0.36, 1) })
								I[80] = new("UIListLayout", I[79], "UIListLayout", { Padding = UDim.new(0, 2), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
								I[81] = new("TextLabel", I[79], "buildName", { BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), LayoutOrder = 1, Size = UDim2.fromScale(1, 0.46), Text = "My House", TextColor3 = Color3.fromRGB(247, 247, 248), TextScaled = true, TextTruncate = Enum.TextTruncate.AtEnd, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
								I[82] = new("TextLabel", I[79], "meta", { BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 2, Size = UDim2.fromScale(1, 0.36), Text = "128 parts", TextColor3 = Color3.fromRGB(237, 238, 238), TextScaled = true, TextTruncate = Enum.TextTruncate.AtEnd, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
						I[83] = new("TextButton", I[74], "loadButton", { AnchorPoint = Vector2.new(1, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(0, 216, 134), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.9795, 0.5), Size = UDim2.fromScale(0.18, 0.5), Text = "Load", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextStrokeTransparency = 0.8, TextWrapped = true, ZIndex = 2 }, nil, { "UIEffectSoundOnly" })
							I[84] = new("UICorner", I[83], "UICorner", { BottomLeftRadius = UDim.new(0.2, 0), BottomRightRadius = UDim.new(0.2, 0), TopLeftRadius = UDim.new(0.2, 0), TopRightRadius = UDim.new(0.2, 0) })
							I[85] = new("UIPadding", I[83], "UIPadding", { PaddingBottom = UDim.new(0.24, 0), PaddingLeft = UDim.new(0.06, 0), PaddingRight = UDim.new(0.06, 0), PaddingTop = UDim.new(0.24, 0) })
						I[86] = new("TextButton", I[74], "deleteButton", { AnchorPoint = Vector2.new(1, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 95, 92), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5785, 0.5), Size = UDim2.fromScale(0.18, 0.5), Text = "Delete", TextColor3 = Color3.fromRGB(18, 18, 21), TextScaled = true, TextWrapped = true, ZIndex = 2 }, nil, { "UIEffectSoundOnly" })
							I[87] = new("UICorner", I[86], "UICorner", { BottomLeftRadius = UDim.new(0.2, 0), BottomRightRadius = UDim.new(0.2, 0), TopLeftRadius = UDim.new(0.2, 0), TopRightRadius = UDim.new(0.2, 0) })
							I[88] = new("UIPadding", I[86], "UIPadding", { PaddingBottom = UDim.new(0.24, 0), PaddingLeft = UDim.new(0.06, 0), PaddingRight = UDim.new(0.06, 0), PaddingTop = UDim.new(0.24, 0) })
						I[89] = new("TextButton", I[74], "updateButton", { AnchorPoint = Vector2.new(1, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(39, 163, 216), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.779, 0.5), Size = UDim2.fromScale(0.18, 0.5), Text = "Update", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextStrokeTransparency = 0.8, TextWrapped = true, ZIndex = 2 }, nil, { "UIEffectSoundOnly" })
							I[90] = new("UICorner", I[89], "UICorner", { BottomLeftRadius = UDim.new(0.2, 0), BottomRightRadius = UDim.new(0.2, 0), TopLeftRadius = UDim.new(0.2, 0), TopRightRadius = UDim.new(0.2, 0) })
							I[91] = new("UIPadding", I[89], "UIPadding", { PaddingBottom = UDim.new(0.24, 0), PaddingLeft = UDim.new(0.06, 0), PaddingRight = UDim.new(0.06, 0), PaddingTop = UDim.new(0.24, 0) })
				I[92] = new("TextButton", I[5], "saveButton", { AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(0, 216, 134), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 3, Size = UDim2.fromScale(1, 0.075), Text = "Save Current Build", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextStrokeTransparency = 0.8, TextWrapped = true }, nil, { "UIEffectSoundOnly" })
					I[93] = new("UICorner", I[92], "UICorner", { BottomLeftRadius = UDim.new(0.2, 0), BottomRightRadius = UDim.new(0.2, 0), TopLeftRadius = UDim.new(0.2, 0), TopRightRadius = UDim.new(0.2, 0) })
					I[94] = new("UIPadding", I[92], "UIPadding", { PaddingBottom = UDim.new(0.16, 0), PaddingLeft = UDim.new(0.04, 0), PaddingRight = UDim.new(0.04, 0), PaddingTop = UDim.new(0.16, 0) })
	return I[1]
end

return build
