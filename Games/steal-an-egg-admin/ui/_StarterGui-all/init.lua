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

local parts = { script.Part01, script.Part02, script.Part03, script.Part04, script.Part05, script.Part06, script.Part07, script.Part08, script.Part09, script.Part10, script.Part11, script.Part12, script.Part13 }

local function build()
	local I = {}
	for _, part in parts do
		require(part)(I, new)
	end
	I[1061].PrimaryPart = I[1062]
	I[1089].PrimaryPart = I[1090]
	return { I[1], I[109], I[120], I[129], I[137], I[170], I[266], I[469], I[516], I[522], I[598], I[615], I[621], I[635], I[637], I[697], I[713], I[720], I[776], I[1119], I[1225], I[1284], I[1300], I[1344], I[1396], I[1401], I[1407], I[1408], I[1765], I[2165], I[2329], I[2336], I[2341], I[2766], I[2810], I[2818], I[2829], I[3070], I[3157], I[3254], I[3381], I[3385], I[3401], I[3590], I[3596], I[4130], I[4134], I[4138], I[4142], I[4426], I[4451], I[4464], I[4489], I[4493], I[4510], I[4532], I[4589], I[4592], I[4594], I[4601], I[5933], I[5935], I[5936], I[6043], I[6112], I[6238], I[6301], I[6747], I[7193], I[7215], I[7222] }
end

return build
