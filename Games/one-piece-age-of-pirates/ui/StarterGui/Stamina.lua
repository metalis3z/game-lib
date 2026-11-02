-- Generated from ui/StarterGui/Stamina.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Stamina")
		I[2] = new("Frame", I[1], "Frame", { BackgroundColor3 = Color3.fromRGB(51, 109, 47), BackgroundTransparency = 0.2, BorderColor3 = Color3.fromRGB(24, 24, 24), BorderSizePixel = 3, Position = UDim2.fromScale(0.1, 0.85), Size = UDim2.fromScale(0.15, 0.075) })
			I[3] = new("Frame", I[2], "Frame", { BackgroundColor3 = Color3.fromRGB(78, 168, 73), BackgroundTransparency = 0.3, BorderColor3 = Color3.fromRGB(24, 24, 24), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = 2 })
			I[4] = new("TextLabel", I[2], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "Stamina", TextColor3 = Color3.fromRGB(25, 25, 25), TextScaled = true, TextWrapped = true, ZIndex = 3 })
			I[5] = new("NumberValue", I[2], "Value", { Value = 100 })
	return I[1]
end

return build
