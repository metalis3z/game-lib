-- Generated from ui/ReplicatedStorage/Assets/UI/FRAMEWORK/InfoOverlay/Blocks/Tradable.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Tradable", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = 2, Size = UDim2.new(1, 0, 0, 25), Visible = false })
		I[2] = new("TextLabel", I[1], "title", { AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0, 1), Text = "Tradable", TextColor3 = Color3.fromRGB(42, 221, 102), TextSize = 23, ZIndex = 2 })
		I[3] = new("ImageLabel", I[1], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(42, 221, 102), LayoutOrder = 1, ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1) })
			I[4] = new("UIAspectRatioConstraint", I[3], "UIAspectRatioConstraint")
		I[5] = new("UIListLayout", I[1], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 5), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
		I[6] = new("Configuration", I[1], "settings", nil, { ["boundsX"] = Vector2.new(149, 150) })
	return I[1]
end

return build
