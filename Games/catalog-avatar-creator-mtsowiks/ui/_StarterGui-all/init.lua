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
	I[1911].Value = I[1892]
	I[2169].Value = I[2149]
	I[2197].Value = I[2149]
	I[2214].Value = I[2149]
	I[3239].Value = I[3219]
	I[3690].Value = I[3655]
	return { I[1], I[216], I[260], I[262], I[928], I[947], I[1159], I[1395], I[1545], I[1619], I[1661], I[1702], I[1705], I[1730], I[1734], I[1738], I[1871], I[1886], I[1889], I[1890], I[2118], I[3098], I[3217], I[3286], I[3288], I[3323], I[3340], I[3381], I[3439], I[3468], I[3483], I[3484], I[3558], I[3652], I[3937], I[4355] }
end

return build
