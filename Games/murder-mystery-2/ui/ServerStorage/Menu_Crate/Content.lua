-- Generated from ui/ServerStorage/Menu_Crate/Content.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Content", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.4, BorderColor3 = Color3.fromRGB(230, 0, 0), Position = UDim2.fromOffset(150, 1), Size = UDim2.fromOffset(148, 148) })
		I[2] = new("TextLabel", I[1], "ItemName", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0, 2, 1, 0), Size = UDim2.new(1, 0, 0, -30), Text = "Beached", TextColor3 = Color3.fromRGB(230, 0, 0), TextScaled = true, TextSize = 24, TextStrokeTransparency = 0.5, TextWrapped = true })
		I[3] = new("TextLabel", I[1], "Variant", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.new(0, 2, 1, -18), Size = UDim2.new(1, 0, 0, -14), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14, TextStrokeTransparency = 0.5, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Bottom })
		I[4] = new("ImageLabel", I[1], "ItemImage", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), ZIndex = 2 })
	return I[1]
end

return build
