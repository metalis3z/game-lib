-- Generated from ui/ReplicatedStorage/Assets/Billboards/BrainrotEgg.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "BrainrotEgg", { Active = true, AlwaysOnTop = true, MaxDistance = 500, ResetOnSpawn = false, Size = UDim2.new(2, 40, 1, 20) })
		I[2] = new("Frame", I[1], "Brainrot", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 5, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 4 })
			I[3] = new("UIPadding", I[2], "UIPadding", { PaddingBottom = UDim.new(0, 3), PaddingLeft = UDim.new(0, 3), PaddingRight = UDim.new(0, 3), PaddingTop = UDim.new(0, 3) })
			I[4] = new("Frame", I[2], "Top", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 1, Size = UDim2.fromScale(1, 0.75) }, { ["isVisible"] = true })
				I[5] = new("UIListLayout", I[4], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.05, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
				I[6] = new("ImageLabel", I[4], "Icon", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://100483305732153"), LayoutOrder = 2, ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), ZIndex = 5 })
					I[7] = new("UIAspectRatioConstraint", I[6], "UIAspectRatioConstraint", { AspectType = Enum.AspectType.ScaleWithParentSize })
				I[8] = new("TextLabel", I[4], "BrainrotName", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(1, 0), Size = UDim2.fromScale(1, 1), Text = "Huge Cat", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextWrapped = true, ZIndex = 5 })
					I[9] = new("UIStroke", I[8], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2.5 }, { ["oldp_Thickness"] = 3 })
			I[10] = new("UIListLayout", I[2], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.05, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
			I[11] = new("TextLabel", I[2], "Rarity", { AnchorPoint = Vector2.new(0.5, 0), AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 0.25), Text = "Basic", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextStrokeTransparency = 0, TextWrapped = true, Visible = false, ZIndex = 2 })
				I[12] = new("UIStroke", I[11], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2 })
				I[13] = new("UIScale", I[11], "UIScale", { Scale = 0.5 })
	return I[1]
end

return build
