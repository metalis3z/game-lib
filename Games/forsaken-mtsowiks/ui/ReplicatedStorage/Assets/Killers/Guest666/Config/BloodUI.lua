-- Generated from ui/ReplicatedStorage/Assets/Killers/Guest666/Config/BloodUI.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "BloodUI", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.4861023, 0.8871508), Size = UDim2.fromScale(0.1722046, 0.1743017) })
		I[2] = new("ImageLabel", I[1], "Blood", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://121087754705235"), Position = UDim2.fromScale(0.4999999, 0.1), Size = UDim2.new(0.28, -1, 0.7, 0) })
			I[3] = new("TextLabel", I[2], "Count", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Merriweather.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.1), Size = UDim2.fromScale(0.9999999, 0.7768596), Text = "300", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 20, TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 3 })
			I[4] = new("ImageLabel", I[2], "Fill", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(255, 0, 0), ImageContent = Content.fromUri("rbxassetid://121087754705235"), Position = UDim2.fromScale(0.5000001, 0.5082644), Size = UDim2.fromScale(0.8599999, 0.8834711), ZIndex = 2 })
				I[5] = new("UIGradient", I[4], "Gradient", { Rotation = -90 })
			I[6] = new("TextLabel", I[2], "Max", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Merriweather.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, -0.45), Size = UDim2.fromScale(0.9999999, 0.708177), Text = "300", TextColor3 = Color3.fromRGB(180, 180, 180), TextSize = 15, TextStrokeTransparency = 0, ZIndex = 3 })
			I[7] = new("ImageLabel", I[2], "COOL", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(255, 0, 0), ImageContent = Content.fromUri("rbxassetid://70490437985609"), Position = UDim2.new(0.4999976, 0, 0.4999991, -1), ResampleMode = Enum.ResamplerMode.Pixelated, Size = UDim2.new(1.0000013, 0, 1.0000006, -1), ZIndex = 4 })
			I[8] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint")
		I[9] = new("Frame", I[1], "Timer", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(45, 20, 20), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.605), Size = UDim2.fromScale(1, 0.1318471) })
			I[10] = new("TextLabel", I[9], "Time", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Merriweather.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1.2898549), Text = "04:02", TextColor3 = Color3.fromRGB(255, 179, 179), TextSize = 21, TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 3 })
			I[11] = new("Frame", I[9], "Fill", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.01, 0.5), Size = UDim2.fromScale(0.98, 0.75) })
				I[12] = new("UIGradient", I[11], "Gradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.1607157, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.1617157, Color3.fromRGB(26, 26, 26)), ColorSequenceKeypoint.new(1, Color3.fromRGB(26, 26, 26)) }) })
			I[13] = new("UIAspectRatioConstraint", I[9], "UIAspectRatioConstraint", { AspectRatio = 10, AspectType = Enum.AspectType.ScaleWithParentSize })
			I[14] = new("ImageLabel", I[9], "coolbar", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://108780440686253"), Position = UDim2.fromScale(-0.01, -0.4), ResampleMode = Enum.ResamplerMode.Pixelated, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1.025, 1.8), SliceCenter = Rect.new(0, 0, 500, 500), ZIndex = 5 })
	return I[1]
end

return build
