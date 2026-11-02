-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1 = Random.new()

return function(p1, p2) --[[ Line: 3 | Upvalues: v1 (copy) ]]
	local v12 = if p2 then p2 else v1

	for i = #p1, 2, -1 do
		local v2 = v12:NextInteger(1, i)
		local v4 = p1[i]

		p1[i] = p1[v2]
		p1[v2] = v4
	end

	return p1
end