-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local function v1(p1, p2) --[[ deepEquals | Line: 1 | Upvalues: v1 (copy) ]]
	if p1 == p2 then
		return true
	end

	if type(p1) == "table" and type(p2) == "table" then
		if #p1 ~= #p2 then
			return false
		end

		for v12, v2 in next, p1 do
			local v3 = p2[v12]

			if v3 == nil or not v1(v2, v3) then
				return false
			end
		end

		for v4, v5 in next, p2 do
			local v6 = p1[v4]

			if v6 == nil or not v1(v5, v6) then
				return false
			end
		end

		return true
	end

	return p1 ~= p1 and p2 ~= p2
end

return v1