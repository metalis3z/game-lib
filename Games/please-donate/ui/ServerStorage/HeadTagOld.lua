-- Generated from ui/ServerStorage/HeadTagOld.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "HeadTagOld", { Active = true, AlwaysOnTop = true, Brightness = 0.5, LightInfluence = 1, MaxDistance = 50, Size = UDim2.fromOffset(20, 40), StudsOffsetWorldSpace = Vector3.new(0, 3.45, 0), ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("UIListLayout", I[1], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 2), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Bottom })
		I[3] = new("TextLabel", I[1], "Role", { AnchorPoint = Vector2.new(0.5, 1), AutomaticSize = Enum.AutomaticSize.XY, BackgroundColor3 = Color3.fromRGB(255, 51, 122), FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal), LineHeight = 0.8, Position = UDim2.fromScale(0.5, 0.5), Text = "Staff", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 12, Visible = false })
			I[4] = new("UIPadding", I[3], "UIPadding", { PaddingBottom = UDim.new(0, 7), PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8), PaddingTop = UDim.new(0, 4) })
			I[5] = new("UICorner", I[3], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
		I[6] = new("TextLabel", I[1], "Display", { AnchorPoint = Vector2.new(0.5, 1), AutomaticSize = Enum.AutomaticSize.XY, BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), LineHeight = 0.8, Position = UDim2.fromScale(0.5, 0.5), Text = "nolan", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14, TextStrokeTransparency = 0.65 })
			I[7] = new("UIPadding", I[6], "UIPadding", { PaddingLeft = UDim.new(0, 12), PaddingRight = UDim.new(0, 12) })
		I[8] = new("ImageLabel", I[1], "Catalog", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://12261977475"), LayoutOrder = -1, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromOffset(20, 20), Visible = false })
	return I[1]
end

return build
