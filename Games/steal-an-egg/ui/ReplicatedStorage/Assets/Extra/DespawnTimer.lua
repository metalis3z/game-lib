-- Generated from ui/ReplicatedStorage/Assets/Extra/DespawnTimer.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "DespawnTimer", { Active = true, MaxDistance = 50, ResetOnSpawn = false, Size = UDim2.fromScale(15, 6), StudsOffset = Vector3.new(0, 0.5, 2) })
		I[2] = new("Frame", I[1], "CharTime", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 10, Position = UDim2.fromScale(0.5, 0.41), Size = UDim2.fromScale(1.0470001, 0.5) })
			I[3] = new("ImageLabel", I[2], "ImageLabel", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://106073375809912"), Position = UDim2.fromScale(0.45, 0.5), Size = UDim2.fromScale(0.7, 0.7) })
				I[4] = new("UIAspectRatioConstraint", I[3], "UIAspectRatioConstraint")
			I[5] = new("TextLabel", I[2], "CharTime", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LineHeight = 1.2, Position = UDim2.fromScale(0.45, 0.5), Size = UDim2.fromScale(0.2, 1), Text = "56s", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[6] = new("TextLabel", I[5], "Shadow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), LayoutOrder = 1, LineHeight = 1.2, Position = UDim2.fromScale(0.5, 0.55), Size = UDim2.fromScale(1, 1), Text = "$0", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false, ZIndex = 0 })
					I[7] = new("UIStroke", I[6], "UIStroke", { Thickness = 1.5 }, { ["ThicknessUDim"] = UDim.new(0, 1) })
				I[8] = new("UIGradient", I[5], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 102, 194)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 124, 133)) }), Rotation = 90 })
				I[9] = new("UIStroke", I[5], "UIStroke", { Thickness = 1.5, Transparency = 0.35 })
	return I[1]
end

return build
