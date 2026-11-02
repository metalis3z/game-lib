-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Eggs = require(ReplicatedStorage.Library.Types.Eggs)
local t = require(ReplicatedStorage.Library.Modules.Packages.t)

return {
	PendingEggReward = t.interface({
		Uid = t.string,
		Egg = Eggs.SchemaValidation.SerializedSavedEgg
	}),
	FuseResult = Eggs.SchemaValidation.SerializedSavedEgg
}