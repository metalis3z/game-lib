-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}

return function(p1, p2) --[[ Line: 9 | Upvalues: t (copy) ]]
	if not p1 then
		return nil
	end

	if t[p1] == nil then
		t[p1] = {}
	end

	if t[p1][p2] == nil then
		t[p1][p2] = p1[p2]
	end

	return t[p1][p2]
end