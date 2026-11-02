-- Generated from ui/StarterPlayer/StarterPlayerScripts/Controllers/StatisticsController/statCard.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "statCard", { BackgroundColor3 = Color3.fromRGB(43, 45, 51), BorderSizePixel = 0 })
		I[2] = new("UICorner", I[1], "UICorner", { BottomLeftRadius = UDim.new(0.075, 0), BottomRightRadius = UDim.new(0.075, 0), TopLeftRadius = UDim.new(0.075, 0), TopRightRadius = UDim.new(0.075, 0) })
		I[3] = new("UIStroke", I[1], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(70, 68, 77), Thickness = 1.5 })
		I[4] = new("TextLabel", I[1], "value", { AnchorPoint = Vector2.new(0, 0.5), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.08, 0.34), Size = UDim2.fromScale(0.84, 0.36), Text = "0", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextTruncate = Enum.TextTruncate.AtEnd, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
		I[5] = new("TextLabel", I[1], "label", { AnchorPoint = Vector2.new(0, 0.5), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.08, 0.7), Size = UDim2.fromScale(0.84, 0.2), Text = "Stat", TextColor3 = Color3.fromRGB(237, 238, 238), TextScaled = true, TextTruncate = Enum.TextTruncate.AtEnd, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
	return I[1]
end

return build
