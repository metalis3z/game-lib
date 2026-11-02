-- Generated from ui/StarterGui/CmdrToggleButton.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "CmdrToggleButton", { ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("TextButton", I[1], "OpenCmdrButton", { BackgroundColor3 = Color3.fromRGB(255, 170, 255), BackgroundTransparency = 0.2, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Bold, Enum.FontStyle.Italic), Position = UDim2.new(0.8297508, 10, 0.8146803, -25), Size = UDim2.fromOffset(132, 41), Text = "f4 panel", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 22 })
			I[3] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0, 10), BottomRightRadius = UDim.new(0, 10), TopLeftRadius = UDim.new(0, 10), TopRightRadius = UDim.new(0, 10) })
			I[4] = new("UIStroke", I[2], "UIStroke", { Color = Color3.fromRGB(80, 80, 100), Thickness = 1.5 })
	return I[1]
end

return build
