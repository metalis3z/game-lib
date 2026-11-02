-- Generated from ui/StarterGui/HUD.rbxm by _tools/rbxm2lua.luau
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
	I[9].Value = I[296]
	I[17].Value = I[48]
	I[31].Value = I[714]
	I[96].Value = I[48]
	I[207].PrimaryPart = I[251]
	I[289].Value = I[103]
	I[377].Value = I[296]
	I[474].Value = I[423]
	I[502].Value = I[481]
	I[547].Value = I[533]
	I[553].Value = I[533]
	I[586].Value = I[578]
	I[606].Value = I[578]
	I[616].Value = I[48]
	I[705].Value = I[653]
	I[719].Value = I[714]
	I[834].PrimaryPart = I[879]
	I[1708].Value = I[1704]
	return I[1]
end

return build
