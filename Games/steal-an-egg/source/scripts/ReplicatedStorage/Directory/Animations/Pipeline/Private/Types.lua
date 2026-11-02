-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Library = game:GetService("ReplicatedStorage").Library

require(Library.Modules.PipelineBuilder)

local t = require(Library.Modules.Packages.t)
local t2 = {}
local v1 = t.interface({
	anim = t.instanceIsA("Animation"),
	weight = t.number,
	looped = t.optional(t.boolean),
	protocol = t.optional(t.interface({
		Stop = t.optional(t.array(t.number)),
		Play = t.optional(t.array(t.number))
	}))
})

t2.SerializedAnimation = v1
t2.SerializedAnimationArray = t.array(v1)

return t2