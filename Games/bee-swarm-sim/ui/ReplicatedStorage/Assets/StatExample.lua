-- Generated from ui/ReplicatedStorage/Assets/StatExample.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ImageLabel", nil, "StatExample", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(122, 95, 76), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=9882336844"), Position = UDim2.fromScale(0, 0.0749542), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromOffset(340, 48), SliceCenter = Rect.new(192, 255, 192, 255) })
		I[2] = new("Folder", I[1], "_Name")
			I[3] = new("TextLabel", I[2], "QName", { BackgroundColor3 = Color3.fromRGB(255, 138, 220), BackgroundTransparency = 1, BorderSizePixel = 0, ClipsDescendants = true, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LineHeight = 0.88, Position = UDim2.fromOffset(63, 4), Size = UDim2.fromOffset(204, 39), Text = " delete", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 23, TextStrokeTransparency = 0.72, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 6 })
				I[4] = new("UIStroke", I[3], "UIStroke", { Color = Color3.fromRGB(66, 66, 66), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2.2 })
				I[5] = new("UICorner", I[3], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
		I[6] = new("Folder", I[1], "_Value")
			I[7] = new("TextLabel", I[6], "QValue", { BackgroundColor3 = Color3.fromRGB(255, 138, 220), BackgroundTransparency = 1, BorderSizePixel = 0, ClipsDescendants = true, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromOffset(267, 2), Size = UDim2.fromOffset(70, 39), Text = "100%", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 25, TextStrokeTransparency = 0.72, TextWrapped = true, ZIndex = 6 })
				I[8] = new("UIStroke", I[7], "UIStroke", { Color = Color3.fromRGB(66, 66, 66), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2.2 })
				I[9] = new("UICorner", I[7], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
		I[10] = new("ImageLabel", I[1], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://14840705234"), Position = UDim2.fromScale(-0.0013469, -0.1875), Size = UDim2.fromOffset(64, 66), ZIndex = 999999999 })
	return I[1]
end

return build
