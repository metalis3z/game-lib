-- Generated from ui/ReplicatedStorage/gooeys/promptGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "promptGui")
		I[2] = new("Frame", I[1], "Frame", { BackgroundColor3 = Color3.fromRGB(125, 125, 125), BackgroundTransparency = 0.5, Position = UDim2.fromScale(0, -1), Size = UDim2.fromScale(1, 1) })
			I[3] = new("Frame", I[2], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(200, 200, 200), BorderSizePixel = 2, Position = UDim2.new(0.5, -225, 0.5, -100), Size = UDim2.fromOffset(450, 200) })
				I[4] = new("TextLabel", I[3], "title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.new(1, 0, 0, 40), Text = "Header", TextSize = 36, ZIndex = 5 })
				I[5] = new("Frame", I[3], "Frame", { BackgroundColor3 = Color3.fromRGB(27, 42, 53), BorderColor3 = Color3.fromRGB(150, 150, 150), BorderSizePixel = 0, Position = UDim2.fromScale(0.05, 0.2), Size = UDim2.new(0.9, 0, 0, 2), ZIndex = 5 })
				I[6] = new("TextLabel", I[3], "body", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.2), Size = UDim2.new(1, 0, 0, 105), Text = "Body text: Lorem ipsum dolor sit amet, sea eu nobis iisque suscipit. Illud iracundia incorrupte duo ei, discere hendrerit conclusionemque an sea, choro prodesset", TextSize = 18, TextWrapped = true, ZIndex = 5 })
				I[7] = new("TextButton", I[3], "TextButton", { BackgroundColor3 = Color3.fromRGB(124, 255, 76), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0.5, -75, 1, -55), Size = UDim2.fromOffset(150, 50), Style = Enum.ButtonStyle.RobloxRoundDropdownButton, Text = "OK", TextSize = 24, ZIndex = 5 })
	return I[1]
end

return build
