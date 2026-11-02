-- Generated from ui/StarterGui/RobuxShop.rbxm by _tools/rbxm2lua.luau
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
	return I[1]
end

return build
