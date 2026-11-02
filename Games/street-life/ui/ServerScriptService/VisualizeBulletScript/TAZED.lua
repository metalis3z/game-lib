-- Generated from ui/ServerScriptService/VisualizeBulletScript/TAZED.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "TAZED", { Active = true, ClipsDescendants = true, Enabled = false, MaxDistance = 150, Size = UDim2.fromScale(3, 1), StudsOffsetWorldSpace = Vector3.new(0, 2, 0), ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("TextLabel", I[1], "DeathLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2, 0), Size = UDim2.fromScale(0.6, 0.6), Text = "*TAZED*", TextColor3 = Color3.fromRGB(209, 139, 0), TextScaled = true, TextSize = 1, TextStrokeTransparency = 0, TextWrapped = true })
	return I[1]
end

return build
