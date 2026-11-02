-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function() --[[ Line: 1 ]]
	local v1 = false

	return function(p1, p2) --[[ Line: 3 | Upvalues: v1 (ref) ]]
		if v1 then
			return false
		end

		v1 = true
		task.delay(p1, function() --[[ Line: 8 | Upvalues: v1 (ref) ]]
			v1 = false
		end)

		if not p2 then
			return true
		end

		p2()

		return true
	end
end