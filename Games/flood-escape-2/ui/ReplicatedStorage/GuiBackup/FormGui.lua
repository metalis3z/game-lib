-- Generated from ui/ReplicatedStorage/GuiBackup/FormGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "FormGui", { ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["ThemeColor"] = Color3.fromRGB(255, 255, 255) })
		I[2] = new("ImageButton", I[1], "FeedbackButton", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, Position = UDim2.new(1, -90, 0, 4), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromOffset(32, 32), ZIndex = 100 })
			I[3] = new("UICorner", I[2], "UICorner")
			I[4] = new("UIPadding", I[2], "UIPadding", { PaddingBottom = UDim.new(0, 4), PaddingLeft = UDim.new(0, 4), PaddingRight = UDim.new(0, 4), PaddingTop = UDim.new(0, 4) })
			I[5] = new("ImageLabel", I[2], "FeedbackIcon", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=6023426957"), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1) })
			I[6] = new("UIGradient", I[2], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(18, 18, 18)), ColorSequenceKeypoint.new(0.5083333, Color3.fromRGB(253, 253, 253)), ColorSequenceKeypoint.new(1, Color3.fromRGB(18, 18, 18)) }), Enabled = false, Offset = Vector2.new(-1, 0), Rotation = 45 })
		I[7] = new("Frame", I[1], "Checkbox", { AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 0) })
			I[8] = new("UIListLayout", I[7], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 10), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
			I[9] = new("ImageButton", I[7], "ImageButton", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=6031068420"), Size = UDim2.fromOffset(24, 24) })
			I[10] = new("ObjectValue", I[7], "Color")
			I[11] = new("BoolValue", I[7], "Checked")
			I[12] = new("TextButton", I[7], "Label", { AutoButtonColor = false, AutomaticSize = Enum.AutomaticSize.XY, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Roboto.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 1, LineHeight = 1.3, Selectable = false, Text = "Label", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 16, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
				I[13] = new("UIPadding", I[12], "UIPadding", { PaddingRight = UDim.new(0, 30), PaddingTop = UDim.new(0, 5) })
		I[14] = new("Frame", I[1], "LinearScale", { AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = 1, Size = UDim2.fromScale(1, 0) })
			I[15] = new("Frame", I[14], "RadioButton", { AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = 1 })
				I[16] = new("UIListLayout", I[15], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 10), SortOrder = Enum.SortOrder.LayoutOrder })
				I[17] = new("StringValue", I[15], "Value", { Value = "First" })
				I[18] = new("ImageButton", I[15], "ImageButton", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=6031068433"), LayoutOrder = 1, Size = UDim2.fromOffset(24, 24) })
				I[19] = new("TextButton", I[15], "Label", { AutoButtonColor = false, AutomaticSize = Enum.AutomaticSize.XY, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Roboto.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LineHeight = 1.3, Selectable = false, Text = "1", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 16, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
			I[20] = new("UIListLayout", I[14], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Bottom })
			I[21] = new("ObjectValue", I[14], "Value")
			I[22] = new("TextButton", I[14], "StartLabel", { AutoButtonColor = false, AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Roboto.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LineHeight = 1.3, Selectable = false, Size = UDim2.fromScale(0.2, 0), Text = "Label", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 16, TextWrapped = true })
				I[23] = new("UIPadding", I[22], "UIPadding", { PaddingLeft = UDim.new(0, 5), PaddingRight = UDim.new(0, 5) })
			I[24] = new("TextButton", I[14], "EndLabel", { AutoButtonColor = false, AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Roboto.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 12, LineHeight = 1.3, Selectable = false, Size = UDim2.fromScale(0.2, 0), Text = "Label", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 16, TextWrapped = true })
				I[25] = new("UIPadding", I[24], "UIPadding", { PaddingLeft = UDim.new(0, 5), PaddingRight = UDim.new(0, 5) })
		I[26] = new("Frame", I[1], "Options", { AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = 2, Size = UDim2.fromScale(1, 0) })
			I[27] = new("UIListLayout", I[26], "UIListLayout", { Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
		I[28] = new("TextBox", I[1], "TextBox", { AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ClearTextOnFocus = false, ClipsDescendants = true, FontFace = Font.new("rbxasset://fonts/families/Roboto.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 2, LineHeight = 1.4, MultiLine = true, PlaceholderColor3 = Color3.fromRGB(113, 117, 121), PlaceholderText = "Your answer", Size = UDim2.fromScale(1, 0), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 16, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
			I[29] = new("Frame", I[28], "Border", { BackgroundColor3 = Color3.fromRGB(224, 224, 224), BorderSizePixel = 0, Position = UDim2.new(0, 0, 1, -2), Size = UDim2.new(1, 0, 0, 1) })
		I[30] = new("ImageLabel", I[1], "Section", { AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://12472842045"), ImageTransparency = 1, ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 0), SliceCenter = Rect.new(0, 0, 640, 640) })
			I[31] = new("UIListLayout", I[30], "UIListLayout", { Padding = UDim.new(0, 16), SortOrder = Enum.SortOrder.LayoutOrder })
			I[32] = new("UIPadding", I[30], "UIPadding", { PaddingBottom = UDim.new(0, 16), PaddingLeft = UDim.new(0, 16), PaddingRight = UDim.new(0, 16), PaddingTop = UDim.new(0, 16) })
			I[33] = new("UICorner", I[30], "UICorner")
			I[34] = new("Frame", I[30], "Required", { AutomaticSize = Enum.AutomaticSize.XY, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, LayoutOrder = 100, Visible = false })
				I[35] = new("TextLabel", I[34], "Label", { AutomaticSize = Enum.AutomaticSize.XY, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Roboto.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 2, Text = "This is a required question", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 12, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
				I[36] = new("ImageLabel", I[34], "Icon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=6026568210"), LayoutOrder = 1, Size = UDim2.fromOffset(24, 24) })
				I[37] = new("UIListLayout", I[34], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
			I[38] = new("UIStroke", I[30], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Enabled = false, Thickness = 2 })
			I[39] = new("BindableEvent", I[30], "ShowValidation")
			I[40] = new("Frame", I[30], "Question", { AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 0) })
				I[41] = new("TextLabel", I[40], "Label", { AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Roboto.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), RichText = true, Size = UDim2.new(1, 0, 0, 15), TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 16, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
					I[42] = new("UISizeConstraint", I[41], "UISizeConstraint", { MinSize = Vector2.new(0, 18) })
				I[43] = new("TextLabel", I[40], "Description", { AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Roboto.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 1, LineHeight = 1.3, RichText = true, Size = UDim2.new(1, 0, 0, 16), Text = "Description", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, Visible = false })
				I[44] = new("UIListLayout", I[40], "UIListLayout", { Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder })
		I[45] = new("Frame", I[1], "Dropdown", { AutomaticSize = Enum.AutomaticSize.XY, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(224, 224, 224), LayoutOrder = 2, Size = UDim2.fromOffset(0, 48) })
			I[46] = new("ImageButton", I[45], "Selected", { AutoButtonColor = false, AutomaticSize = Enum.AutomaticSize.XY, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(224, 224, 224), BorderSizePixel = 0, Size = UDim2.fromScale(1, 0) })
				I[47] = new("TextLabel", I[46], "Label", { AutomaticSize = Enum.AutomaticSize.XY, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Roboto.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LineHeight = 1.5, Text = "Choose", TextColor3 = Color3.fromRGB(113, 117, 121), TextSize = 16, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
					I[48] = new("ImageLabel", I[47], "Icon", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=6031091004"), LayoutOrder = 1, Position = UDim2.new(1, 4, 0.5, -4), Size = UDim2.fromOffset(24, 24) })
					I[49] = new("UIPadding", I[47], "UIPadding", { PaddingRight = UDim.new(0, 16), PaddingTop = UDim.new(0, 8) })
				I[50] = new("UIPadding", I[46], "UIPadding", { PaddingBottom = UDim.new(0, 8), PaddingLeft = UDim.new(0, 16), PaddingRight = UDim.new(0, 16), PaddingTop = UDim.new(0, 8) })
			I[51] = new("ImageButton", I[45], "Option", { AutoButtonColor = false, AutomaticSize = Enum.AutomaticSize.XY, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(224, 224, 224), Size = UDim2.fromScale(1, 0), Visible = false })
				I[52] = new("TextLabel", I[51], "Label", { AutomaticSize = Enum.AutomaticSize.XY, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Roboto.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LineHeight = 1.5, Text = "Choose", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 16, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
					I[53] = new("UIPadding", I[52], "UIPadding", { PaddingTop = UDim.new(0, 8) })
				I[54] = new("StringValue", I[51], "Value", { Value = "First" })
				I[55] = new("UIPadding", I[51], "UIPadding", { PaddingBottom = UDim.new(0, 8), PaddingLeft = UDim.new(0, 16), PaddingRight = UDim.new(0, 16), PaddingTop = UDim.new(0, 8) })
			I[56] = new("ObjectValue", I[45], "Value")
			I[57] = new("UIListLayout", I[45], "UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder })
		I[58] = new("Frame", I[1], "Buttons", { AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 0) })
			I[59] = new("TextButton", I[58], "Cancel", { AutomaticSize = Enum.AutomaticSize.XY, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.9, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Roboto.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Text = "Cancel", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 16 })
				I[60] = new("UIPadding", I[59], "UIPadding", { PaddingBottom = UDim.new(0, 12), PaddingLeft = UDim.new(0, 24), PaddingRight = UDim.new(0, 24), PaddingTop = UDim.new(0, 12) })
				I[61] = new("UICorner", I[59], "UICorner")
			I[62] = new("TextButton", I[58], "Submit", { AnchorPoint = Vector2.new(1, 0), AutomaticSize = Enum.AutomaticSize.XY, BackgroundColor3 = Color3.fromRGB(94, 94, 94), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Roboto.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(1, 0), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 16 })
				I[63] = new("UIPadding", I[62], "UIPadding", { PaddingBottom = UDim.new(0, 12), PaddingLeft = UDim.new(0, 24), PaddingRight = UDim.new(0, 24), PaddingTop = UDim.new(0, 12) })
				I[64] = new("UICorner", I[62], "UICorner")
				I[65] = new("UIGradient", I[62], "UIGradient", { Enabled = false, Offset = Vector2.new(-1, 0), Rotation = 45 })
				I[66] = new("TextLabel", I[62], "Label", { AutomaticSize = Enum.AutomaticSize.XY, BackgroundColor3 = Color3.fromRGB(94, 94, 94), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Roboto.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Text = "Submit", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 16 })
		I[67] = new("Frame", I[1], "FormFrame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(235, 235, 235), BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.new(0.5, 0, 0.5, 6), Size = UDim2.fromScale(0.9, 1), Visible = false })
			I[68] = new("UISizeConstraint", I[67], "UISizeConstraint", { MaxSize = Vector2.new(640, math.huge) })
			I[69] = new("UICorner", I[67], "UICorner")
			I[70] = new("ScrollingFrame", I[67], "ScrollingFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, CanvasSize = UDim2.fromScale(0, 0), ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0), ScrollingDirection = Enum.ScrollingDirection.Y, Size = UDim2.fromScale(1, 1) })
				I[71] = new("Frame", I[70], "Contents", { AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.05, 0), Size = UDim2.new(0.9, -12, 0, 0) })
					I[72] = new("UIPadding", I[71], "UIPadding", { PaddingBottom = UDim.new(0, 20), PaddingTop = UDim.new(0, 20) })
					I[73] = new("UIListLayout", I[71], "UIListLayout", { Padding = UDim.new(0, 24), SortOrder = Enum.SortOrder.LayoutOrder })
			I[74] = new("UIScale", I[67], "UIScale")
		I[75] = new("Frame", I[1], "SelectionImageObject", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromOffset(-1, -1), Size = UDim2.new(1, 2, 1, 2) })
			I[76] = new("UIStroke", I[75], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(255, 255, 255), Thickness = 2 })
				I[77] = new("UIGradient", I[76], "UIGradient", { Rotation = 90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.24375), NumberSequenceKeypoint.new(1, 0) }) })
			I[78] = new("UICorner", I[75], "UICorner", { BottomLeftRadius = UDim.new(0, 4), BottomRightRadius = UDim.new(0, 4), TopLeftRadius = UDim.new(0, 4), TopRightRadius = UDim.new(0, 4) })
		I[79] = new("Frame", I[1], "EmptyFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromOffset(-1, -1), Size = UDim2.new(1, 2, 1, 2), Visible = false })
		I[80] = new("ImageLabel", I[1], "TitleSection", { AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://12472842045"), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 0), SliceCenter = Rect.new(0, 0, 640, 640) })
			I[81] = new("UIListLayout", I[80], "UIListLayout", { Padding = UDim.new(0, 12), SortOrder = Enum.SortOrder.LayoutOrder })
			I[82] = new("UIPadding", I[80], "UIPadding", { PaddingBottom = UDim.new(0, 16), PaddingLeft = UDim.new(0, 16), PaddingRight = UDim.new(0, 16), PaddingTop = UDim.new(0, 26) })
			I[83] = new("UICorner", I[80], "UICorner")
			I[84] = new("TextLabel", I[80], "Title", { AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Roboto.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Size = UDim2.new(1, 0, 0, 26), Text = "Title", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 24, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
			I[85] = new("TextLabel", I[80], "Description", { AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Roboto.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 1, LineHeight = 1.3, Size = UDim2.new(1, 0, 0, 16), Text = "Description", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, Visible = false })
			I[86] = new("Frame", I[80], "Divider", { BackgroundColor3 = Color3.fromRGB(224, 224, 224), BorderSizePixel = 0, LayoutOrder = 2, Position = UDim2.fromScale(0, 1), Size = UDim2.new(1, 0, 0, 1) })
			I[87] = new("TextLabel", I[80], "Required", { AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Roboto.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 4, LineHeight = 1.3, Size = UDim2.new(1, 0, 0, 16), Text = "* Required", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 12, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, Visible = false })
			I[88] = new("TextLabel", I[80], "Shared", { AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Roboto.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 3, LineHeight = 1.3, RichText = true, Size = UDim2.new(1, 0, 0, 16), Text = "<i>(shared)</i>", TextColor3 = Color3.fromRGB(95, 99, 104), TextSize = 12, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, Visible = false })
		I[89] = new("Frame", I[1], "RadioButtonGroup", { AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = 1, Size = UDim2.fromScale(1, 0) })
			I[90] = new("Frame", I[89], "RadioButton", { AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 0) })
				I[91] = new("UIListLayout", I[90], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 10), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
				I[92] = new("StringValue", I[90], "Value", { Value = "First" })
				I[93] = new("ImageButton", I[90], "ImageButton", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=6031068433"), Size = UDim2.fromOffset(24, 24) })
				I[94] = new("TextButton", I[90], "Label", { AutoButtonColor = false, AutomaticSize = Enum.AutomaticSize.XY, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Roboto.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 1, LineHeight = 1.3, Selectable = false, Text = "Label", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 16, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
					I[95] = new("UIPadding", I[94], "UIPadding", { PaddingRight = UDim.new(0, 30), PaddingTop = UDim.new(0, 5) })
			I[96] = new("UIListLayout", I[89], "UIListLayout", { Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
			I[97] = new("ObjectValue", I[89], "Value")
		I[98] = new("BindableFunction", I[1], "ToggleForm")
	return I[1]
end

return build
