-- Generated from ui/ReplicatedStorage/Assets/Extra/AssetSpawnData.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "AssetSpawnData", { Active = true, MaxDistance = 999999988484154753734934528, ResetOnSpawn = false, Size = UDim2.fromScale(15, 6), StudsOffset = Vector3.new(0, 5, 0) })
		I[2] = new("TextLabel", I[1], "Rarity", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LayoutOrder = 4, Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromScale(1.0474006, 0.129771), Text = "Rare", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["DefaultState"] = true })
			I[3] = new("UIStroke", I[2], "UIStroke", { Thickness = 2, Transparency = 0.35 })
		I[4] = new("Frame", I[1], "CharTime", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = -10, Position = UDim2.fromScale(0.5, 0.78), Size = UDim2.fromScale(1.0474006, 0.129771) })
			I[5] = new("ImageLabel", I[4], "ImageLabel", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://106073375809912"), Position = UDim2.fromScale(0.475, 0.5), Size = UDim2.fromScale(0.9, 0.9) })
				I[6] = new("UIAspectRatioConstraint", I[5], "UIAspectRatioConstraint")
			I[7] = new("TextLabel", I[4], "TextLabel", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), LineHeight = 1.2, Position = UDim2.fromScale(0.475, 0.5), Size = UDim2.fromScale(0.1, 1), Text = "56s", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[8] = new("TextLabel", I[7], "Shadow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), LayoutOrder = 1, LineHeight = 1.2, Position = UDim2.fromScale(0.5, 0.55), Size = UDim2.fromScale(1, 1), Text = "$0", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false, ZIndex = 0 })
					I[9] = new("UIStroke", I[8], "UIStroke", { Thickness = 2.5 }, { ["ThicknessUDim"] = UDim.new(0, 1) })
				I[10] = new("UIGradient", I[7], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 102, 194)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 124, 133)) }), Rotation = 90 })
				I[11] = new("UIStroke", I[7], "UIStroke", { Thickness = 2.5, Transparency = 0.35 })
	return I[1]
end

return build
