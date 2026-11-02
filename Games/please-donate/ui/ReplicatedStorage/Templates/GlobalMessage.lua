-- Generated from ui/ReplicatedStorage/Templates/GlobalMessage.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "GlobalMessage", { AnchorPoint = Vector2.new(0.5, 0), AutomaticSize = Enum.AutomaticSize.XY, BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5) })
		I[2] = new("ImageLabel", I[1], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://12259533293"), LayoutOrder = -1, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Selectable = true, Size = UDim2.fromOffset(25, 25), ZIndex = 2 })
			I[3] = new("UIScale", I[2], "UIScale")
		I[4] = new("TextLabel", I[1], "TextLabel", { AutomaticSize = Enum.AutomaticSize.XY, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), RichText = true, Text = "THIS IS A TEST MESSAGE", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
			I[5] = new("UISizeConstraint", I[4], "UISizeConstraint", { MaxSize = Vector2.new(500, 60) })
		I[6] = new("UICorner", I[1], "UICorner")
		I[7] = new("UIListLayout", I[1], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 15), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
		I[8] = new("UIPadding", I[1], "UIPadding", { PaddingBottom = UDim.new(0, 15), PaddingLeft = UDim.new(0, 20), PaddingRight = UDim.new(0, 20), PaddingTop = UDim.new(0, 15) })
	return I[1]
end

return build
