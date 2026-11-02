-- Generated from ui/ReplicatedStorage/Modules/UI/Shops2/CItemTemplate.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ImageLabel", nil, "CItemTemplate", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://12875049218"), Position = UDim2.fromScale(0, 0.0657656), ResampleMode = Enum.ResamplerMode.Pixelated, ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.2144164, 0.8684689), ZIndex = 2 })
		I[2] = new("TextLabel", I[1], "Am", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.623067), Size = UDim2.fromScale(1.0000001, 0.376933), Text = "x165", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.64, TextWrapped = true, ZIndex = 2 })
	return I[1]
end

return build
