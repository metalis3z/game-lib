-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1 = nil

return {
	set = function(p1) --[[ set | Line: 6 | Upvalues: v1 (ref) ]]
		v1 = p1
	end,
	get = function() --[[ get | Line: 10 | Upvalues: v1 (ref) ]]
		return v1
	end
}