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

local parts = { script.Part01, script.Part02, script.Part03, script.Part04, script.Part05, script.Part06 }

local function build()
	local I = {}
	for _, part in parts do
		require(part)(I, new)
	end
	I[222].PrimaryPart = I[347]
	I[234].Part0 = I[236]
	I[234].Part1 = I[229]
	I[241].Part0 = I[250]
	I[241].Part1 = I[236]
	I[249].Part0 = I[243]
	I[249].Part1 = I[236]
	I[257].Part0 = I[289]
	I[257].Part1 = I[250]
	I[264].Part0 = I[266]
	I[264].Part1 = I[259]
	I[271].Part0 = I[280]
	I[271].Part1 = I[266]
	I[279].Part0 = I[273]
	I[279].Part1 = I[266]
	I[287].Part0 = I[289]
	I[287].Part1 = I[280]
	I[308].Part0 = I[311]
	I[308].Part1 = I[289]
	I[324].Part0 = I[223]
	I[324].Part1 = I[311]
	I[345].Part0 = I[289]
	I[345].Part1 = I[332]
	I[352].PrimaryPart = I[390]
	I[358].Part0 = I[359]
	I[358].Part1 = I[357]
	I[360].Part0 = I[361]
	I[360].Part1 = I[359]
	I[362].Part0 = I[369]
	I[362].Part1 = I[361]
	I[364].Part0 = I[365]
	I[364].Part1 = I[363]
	I[366].Part0 = I[367]
	I[366].Part1 = I[365]
	I[368].Part0 = I[369]
	I[368].Part1 = I[367]
	I[370].Part0 = I[384]
	I[370].Part1 = I[369]
	I[373].Part0 = I[374]
	I[373].Part1 = I[372]
	I[375].Part0 = I[376]
	I[375].Part1 = I[374]
	I[377].Part0 = I[384]
	I[377].Part1 = I[376]
	I[379].Part0 = I[380]
	I[379].Part1 = I[378]
	I[381].Part0 = I[382]
	I[381].Part1 = I[380]
	I[383].Part0 = I[384]
	I[383].Part1 = I[382]
	I[385].Part0 = I[353]
	I[385].Part1 = I[384]
	I[389].Part0 = I[369]
	I[389].Part1 = I[388]
	return { I[1], I[12], I[3866], I[3964] }
end

return build
