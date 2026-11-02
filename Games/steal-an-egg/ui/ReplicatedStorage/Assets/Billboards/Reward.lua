-- Generated from ui/ReplicatedStorage/Assets/Billboards/Reward.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "Reward", { Active = true, AlwaysOnTop = true, ClipsDescendants = true, MaxDistance = 0, ResetOnSpawn = false, Size = UDim2.new(20, 250, 2, 40) })
		I[2] = new("TextLabel", I[1], "amount", { AnchorPoint = Vector2.new(1, 1), AutoLocalize = false, AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(1, 1), Size = UDim2.fromScale(0, 1), Text = "9,999", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 40, TextStrokeTransparency = 0, ZIndex = 2 })
			I[3] = new("UIStroke", I[2], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2 })
		I[4] = new("ImageLabel", I[1], "icon", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://116290627333364"), Position = UDim2.fromScale(0, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.new(0.2, 0, 0.15, 30) })
			I[5] = new("UIAspectRatioConstraint", I[4], "UIAspectRatioConstraint")
			I[6] = new("ImageLabel", I[4], "shadow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://116290627333364"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.new(1, 4, 1, 4), ZIndex = 0 })
		I[7] = new("UIListLayout", I[1], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 10), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
	return I[1]
end

return build
