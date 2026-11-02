-- Generated from ui/StarterGui/GangZone.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "GangZone", { ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("ImageLabel", I[1], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(34, 34, 34), ImageContent = Content.fromUri("rbxassetid://3570695787"), ImageTransparency = 1, Position = UDim2.fromScale(0.1416996, 0.644618), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.1348169, 0.0876297), SliceCenter = Rect.new(100, 100, 100, 100), SliceScale = 0.12 })
			I[3] = new("TextLabel", I[2], "TextLabel2", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0000001, 0.2257999), Size = UDim2.fromScale(1.0000001, 0.6688244), Text = "YOU ARE ENTERING A ZONE WITH A LOT OF CRIME!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextTransparency = 1, TextWrapped = true })
				I[4] = new("UIStroke", I[3], "UIStroke", { Transparency = 1 })
			I[5] = new("TextLabel", I[2], "TextLabel3", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0000001, -0.0809462), Size = UDim2.fromScale(1.0000001, 0.306746), Text = "WARNING !", TextColor3 = Color3.fromRGB(255, 0, 4), TextScaled = true, TextSize = 14, TextTransparency = 1, TextWrapped = true })
				I[6] = new("UIStroke", I[5], "UIStroke", { Thickness = 2, Transparency = 1 })
			I[7] = new("TextLabel", I[2], "Block", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0000001, 0.863812), Size = UDim2.fromScale(1.0000001, 0.4008225), Text = "NORTH", TextColor3 = Color3.fromRGB(255, 0, 4), TextScaled = true, TextSize = 14, TextTransparency = 1, TextWrapped = true })
				I[8] = new("UIStroke", I[7], "UIStroke", { Transparency = 1 })
			I[9] = new("BoolValue", I[2], "Value")
	return I[1]
end

return build
