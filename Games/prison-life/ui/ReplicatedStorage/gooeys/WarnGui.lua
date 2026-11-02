-- Generated from ui/ReplicatedStorage/gooeys/WarnGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "WarnGui")
		I[2] = new("Frame", I[1], "Frame", { BackgroundColor3 = Color3.fromRGB(9, 25, 36), BorderSizePixel = 0, Position = UDim2.fromScale(-0.25, 0.37), Size = UDim2.fromScale(0.25, 0.2), SizeConstraint = Enum.SizeConstraint.RelativeYY })
			I[3] = new("Frame", I[2], "Frame", { BackgroundColor3 = Color3.fromRGB(220, 50, 47), BorderSizePixel = 0, Size = UDim2.fromScale(1, 0.05) })
			I[4] = new("TextLabel", I[2], "title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.06), Size = UDim2.fromScale(1, 0.2), Text = "WARNING", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[5] = new("TextLabel", I[2], "desc", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.05, 0.2), Size = UDim2.fromScale(0.9, 0.7), Text = "Do not kill innocent people! You will be arrested and jailed if you kill _ more times.", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
	return I[1]
end

return build
