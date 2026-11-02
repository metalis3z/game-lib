-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModuleLoader = require(ReplicatedStorage.ModuleLoader)

require(script.Types.Interface)

return ModuleLoader(script._Index, {}, {
	noPrint = true,
	typeCast = "Alphabet"
})