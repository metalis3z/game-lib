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

local parts = { script.Part01, script.Part02 }

local function build()
	local I = {}
	for _, part in parts do
		require(part)(I, new)
	end
	I[129].Value = I[122]
	I[188].Value = I[173]
	I[303].Value = I[296]
	I[358].Value = I[351]
	I[415].Value = I[408]
	I[440].Value = I[433]
	I[493].Value = I[480]
	I[612].Value = I[599]
	return { I[1], I[836], I[837], I[841] }
end

return build
