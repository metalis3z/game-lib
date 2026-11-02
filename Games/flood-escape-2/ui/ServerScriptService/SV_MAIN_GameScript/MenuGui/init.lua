-- Generated from ui/ServerScriptService/SV_MAIN_GameScript/MenuGui.rbxm by _tools/rbxm2lua.luau
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
	I[978].PrimaryPart = I[979]
	I[980].Part0 = I[979]
	I[980].Part1 = I[981]
	I[982].Part0 = I[981]
	I[982].Part1 = I[987]
	I[983].Part0 = I[981]
	I[983].Part1 = I[988]
	I[984].Part0 = I[981]
	I[984].Part1 = I[989]
	I[985].Part0 = I[981]
	I[985].Part1 = I[990]
	I[986].Part0 = I[981]
	I[986].Part1 = I[991]
	I[995].PrimaryPart = I[996]
	I[997].Part0 = I[996]
	I[997].Part1 = I[998]
	I[999].Part0 = I[998]
	I[999].Part1 = I[1004]
	I[1000].Part0 = I[998]
	I[1000].Part1 = I[1005]
	I[1001].Part0 = I[998]
	I[1001].Part1 = I[1006]
	I[1002].Part0 = I[998]
	I[1002].Part1 = I[1007]
	I[1003].Part0 = I[998]
	I[1003].Part1 = I[1008]
	I[1012].PrimaryPart = I[1013]
	I[1030].Part0 = I[1020]
	I[1030].Part1 = I[1038]
	I[1031].Part0 = I[1020]
	I[1031].Part1 = I[1035]
	I[1032].Part0 = I[1020]
	I[1032].Part1 = I[1043]
	I[1033].Part0 = I[1020]
	I[1033].Part1 = I[1041]
	I[1034].Part0 = I[1020]
	I[1034].Part1 = I[1013]
	I[1056].Part0 = I[1054]
	I[1056].Part1 = I[1020]
	return I[1]
end

return build
