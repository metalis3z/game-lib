-- Generated from ui/StarterPlayer/StarterPlayerScripts/Scripts/GUIs/Menu/Crate.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Crate", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, LayoutOrder = 1, Size = UDim2.new(1, 0, 0, 125) })
		I[2] = new("ImageLabel", I[1], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(42, 42, 42), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=3834644695"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(10, 10, 40, 40), ZIndex = 2 })
			I[3] = new("ImageButton", I[2], "Buy", { AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(255, 223, 62), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=3834644695"), LayoutOrder = 1, Position = UDim2.fromScale(0.85, 0.405), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.25, 0.55), SliceCenter = Rect.new(10, 10, 40, 40), ZIndex = 2 })
				I[4] = new("ImageLabel", I[3], "Icon", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=4353429466"), Position = UDim2.fromScale(0.085, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.175, 0.6), ZIndex = 2 })
				I[5] = new("TextLabel", I[3], "Amount", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.275, 0.5), Size = UDim2.fromScale(0.6, 0.7), Text = "...", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 20, TextWrapped = true, ZIndex = 2 })
			I[6] = new("Frame", I[2], "Guns", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.fromScale(0.01, 0.415), Size = UDim2.fromScale(0.65, 0.65), ZIndex = 2 })
				I[7] = new("Frame", I[6], "Container", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = 2 })
					I[8] = new("UIListLayout", I[7], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 3), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
			I[9] = new("UIPadding", I[2], "UIPadding", { PaddingBottom = UDim.new(0.055, 0), PaddingLeft = UDim.new(0.008, 0), PaddingRight = UDim.new(0.008, 0), PaddingTop = UDim.new(0.055, 0) })
			I[10] = new("TextLabel", I[2], "Title", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 1.035), Size = UDim2.fromScale(1, 0.2), Text = "Exclusive Gun Crate!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextTransparency = 0.1, TextWrapped = true, ZIndex = 2 })
				I[11] = new("UIStroke", I[10], "UIStroke", { Color = Color3.fromRGB(45, 45, 45) })
			I[12] = new("UIGradient", I[2], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.499168, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(193, 193, 193)) }), Rotation = 85 })
	return I[1]
end

return build
