-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local function v1(p1) --[[ freeze | Line: 1 | Upvalues: v1 (copy) ]]
	if type(p1) ~= "table" then
		return
	end

	if not table.isfrozen(p1) then
		table.freeze(p1)
	end

	for k, v in pairs(p1) do
		v1(k)
		v1(v)
	end
end

return function(p1) --[[ Line: 13 | Upvalues: v1 (copy) ]]
	v1(p1)

	return p1
end