-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local v1 = if require(ReplicatedStorage.Library.Globals.Constants).IS_MOBILE then 100 else 300

return function(p1, p2) --[[ Line: 13 | Upvalues: Asserts (copy), v1 (copy) ]]
	Asserts.number(p1)
	Asserts.optional.number(p2)

	if p1 % (if p2 then p2 else v1) == 0 then
		task.wait(0)
	end
end