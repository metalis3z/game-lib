-- Generated from ui/StarterGui/ShadowToggleGUI.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "ShadowToggleGUI", { ResetOnSpawn = false })
		I[2] = new("TextButton", I[1], "ToggleButton", { BackgroundColor3 = Color3.fromRGB(45, 45, 45), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0, 0, 0.9710425, -25), Size = UDim2.fromOffset(160, 40), Text = "Shadows: ON", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 16, TextWrapped = true })
	return I[1]
end

return build
