-- Generated from ui/StarterPlayer/StarterPlayerScripts/CL_EntryScript/PlayerButton.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("TextButton", nil, "PlayerButton", { AutoButtonColor = false, AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(127, 140, 141), BorderSizePixel = 0, Size = UDim2.new(1, 0, 0.1, 1), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.65, TextWrapped = true, ZIndex = 2 })
		I[2] = new("TextLabel", I[1], "Friend", { AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.02, 0), Size = UDim2.fromScale(0.68, 1), Text = "Player Name", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.65, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
		I[3] = new("UICorner", I[1], "UI_Corner", { BottomLeftRadius = UDim.new(0.125, 0), BottomRightRadius = UDim.new(0.125, 0), TopLeftRadius = UDim.new(0.125, 0), TopRightRadius = UDim.new(0.125, 0) })
		I[4] = new("TextLabel", I[1], "Desc", { BackgroundColor3 = Color3.fromRGB(52, 152, 219), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.7, 0), Size = UDim2.fromScale(0.3, 1), Text = "Mode", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.65, TextWrapped = true })
		I[5] = new("UIGradient", I[1], "UI_Gradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(127, 127, 127)), ColorSequenceKeypoint.new(0.0515807, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.332779, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.950083, Color3.fromRGB(127, 127, 127)), ColorSequenceKeypoint.new(1, Color3.fromRGB(63, 63, 63)) }), Rotation = 90 })
	return I[1]
end

return build
