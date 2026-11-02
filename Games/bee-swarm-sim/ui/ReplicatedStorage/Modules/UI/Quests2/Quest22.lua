-- Generated from ui/ReplicatedStorage/Modules/UI/Quests2/Quest22.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ImageLabel", nil, "Quest22", { BackgroundColor3 = Color3.fromRGB(103, 81, 64), Size = UDim2.new(0.995, 0, 0, 80) })
		I[2] = new("UICorner", I[1], "UICorner", { BottomLeftRadius = UDim.new(0, 10), BottomRightRadius = UDim.new(0, 10), TopLeftRadius = UDim.new(0, 10), TopRightRadius = UDim.new(0, 10) })
		I[3] = new("TextLabel", I[1], "QuestType", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.new(0.0502513, 0, 0, 5), Size = UDim2.new(0.5927004, 0, 0, 25), Text = "Test Quest", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
			I[4] = new("UICorner", I[3], "UICorner", { BottomLeftRadius = UDim.new(0, 50), BottomRightRadius = UDim.new(0, 50), TopLeftRadius = UDim.new(0, 50), TopRightRadius = UDim.new(0, 50) })
		I[5] = new("TextLabel", I[1], "NPC", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.new(0.6429515, 0, 0, 5), Size = UDim2.new(0.309442, 0, 0, 25), Text = "Brown Bear", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right })
			I[6] = new("UICorner", I[5], "UICorner", { BottomLeftRadius = UDim.new(0, 50), BottomRightRadius = UDim.new(0, 50), TopLeftRadius = UDim.new(0, 50), TopRightRadius = UDim.new(0, 50) })
		I[7] = new("UIGradient", I[1], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(226, 226, 226)), ColorSequenceKeypoint.new(1, Color3.fromRGB(173, 173, 173)) }), Rotation = -90 })
	return I[1]
end

return build
