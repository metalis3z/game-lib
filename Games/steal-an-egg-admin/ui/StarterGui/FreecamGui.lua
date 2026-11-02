-- Generated from ui/StarterGui/FreecamGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "FreecamGui", { ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets }, { ["_lemonadeUniqueId"] = "60pFzJsw60pF" })
		I[2] = new("BindableEvent", I[1], "ToggleRequested", nil, { ["_lemonadeUniqueId"] = "SCCO0LLdSCCO" })
	return I[1]
end

return build
