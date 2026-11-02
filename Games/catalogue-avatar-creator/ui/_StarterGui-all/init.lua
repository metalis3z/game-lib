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

local parts = { script.Part01, script.Part02, script.Part03, script.Part04, script.Part05, script.Part06, script.Part07, script.Part08 }

local function build()
	local I = {}
	for _, part in parts do
		require(part)(I, new)
	end
	I[968].Value = I[949]
	I[1009].Value = I[949]
	I[1982].Value = I[1963]
	I[2240].Value = I[2220]
	I[2268].Value = I[2220]
	I[2285].Value = I[2220]
	I[3320].Value = I[3300]
	I[3792].Value = I[3757]
	return { I[1], I[216], I[260], I[262], I[928], I[947], I[1159], I[1395], I[1545], I[1619], I[1661], I[1702], I[1705], I[1730], I[1734], I[1738], I[1871], I[1886], I[1889], I[1961], I[2189], I[3169], I[3298], I[3367], I[3369], I[3404], I[3421], I[3462], I[3520], I[3549], I[3564], I[3586], I[3660], I[3754], I[4039] }
end

return build
