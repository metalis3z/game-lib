-- Generated from ui/ReplicatedStorage/Billboard_UI.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "Billboard_UI", { Active = true, AlwaysOnTop = true, ClipsDescendants = true, MaxDistance = 100, Size = UDim2.fromScale(12, 4.75), StudsOffset = Vector3.new(7.5, 0, 0), ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("UIListLayout", I[1], "UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center }, { ["_syncbackDontRename"] = true })
	return I[1]
end

return build
