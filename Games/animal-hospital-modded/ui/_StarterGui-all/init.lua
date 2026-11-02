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

local parts = { script.Part01, script.Part02, script.Part03, script.Part04 }

local function build()
	local I = {}
	for _, part in parts do
		require(part)(I, new)
	end
	return { I[1], I[6], I[36], I[46], I[50], I[54], I[70], I[75], I[77], I[100], I[115], I[162], I[200], I[208], I[212], I[217], I[222], I[246], I[278], I[305], I[442], I[479], I[483], I[487], I[491], I[499], I[504], I[506], I[568], I[665], I[676], I[1124], I[1183], I[1220], I[1405], I[1424], I[2040], I[2051], I[2073], I[2092], I[2201], I[2203], I[2266], I[2269] }
end

return build
