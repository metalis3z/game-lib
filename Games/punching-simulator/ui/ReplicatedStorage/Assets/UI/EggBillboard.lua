-- Generated from ui/ReplicatedStorage/Assets/UI/EggBillboard.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "EggBillboard", { Active = true, AlwaysOnTop = true, ClipsDescendants = true, MaxDistance = math.huge, ResetOnSpawn = false, Size = UDim2.fromScale(15, 15), ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
			I[3] = new("ImageLabel", I[2], "Background", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://13839246723"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(15, 15, 29, 25) })
			I[4] = new("UIScale", I[2], "UIScale")
			I[5] = new("ImageButton", I[2], "Open_1", { Active = false, AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://13804213417"), Position = UDim2.fromScale(0.5, 0.85), ScaleType = Enum.ScaleType.Slice, Selectable = false, Size = UDim2.fromScale(0.3, 0.2), SliceCenter = Rect.new(15, 62, 40, 71), SliceScale = 2, ZIndex = 2 }, nil, { "PopButton" })
				I[6] = new("TextLabel", I[5], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.45), Size = UDim2.fromScale(0.8, 0.7), Text = "E", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 35, TextStrokeColor3 = Color3.fromRGB(72, 72, 72), TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 4 })
					I[7] = new("UIStroke", I[6], "UIStroke", { Color = Color3.fromRGB(23, 23, 29), Thickness = 2 })
				I[8] = new("TextLabel", I[5], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.9), Size = UDim2.fromScale(0.75, 0.3), Text = "x1 Egg", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 35, TextStrokeColor3 = Color3.fromRGB(72, 72, 72), TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 4 })
					I[9] = new("UIStroke", I[8], "UIStroke", { Color = Color3.fromRGB(23, 23, 29), Thickness = 2 })
			I[10] = new("ImageButton", I[2], "Auto", { Active = false, AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://13804213417"), Position = UDim2.fromScale(0.175, 0.85), ScaleType = Enum.ScaleType.Slice, Selectable = false, Size = UDim2.fromScale(0.3, 0.2), SliceCenter = Rect.new(15, 62, 40, 71), SliceScale = 2, ZIndex = 2 }, nil, { "PopButton" })
				I[11] = new("TextLabel", I[10], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.45), Size = UDim2.fromScale(0.8, 0.7), Text = "T", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 35, TextStrokeColor3 = Color3.fromRGB(72, 72, 72), TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 4 })
					I[12] = new("UIStroke", I[11], "UIStroke", { Color = Color3.fromRGB(23, 23, 29), Thickness = 2 })
				I[13] = new("TextLabel", I[10], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.9), Size = UDim2.fromScale(0.75, 0.3), Text = "Auto", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 35, TextStrokeColor3 = Color3.fromRGB(72, 72, 72), TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 4 })
					I[14] = new("UIStroke", I[13], "UIStroke", { Color = Color3.fromRGB(23, 23, 29), Thickness = 2 })
			I[15] = new("ImageButton", I[2], "Open_3", { Active = false, AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://13804213417"), Position = UDim2.fromScale(0.825, 0.85), ScaleType = Enum.ScaleType.Slice, Selectable = false, Size = UDim2.fromScale(0.3, 0.2), SliceCenter = Rect.new(15, 62, 40, 71), SliceScale = 2, ZIndex = 2 }, nil, { "PopButton" })
				I[16] = new("TextLabel", I[15], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.45), Size = UDim2.fromScale(0.8, 0.7), Text = "R", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 35, TextStrokeColor3 = Color3.fromRGB(72, 72, 72), TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 4 })
					I[17] = new("UIStroke", I[16], "UIStroke", { Color = Color3.fromRGB(23, 23, 29), Thickness = 2 })
				I[18] = new("TextLabel", I[15], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.9), Size = UDim2.fromScale(0.75, 0.3), Text = "x3 Egg", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 35, TextStrokeColor3 = Color3.fromRGB(72, 72, 72), TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 4 })
					I[19] = new("UIStroke", I[18], "UIStroke", { Color = Color3.fromRGB(23, 23, 29), Thickness = 2 })
			I[20] = new("Frame", I[2], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.425), Size = UDim2.fromScale(0.9, 0.6) })
				I[21] = new("UIGridLayout", I[20], "UIGridLayout", { CellPadding = UDim2.fromScale(0.03, 0.05), CellSize = UDim2.fromScale(0.3, 0.35), FillDirectionMaxCells = 3, HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
			I[22] = new("ImageLabel", I[2], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://13784127821"), Position = UDim2.fromScale(0.925, 0.075), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.1, 0.1) })
				I[23] = new("TextLabel", I[22], "Price", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187370000", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(-1.625, 0.6), Size = UDim2.fromScale(3, 0.625), Text = "100", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 40, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right })
					I[24] = new("UIStroke", I[23], "UIStroke", { Thickness = 3.5999999 })
			I[25] = new("TextLabel", I[2], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.35, 0.08), Size = UDim2.fromScale(0.6, 0.125), Text = "Farm Egg", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 40, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 2 })
				I[26] = new("UIStroke", I[25], "UIStroke", { Thickness = 3.5999999 })
	return I[1]
end

return build
