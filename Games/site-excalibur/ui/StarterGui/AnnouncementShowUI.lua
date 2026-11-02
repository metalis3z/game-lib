-- Generated from ui/StarterGui/AnnouncementShowUI.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "AnnouncementShowUI", { ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("ImageButton", I[1], "Main", { Active = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(54, 54, 54), ImageContent = Content.fromUri("rbxassetid://2790382281"), Position = UDim2.fromScale(0.314, -0.3), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.371, 0.1601837), SliceCenter = Rect.new(4, 4, 252, 252) })
			I[3] = new("ImageButton", I[2], "ShoutFrame", { Active = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(74, 74, 74), ImageContent = Content.fromUri("rbxassetid://2790382281"), Position = UDim2.fromScale(0.0134797, 0.4687196), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.9703447, 0.4457006), SliceCenter = Rect.new(4, 4, 252, 252) })
				I[4] = new("TextLabel", I[3], "Shout", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Zekton.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), RichText = true, Size = UDim2.fromScale(1.0000001, 0.9991254), Text = "Test", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[5] = new("ImageButton", I[2], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 170, 255), ImageContent = Content.fromUri("rbxassetid://2790390993"), Position = UDim2.fromScale(0.0134797, 0.0879081), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.9703447, 0.2731017), SliceCenter = Rect.new(16, 16, 240, 240) })
				I[6] = new("TextLabel", I[5], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Zekton.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.1043656), RichText = true, Size = UDim2.fromScale(1, 0.75), Text = "Announcemet from hghghghv", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
	return I[1]
end

return build
