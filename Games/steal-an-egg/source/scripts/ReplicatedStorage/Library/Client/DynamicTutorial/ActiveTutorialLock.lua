-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1 = false

return {
	SetRoundTutorialActive = function(p1) --[[ SetRoundTutorialActive | Line: 10 | Upvalues: v1 (ref) ]]
		v1 = p1
	end,
	IsRoundTutorialActive = function() --[[ IsRoundTutorialActive | Line: 14 | Upvalues: v1 (ref) ]]
		return v1
	end
}