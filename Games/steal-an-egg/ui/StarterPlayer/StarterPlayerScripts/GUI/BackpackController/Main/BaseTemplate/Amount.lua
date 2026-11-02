-- Generated from ui/StarterPlayer/StarterPlayerScripts/GUI/BackpackController/Main/BaseTemplate/Amount.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("TextLabel", nil, "Amount", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(1, 1), Size = UDim2.new(1, -2, 0.725, -2), Text = "x12", TextColor3 = Color3.fromRGB(217, 217, 217), TextSize = 13, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Bottom, ZIndex = 23 })
		I[2] = new("UIStroke", I[1], "UIStroke", { Thickness = 2.0999999, Transparency = 0.5 }, { ["oldp_Thickness"] = 1.5 })
	return I[1]
end

return build
