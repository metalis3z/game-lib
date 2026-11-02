-- Generated from ui/ReplicatedStorage/Assets/AutoSellSlot.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "AutoSellSlot", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = -1, Position = UDim2.fromScale(0.5545452, 0.4247151), Size = UDim2.fromScale(0.8909099, 0.2292624), ZIndex = 13 }, { ["AutoTween"] = "" })
		I[2] = new("ImageButton", I[1], "TextButton", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://73214197551985"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(64, 64, 64, 64), SliceScale = 0.2, ZIndex = 10 })
			I[3] = new("UIGradient", I[2], "selected", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(240, 249, 243)), ColorSequenceKeypoint.new(1, Color3.fromRGB(176, 175, 170)) }), Rotation = 90 })
			I[4] = new("ImageLabel", I[2], "Pattern", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://131176354845909"), ImageTransparency = 0.75, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1.0000001, 0.9999999), TileSize = UDim2.fromScale(0.5, 1.25), ZIndex = 11 })
		I[5] = new("TextLabel", I[1], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Interactable = false, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9289218, 0.6484563), Text = "Garden", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 12 })
			I[6] = new("UIStroke", I[5], "UIStroke", { Thickness = 2 })
		I[7] = new("ImageLabel", I[1], "Glow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://96735047582734"), ImageTransparency = 0.85, Position = UDim2.fromScale(0.4915327, 0.4806248), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1.2130487, 1.5039177), SliceCenter = Rect.new(256, 256, 256, 256), SliceScale = 0.4, ZIndex = 9 })
		I[8] = new("UIScale", I[1], "UIScale")
	return I[1]
end

return build
