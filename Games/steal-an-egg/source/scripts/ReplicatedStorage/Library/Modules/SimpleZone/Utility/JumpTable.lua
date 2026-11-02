-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function(p1) --[[ Line: 1 ]]
	return function(p12, ...) --[[ Line: 2 | Upvalues: p1 (copy) ]]
		local v1 = p1[p12] or p1._

		if v1 then
			return v1(...)
		end
	end
end