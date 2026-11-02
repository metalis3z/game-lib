-- Generated from ui/StarterGui/Topbar.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Topbar", { DisplayOrder = 10, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.TopbarSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Holder", { BackgroundTransparency = 1, Position = UDim2.fromOffset(12, 0), Size = UDim2.new(1, 0, 1, -1) })
			I[3] = new("UIListLayout", I[2], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 12), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Bottom })
			I[4] = new("TextButton", I[2], "Like", { AnchorPoint = Vector2.new(1, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Guru.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 4, Position = UDim2.new(1, -10, 0.5, 105), SelectionBehaviorDown = Enum.SelectionBehavior.Stop, SelectionBehaviorLeft = Enum.SelectionBehavior.Stop, SelectionBehaviorRight = Enum.SelectionBehavior.Stop, SelectionBehaviorUp = Enum.SelectionBehavior.Stop, SelectionGroup = true, Size = UDim2.fromOffset(44, 44), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 54, ZIndex = 9 }, { ["Animation"] = "Rotate" })
				I[5] = new("ImageLabel", I[4], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=18502453055"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(0.5, 4, 0.5, 4), ZIndex = 3 })
				I[6] = new("ImageLabel", I[4], "Background", { AnchorPoint = Vector2.new(0.5, 0.5), AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://16071033599"), ImageTransparency = 0.4, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(256, 256, 256, 256) })
			I[7] = new("TextButton", I[2], "Quests", { AnchorPoint = Vector2.new(1, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Guru.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 4, Position = UDim2.new(1, -10, 0.5, 105), SelectionBehaviorDown = Enum.SelectionBehavior.Stop, SelectionBehaviorLeft = Enum.SelectionBehavior.Stop, SelectionBehaviorRight = Enum.SelectionBehavior.Stop, SelectionBehaviorUp = Enum.SelectionBehavior.Stop, SelectionGroup = true, Size = UDim2.fromOffset(44, 44), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 54, ZIndex = 10 }, { ["Animation"] = "Rotate" })
				I[8] = new("ImageLabel", I[7], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=18955910528"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(0.5, 4, 0.5, 4), ZIndex = 3 })
				I[9] = new("ImageLabel", I[7], "Background", { AnchorPoint = Vector2.new(0.5, 0.5), AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://16071033599"), ImageTransparency = 0.4, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(256, 256, 256, 256) })
				I[10] = new("Frame", I[7], "Notification", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(244, 67, 54), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.new(1, 3, 0, -3), Size = UDim2.fromOffset(18, 18), Visible = false, ZIndex = 3 })
					I[11] = new("UICorner", I[10], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
					I[12] = new("ImageLabel", I[10], "Shadow", { AnchorPoint = Vector2.new(0.5, 0), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://16071034841"), Position = UDim2.fromScale(0.5, -0.03125), Size = UDim2.fromScale(1.125, 1.125), ZIndex = 0 })
	return I[1]
end

return build
