-- Generated from ui/ServerStorage/Decompiled/LocalPlayer/PlayerGui/ScreenFrames.rbxm by _tools/rbxm2lua.luau
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

local parts = { script.Part01, script.Part02 }

local function build()
	local I = {}
	for _, part in parts do
		require(part)(I, new)
	end
	I[255].PrimaryPart = I[296]
	I[281].Part0 = I[272]
	I[281].Part1 = I[289]
	I[282].Part0 = I[272]
	I[282].Part1 = I[286]
	I[283].Part0 = I[272]
	I[283].Part1 = I[294]
	I[284].Part0 = I[272]
	I[284].Part1 = I[292]
	I[285].Part0 = I[272]
	I[285].Part1 = I[265]
	I[298].Part0 = I[296]
	I[298].Part1 = I[272]
	I[497].PrimaryPart = I[538]
	I[523].Part0 = I[514]
	I[523].Part1 = I[531]
	I[524].Part0 = I[514]
	I[524].Part1 = I[528]
	I[525].Part0 = I[514]
	I[525].Part1 = I[536]
	I[526].Part0 = I[514]
	I[526].Part1 = I[534]
	I[527].Part0 = I[514]
	I[527].Part1 = I[507]
	I[540].Part0 = I[538]
	I[540].Part1 = I[514]
	I[593].PrimaryPart = I[641]
	I[619].Part0 = I[610]
	I[619].Part1 = I[631]
	I[620].Part0 = I[610]
	I[620].Part1 = I[628]
	I[621].Part0 = I[610]
	I[621].Part1 = I[637]
	I[622].Part0 = I[610]
	I[622].Part1 = I[634]
	I[623].Part0 = I[610]
	I[623].Part1 = I[603]
	I[624].Part0 = I[610]
	I[625].Part0 = I[610]
	I[626].Part0 = I[610]
	I[627].Part0 = I[610]
	I[627].Part1 = I[644]
	I[636].Part0 = I[634]
	I[639].Part0 = I[637]
	I[643].Part0 = I[641]
	I[643].Part1 = I[610]
	return I[1]
end

return build
