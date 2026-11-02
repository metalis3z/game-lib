-- Generated from ui/ReplicatedStorage/Assets/UI/InfoHover/Components/Serial.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("TextLabel", nil, "Serial", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 10, Position = UDim2.fromScale(0.0944612, 0.7652586), Size = UDim2.fromScale(0.7867028, 0.0645901), Text = "#526 - @Roks3k", TextColor3 = Color3.fromRGB(195, 56, 250), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 1550 })
	return I[1]
end

return build
