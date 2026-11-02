-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Library.Modules.Packages.t)
local t2 = {}
local v1 = t.interface({
	Text = t.optional(t.string),
	Color = t.optional(t.Color3),
	StrokeColor = t.optional(t.Color3)
})

t2.MessageDataInterface = t.interface({
	Message = t.string,
	Time = t.number,
	Color = t.optional(t.Color3),
	Sound = t.optional(t.union(t.string, t.number)),
	Gradient = t.optional(t.instanceIsA("UIGradient")),
	Image = t.optional(t.string),
	DelayInRound = t.optional(t.boolean),
	PreText = t.optional(v1)
})

return t2