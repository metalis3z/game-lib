-- Generated from ui/StarterGui/VersionLabel.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "VersionLabel", { ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("TextLabel", I[1], "UpdateLabel", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.9944013, 0.026616), Size = UDim2.fromOffset(103, 30), Text = "v1337", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextTransparency = 0.7, TextWrapped = true })
			I[3] = new("UIStroke", I[2], "UIStroke", { Transparency = 0.5 })
	return I[1]
end

return build
