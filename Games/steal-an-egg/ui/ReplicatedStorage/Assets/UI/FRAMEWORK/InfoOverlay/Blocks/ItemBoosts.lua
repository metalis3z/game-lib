-- Generated from ui/ReplicatedStorage/Assets/UI/FRAMEWORK/InfoOverlay/Blocks/ItemBoosts.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "ItemBoosts", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = 20, Size = UDim2.new(1, 0, 0, 38) })
		I[2] = new("TextLabel", I[1], "boost", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0.5601693, 0.5000001), RichText = true, Size = UDim2.fromScale(0.720339, 1.0000001), Text = "+100%", TextColor3 = Color3.fromRGB(0, 255, 30), TextSize = 20, TextWrapped = true })
			I[3] = new("UIStroke", I[2], "UIStroke", { Thickness = 1.4 })
		I[4] = new("Configuration", I[1], "settings", nil, { ["boundsX"] = Vector2.new(65, 175) })
		I[5] = new("UIListLayout", I[1], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
		I[6] = new("ImageLabel", I[1], "icon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://108767181763013"), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.2593221, 1.0000001) })
			I[7] = new("ImageLabel", I[6], "RarityBg", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://109779235221479"), Position = UDim2.fromScale(1, 1), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1.2, 1.2), Visible = false })
	return I[1]
end

return build
