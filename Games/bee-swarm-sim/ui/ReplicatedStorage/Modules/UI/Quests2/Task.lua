-- Generated from ui/ReplicatedStorage/Modules/UI/Quests2/Task.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Task", { BackgroundColor3 = Color3.fromRGB(218, 68, 68), BorderSizePixel = 0, Position = UDim2.new(0.024, 0, 0, 43), Size = UDim2.new(0.9523934, 0, 0, 27) })
		I[2] = new("Frame", I[1], "Fill", { BackgroundColor3 = Color3.fromRGB(108, 199, 75), BorderSizePixel = 0, Size = UDim2.fromScale(0, 1) })
			I[3] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0, 5), BottomRightRadius = UDim.new(0, 5), TopLeftRadius = UDim.new(0, 5), TopRightRadius = UDim.new(0, 5) })
		I[4] = new("UIStroke", I[1], "UIStroke", { Color = Color3.fromRGB(42, 42, 42), Thickness = 3 })
		I[5] = new("UICorner", I[1], "UICorner", { BottomLeftRadius = UDim.new(0, 5), BottomRightRadius = UDim.new(0, 5), TopLeftRadius = UDim.new(0, 5), TopRightRadius = UDim.new(0, 5) })
		I[6] = new("TextLabel", I[1], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "50/100 Pollen", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.75, TextWrapped = true, ZIndex = 2 })
	return I[1]
end

return build
