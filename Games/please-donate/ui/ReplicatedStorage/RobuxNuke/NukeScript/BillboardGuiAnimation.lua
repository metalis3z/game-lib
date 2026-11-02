-- Generated from ui/ReplicatedStorage/RobuxNuke/NukeScript/BillboardGuiAnimation.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "BillboardGuiAnimation", { AlwaysOnTop = true, Brightness = 2.5, ExtentsOffset = Vector3.new(0, 300, 0), MaxDistance = math.huge, ResetOnSpawn = false, Size = UDim2.fromScale(70, 70), ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
			I[3] = new("Frame", I[2], "RobuxLogo", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.75, 0.75) })
				I[4] = new("ImageLabel", I[3], "Fill", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://8973045221"), ImageTransparency = 0.75, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 0 })
					I[5] = new("UIGradient", I[4], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 170, 0)) }), Rotation = 90 })
			I[6] = new("ImageLabel", I[2], "Star", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://4949259834"), ImageTransparency = 0.85, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1.5, 1.5), ZIndex = 0 })
			I[7] = new("UIScale", I[2], "UIScale")
			I[8] = new("Frame", I[2], "TextLabels", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) })
				I[9] = new("TextLabel", I[8], "MiddleText", { AnchorPoint = Vector2.new(0.5, 0.5), AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(2, 0), Text = "100,000", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 70, ZIndex = 2 })
					I[10] = new("UIStroke", I[9], "UIStroke", { Thickness = 4 })
					I[11] = new("UIGradient", I[9], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.429285, Color3.fromRGB(255, 213, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 78, 24)) }), Rotation = 90 })
				I[12] = new("TextLabel", I[8], "TopText", { AnchorPoint = Vector2.new(0.5, 1), AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.38), Size = UDim2.fromScale(2, 0), Text = "HAZEM DONATED", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 25, TextYAlignment = Enum.TextYAlignment.Bottom, ZIndex = 3 })
					I[13] = new("UIStroke", I[12], "UIStroke", { Thickness = 2.5 })
				I[14] = new("TextLabel", I[8], "BottomText", { AnchorPoint = Vector2.new(0.5, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = 2, Position = UDim2.fromScale(0.5, 0.6), Size = UDim2.fromScale(2, 0), Text = "TO PLXSMA", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 25, TextYAlignment = Enum.TextYAlignment.Top })
					I[15] = new("UIStroke", I[14], "UIStroke", { Thickness = 2.5 })
				I[16] = new("UIListLayout", I[8], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
	return I[1]
end

return build
