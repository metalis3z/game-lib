-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent.Parent.Types)

return function(p1) --[[ Line: 3 ]]
	local sum = 0

	for i = 1, #p1 do
		sum = sum + (p1[i].weight or 1)
	end

	local v1 = math.random() * sum
	local sum2 = 0

	for j = 1, #p1 do
		local v2 = p1[j]

		sum2 = sum2 + (v2.weight or 1)

		if v1 <= sum2 then
			return v2.anim, #p1, v2
		end
	end

	local v3 = p1[#p1]

	return v3.anim, #p1, v3
end