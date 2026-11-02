-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function(p1, p2) --[[ Line: 1 ]]
	local t = {}

	for k, v in pairs(p1) do
		if p2(v) then
			t[k] = v
		end
	end

	return t
end