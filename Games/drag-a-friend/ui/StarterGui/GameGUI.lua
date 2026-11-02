-- Generated from ui/StarterGui/GameGUI.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "GameGUI", { ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("TextButton", I[1], "Leave", { BackgroundColor3 = Color3.fromRGB(35, 35, 35), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/PressStart2P.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4289544, 0.8918685), Size = UDim2.fromOffset(265, 50), Text = "LEAVE", TextColor3 = Color3.fromRGB(207, 207, 207), TextSize = 54, Visible = false })
			I[3] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0.075, 0), BottomRightRadius = UDim.new(0.075, 0), TopLeftRadius = UDim.new(0.075, 0), TopRightRadius = UDim.new(0.075, 0) })
	return I[1]
end

return build
