-- Generated from ui/ReplicatedStorage/Modules/MapVoting/MapChoice.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ImageLabel", nil, "MapChoice", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://81699914649761"), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(15, 15, 415, 380) })
		I[2] = new("TextButton", I[1], "TitleButton", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/AccanthisADFStd.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, -26, 1, -24), Text = "Mostly Twenty Chars", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Bottom, ZIndex = 2 })
			I[3] = new("UIPadding", I[2], "UIPadding", { PaddingLeft = UDim.new(0.05, 0), PaddingRight = UDim.new(0.05, 0), PaddingTop = UDim.new(0.6, 0) })
			I[4] = new("UIStroke", I[2], "UIStroke", { Thickness = 2 })
		I[5] = new("TextLabel", I[1], "Gamemode", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/AccanthisADFStd.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.new(0.5, 0, 0, 15), Size = UDim2.fromScale(0.6, 0.125), Text = "Standard", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 3 })
			I[6] = new("UIStroke", I[5], "UIStroke", { Thickness = 2 })
		I[7] = new("ImageLabel", I[1], "Render", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(150, 150, 150), ImageContent = Content.fromUri("rbxassetid://77285008779144"), ScaleType = Enum.ScaleType.Crop, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(15, 15, 415, 380) })
		I[8] = new("UIPadding", I[1], "UIPadding", { PaddingBottom = UDim.new(0, 12), PaddingLeft = UDim.new(0, 13), PaddingRight = UDim.new(0, 13), PaddingTop = UDim.new(0, 12) })
		I[9] = new("TextLabel", I[1], "Votes", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/AccanthisADFStd.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromOffset(4, 4), Size = UDim2.fromScale(0.15, 0.15), Text = "0", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 3 })
			I[10] = new("UIStroke", I[9], "UIStroke", { Thickness = 2 })
	return I[1]
end

return build
