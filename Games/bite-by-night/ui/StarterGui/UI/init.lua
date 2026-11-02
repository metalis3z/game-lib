-- Generated from ui/StarterGui/UI.rbxm by _tools/rbxm2lua.luau
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

local parts = { script.Part01, script.Part02, script.Part03, script.Part04, script.Part05, script.Part06, script.Part07, script.Part08, script.Part09 }

local function build()
	local I = {}
	for _, part in parts do
		require(part)(I, new)
	end
	I[261].PrimaryPart = I[303]
	I[288].Part0 = I[278]
	I[288].Part1 = I[296]
	I[289].Part0 = I[278]
	I[289].Part1 = I[293]
	I[290].Part0 = I[278]
	I[290].Part1 = I[301]
	I[291].Part0 = I[278]
	I[291].Part1 = I[299]
	I[292].Part0 = I[278]
	I[292].Part1 = I[271]
	I[305].Part0 = I[303]
	I[305].Part1 = I[278]
	I[3705].PrimaryPart = I[3737]
	I[3753].Part0 = I[3743]
	I[3753].Part1 = I[3761]
	I[3754].Part0 = I[3743]
	I[3754].Part1 = I[3758]
	I[3755].Part0 = I[3743]
	I[3755].Part1 = I[3766]
	I[3756].Part0 = I[3743]
	I[3756].Part1 = I[3764]
	I[3757].Part0 = I[3743]
	I[3757].Part1 = I[3737]
	I[3770].Part0 = I[3768]
	I[3770].Part1 = I[3743]
	I[3776].PrimaryPart = I[3808]
	I[3824].Part0 = I[3814]
	I[3824].Part1 = I[3832]
	I[3825].Part0 = I[3814]
	I[3825].Part1 = I[3829]
	I[3826].Part0 = I[3814]
	I[3826].Part1 = I[3837]
	I[3827].Part0 = I[3814]
	I[3827].Part1 = I[3835]
	I[3828].Part0 = I[3814]
	I[3828].Part1 = I[3808]
	I[3841].Part0 = I[3839]
	I[3841].Part1 = I[3814]
	I[3873].PrimaryPart = I[3905]
	I[3921].Part0 = I[3911]
	I[3921].Part1 = I[3929]
	I[3922].Part0 = I[3911]
	I[3922].Part1 = I[3926]
	I[3923].Part0 = I[3911]
	I[3923].Part1 = I[3934]
	I[3924].Part0 = I[3911]
	I[3924].Part1 = I[3932]
	I[3925].Part0 = I[3911]
	I[3925].Part1 = I[3905]
	I[3938].Part0 = I[3936]
	I[3938].Part1 = I[3911]
	I[3949].PrimaryPart = I[3981]
	I[3997].Part0 = I[3987]
	I[3997].Part1 = I[4005]
	I[3998].Part0 = I[3987]
	I[3998].Part1 = I[4002]
	I[3999].Part0 = I[3987]
	I[3999].Part1 = I[4010]
	I[4000].Part0 = I[3987]
	I[4000].Part1 = I[4008]
	I[4001].Part0 = I[3987]
	I[4001].Part1 = I[3981]
	I[4014].Part0 = I[4012]
	I[4014].Part1 = I[3987]
	return I[1]
end

return build
