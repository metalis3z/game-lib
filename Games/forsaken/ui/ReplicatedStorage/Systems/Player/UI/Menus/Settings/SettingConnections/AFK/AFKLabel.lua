-- Generated from ui/ReplicatedStorage/Systems/Player/UI/Menus/Settings/SettingConnections/AFK/AFKLabel.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("TextLabel", nil, "AFKLabel", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/AccanthisADFStd.json", Enum.FontWeight.Bold, Enum.FontStyle.Italic), Position = UDim2.fromScale(0.5, 0.975), Size = UDim2.new(0.75, 0, 0, 50), Text = "AFK mode is on. While enabled, you will be kept from being put ingame every time a match starts.\nAFK mode can be toggled on/off in the settings menu and in the lobby through talking to the grandfather clock.", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 20, TextStrokeColor3 = Color3.fromRGB(255, 255, 255), TextTransparency = 0.75, TextWrapped = true, ZIndex = -10 })
	return I[1]
end

return build
