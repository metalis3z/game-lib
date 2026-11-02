-- Generated from ui/ReplicatedStorage/Assets/Billboards/MonsterParasite.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "MonsterParasite", { AlwaysOnTop = true, MaxDistance = 160, Size = UDim2.fromScale(1.7, 1.7), StudsOffsetWorldSpace = Vector3.new(0, 2.2, 0) }, { ["MonsterParasitePlaceholder"] = true, ["_lemonadeUniqueId"] = "CZO3iY4ECZO3" })
		I[2] = new("ImageLabel", I[1], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://110813665960952"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.94, 0.94) }, { ["_lemonadeUniqueId"] = "wo3nJe4iwo3n" })
	return I[1]
end

return build
