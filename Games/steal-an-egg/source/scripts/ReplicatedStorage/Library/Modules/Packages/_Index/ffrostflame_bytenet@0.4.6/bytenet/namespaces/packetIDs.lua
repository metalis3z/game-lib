-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}

return {
	set = function(p1, p2) --[[ set | Line: 11 | Upvalues: t (copy) ]]
		t[p1] = p2
	end,
	ref = function() --[[ ref | Line: 16 | Upvalues: t (copy) ]]
		return t
	end
}