-- Generated from ui/ServerScriptService/GiveUI/AnnouncementUI.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "AnnouncementUI", { ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("ImageButton", I[1], "Button", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(54, 54, 54), ImageContent = Content.fromUri("rbxassetid://2790382281"), Position = UDim2.fromScale(0.009, 0.795), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.0405268, 0.0668896), SliceCenter = Rect.new(4, 4, 252, 252) })
			I[3] = new("ImageButton", I[2], "Main", { Active = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(54, 54, 54), ImageContent = Content.fromUri("rbxassetid://2790382281"), Position = UDim2.fromScale(-5.3388553, 0), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(4.8638549, 2.8360753), SliceCenter = Rect.new(4, 4, 252, 252) })
				I[4] = new("ImageButton", I[3], "TextFrame", { Active = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(85, 170, 255), ImageContent = Content.fromUri("rbxassetid://2790382281"), Position = UDim2.fromScale(0.0368138, 0.0635854), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.9210883, 0.2488473), SliceCenter = Rect.new(4, 4, 252, 252) })
					I[5] = new("TextLabel", I[4], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Zekton.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0793164, 0.1266099), Size = UDim2.fromScale(0.8370118, 0.7323599), Text = "Announcement Panel", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[6] = new("Folder", I[3], "ShoutSystem")
					I[7] = new("ImageButton", I[6], "ShoutFrame", { Active = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(39, 39, 39), ImageContent = Content.fromUri("rbxassetid://2790382281"), Position = UDim2.fromScale(0.0409366, 0.7268279), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.9210883, 0.2034359), SliceCenter = Rect.new(4, 4, 252, 252) })
						I[8] = new("TextBox", I[7], "Message", { Active = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), PlaceholderColor3 = Color3.fromRGB(178, 178, 178), PlaceholderText = "Write shout here.", Size = UDim2.fromScale(0.9936717, 0.9552519), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14 })
					I[9] = new("ImageButton", I[6], "ShoutButton", { Active = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(255, 0, 68), ImageContent = Content.fromUri("rbxassetid://2790382281"), Position = UDim2.fromScale(0.0409366, 0.4660589), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.4332184, 0.2155384), SliceCenter = Rect.new(4, 4, 252, 252) })
						I[10] = new("TextLabel", I[9], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Zekton.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0505976, 0.12661), Size = UDim2.fromScale(0.8827604, 0.7323599), Text = "Announce", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[11] = new("ImageLabel", I[2], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://3926305904"), ImageRectOffset = Vector2.new(4, 244), ImageRectSize = Vector2.new(36, 36), Position = UDim2.fromScale(0.1, 0.1203985), Size = UDim2.fromScale(0.775, 0.7250001) })
			I[12] = new("Sound", I[2], "ClickSound", { Volume = 2 })
	return I[1]
end

return build
