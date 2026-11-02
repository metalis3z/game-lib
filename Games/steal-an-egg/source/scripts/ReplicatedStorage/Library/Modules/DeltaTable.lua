-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}

function t.MakeDeltaTable(p1, p2, p3) --[[ MakeDeltaTable | Line: 4 | Upvalues: t (copy) ]]
	if p2 == nil then
		return p1:DeepCopy(p3)
	end

	local count = 0
	local t2 = {}

	for k, v in pairs(p3) do
		if p2[k] == nil then
			t2[k] = v

			continue
		end

		if type(p3[k]) == "table" then
			local v2, v3 = t:MakeDeltaTable(p2[k], p3[k])

			if v3 > 0 then
				t2[k] = v2
				count = count + 1
			end

			continue
		end

		local v4 = p3[k]

		if v4 ~= p2[k] then
			t2[k] = v4
			count = count + 1
		end
	end

	for k, v in pairs(p2) do
		if p3[k] == nil then
			if t2.__deletions == nil then
				t2.__deletions = {}
			end

			table.insert(t2.__deletions, k)
		end
	end

	return t2, count
end
function t.ApplyDeltaTable(p1, p2, p3) --[[ ApplyDeltaTable | Line: 46 ]]
	if p2 == nil then
		p2 = {}
	end

	local v1 = p1:DeepCopy(p2)

	if v1 == nil then
		v1 = {}
	end

	for k, v in pairs(p3) do
		if type(p3[k]) == "table" then
			v1[k] = p1:ApplyDeltaTable(p2[k], p3[k])

			continue
		end

		v1[k] = p3[k]
	end

	if v1.__deletions ~= nil then
		for k, v in pairs(v1.__deletions) do
			v1[v] = nil
		end
	end

	return v1
end
function t.DeepCopy(p1, p2) --[[ DeepCopy | Line: 73 ]]
	local function v1(p1) --[[ Deep | Line: 74 | Upvalues: v1 (copy) ]]
		local v12 = table.create(#p1)

		for k, v in pairs(p1) do
			if type(v) == "table" then
				v12[k] = v1(v)

				continue
			end

			v12[k] = v
		end

		return v12
	end

	return v1(p2)
end
function t.DeepCopySharedTable(p1, p2) --[[ DeepCopySharedTable | Line: 88 ]]
	local function v1(p1) --[[ Deep | Line: 89 | Upvalues: v1 (copy) ]]
		local t = {}

		for v12, v2 in p1 do
			if type(v2) == "table" then
				t[v12] = v1(v2)

				continue
			end

			t[v12] = v2
		end

		return t
	end

	return v1(p2)
end

return t