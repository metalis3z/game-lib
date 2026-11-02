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
	return { I[1], I[12], I[21], I[35], I[68], I[164], I[166], I[211], I[215], I[251], I[253], I[291], I[305], I[834], I[836], I[838], I[952], I[953], I[1000], I[1149], I[1150], I[1173], I[1243], I[1259], I[1263], I[1353], I[1439], I[1748], I[1808], I[1904], I[2010], I[2165], I[2368], I[2456], I[2573], I[2637], I[2643], I[2750], I[2880], I[2887], I[2895], I[2907], I[2971], I[3056], I[3060], I[4018], I[4034], I[4038], I[4048], I[4054], I[4145], I[4174], I[4237], I[4503], I[4598], I[4607], I[4611], I[4615], I[4619], I[4903], I[4928], I[4941], I[5037], I[5502], I[5511], I[5515], I[5532], I[5536], I[5551], I[5768], I[5893], I[6137], I[6639], I[6748], I[6775], I[6792], I[6920], I[6978] }
end

return build
