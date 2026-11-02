-- Generated from ui/ServerScriptService/Realism Mod/_me/Emote.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "Emote", { MaxDistance = 65, Size = UDim2.fromScale(10, 10) })
		I[2] = new("Frame", I[1], "MainFrame", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderSizePixel = 5, Position = UDim2.fromScale(0.4, -0.0501002), Size = UDim2.fromScale(0.2, 0.018) })
			I[3] = new("TextLabel", I[2], "rank", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(-0.631, 14.0553751), Size = UDim2.fromScale(2.2409999, 2.6359999), Text = "[RP]: **[action]**", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.7, TextWrapped = true })
				I[4] = new("UIGradient", I[3], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(29, 0, 44)), ColorSequenceKeypoint.new(0.485857, Color3.fromRGB(170, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(29, 0, 44)) }), Rotation = 90 })
	return I[1]
end

return build
