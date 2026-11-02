-- Generated from ui/Lighting/NotEnoughMoney.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "NotEnoughMoney")
		I[2] = new("Frame", I[1], "Background", { BackgroundColor3 = Color3.fromRGB(172, 172, 172), BorderColor3 = Color3.fromRGB(49, 49, 49), BorderSizePixel = 8, Position = UDim2.fromScale(0.3, 0.35), Size = UDim2.fromScale(0.5, 0.4), ZIndex = 5 })
			I[3] = new("TextLabel", I[2], "Warning", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "You do not have enough money", TextColor3 = Color3.fromRGB(31, 31, 31), TextWrapped = true, ZIndex = 5 })
	return I[1]
end

return build
