-- Generated from ui/ReplicatedStorage/Assets/OptionExample.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ImageLabel", nil, "OptionExample", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(122, 95, 76), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=9882336844"), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromOffset(340, 59), SliceCenter = Rect.new(192, 255, 192, 255) })
		I[2] = new("TextLabel", I[1], "QName", { BackgroundColor3 = Color3.fromRGB(255, 138, 220), BackgroundTransparency = 1, BorderSizePixel = 0, ClipsDescendants = true, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromOffset(11, 6), Size = UDim2.fromOffset(206, 45), Text = "Music", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 23, TextStrokeTransparency = 0.72, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 6 })
			I[3] = new("UIStroke", I[2], "UIStroke", { Color = Color3.fromRGB(66, 66, 66), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2.2 })
			I[4] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
		I[5] = new("TextButton", I[1], "TextButton", { BackgroundColor3 = Color3.fromRGB(213, 59, 53), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.7176471, 0.196647), Size = UDim2.fromOffset(84, 35), Text = "Enabled", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 99 })
			I[6] = new("UIStroke", I[5], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(75, 61, 45), Thickness = 2.0999999 })
	return I[1]
end

return build
