-- Generated from ui/StarterGui/Reward.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Reward", { DisplayOrder = 3, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets })
		I[2] = new("ImageButton", I[1], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 0 })
			I[3] = new("Frame", I[2], "Middle", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.45), Size = UDim2.fromScale(1, 0.5) })
				I[4] = new("Frame", I[3], "Rewards", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.6450839), Size = UDim2.fromScale(0.9, 0.6001679) })
					I[5] = new("UIGridLayout", I[4], "UIGridLayout", { CellPadding = UDim2.fromScale(0, 0.01), CellSize = UDim2.fromScale(0.175, 0.8), FillDirectionMaxCells = 5, HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder })
				I[6] = new("ImageLabel", I[3], "YouReceived", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://13802999880"), Position = UDim2.fromScale(0.5, 0.2), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.4177368, 0.2398082), SliceCenter = Rect.new(125, 94, 132, 94) })
					I[7] = new("TextLabel", I[6], "LabelTxt", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.45), Size = UDim2.fromScale(0.6, 0.8), Text = "You received:", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
						I[8] = new("UIStroke", I[7], "UIStroke", { Thickness = 3.0999999 })
						I[9] = new("UIScale", I[7], "UIScale")
					I[10] = new("UIScale", I[6], "UIScale", { Scale = 0.0000001 })
				I[11] = new("UIAspectRatioConstraint", I[3], "UIAspectRatioConstraint", { AspectRatio = 3 })
				I[12] = new("TextLabel", I[3], "ContinueTxt", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 1.5), Size = UDim2.fromScale(0.4, 0.1657026), Text = "(Click anywhere to continue)", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
					I[13] = new("UIStroke", I[12], "UIStroke", { Thickness = 3.0999999 })
					I[14] = new("UIScale", I[12], "UIScale", { Scale = 0.0000001 })
				I[15] = new("ImageLabel", I[3], "Sunburst", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://13805589492"), ImageTransparency = 0.95, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1.25, 1.25), ZIndex = 0 })
					I[16] = new("UIScale", I[15], "UIScale", { Scale = 0.0000001 })
	return I[1]
end

return build
