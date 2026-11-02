-- Generated from ui/ReplicatedStorage/Modules/Alerts/Template.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("TextLabel", nil, "Template", { BackgroundColor3 = Color3.fromRGB(96, 166, 231), BorderColor3 = Color3.fromRGB(96, 166, 231), BorderMode = Enum.BorderMode.Inset, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.new(1, 0, 0, 35), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
		I[2] = new("UICorner", I[1], "UICorner", { BottomLeftRadius = UDim.new(0.2, 0), BottomRightRadius = UDim.new(0.2, 0), TopLeftRadius = UDim.new(0.2, 0), TopRightRadius = UDim.new(0.2, 0) })
		I[3] = new("TextLabel", I[1], "TextD", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(96, 166, 231), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(96, 166, 231), BorderMode = Enum.BorderMode.Inset, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.9), Text = "+10000000 Honey", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 42, TextStrokeTransparency = 0.95, TextWrapped = true, Visible = false })
		I[4] = new("IntValue", I[1], "Amount")
	return I[1]
end

return build
