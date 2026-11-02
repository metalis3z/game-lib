-- Generated from ui/_StarterGui-all.rbxm by _tools/rbxm2lua.luau
-- UI builder: local gui = require(this)(); gui.Parent = game.Players.LocalPlayer.PlayerGui (or StarterGui)
-- Large pack: split into ModuleScript children (Rojo layout). In Studio make init.lua a ModuleScript
-- and put each PartNN.lua inside it as a ModuleScript named PartNN.

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

local parts = { script.Part01, script.Part02, script.Part03, script.Part04, script.Part05, script.Part06, script.Part07, script.Part08, script.Part09, script.Part10, script.Part11, script.Part12, script.Part13, script.Part14, script.Part15 }

local function build()
	local I = {}
	for _, part in parts do
		require(part)(I, new)
	end
	return { I[1], I[4], I[96], I[148], I[523], I[938], I[941], I[970], I[1688], I[2823], I[2828], I[8947], I[9053], I[9114], I[9193] }
end

return build
