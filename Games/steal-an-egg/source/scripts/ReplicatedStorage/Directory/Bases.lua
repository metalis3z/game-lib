-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local Asserts = require(ReplicatedStorage.Library.Asserts)
local t = {}
local t2 = {
	1000,
	1000000,
	75000000,
	500000000,
	1000000000,
	50000000000,
	500000000000,
	1000000000000,
	25000000000000,
	100000000000000,
	500000000000000,
	1000000000000000
}

local function getBaseModelIfServer(p1) --[[ getBaseModelIfServer | Line: 43 | Upvalues: Asserts (copy), Constants (copy), ServerStorage (copy) ]]
	Asserts.string(p1)

	if Constants.IS_SERVER then
		return ServerStorage.Assets.Models.Bases.Main[p1]
	end

	return nil
end

local t3 = {}
local t4 = {
	MaxAssets = 7,
	Cost = 0
}

Asserts.string("1")
t4.Model = if Constants.IS_SERVER then ServerStorage.Assets.Models.Bases.Main["1"] else nil
t3[0] = t4

local t5 = {
	MaxAssets = 7
}

Asserts.string("1")
t5.Model = if Constants.IS_SERVER then ServerStorage.Assets.Models.Bases.Main["1"] else nil
t5.Cost = t2[1]
t3[1] = t5

local t6 = {
	MaxAssets = 9
}

Asserts.string("2")
t6.Model = if Constants.IS_SERVER then ServerStorage.Assets.Models.Bases.Main["2"] else nil
t6.Cost = t2[2]
t3[2] = t6

local t7 = {
	MaxAssets = 10
}

Asserts.string("3")
t7.Model = if Constants.IS_SERVER then ServerStorage.Assets.Models.Bases.Main["3"] else nil
t7.Cost = t2[3]
t3[3] = t7

local t8 = {
	MaxAssets = 11
}

Asserts.string("4")
t8.Model = if Constants.IS_SERVER then ServerStorage.Assets.Models.Bases.Main["4"] else nil
t8.Cost = t2[4]
t3[4] = t8

local t9 = {
	MaxAssets = 12
}

Asserts.string("5")
t9.Model = if Constants.IS_SERVER then ServerStorage.Assets.Models.Bases.Main["5"] else nil
t9.Cost = t2[5]
t3[5] = t9

local t10 = {
	MaxAssets = 13
}

Asserts.string("6")
t10.Model = if Constants.IS_SERVER then ServerStorage.Assets.Models.Bases.Main["6"] else nil
t10.Cost = t2[6]
t3[6] = t10

local t11 = {
	MaxAssets = 14
}

Asserts.string("7")
t11.Model = if Constants.IS_SERVER then ServerStorage.Assets.Models.Bases.Main["7"] else nil
t11.Cost = t2[7]
t3[7] = t11

local t12 = {
	MaxAssets = 15
}

Asserts.string("8")
t12.Model = if Constants.IS_SERVER then ServerStorage.Assets.Models.Bases.Main["8"] else nil
t12.Cost = t2[8]
t3[8] = t12

local t13 = {
	MaxAssets = 16
}

Asserts.string("9")
t13.Model = if Constants.IS_SERVER then ServerStorage.Assets.Models.Bases.Main["9"] else nil
t13.Cost = t2[9]
t3[9] = t13

local t14 = {
	MaxAssets = 17
}

Asserts.string("10")
t14.Model = if Constants.IS_SERVER then ServerStorage.Assets.Models.Bases.Main["10"] else nil
t14.Cost = t2[10]
t3[10] = t14

local t15 = {
	MaxAssets = 18
}

Asserts.string("11")
t15.Model = if Constants.IS_SERVER then ServerStorage.Assets.Models.Bases.Main["11"] else nil
t15.Cost = t2[11]
t3[11] = t15
t.BASES = t3
t.SKINS = {}
t.MIN_ASSET_EQUIP_CAPACITY = t.BASES[0].MaxAssets
t.MAX_ASSET_EQUIP_CAPACITY = t.BASES[#t.BASES].MaxAssets
function t.GetMaxBaseLevel() --[[ GetMaxBaseLevel | Line: 122 | Upvalues: t (copy) ]]
	local v1 = 0

	for k in pairs(t.BASES) do
		if v1 < k then
			v1 = k
		end
	end

	return v1
end
function t.GetBaseConfigFor(p1, p2) --[[ GetBaseConfigFor | Line: 134 | Upvalues: Asserts (copy), t (copy) ]]
	Asserts.number(p1)
	Asserts.optional.string(p2)

	local v3, v4 = math.max(0, (math.floor(p1))), nil

	for k in pairs(t.BASES) do
		if k <= v3 and (not v4 or v4 < k) then
			v4 = k
		end
	end

	if v4 and p2 then
		return t.BASES[v4], t.SKINS[p2]
	end

	if v4 then
		return t.BASES[v4]
	end

	return nil
end
function t.GetAssetEquipCapacity(p1) --[[ GetAssetEquipCapacity | Line: 158 | Upvalues: t (copy) ]]
	local v1 = t.GetBaseConfigFor(p1 or 0)

	return t.GetBaseConfigFor(p1 or 0) and v1.MaxAssets or t.MIN_ASSET_EQUIP_CAPACITY
end

if Constants.IS_STUDIO then
	assert(#t2 >= #t.BASES, "Not enough costs for the number of bases")

	for k, v in pairs(t.BASES) do
		local v15 = if v.Cost == t2[k] then true elseif k == 0 then if v.Cost == 0 then true else false else false

		assert(v15, (("Cost for base index %* does not match expected cost from COSTS table"):format(k)))

		if Constants.IS_SERVER then
			local Model = v.Model
			local v17 = if typeof(Model) == "Instance" then Model:IsA("Model") else false

			assert(v17, (("Model for base index %* is not a valid Model instance"):format(k)))

			local v19 = Model.PrimaryPart and (if Model.PrimaryPart.Name == "CenterPoint" then true else false)

			assert(v19, (("Model for base index %* must have a PrimaryPart named \"CenterPoint\""):format(k)))

			local ToUpdate = Model:FindFirstChild("ToUpdate")
			local v21 = if ToUpdate then ToUpdate:IsA("Model") and (ToUpdate.PrimaryPart and (if ToUpdate.PrimaryPart.Name == "CenterPoint" then ToUpdate:FindFirstChild("PetArea") else false)) else ToUpdate

			assert(v21, (("Model for base index %* must have a child Model named \"ToUpdate\" with a PrimaryPart named \"CenterPoint\""):format(k)))
		end

		local v23 = if typeof(v.MaxAssets) == "number" then if v.MaxAssets == t.GetAssetEquipCapacity(k) then true else false else false

		assert(v23, (("MaxAssets for base index %* must match asset equip capacity"):format(k)))
	end
end

if Constants.IS_STUDIO and Constants.IS_SERVER then
	for k, v in pairs(t.SKINS) do
		local v25 = if typeof(v.FirstFloor) == "Instance" then v.FirstFloor:IsA("Model") else false

		assert(v25, (("Model for base skin index %* is not a valid Model instance"):format(k)))
	end
end

return t