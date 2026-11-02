-- Generated from ui/StarterPlayer/StarterPlayerScripts/Scripts/GUIs/Menu/Pack.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Pack", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, LayoutOrder = 1, Size = UDim2.new(1, 0, 0, 170) })
		I[2] = new("ImageLabel", I[1], "Border", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(255, 55, 152), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=4010083981"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(10, 10, 40, 40) })
		I[3] = new("ImageLabel", I[1], "Top", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(255, 55, 152), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=3834644695"), Position = UDim2.fromScale(0.5, 0), ScaleType = Enum.ScaleType.Slice, Size = UDim2.new(1, 0, 0, 25), SliceCenter = Rect.new(10, 10, 40, 40) })
			I[4] = new("TextLabel", I[3], "Title", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(0.7, 0.8), Text = "🔥 LIMITED TIME - for FREE 🔥", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
			I[5] = new("TextLabel", I[3], "Timer", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(1, 0.5), Size = UDim2.fromScale(0.3, 0.65), Text = "⌛ 16 Hours ⌛", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right })
			I[6] = new("UIPadding", I[3], "UIPadding", { PaddingBottom = UDim.new(0.1, 0), PaddingLeft = UDim.new(0.025, 0), PaddingRight = UDim.new(0.025, 0), PaddingTop = UDim.new(0.1, 0) })
		I[7] = new("ImageLabel", I[1], "Bottom", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(255, 55, 152), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=3834644695"), Position = UDim2.fromScale(0.5, 1), ScaleType = Enum.ScaleType.Slice, Size = UDim2.new(1, 0, 0, 45), SliceCenter = Rect.new(10, 10, 40, 40) })
			I[8] = new("ImageButton", I[7], "Buy", { AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(255, 223, 62), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=3834644695"), LayoutOrder = 1, Position = UDim2.new(0.9, -10, 0.5, 0), ScaleType = Enum.ScaleType.Slice, Size = UDim2.new(0.2, 20, 1, 0), SliceCenter = Rect.new(10, 10, 40, 40), ZIndex = 2 })
				I[9] = new("ImageLabel", I[8], "Icon", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=4353429466"), Position = UDim2.fromScale(0.085, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.175, 0.6), ZIndex = 2 })
				I[10] = new("TextLabel", I[8], "Amount", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.275, 0.5), Size = UDim2.fromScale(0.6, 0.7), Text = "...", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 20, TextWrapped = true, ZIndex = 2 })
			I[11] = new("TextLabel", I[7], "Own", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.8, 0.7), Text = "You own this pack!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 20, TextWrapped = true, Visible = false, ZIndex = 2 })
			I[12] = new("TextLabel", I[7], "Desc", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(0.65, 0.5), Text = "Buy entire pack at a discount!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 20, TextWrapped = true, ZIndex = 2 })
			I[13] = new("UIPadding", I[7], "UIPadding", { PaddingBottom = UDim.new(0.1, 0), PaddingLeft = UDim.new(0.008, 0), PaddingRight = UDim.new(0.008, 0), PaddingTop = UDim.new(0.1, 0) })
		I[14] = new("Frame", I[1], "Guns", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.new(0.5, 0, 0, 25), Size = UDim2.new(1, 0, 1, -20) })
			I[15] = new("UIGridLayout", I[14], "UIGridLayout", { CellSize = UDim2.fromOffset(85, 85), HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder })
				I[16] = new("UIAspectRatioConstraint", I[15], "UIAspectRatioConstraint")
			I[17] = new("UIPadding", I[14], "UIPadding", { PaddingBottom = UDim.new(0, 5), PaddingTop = UDim.new(0, 5) })
	return I[1]
end

return build
