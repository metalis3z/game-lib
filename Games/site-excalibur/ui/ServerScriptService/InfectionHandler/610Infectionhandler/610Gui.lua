-- Generated from ui/ServerScriptService/InfectionHandler/610Infectionhandler/610Gui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "610Gui", { DisplayOrder = -1 })
		I[2] = new("Frame", I[1], "Frame", { BackgroundColor3 = Color3.fromRGB(50, 0, 0), BackgroundTransparency = 0.6, Position = UDim2.fromOffset(0, -36), Size = UDim2.new(1, 0, 1, 36) })
			I[3] = new("TextLabel", I[2], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Balthazar.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.new(0.5, -100, 0.094, -65), Size = UDim2.fromOffset(200, 50), Text = "YOU ARE AN SCP-610 INSTANCE, FIND AND INFECT OTHER PLAYERS.", TextColor3 = Color3.fromRGB(122, 0, 0), TextSize = 30 })
	return I[1]
end

return build
