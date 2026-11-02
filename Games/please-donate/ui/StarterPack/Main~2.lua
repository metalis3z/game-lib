-- Generated from ui/StarterPack/Main~2.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("TextButton", nil, "Main", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.8, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), LayoutOrder = 77, Size = UDim2.fromScale(1, 0.9), Text = "Part: ______________", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
		I[2] = new("UIAspectRatioConstraint", I[1], "UIAspectRatioConstraint")
		I[3] = new("UICorner", I[1], "UICorner", { BottomLeftRadius = UDim.new(0.11, 0), BottomRightRadius = UDim.new(0.11, 0), TopLeftRadius = UDim.new(0.11, 0), TopRightRadius = UDim.new(0.11, 0) })
		I[4] = new("UIStroke", I[1], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(0, 153, 255), Enabled = false, Thickness = 2 })
	return I[1]
end

return build
