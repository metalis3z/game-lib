-- Generated from ui/ServerStorage/Assets/Models/Cosmetics/Titles/Admin.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "Admin", { Active = true, ClipsDescendants = true, LightInfluence = 1, MaxDistance = math.huge, Size = UDim2.fromScale(4, 1), StudsOffsetWorldSpace = Vector3.new(0, 4, 0), ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["GroupRank"] = 200 })
		I[2] = new("TextLabel", I[1], "Text", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), RichText = true, Size = UDim2.fromScale(1, 1), Text = "[ ADMIN ]", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
	return I[1]
end

return build
