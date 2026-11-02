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

local parts = { script.Part01, script.Part02, script.Part03, script.Part04, script.Part05, script.Part06, script.Part07 }

local function build()
	local I = {}
	for _, part in parts do
		require(part)(I, new)
	end
	I[2348].PrimaryPart = I[2353]
	I[2349].PrimaryPart = I[2353]
	I[2389].PrimaryPart = I[2394]
	I[2390].PrimaryPart = I[2394]
	I[2436].PrimaryPart = I[2441]
	I[2437].PrimaryPart = I[2441]
	return { I[1], I[2], I[3590], I[3623], I[3629], I[3642], I[3666] }
end

return build
