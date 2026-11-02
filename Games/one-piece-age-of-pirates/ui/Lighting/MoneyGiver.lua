-- Generated from ui/Lighting/MoneyGiver.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "MoneyGiver")
		I[2] = new("Frame", I[1], "MainGui", { Active = true, BackgroundColor3 = Color3.fromRGB(203, 162, 111), BackgroundTransparency = 0.1, BorderColor3 = Color3.fromRGB(126, 101, 47), BorderSizePixel = 5, Position = UDim2.fromScale(0.35, 0.3), Size = UDim2.fromScale(0.3, 0.5) })
			I[3] = new("TextLabel", I[2], "Title", { BackgroundColor3 = Color3.fromRGB(203, 162, 111), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(126, 101, 47), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 0.2), Text = "Money Giver", TextColor3 = Color3.fromRGB(245, 197, 91) })
			I[4] = new("Frame", I[2], "Line", { Active = true, BackgroundColor3 = Color3.fromRGB(126, 101, 47), BackgroundTransparency = 0.1, BorderColor3 = Color3.fromRGB(126, 101, 47), BorderSizePixel = 0, Position = UDim2.fromScale(0.2, 0.225), Size = UDim2.fromScale(0.6, 0.01) })
			I[5] = new("TextBox", I[2], "TextBox", { BackgroundColor3 = Color3.fromRGB(203, 162, 111), BackgroundTransparency = 0.1, BorderColor3 = Color3.fromRGB(126, 101, 47), BorderSizePixel = 3, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1, 0.35), Size = UDim2.fromScale(0.8, 0.3), Text = "Type Amount Here", TextColor3 = Color3.fromRGB(245, 197, 91) })
			I[6] = new("TextButton", I[2], "Finish", { BackgroundColor3 = Color3.fromRGB(158, 123, 85), BackgroundTransparency = 0.1, BorderColor3 = Color3.fromRGB(93, 73, 34), BorderSizePixel = 3, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3, 0.72), Size = UDim2.fromScale(0.4, 0.2), Text = "Finish", TextColor3 = Color3.fromRGB(198, 159, 74), TextWrapped = true })
			I[7] = new("ImageLabel", I[2], "Exit", { Active = true, BackgroundColor3 = Color3.fromRGB(172, 172, 172), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(126, 101, 47), BorderSizePixel = 2, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=138680039"), ImageTransparency = 0.2, Position = UDim2.fromScale(0.01, 0.01), Size = UDim2.fromScale(0.075, 0.075), ZIndex = 3 })
				I[8] = new("TextButton", I[7], "TextButton", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "" })
	return I[1]
end

return build
