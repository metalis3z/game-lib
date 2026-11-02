-- Generated from ui/ReplicatedStorage/Modules/UI/Quests2/Template.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Template", { BackgroundColor3 = Color3.fromRGB(217, 107, 107), BorderMode = Enum.BorderMode.Inset, BorderSizePixel = 0, Position = UDim2.fromScale(0.046, 0), Size = UDim2.new(0.908, 0, 0, 35) })
		I[2] = new("UICorner", I[1], "UICorner")
		I[3] = new("Frame", I[1], "FillBar", { BackgroundColor3 = Color3.fromRGB(111, 222, 113), BorderMode = Enum.BorderMode.Inset, BorderSizePixel = 0, Size = UDim2.fromScale(0.4899689, 1) })
			I[4] = new("UICorner", I[3], "UICorner")
		I[5] = new("TextLabel", I[1], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0139056, 0.0857143), Size = UDim2.fromScale(0.9721888, 0.8242859), Text = "Collect 15 Cengdops. 0/15", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.4, TextWrapped = true })
	return I[1]
end

return build
