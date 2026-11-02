-- Generated from ui/StarterGui/COPYRIGHT.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "COPYRIGHT", { Enabled = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("TextBox", I[1], "TextBox", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), PlaceholderColor3 = Color3.fromRGB(178, 178, 178), Position = UDim2.fromScale(0, 0.9648094), Selectable = false, Size = UDim2.fromOffset(200, 24), Text = "", TextColor3 = Color3.fromRGB(253, 253, 253), TextSize = 14, TextStrokeTransparency = 0.5, TextTransparency = 0.5 })
		I[3] = new("TextBox", I[1], "TextBox", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), PlaceholderColor3 = Color3.fromRGB(178, 178, 178), Position = UDim2.fromScale(0, 0.94), Selectable = false, Size = UDim2.fromOffset(200, 24), Text = "", TextColor3 = Color3.fromRGB(253, 253, 253), TextSize = 14, TextStrokeTransparency = 0.5, TextTransparency = 0.5 })
	return I[1]
end

return build
