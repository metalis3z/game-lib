-- Generated from ui/ServerScriptService/Booths/BoothEvents/ItemTemplate.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("TextButton", nil, "ItemTemplate", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(38, 255, 0), FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), LayoutOrder = 5, Position = UDim2.fromScale(0.4699571, 0.4774816), Size = UDim2.fromScale(0.388412, 0.7895221), Text = "5", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true })
		I[2] = new("ImageLabel", I[1], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://15815310805"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.5, 0.5), Visible = false })
			I[3] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
		I[4] = new("UICorner", I[1], "UICorner", { BottomLeftRadius = UDim.new(0, 6), BottomRightRadius = UDim.new(0, 6), TopLeftRadius = UDim.new(0, 6), TopRightRadius = UDim.new(0, 6) })
		I[5] = new("UIScale", I[1], "UIScale")
		I[6] = new("UIAspectRatioConstraint", I[1], "UIAspectRatioConstraint")
		I[7] = new("UIListLayout", I[1], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 2), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
		I[8] = new("UIStroke", I[1], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 4 })
		I[9] = new("UIPadding", I[1], "UIPadding", { PaddingBottom = UDim.new(0, 5), PaddingLeft = UDim.new(0, 4), PaddingRight = UDim.new(0, 4), PaddingTop = UDim.new(0, 5) })
		I[10] = new("TextLabel", I[1], "Price", { AnchorPoint = Vector2.new(0.5, 0.5), AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.8167614), Size = UDim2.fromScale(0.9112993, 0.3803267), Text = "5", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 100, TextWrapped = true, Visible = false })
		I[11] = new("IntValue", I[1], "Robux")
		I[12] = new("IntValue", I[1], "Gamepass")
		I[13] = new("IntValue", I[1], "OwnerID")
	return I[1]
end

return build
