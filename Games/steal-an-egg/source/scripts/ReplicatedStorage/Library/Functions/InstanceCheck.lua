-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function(p1, p2) --[[ Line: 1 ]]
	return if typeof(p1) == "Instance" and typeof(p2) == "string" then p1:IsA(p2) else false
end