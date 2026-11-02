-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local function v1(p1) --[[ deepCopy | Line: 1 | Upvalues: v1 (copy) ]]
	if type(p1) ~= "table" then
		return p1
	end

	local t = {}
	local v12 = #p1

	if v12 > 0 then
		for i = 1, v12 do
			table.insert(t, v1(p1[i]))
		end
	else
		for v4, v5 in next, p1 do
			t[v1(v4)] = v1(v5)
		end
	end

	return t
end

return v1