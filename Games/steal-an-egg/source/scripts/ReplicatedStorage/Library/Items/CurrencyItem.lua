-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Directory = require(ReplicatedStorage.Directory.Currency).Directory
local Rarity = require(ReplicatedStorage.Directory.Rarity)
local AbstractItem = require(script.Parent.AbstractItem)
local Currency = require(ReplicatedStorage.Library.Types.Currency)

require(ReplicatedStorage.Library.Util.ItemUtil.Types.Interface)

local Signal = require(ReplicatedStorage.Library.Signal)

require(ReplicatedStorage.Library.Modules.Packages.InstanceCache)

local t = {
	Directory = Directory
}
local v1 = setmetatable({
	StackLimit = 1,
	LockingEnabled = false,
	TradingEnabled = false,
	CreationTimeEnabled = false,
	CreationUserEnabled = false,
	OwnerCountEnabled = false,
	OwnerLogEnabled = false,
	NicknameEnabled = false,
	SignedByEnabled = false
}, {
	__index = AbstractItem.Prototype
})
local v2, v3 = AbstractItem.Define("Currency", script, t)

v1.Class = v2
t.Class = v2
t.Prototype = v1

local t3 = {
	[250000] = "rbxassetid://75372541151576",
	[1000000] = "rbxassetid://139742352093157",
	[5000000] = "rbxassetid://112271178072366"
}

local function new(p1, p2) --[[ new | Line: 62 | Upvalues: Directory (copy), v3 (copy), t (copy) ]]
	local v1

	if type(p2) == "string" then
		assert(Directory[p2], (("Currency not found in directory for ID: %*"):format(p2)))
		v1 = p2
	else
		assert(Directory[p2._id] == p2, (("Currency not found in directory for ID: %*"):format(p2._id)))
		v1 = p2._id
	end

	return v3.From(t, {
		id = v1
	})
end

function v1.Patch(p1) --[[ Patch | Line: 84 ]]
	local v1 = p1:GetAmount()
	local v2 = p1:GetMaxAmount()

	if not (v2 < v1) then
		return
	end

	p1:SetAmount(v2)
end
function v1.AbstractIsRAPVisible(p1) --[[ AbstractIsRAPVisible | Line: 92 ]]
	return false
end
function v1.GetId(p1) --[[ GetId | Line: 96 ]]
	return p1._data.id
end
function v1.AbstractGetMaxAmount(p1) --[[ AbstractGetMaxAmount | Line: 100 ]]
	return (1 / 0)
end
function v1.ToRewardFormat(p1) --[[ ToRewardFormat | Line: 104 | Upvalues: Signal (copy) ]]
	local v1 = p1:GetId()
	local v2 = p1:GetAmount()

	return function(p1) --[[ Line: 107 | Upvalues: Signal (ref), v1 (copy), v2 (copy) ]]
		Signal.Fire(Signal.MAP.Server.MoneyService.ADD, p1, v1, v2)
	end
end
function v1.ToItemUtilFormat(p1) --[[ ToItemUtilFormat | Line: 112 | Upvalues: Currency (copy) ]]
	local v1 = Currency.AllCurrencyTypes[p1:GetId()]

	assert(v1, (("Attempt to convert non-currency item to ItemUtil format: %*"):format((p1:GetId()))))

	return {
		Currency = p1:GetId(),
		Amount = p1:GetAmount()
	}
end
function v1.SetId(p1, p2) --[[ SetId | Line: 123 | Upvalues: Directory (copy) ]]
	assert(Directory[p2], (("Currency not found in directory for ID: %*"):format(p2)))
	p1._data.id = p2

	return p1
end
function v1.SetDirectory(p1, p2) --[[ SetDirectory | Line: 129 | Upvalues: Directory (copy) ]]
	local v1 = if Directory[p2._id] == p2 then true else false

	assert(v1, (("Currency not found in directory for ID: %*"):format(p2._id)))

	return p1:SetId(p2._id)
end
function v1.Directory(p1) --[[ Directory | Line: 134 | Upvalues: Directory (copy) ]]
	return Directory[p1._data.id]
end
function v1.GetIcon(p1) --[[ GetIcon | Line: 138 | Upvalues: t3 (copy) ]]
	local v1 = p1:GetAmount()
	local v2 = -1
	local v3 = nil

	for k, v in pairs(t3) do
		if k <= v1 and v2 < k then
			v2 = k
			v3 = v
		end
	end

	if v3 then
		return v3
	end

	return p1:Directory().Icon or ""
end
function v1.GetName(p1) --[[ GetName | Line: 158 ]]
	return p1:Directory().DisplayName or ""
end
function v1.GetDesc(p1) --[[ GetDesc | Line: 162 ]]
	return p1:Directory().Desc or ""
end
function v1.GetRarity(p1) --[[ GetRarity | Line: 166 | Upvalues: Rarity (copy) ]]
	return p1:Directory().Rarity or Rarity.Rarities.Rare
end
function v1.GetOrbInstance(p1) --[[ GetOrbInstance | Line: 170 ]]
	return p1:Directory().Instance
end
function v1.GetCollectDistanceOverride(p1) --[[ GetCollectDistanceOverride | Line: 174 ]]
	return p1:Directory().CollectDistanceOverride
end
function v1.GetPickupDistanceOverride(p1) --[[ GetPickupDistanceOverride | Line: 178 ]]
	return p1:Directory().PickupDistanceOverride
end

return setmetatable(t, {
	__index = v3,
	__call = new
})