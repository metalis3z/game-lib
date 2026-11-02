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

local parts = { script.Part01, script.Part02, script.Part03, script.Part04, script.Part05 }

local function build()
	local I = {}
	for _, part in parts do
		require(part)(I, new)
	end
	return { I[1], I[338], I[339], I[414], I[531], I[681], I[767], I[856], I[872], I[1738], I[1799], I[1804], I[1897], I[1901], I[1903], I[1910], I[1944], I[1973], I[2220], I[2278], I[2359], I[2409], I[2422], I[2758], I[2876], I[2931], I[2991], I[3027], I[3084], I[3156], I[3195], I[3210] }
end

return build
