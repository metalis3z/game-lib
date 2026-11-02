-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local function v1(p1, p2, p3) --[[ DeepEquals | Line: 1 | Upvalues: v1 (copy) ]]
	if p1 == p2 then
		return true
	end

	if type(p1) ~= "table" or type(p2) ~= "table" then
		return false
	end

	local v12 = if p3 then p3 else {}

	v12[p1] = v12[p1] or {}

	if v12[p1][p2] then
		return true
	end

	v12[p2] = v12[p2] or {}

	if v12[p2][p1] then
		return true
	end

	v12[p1][p2] = true
	v12[p2][p1] = true

	local v4 = getmetatable(p1)

	if v4 and v4.__eq then
		return p1 == p2
	end

	local v6 = getmetatable(p2)

	if v6 and v6.__eq then
		return p1 == p2
	end

	if #p1 ~= #p2 then
		return false
	end

	local v8 = v12

	for k, v in pairs(p1) do
		local v9 = p2[k]

		if v9 == nil or not v1(v, v9, v8) then
			return false
		end
	end

	for k, v in pairs(p2) do
		local v10 = p1[k]

		if v10 == nil or not v1(v, v10, v8) then
			return false
		end
	end

	return true
end

return v1