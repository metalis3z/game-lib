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

local parts = { script.Part01, script.Part02, script.Part03, script.Part04, script.Part05, script.Part06, script.Part07, script.Part08, script.Part09 }

local function build()
	local I = {}
	for _, part in parts do
		require(part)(I, new)
	end
	I[262].PrimaryPart = I[304]
	I[289].Part0 = I[279]
	I[289].Part1 = I[297]
	I[290].Part0 = I[279]
	I[290].Part1 = I[294]
	I[291].Part0 = I[279]
	I[291].Part1 = I[302]
	I[292].Part0 = I[279]
	I[292].Part1 = I[300]
	I[293].Part0 = I[279]
	I[293].Part1 = I[272]
	I[306].Part0 = I[304]
	I[306].Part1 = I[279]
	I[3706].PrimaryPart = I[3738]
	I[3754].Part0 = I[3744]
	I[3754].Part1 = I[3762]
	I[3755].Part0 = I[3744]
	I[3755].Part1 = I[3759]
	I[3756].Part0 = I[3744]
	I[3756].Part1 = I[3767]
	I[3757].Part0 = I[3744]
	I[3757].Part1 = I[3765]
	I[3758].Part0 = I[3744]
	I[3758].Part1 = I[3738]
	I[3771].Part0 = I[3769]
	I[3771].Part1 = I[3744]
	I[3777].PrimaryPart = I[3809]
	I[3825].Part0 = I[3815]
	I[3825].Part1 = I[3833]
	I[3826].Part0 = I[3815]
	I[3826].Part1 = I[3830]
	I[3827].Part0 = I[3815]
	I[3827].Part1 = I[3838]
	I[3828].Part0 = I[3815]
	I[3828].Part1 = I[3836]
	I[3829].Part0 = I[3815]
	I[3829].Part1 = I[3809]
	I[3842].Part0 = I[3840]
	I[3842].Part1 = I[3815]
	I[3874].PrimaryPart = I[3906]
	I[3922].Part0 = I[3912]
	I[3922].Part1 = I[3930]
	I[3923].Part0 = I[3912]
	I[3923].Part1 = I[3927]
	I[3924].Part0 = I[3912]
	I[3924].Part1 = I[3935]
	I[3925].Part0 = I[3912]
	I[3925].Part1 = I[3933]
	I[3926].Part0 = I[3912]
	I[3926].Part1 = I[3906]
	I[3939].Part0 = I[3937]
	I[3939].Part1 = I[3912]
	I[3950].PrimaryPart = I[3982]
	I[3998].Part0 = I[3988]
	I[3998].Part1 = I[4006]
	I[3999].Part0 = I[3988]
	I[3999].Part1 = I[4003]
	I[4000].Part0 = I[3988]
	I[4000].Part1 = I[4011]
	I[4001].Part0 = I[3988]
	I[4001].Part1 = I[4009]
	I[4002].Part0 = I[3988]
	I[4002].Part1 = I[3982]
	I[4015].Part0 = I[4013]
	I[4015].Part1 = I[3988]
	return { I[1], I[2] }
end

return build
