-- Generated from ui/ReplicatedStorage/gooeys/messageGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "messageGui", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.4, BorderColor3 = Color3.fromRGB(53, 53, 53), BorderSizePixel = 0, Position = UDim2.fromScale(0, -0.2), Selectable = true, Size = UDim2.fromScale(1, 0.1), ZIndex = 4 })
		I[2] = new("TextLabel", I[1], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 0.5), Text = "PRISON ANNOUNCEMENT", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 32, TextStrokeColor3 = Color3.fromRGB(50, 50, 50), TextStrokeTransparency = 0.5, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Bottom, ZIndex = 7 })
		I[3] = new("TextLabel", I[1], "Desc", { BackgroundColor3 = Color3.fromRGB(43, 43, 43), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(1, 0.5), Text = "Lunch is now being served in the cafeteria. Attendance is mandatory as usual.", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 24, TextStrokeColor3 = Color3.fromRGB(50, 50, 50), TextStrokeTransparency = 0.5, TextWrapped = true, ZIndex = 7 })
		I[4] = new("ImageLabel", I[1], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://267232285"), ImageTransparency = 0.5, Size = UDim2.fromScale(1, 1) })
	return I[1]
end

return build
