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

local parts = { script.Part01, script.Part02, script.Part03, script.Part04, script.Part05, script.Part06, script.Part07, script.Part08, script.Part09, script.Part10, script.Part11, script.Part12 }

local function build()
	local I = {}
	for _, part in parts do
		require(part)(I, new)
	end
	I[704].PrimaryPart = I[733]
	I[734].Part0 = I[733]
	I[734].Part1 = I[730]
	I[735].Part0 = I[733]
	I[735].Part1 = I[712]
	I[736].Part0 = I[733]
	I[736].Part1 = I[717]
	I[737].Part0 = I[733]
	I[737].Part1 = I[777]
	I[738].Part0 = I[733]
	I[738].Part1 = I[711]
	I[739].Part0 = I[733]
	I[739].Part1 = I[715]
	I[740].Part0 = I[733]
	I[740].Part1 = I[775]
	I[741].Part0 = I[733]
	I[741].Part1 = I[708]
	I[742].Part0 = I[733]
	I[742].Part1 = I[713]
	I[749].Part0 = I[733]
	I[749].Part1 = I[723]
	I[750].Part0 = I[733]
	I[750].Part1 = I[710]
	I[751].Part0 = I[733]
	I[751].Part1 = I[773]
	I[752].Part0 = I[733]
	I[752].Part1 = I[707]
	I[753].Part0 = I[733]
	I[753].Part1 = I[719]
	I[754].Part0 = I[733]
	I[754].Part1 = I[706]
	I[755].Part0 = I[733]
	I[755].Part1 = I[729]
	I[756].Part0 = I[733]
	I[756].Part1 = I[724]
	I[757].Part0 = I[733]
	I[757].Part1 = I[718]
	I[758].Part0 = I[733]
	I[758].Part1 = I[714]
	I[759].Part0 = I[733]
	I[759].Part1 = I[716]
	I[760].Part0 = I[733]
	I[760].Part1 = I[720]
	I[761].Part0 = I[733]
	I[761].Part1 = I[722]
	I[762].Part0 = I[733]
	I[762].Part1 = I[721]
	I[763].Part0 = I[733]
	I[763].Part1 = I[731]
	I[764].Part0 = I[733]
	I[764].Part1 = I[774]
	I[765].Part0 = I[733]
	I[765].Part1 = I[728]
	I[766].Part0 = I[733]
	I[766].Part1 = I[705]
	I[767].Part0 = I[733]
	I[767].Part1 = I[727]
	I[768].Part0 = I[733]
	I[768].Part1 = I[732]
	I[769].Part0 = I[733]
	I[769].Part1 = I[709]
	I[770].Part0 = I[733]
	I[770].Part1 = I[725]
	I[771].Part0 = I[733]
	I[771].Part1 = I[726]
	I[772].Part0 = I[733]
	I[772].Part1 = I[776]
	return { I[1], I[1159], I[1216], I[1271], I[1404], I[1407], I[1415], I[1425], I[1485], I[1559], I[1577], I[1669], I[1676], I[1772], I[1785], I[1816], I[1821], I[1867], I[1955], I[1958], I[2189], I[2421], I[2425], I[2710], I[2771], I[2772], I[2825], I[2957], I[2961], I[2963], I[2981], I[2982], I[3033], I[3034], I[3036], I[3075], I[3317], I[3334], I[3355], I[3764], I[3773], I[3774], I[3784], I[3789], I[4120], I[4145], I[4498], I[4599], I[4600], I[4669], I[4866], I[4984], I[5079], I[5127], I[5253], I[5466], I[5552], I[5597], I[5839], I[5908], I[5973], I[5975], I[5997] }
end

return build
