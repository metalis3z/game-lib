-- Generated from ui/StarterPlayer/StarterPlayerScripts/CL_MAIN_GameScript/Resources/PlayMenu.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "PlayMenu", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, LayoutOrder = -10, Size = UDim2.fromOffset(100, 100) })
		I[2] = new("NumberValue", I[1], "IconID", { Value = 12812989387 }, { ["ImageColor3"] = Color3.fromRGB(46, 204, 113) })
		I[3] = new("UIScale", I[1], "UIScale")
	return I[1]
end

return build
