-- Generated from ui/ReplicatedStorage/Assets/UI/Rarity/Notification.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Notification", { AnchorPoint = Vector2.new(1, 1), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(1.05, 0.1991184), Size = UDim2.fromScale(0.3913043, 0.2788802), Visible = false, ZIndex = 55 })
		I[2] = new("Frame", I[1], "Frame", { AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Size = UDim2.fromScale(0, 1), ZIndex = 56 })
			I[3] = new("UIListLayout", I[2], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Right, Padding = UDim.new(0, 3), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
			I[4] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0.5, 0), BottomRightRadius = UDim.new(0.5, 0), TopLeftRadius = UDim.new(0.5, 0), TopRightRadius = UDim.new(0.5, 0) })
			I[5] = new("UIPadding", I[2], "UIPadding", { PaddingLeft = UDim.new(0, 9), PaddingRight = UDim.new(0, 9) })
			I[6] = new("TextLabel", I[2], "Amount", { AnchorPoint = Vector2.new(1, 0.5), AutoLocalize = false, AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 2, LineHeight = 0.89, Position = UDim2.fromScale(1, 0.5), Size = UDim2.fromScale(0, 0.9), Text = "99", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextStrokeColor3 = Color3.fromRGB(19, 48, 57), TextWrapped = true, ZIndex = 56 })
				I[7] = new("UIStroke", I[6], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2.5 })
			I[8] = new("UIStroke", I[2], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(48, 0, 0), Thickness = 3 })
			I[9] = new("UIGradient", I[2], "red gradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 2, 61)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 39, 125)) }), Rotation = -90 })
	return I[1]
end

return build
