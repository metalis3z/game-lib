-- Generated from ui/ReplicatedStorage/Controllers/FastOverheadController/CashPad.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("SurfaceGui", nil, "CashPad", { Brightness = 2, CanvasSize = Vector2.new(200, 120), ClipsDescendants = true, MaxDistance = 60, ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("TextLabel", I[1], "Offline", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 2, RichText = true, Size = UDim2.fromScale(1, 0.3), Text = "(Offline Cash: $700)", TextColor3 = Color3.fromRGB(156, 156, 156), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[3] = new("UIStroke", I[2], "UIStroke", { Thickness = 3 })
			I[4] = new("UIGradient", I[2], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(171, 171, 171)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }), Rotation = 90 })
		I[5] = new("TextLabel", I[1], "Collect", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 2, Size = UDim2.fromScale(1, 0.375), Text = "Collect", TextColor3 = Color3.fromRGB(202, 255, 201), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[6] = new("UIStroke", I[5], "UIStroke", { Thickness = 3 })
			I[7] = new("UIGradient", I[5], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(171, 171, 171)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }), Rotation = 90 })
		I[8] = new("UIListLayout", I[1], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
		I[9] = new("TextLabel", I[1], "CollectAmount", { AnchorPoint = Vector2.new(0.5, 0.5), AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 2, Size = UDim2.fromScale(1, 0.375), Text = "Collect", TextColor3 = Color3.fromRGB(115, 255, 0), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[10] = new("UIStroke", I[9], "UIStroke", { Thickness = 3 })
			I[11] = new("UIGradient", I[9], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(171, 171, 171)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }), Rotation = 90 })
	return I[1]
end

return build
