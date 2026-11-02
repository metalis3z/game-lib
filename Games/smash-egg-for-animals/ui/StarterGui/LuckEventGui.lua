-- Generated from ui/StarterGui/LuckEventGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "LuckEventGui", { DisplayOrder = 4, Enabled = false, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets })
		I[2] = new("TextLabel", I[1], "Luck", { AnchorPoint = Vector2.new(0.5, 0), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.new(0.5, 0, 0, 100), Size = UDim2.fromOffset(420, 36), Text = "", TextColor3 = Color3.fromRGB(255, 215, 0), TextSize = 28, TextStrokeTransparency = 0.25, Visible = false })
	return I[1]
end

return build
