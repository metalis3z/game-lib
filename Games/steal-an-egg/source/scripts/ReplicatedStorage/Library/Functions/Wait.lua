-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1 = Random.new()

return function(p1, p2) --[[ Line: 3 | Upvalues: v1 (copy) ]]
	if p2 then
		p1 = v1:NextNumber(p1, p2)
	end

	task.wait(p1)
end