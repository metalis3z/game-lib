-- Generated from ui/ReplicatedStorage/Assets/Extra/Cash.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "Cash", { Active = true, AlwaysOnTop = true, Brightness = 2, ClipsDescendants = true, MaxDistance = 160, ResetOnSpawn = false, Size = UDim2.fromScale(8, 3), StudsOffset = Vector3.new(0, 2, 0), ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("UIListLayout", I[1], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
		I[3] = new("TextLabel", I[1], "Money", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 2, RichText = true, Size = UDim2.fromScale(0.8, 0.4), Text = "900k", TextColor3 = Color3.fromRGB(26, 255, 0), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[4] = new("UIGradient", I[3], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(171, 171, 171)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }), Enabled = false, Rotation = 90 })
			I[5] = new("UIStroke", I[3], "UIStroke", { StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.07 })
	return I[1]
end

return build
