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

local parts = { script.Part01, script.Part02, script.Part03 }

local function build()
	local I = {}
	for _, part in parts do
		require(part)(I, new)
	end
	I[33].Value = I[320]
	I[41].Value = I[72]
	I[55].Value = I[738]
	I[120].Value = I[72]
	I[231].PrimaryPart = I[275]
	I[313].Value = I[127]
	I[401].Value = I[320]
	I[498].Value = I[447]
	I[526].Value = I[505]
	I[571].Value = I[557]
	I[577].Value = I[557]
	I[610].Value = I[602]
	I[630].Value = I[602]
	I[640].Value = I[72]
	I[729].Value = I[677]
	I[743].Value = I[738]
	I[858].PrimaryPart = I[903]
	I[1732].Value = I[1728]
	return { I[1], I[3], I[8], I[18], I[22], I[25], I[1782], I[1804] }
end

return build
