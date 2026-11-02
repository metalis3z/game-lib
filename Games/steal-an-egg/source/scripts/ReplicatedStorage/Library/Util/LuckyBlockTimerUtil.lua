-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets = require(ReplicatedStorage.Directory.Assets)
local t = {}

local function parseMutations(p1) --[[ parseMutations | Line: 25 ]]
	if typeof(p1) ~= "string" or p1 == "" then
		return {}
	end

	local t = {}

	for v1 in string.gmatch(p1, "[^,%s]+") do
		if v1 ~= "" and v1 ~= "Alpha" then
			table.insert(t, v1)
		end
	end

	return t
end

local function cloneDropTable(p1) --[[ cloneDropTable | Line: 40 ]]
	if not p1 then
		return nil
	end

	local t = {}

	for i, v in ipairs(p1) do
		t[i] = { v[1], v[2] }
	end

	return t
end

function t.GetTimerConfig(p1) --[[ GetTimerConfig | Line: 54 | Upvalues: Assets (copy), parseMutations (copy), cloneDropTable (copy) ]]
	if not p1:IsA("BasePart") then
		return nil
	end

	local v1 = p1:GetAttribute("AssetId")
	local v2 = p1:GetAttribute("Time")

	if typeof(v1) ~= "string" or typeof(v2) ~= "number" then
		return nil
	end

	local v3 = Assets.Directory[v1]

	if not v3 then
		return nil
	end

	local v4 = p1:GetAttribute("BaseMutation")
	local v5 = if typeof(v4) == "string" and v4 ~= "Alpha" then v4 else nil
	local v6 = parseMutations(p1:GetAttribute("Mutations"))
	local v7 = math.max(v2, 0)
	local v8 = p1:GetAttribute("BaseScale")
	local v9 = if typeof(v8) == "number" then math.max(v8, 0) else math.max(v3.BaseModelScale or 1, 0)

	return {
		assetId = v1,
		duration = v7,
		mutations = v6,
		baseMutation = v5,
		baseScale = v9,
		scale = v9,
		dropTable = cloneDropTable(v3.LuckyBlockDropTable) or {}
	}
end
function t.CloneDropTable(p1) --[[ CloneDropTable | Line: 95 | Upvalues: cloneDropTable (copy) ]]
	return cloneDropTable(p1)
end

return t