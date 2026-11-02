-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local function v1(p1, p2, p3, p4, p5, p6) --[[ DeepCopy | Line: 1 | Upvalues: v1 (copy) ]]
	if typeof(p1) ~= "table" then
		return p1
	end

	local v12 = if p5 then p5 else {}
	local v2 = v12[p1]

	if v2 then
		return v2
	end

	local v3, v4

	if typeof(p2) == "table" and p2 then
		v3 = v12
		v4 = p2
	else
		v3 = v12
		v4 = {}
	end

	v3[p1] = v4

	for v5, v6 in p1 do
		if typeof(p4) ~= "table" or not (p3 and p4[v5]) then
			if typeof(v6) == "table" and not p3 then
				v4[v5] = v1(v6, nil, p3, p4, v3, true)

				continue
			end

			v4[v5] = v6
		end
	end

	local v7 = getmetatable(p1)

	if typeof(v7) == "table" then
		setmetatable(v4, v7)
	end

	if p6 then
		return v4
	end

	table.clear(v3)

	return v4
end

return v1