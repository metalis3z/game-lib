-- Generated from ui/ReplicatedStorage/Assets/UI/Notifications/Top/HugeParty.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "HugeParty", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) })
		I[2] = new("Frame", I[1], "TextHolder", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 0.85) })
			I[3] = new("TextLabel", I[2], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 1, RichText = true, Size = UDim2.fromScale(1, 0.4), Text = "<stroke color=\"#000000\" joins=\"bevel\" thickness=\"3\" transparency=\"0\">H<font color=\"rgb(255,182,240)\">U</font>G<font color=\"rgb(255,182,240)\">E</font> P<font color=\"rgb(255,182,240)\">A</font>R<font color=\"rgb(255,182,240)\">T</font>Y!</stroke>", TextColor3 = Color3.fromRGB(255, 55, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[4] = new("UIStroke", I[3], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 3 })
			I[5] = new("TextLabel", I[2], "Countdown", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 3, Size = UDim2.fromScale(1, 0.3), Text = "100:00:00", TextColor3 = Color3.fromRGB(55, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[6] = new("UIStroke", I[5], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2.5 })
			I[7] = new("TextLabel", I[2], "Odds", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 2, Size = UDim2.fromScale(1, 0.3), Text = "3x HUGE CHANCE!", TextColor3 = Color3.fromRGB(252, 255, 55), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[8] = new("UIStroke", I[7], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 3 })
			I[9] = new("UIListLayout", I[2], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
		I[10] = new("ImageLabel", I[1], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://120802901067174"), Position = UDim2.fromScale(0.0221517, -0.0263364), Rotation = 180, ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.2630468, 0.5930298) })
		I[11] = new("ImageLabel", I[1], "ImageLabel_2", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://121143798450847"), Position = UDim2.fromScale(0.9782532, -0.0263364), Rotation = 180, ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.263, 0.593) })
	return I[1]
end

return build
