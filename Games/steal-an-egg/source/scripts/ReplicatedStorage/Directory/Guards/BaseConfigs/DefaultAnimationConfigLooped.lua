-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(ReplicatedStorage.Directory.Animations.Pipeline)

return require(ReplicatedStorage.Library.Functions.DeepFreezeUnsafe)({
	DropWeight = 1,
	Looped = true,
	Play = { 0.15 },
	Stop = { 0.5 }
})