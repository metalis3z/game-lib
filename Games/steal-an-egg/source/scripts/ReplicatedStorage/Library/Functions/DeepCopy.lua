-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local function v1(p1, p2) --[[ DeepCopy | Line: 1 | Upvalues: v1 (copy) ]]
	if typeof(p1) ~= "table" then
		return p1
	end

	local v12 = if p2 then p2 else {}
	local v2 = v12[p1]

	if v2 then
		return v2
	end

	local t = {}

	v12[p1] = t

	local v3 = #p1

	if v3 > 0 then
		for i = 1, v3 do
			table.insert(t, v1(p1[i], v12))
		end
	else
		for v7, v8 in next, p1 do
			t[v1(v7, v12)] = v1(v8, v12)
		end
	end

	local v9 = getmetatable(p1)

	if v9 then
		setmetatable(t, v1(v9, v12))
	end

	return t
end

return v1