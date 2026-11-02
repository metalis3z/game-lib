-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DeepEqualsUnsafe = require(ReplicatedStorage.Library.Functions.DeepEqualsUnsafe)
local AssetItemSerialization = require(ReplicatedStorage.Library.Util.AssetItemSerialization)

require(script.Parent.InventoryProjectionTypes)

local t = {}

local function makeDeterministicUID(p1) --[[ makeDeterministicUID | Line: 17 ]]
	local v1 = ("inventory_projection_skin/%*"):format(p1)
	local v2 = 2166136261
	local v3 = 2654435769
	local v4 = 3266489909
	local v5 = 668265263

	for i = 1, #v1 do
		local v6 = string.byte(v1, i)

		v2, v3, v4, v5 = bit32.band(bit32.bxor(v2, v6) * 16777619, 4294967295), bit32.band((v3 + v6) * 2246822519, 4294967295), bit32.band(bit32.bxor(v4, (bit32.lshift(v6, i % 8))) * 3266489917, 4294967295), bit32.band((v5 + bit32.bxor(v6, i)) * 668265263, 4294967295)
	end

	local v15 = string.format("%08x%08x%08x%08x", v2, v3, v4, v5)

	return ("%*4%*8%*"):format(v15:sub(1, 12), v15:sub(14, 16), (v15:sub(18, 32)))
end

local function getOwnedSkinCount(p1, p2) --[[ getOwnedSkinCount | Line: 37 ]]
	local v1 = if p1 then p1[p2] or nil else nil

	if type(v1) ~= "number" then
		return 0
	end

	local v2 = math.floor(v1)

	if v2 <= 0 then
		return 0
	end

	return v2
end

local function normalizeSkinInventory(p1) --[[ normalizeSkinInventory | Line: 51 ]]
	local t = {}

	if not p1 then
		return t
	end

	for k in pairs(p1) do
		local v1
		local v2 = p1 and p1[k] or nil

		if type(v2) == "number" then
			local v3 = math.floor(v2)

			v1 = if v3 <= 0 then 0 else v3
		else
			v1 = 0
		end

		if v1 > 0 then
			t[k] = v1
		end
	end

	return t
end

local function projectBrainrots(p1) --[[ projectBrainrots | Line: 70 | Upvalues: AssetItemSerialization (copy) ]]
	local t = {}

	if not p1 then
		return t
	end

	for k, v in pairs(p1) do
		local v1 = AssetItemSerialization.Deserialize(v)

		if v1.InFuse ~= true then
			t[k] = {
				id = v1.Category,
				Mutations = v1.Mutations,
				BaseMutation = v1.BaseMutation,
				Scale = v1.Scale
			}
		end
	end

	return t
end

local function buildBrainrotPatch(p1) --[[ buildBrainrotPatch | Line: 92 | Upvalues: AssetItemSerialization (copy) ]]
	local t = {}
	local t2 = {}
	local t3 = {}

	if not p1 then
		return t, t2, t3
	end

	for k, v in pairs(p1) do
		local v1 = AssetItemSerialization.Deserialize(v)

		if v1.InFuse == true then
			t2[#t2 + 1] = k
			t3[k] = true

			continue
		end

		t[k] = {
			id = v1.Category,
			Mutations = v1.Mutations,
			BaseMutation = v1.BaseMutation,
			Scale = v1.Scale
		}
	end

	return t, t2, t3
end

local function projectSkins(p1) --[[ projectSkins | Line: 121 | Upvalues: normalizeSkinInventory (copy), makeDeterministicUID (copy) ]]
	local t = {}

	for k, v in pairs((normalizeSkinInventory(p1))) do
		t[makeDeterministicUID(k)] = {
			id = k,
			_am = v
		}
	end

	return t
end

local function buildSetPacket(p1) --[[ buildSetPacket | Line: 135 ]]
	local t = {}

	for k, v in pairs(p1) do
		if next(v) ~= nil then
			t[k] = v
		end
	end

	if next(t) == nil then
		return nil
	end

	return {
		set = t
	}
end

function t.MakeSkinUID(p1) --[[ MakeSkinUID | Line: 157 | Upvalues: makeDeterministicUID (copy) ]]
	assert(type(p1) == "string", "Expected skinId to be a string")

	return makeDeterministicUID(p1)
end
function t.GetOwnedSkinCount(p1, p2) --[[ GetOwnedSkinCount | Line: 162 ]]
	assert(if type(p2) == "string" then true else false, "Expected skinId to be a string")

	local v2 = if p1 then p1[p2] or nil else nil

	if type(v2) ~= "number" then
		return 0
	end

	local v3 = math.floor(v2)

	if v3 <= 0 then
		return 0
	end

	return v3
end
function t.NormalizeSkinInventory(p1) --[[ NormalizeSkinInventory | Line: 167 | Upvalues: normalizeSkinInventory (copy) ]]
	return normalizeSkinInventory(p1)
end
function t.BuildSnapshot(p1) --[[ BuildSnapshot | Line: 173 | Upvalues: projectBrainrots (copy), projectSkins (copy) ]]
	assert(type(p1) == "table", "Expected saveData to be a table")

	return {
		Brainrot = projectBrainrots(p1.Inventory),
		Skin = projectSkins(p1.SkinInventory)
	}
end
function t.BuildInitialPacket(p1) --[[ BuildInitialPacket | Line: 184 | Upvalues: buildSetPacket (copy), t (copy) ]]
	return buildSetPacket(t.BuildSnapshot(p1))
end
function t.BuildInventoryPatchPacket(p1, p2) --[[ BuildInventoryPatchPacket | Line: 188 | Upvalues: buildBrainrotPatch (copy) ]]
	local t = {}
	local v1, v2, v3 = buildBrainrotPatch(p1)

	if next(v1) ~= nil then
		t.Brainrot = v1
	end

	if p2 then
		for k in pairs(p2) do
			if not v3[k] then
				v2[#v2 + 1] = k
			end
		end
	end

	if next(t) == nil and #v2 == 0 then
		return nil
	end

	local t2 = {}

	t2.set = if next(t) and t then t else nil
	t2.del = if #v2 > 0 then v2 else nil

	return t2
end
function t.BuildDeltaPacket(p1, p2) --[[ BuildDeltaPacket | Line: 217 | Upvalues: t (copy), DeepEqualsUnsafe (copy) ]]
	assert(if type(p1) == "table" then true else false, "Expected previousData to be a table")
	assert(if type(p2) == "table" then true else false, "Expected nextData to be a table")

	local v3 = t.BuildSnapshot(p1)
	local t2 = {}
	local t3 = {}

	for k, v in pairs((t.BuildSnapshot(p2))) do
		local v5 = v3[k]

		for k2, v6 in pairs(v) do
			local v62 = v5[k2]

			if v62 == nil or not DeepEqualsUnsafe(v62, v6) then
				local v7 = t2[k]

				if not v7 then
					v7 = {}
					t2[k] = v7
				end

				v7[k2] = v6
			end
		end

		for k2 in pairs(v5) do
			if v[k2] == nil then
				t3[#t3 + 1] = k2
			end
		end
	end

	if next(t2) == nil and #t3 == 0 then
		return nil
	end

	local t4 = {}

	t4.set = if next(t2) and t2 then t2 else nil
	t4.del = if #t3 > 0 then t3 else nil

	return t4
end

return t