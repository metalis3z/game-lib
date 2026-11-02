-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Variables = require(script.Variables)

setmetatable(Variables, {
	__index = require(script.Functions)
})

return Variables