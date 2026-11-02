-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets = require(ReplicatedStorage.Directory.Assets)
local Rarity = require(ReplicatedStorage.Directory.Rarity)
local AbstractItem = require(script.Parent.AbstractItem)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local Asserts = require(ReplicatedStorage.Library.Asserts)

require(ReplicatedStorage.Library.Types.AssetItem)

local Personalities = require(ReplicatedStorage.Directory.Assets.Personalities)
local Mutations = require(ReplicatedStorage.Library.Modules.Mutations)
local v1 = require(ReplicatedStorage.Library.Modules.Packages.Log).new()
local Signal = require(ReplicatedStorage.Library.Signal)
local AssetGenerationUtil = require(ReplicatedStorage.Library.Util.AssetGenerationUtil)
local t = {
	Directory = Assets.Directory
}
local v2 = setmetatable({}, {
	__index = AbstractItem.Prototype
})
local v3, v4 = AbstractItem.Define("Brainrot", script, t)

v2.Class = v3
t.Class = v3
t.Prototype = v2

local function ensureDataDefaults(p1) --[[ ensureDataDefaults | Line: 40 ]]
	local v1 = p1:GetData()

	if v1.Mutations == nil then
		v1.Mutations = {}
	end

	if v1.Scale == nil then
		v1.Scale = 1
	end

	return v1
end

local function getAssetItemData(p1) --[[ getAssetItemData | Line: 51 | Upvalues: Personalities (copy) ]]
	local v1 = p1:GetData()

	if v1.Mutations == nil then
		v1.Mutations = {}
	end

	if v1.Scale == nil then
		v1.Scale = 1
	end

	return {
		HasBeenFirstPlaced = true,
		Category = p1:GetId(),
		Mutations = table.clone(v1.Mutations),
		BaseMutation = v1.BaseMutation,
		Scale = v1.Scale,
		Personality = Personalities.Personalities.Normal
	}
end

local function newBrainrot(p1, p2) --[[ newBrainrot | Line: 64 | Upvalues: Assets (copy), v4 (copy), t (copy) ]]
	local v1

	if type(p2) == "string" then
		assert(Assets.Directory[p2], (("brainrot not found in directory for identifier: %*"):format(p2)))
		v1 = p2
	else
		assert(Assets.Directory[p2._id] == p2, (("brainrot not found in directory for ID: %*"):format(p2._id)))
		v1 = p2._id
	end

	local v6 = v4.From(t, {
		id = v1
	})
	local v7 = v6:GetData()

	if v7.Mutations == nil then
		v7.Mutations = {}
	end

	if v7.Scale ~= nil then
		return v6
	end

	v7.Scale = 1

	return v6
end

function v2.AbstractPopulate(p1) --[[ AbstractPopulate | Line: 84 ]] end
function v2.GetId(p1) --[[ GetId | Line: 86 ]]
	return p1._data.id
end
function v2.SetId(p1, p2) --[[ SetId | Line: 90 | Upvalues: Assets (copy) ]]
	assert(Assets.Directory[p2], (("brainrot not found in directory for ID: %*"):format(p2)))
	p1._data.id = p2

	return p1
end
function v2.SetDirectory(p1, p2) --[[ SetDirectory | Line: 96 | Upvalues: Assets (copy) ]]
	local v1 = if Assets.Directory[p2._id] == p2 then true else false

	assert(v1, (("brainrot not found in directory for ID: %*"):format(p2._id)))

	return p1:SetId(p2._id)
end
function v2.Directory(p1) --[[ Directory | Line: 101 | Upvalues: Assets (copy) ]]
	return Assets.Directory[p1._data.id]
end
function v2.GetName(p1) --[[ GetName | Line: 105 ]]
	return p1:Directory().DisplayName or ""
end
function v2.ComputeRarityImpact(p1) --[[ ComputeRarityImpact | Line: 109 ]]
	return math.clamp(math.floor(p1:GetRarity().RarityNumber / 2), 1, 3)
end
function v2.GetRarity(p1) --[[ GetRarity | Line: 113 | Upvalues: Rarity (copy) ]]
	return p1:Directory().Rarity or Rarity.Rarities.Basic
end
function v2.GetIcon(p1) --[[ GetIcon | Line: 117 ]]
	local v1 = p1:Directory()
	local v2 = p1:GetMutations()[1]

	if v2 then
		local MutationIcons = v1.MutationIcons

		if MutationIcons then
			local v3 = MutationIcons[v2]

			if v3 then
				return v3
			end
		end
	end

	return v1.Icon or ""
end
function v2.AbstractIsTradable(p1) --[[ AbstractIsTradable | Line: 135 ]]
	local isNotIsTradable = p1:Directory().IsTradable ~= false

	return isNotIsTradable
end
function v2.AbstractCompareTo(p1, p2) --[[ AbstractCompareTo | Line: 139 | Upvalues: AssetGenerationUtil (copy), getAssetItemData (copy) ]]
	if p1:GetRarity() ~= p2:GetRarity() then
		return 0
	end

	local v1 = AssetGenerationUtil.GetRateWithoutRebirth((getAssetItemData(p1)))
	local v2 = AssetGenerationUtil.GetRateWithoutRebirth((getAssetItemData(p2)))

	if v1 == v2 then
		return 0
	end

	if v1 < v2 then
		return 1
	end

	return -1
end
function v2.GetMutations(p1) --[[ GetMutations | Line: 153 ]]
	local v1 = p1:GetData()

	if v1.Mutations == nil then
		v1.Mutations = {}
	end

	if v1.Scale == nil then
		v1.Scale = 1
	end

	return v1.Mutations
end
function v2.HasMutation(p1, p2) --[[ HasMutation | Line: 158 | Upvalues: Asserts (copy), Mutations (copy), Constants (copy), v1 (copy) ]]
	Asserts.string(p2)

	if Mutations.Exists(p2) then
		return table.find(p1:GetMutations(), p2) ~= nil
	end

	local v2 = ("Mutation %* does not exist in the mutation directory!"):format(p2)

	if Constants.IS_STUDIO then
		error(v2)
	end

	v1:AtError():Log(v2)

	return false
end
function v2.SetMutations(p1, p2) --[[ SetMutations | Line: 175 | Upvalues: Asserts (copy) ]]
	Asserts.table(p2)

	for i, v in ipairs(p2) do
		Asserts.string(v)
	end

	local v1 = p1:GetData()

	if v1.Mutations == nil then
		v1.Mutations = {}
	end

	if v1.Scale == nil then
		v1.Scale = 1
	end

	v1.Mutations = table.clone(p2)

	return p1
end
function v2.SetBaseMutation(p1, p2) --[[ SetBaseMutation | Line: 186 | Upvalues: Asserts (copy) ]]
	if p2 ~= nil then
		Asserts.string(p2)
	end

	local v1 = p1:GetData()

	if v1.Mutations == nil then
		v1.Mutations = {}
	end

	if v1.Scale == nil then
		v1.Scale = 1
	end

	v1.BaseMutation = p2

	return p1
end
function v2.SetScale(p1, p2) --[[ SetScale | Line: 196 | Upvalues: Asserts (copy) ]]
	Asserts.number(p2)

	local v1 = p1:GetData()

	if v1.Mutations == nil then
		v1.Mutations = {}
	end

	if v1.Scale == nil then
		v1.Scale = 1
	end

	v1.Scale = p2

	return p1
end
function v2.ToRewardFormat(p1, p2) --[[ ToRewardFormat | Line: 204 | Upvalues: Signal (copy) ]]
	local v1 = p1:GetId()
	local v2 = p1:GetData()

	if v2.Mutations == nil then
		v2.Mutations = {}
	end

	if v2.Scale == nil then
		v2.Scale = 1
	end

	local v3 = table.clone(v2.Mutations)
	local v4 = v2.BaseMutation or v3[1]
	local v5 = v2.Scale or 1

	return function(p1) --[[ Line: 211 | Upvalues: Signal (ref), v1 (copy), v3 (copy), v4 (copy), v5 (copy) ]]
		Signal.Invoke(Signal.MAP.Server.BrainrotItem.SPAWN_FOR_REWARD, p1, v1, v3, v4, v5)
	end
end

return setmetatable(t, {
	__index = v4,
	__call = newBrainrot
})