-- Generated from ui/StarterGui/MainUI.rbxm by _tools/rbxm2lua.luau
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
	I[211].PrimaryPart = I[336]
	I[223].Part0 = I[225]
	I[223].Part1 = I[218]
	I[230].Part0 = I[239]
	I[230].Part1 = I[225]
	I[238].Part0 = I[232]
	I[238].Part1 = I[225]
	I[246].Part0 = I[278]
	I[246].Part1 = I[239]
	I[253].Part0 = I[255]
	I[253].Part1 = I[248]
	I[260].Part0 = I[269]
	I[260].Part1 = I[255]
	I[268].Part0 = I[262]
	I[268].Part1 = I[255]
	I[276].Part0 = I[278]
	I[276].Part1 = I[269]
	I[297].Part0 = I[300]
	I[297].Part1 = I[278]
	I[313].Part0 = I[212]
	I[313].Part1 = I[300]
	I[334].Part0 = I[278]
	I[334].Part1 = I[321]
	I[341].PrimaryPart = I[379]
	I[347].Part0 = I[348]
	I[347].Part1 = I[346]
	I[349].Part0 = I[350]
	I[349].Part1 = I[348]
	I[351].Part0 = I[358]
	I[351].Part1 = I[350]
	I[353].Part0 = I[354]
	I[353].Part1 = I[352]
	I[355].Part0 = I[356]
	I[355].Part1 = I[354]
	I[357].Part0 = I[358]
	I[357].Part1 = I[356]
	I[359].Part0 = I[373]
	I[359].Part1 = I[358]
	I[362].Part0 = I[363]
	I[362].Part1 = I[361]
	I[364].Part0 = I[365]
	I[364].Part1 = I[363]
	I[366].Part0 = I[373]
	I[366].Part1 = I[365]
	I[368].Part0 = I[369]
	I[368].Part1 = I[367]
	I[370].Part0 = I[371]
	I[370].Part1 = I[369]
	I[372].Part0 = I[373]
	I[372].Part1 = I[371]
	I[374].Part0 = I[342]
	I[374].Part1 = I[373]
	I[378].Part0 = I[358]
	I[378].Part1 = I[377]
	return I[1]
end

return build
