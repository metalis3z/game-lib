-- Generated from ui/StarterPlayer/StarterPlayerScripts/UserInterface/LootboxListSlot.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "LootboxListSlot", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 0.15), SizeConstraint = Enum.SizeConstraint.RelativeXX })
		I[2] = new("Frame", I[1], "Container", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0, 0.55), Size = UDim2.fromScale(0.15, 1) })
		I[3] = new("TextLabel", I[1], "Type", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.15, 0.75), Size = UDim2.fromScale(0.65, 0.3), Text = "Mythical Assault Rifle Skin", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
			I[4] = new("UIStroke", I[3], "UIStroke", { Thickness = 2, Transparency = 0.75 })
		I[5] = new("TextLabel", I[1], "Chance", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.925, 0.5), Size = UDim2.fromScale(0.125, 0.5), Text = "0.33%", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[6] = new("UIStroke", I[5], "UIStroke", { Thickness = 2, Transparency = 0.75 })
		I[7] = new("ImageLabel", I[1], "Background", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(100, 255, 50), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(100, 255, 50), ImageTransparency = 0.25, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.new(1, -4, 1, -4), SliceCenter = Rect.new(15, 15, 16, 16), SliceScale = 0.5, ZIndex = -1 })
			I[8] = new("UIGradient", I[7], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)) }), Rotation = -90 })
			I[9] = new("UICorner", I[7], "UICorner")
			I[10] = new("UIStroke", I[7], "UIStroke", { Color = Color3.fromRGB(100, 255, 50), Thickness = 2 })
				I[11] = new("UIGradient", I[10], "UIGradient", { Rotation = -90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.4125), NumberSequenceKeypoint.new(1, 0) }) })
		I[12] = new("TextLabel", I[1], "ItemName", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.15, 0.35), Size = UDim2.fromScale(0.65, 0.6), Text = "Blobfish", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 5 })
			I[13] = new("UIStroke", I[12], "UIStroke", { Thickness = 2, Transparency = 0.75 })
	return I[1]
end

return build
