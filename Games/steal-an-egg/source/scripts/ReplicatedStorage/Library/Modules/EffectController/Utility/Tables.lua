-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}

function t.CopyTable(p1) --[[ CopyTable | Line: 3 | Upvalues: t (copy) ]]
	local t2 = {}

	for k, v in pairs(p1) do
		t2[k] = typeof(v) == "table" and t.CopyTable(v) or v
	end

	return t2
end
function t.Reconcile(p1, p2, p3) --[[ Reconcile | Line: 11 | Upvalues: t (copy) ]]
	local v2 = p3 and t.CopyTable(p1) or p1

	for k, v in pairs(p2) do
		if v2[k] == nil then
			v2[k] = typeof(v) == "table" and t.CopyTable(v) or v
		end
	end

	return v2
end
function t.CacheDirectory(p1, p2) --[[ CacheDirectory | Line: 21 | Upvalues: t (copy) ]]
	local t2 = {}

	for i, v in ipairs(p1:GetChildren()) do
		local v1

		v1 = if v:IsA("ModuleScript") then p2 and p2(v) or require(v) else nil

		if v1 then
			t2[v.Name] = v1

			continue
		end

		if v:IsA("Folder") or v:IsA("Model") then
			t2[v.Name] = t.CacheDirectory(v, p2)

			continue
		end

		t2[v.Name] = nil
	end

	return t2
end
function t.DeepCopy(p1) --[[ DeepCopy | Line: 39 | Upvalues: t (copy) ]]
	if type(p1) ~= "table" then
		return p1
	end

	local t2 = {}

	for k, v in pairs(p1) do
		t2[t.DeepCopy(k)] = t.DeepCopy(v)
	end

	setmetatable(t2, t.DeepCopy((getmetatable(p1))))

	return t2
end
function t.DeepCopyRecursive(p1, p2) --[[ DeepCopyRecursive | Line: 52 | Upvalues: t (copy) ]]
	local v1 = if p2 then p2 else {}

	if type(p1) ~= "table" then
		return p1
	end

	if v1[p1] then
		return v1[p1]
	end

	local t2 = {}

	v1[p1] = t2

	local v2 = v1

	for k, v in pairs(p1) do
		t2[t.DeepCopyRecursive(k, v2)] = t.DeepCopyRecursive(v, v2)
	end

	setmetatable(t2, t.DeepCopyRecursive(getmetatable(p1), v2))

	return t2
end

return t