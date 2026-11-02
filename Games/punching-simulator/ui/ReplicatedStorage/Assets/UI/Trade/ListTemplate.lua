-- Generated from ui/ReplicatedStorage/Assets/UI/Trade/ListTemplate.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "ListTemplate", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(50, 50, 50), BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.3305771), Size = UDim2.fromScale(0.95, 0.2) })
		I[2] = new("Frame", I[1], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 170, 255), BorderSizePixel = 0, LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.95, 0.8) })
			I[3] = new("ImageButton", I[2], "TradeBtn", { Active = false, AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://13645841920"), Position = UDim2.fromScale(0.8895352, 0.5), ScaleType = Enum.ScaleType.Slice, Selectable = false, Size = UDim2.fromScale(0.1719434, 0.8565251), SliceCenter = Rect.new(15, 62, 40, 71), SliceScale = 2, ZIndex = 2 }, nil, { "PopButton" })
				I[4] = new("ImageLabel", I[3], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://14195068732"), Position = UDim2.fromScale(0.5, 0.45), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.79, 0.7), ZIndex = 2 })
					I[5] = new("UIAspectRatioConstraint", I[4], "UIAspectRatioConstraint")
			I[6] = new("TextLabel", I[2], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3966797, 0.5000001), Size = UDim2.fromScale(0.7247027, 0.7), Text = "Music", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 2 })
				I[7] = new("UITextSizeConstraint", I[6], "UITextSizeConstraint", { MaxTextSize = 41 })
				I[8] = new("UIStroke", I[6], "UIStroke", { Color = Color3.fromRGB(19, 19, 19), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2 })
			I[9] = new("UIStroke", I[2], "UIStroke", { Thickness = 3 })
			I[10] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0.125, 0), BottomRightRadius = UDim.new(0.125, 0), TopLeftRadius = UDim.new(0.125, 0), TopRightRadius = UDim.new(0.125, 0) })
	return I[1]
end

return build
