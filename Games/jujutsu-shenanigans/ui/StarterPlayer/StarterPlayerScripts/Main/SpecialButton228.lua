-- Generated from ui/StarterPlayer/StarterPlayerScripts/Main/SpecialButton228.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ImageButton", nil, "SpecialButton228", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://6256840888"), Interactable = false, LayoutOrder = 3, Position = UDim2.new(0.8961424, -95, 1.1257485, -315), Size = UDim2.fromOffset(70, 70), Visible = false })
	return I[1]
end

return build
