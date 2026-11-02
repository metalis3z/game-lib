-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Asserts = require(game:GetService("ReplicatedStorage").Library.Asserts)

return function(p1) --[[ DebugGetCallerName | Line: 3 | Upvalues: Asserts (copy) ]]
	Asserts.optional.number(p1)

	local v1 = debug.info(p1 or 4, "s")

	return if v1 then v1:match("([^%.]-)$") or "" else ""
end