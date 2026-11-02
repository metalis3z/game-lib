-- Generated from ui/StarterGui/MainInventory.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "MainInventory", { ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Holder", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.1585478, 0.2125), Size = UDim2.fromOffset(584, 351), Visible = false })
			I[3] = new("ImageLabel", I[2], "Slot", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://98920609911971"), Position = UDim2.fromScale(0.4776376, 0.4993055), Size = UDim2.fromOffset(790, 430) })
				I[4] = new("UIListLayout", I[3], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center, VerticalFlex = Enum.UIFlexAlignment.SpaceAround, Wraps = true })
				I[5] = new("ImageLabel", I[3], "Slot", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://98920609911971"), Position = UDim2.fromScale(0.4443807, 0.05), Size = UDim2.fromOffset(115, 115) })
					I[6] = new("ImageLabel", I[5], "Itemimage", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = -4, Position = UDim2.fromScale(0.2347826, 0.2347826), Size = UDim2.fromOffset(61, 61) })
					I[7] = new("TextLabel", I[5], "Number", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/IndieFlower.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 5, Position = UDim2.fromScale(-0.5391304, 0.1652174), Size = UDim2.fromOffset(200, 50), Text = "1", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 70 })
			I[8] = new("ImageLabel", I[2], "Slot", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://98920609911971"), Position = UDim2.fromScale(0.1532826, 0.0455484), Size = UDim2.fromOffset(207, 94) })
				I[9] = new("TextLabel", I[8], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/IndieFlower.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0307914, 0.2300154), Size = UDim2.fromOffset(200, 50), Text = "Inventory", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 40 })
	return I[1]
end

return build
