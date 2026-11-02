-- Generated from ui/ReplicatedStorage/TranslationPointUI.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "TranslationPointUI", { Active = true, Enabled = false, LightInfluence = 1, MaxDistance = 35, Size = UDim2.fromOffset(200, 80), ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("TextLabel", I[1], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), AutomaticSize = Enum.AutomaticSize.XY, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Text = "He will never be translated *Spits cereal*", TextColor3 = Color3.fromRGB(255, 211, 175), TextSize = 36, TextWrapped = true })
			I[3] = new("UIStroke", I[2], "UIStroke", { Color = Color3.fromRGB(47, 36, 31), Thickness = 2 })
	return I[1]
end

return build
