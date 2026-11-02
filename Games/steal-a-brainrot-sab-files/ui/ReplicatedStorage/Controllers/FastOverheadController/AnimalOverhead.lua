-- Generated from ui/ReplicatedStorage/Controllers/FastOverheadController/AnimalOverhead.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("SurfaceGui", nil, "AnimalOverhead", { CanvasSize = Vector2.new(340, 113.3330002), LightInfluence = 1, MaxDistance = 60, ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Traits", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.15), Size = UDim2.fromScale(1, 0.2), Visible = false })
			I[3] = new("ImageLabel", I[2], "Template", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://110835412437000"), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), SizeConstraint = Enum.SizeConstraint.RelativeYY, Visible = false })
			I[4] = new("UIListLayout", I[2], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
		I[5] = new("TextLabel", I[1], "DisplayName", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.35), Size = UDim2.fromScale(1, 0.15), Text = "{DisplayName}", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[6] = new("UIStroke", I[5], "UIStroke", { Thickness = 3.5, Transparency = 0.3 })
		I[7] = new("TextLabel", I[1], "Generation", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LayoutOrder = 3, Position = UDim2.fromScale(0.5, 0.65), Size = UDim2.fromScale(1, 0.15), Text = "$0/s", TextColor3 = Color3.fromRGB(255, 247, 0), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[8] = new("UIStroke", I[7], "UIStroke", { Thickness = 3.5, Transparency = 0.3 })
		I[9] = new("TextLabel", I[1], "Mutation", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LayoutOrder = -1, Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(1, 0.15), Text = "Gold", TextColor3 = Color3.fromRGB(255, 222, 89), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[10] = new("UIStroke", I[9], "UIStroke", { Thickness = 3.5, Transparency = 0.3 })
		I[11] = new("TextLabel", I[1], "Price", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LayoutOrder = 4, Position = UDim2.fromScale(0.5, 0.8), Size = UDim2.fromScale(1, 0.15), Text = "$500", TextColor3 = Color3.fromRGB(115, 255, 0), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[12] = new("UIStroke", I[11], "UIStroke", { Thickness = 3.5, Transparency = 0.3 })
		I[13] = new("TextLabel", I[1], "Rarity", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 0.15), Text = "Rarity", TextColor3 = Color3.fromRGB(115, 255, 0), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[14] = new("UIStroke", I[13], "UIStroke", { Thickness = 3.5, Transparency = 0.3 })
		I[15] = new("TextLabel", I[1], "Stolen", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0.5, 0.9367089), Size = UDim2.fromScale(1, 0.15), Text = "STOLEN", TextColor3 = Color3.fromRGB(255, 0, 4), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false })
			I[16] = new("UIStroke", I[15], "UIStroke", { Thickness = 3.5, Transparency = 0.3 })
		I[17] = new("UIListLayout", I[1], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
	return I[1]
end

return build
