-- Generated from ui/ReplicatedStorage/Assets/UI/DamageGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "DamageGui", { Active = true, AlwaysOnTop = true, ClipsDescendants = true, LightInfluence = 1, MaxDistance = -1, Size = UDim2.fromScale(24, 24), ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["Distance"] = 40 })
		I[2] = new("Frame", I[1], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
			I[3] = new("UIScale", I[2], "UIScale", { Scale = 0.5 })
			I[4] = new("TextLabel", I[2], "Damage", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 0.5), Text = "-100.8K", TextColor3 = Color3.fromRGB(255, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[5] = new("UIStroke", I[4], "UIStroke", { Thickness = 3 })
				I[6] = new("UIPadding", I[4], "UIPadding", { PaddingTop = UDim.new(0.2, 0) })
	return I[1]
end

return build
