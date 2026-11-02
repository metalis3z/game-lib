-- Generated from ui/ReplicatedStorage/gooeys/camGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "camGui")
		I[2] = new("Frame", I[1], "Frame", { BackgroundColor3 = Color3.fromRGB(39, 39, 39), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 4, Position = UDim2.fromScale(0, 0.7), Size = UDim2.fromScale(1, 0.3), Style = Enum.FrameStyle.DropShadow })
			I[3] = new("TextLabel", I[2], "TextLabel", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 2, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 0.2), Text = "Press [Q] or [E] to switch cameras. Press spacebar or deselect tool to exit.", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 24, TextWrapped = true })
			I[4] = new("TextLabel", I[2], "desc", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 2, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 0.6), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 36, TextWrapped = true })
			I[5] = new("Frame", I[2], "Frame", { BackgroundColor3 = Color3.fromRGB(39, 39, 39), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 4, Size = UDim2.fromScale(1, 0.2), Style = Enum.FrameStyle.DropShadow })
	return I[1]
end

return build
