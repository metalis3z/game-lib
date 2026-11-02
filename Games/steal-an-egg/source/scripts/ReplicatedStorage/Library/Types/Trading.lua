-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Library.Modules.Packages.t)
local t2 = {
	ReadyDebounce = 1,
	ReadyDuration = 5,
	ModificationReadyDuration = 3,
	MessageDebounce = 1,
	MessageLimit = 200,
	ItemLimit = 100,
	HistoryLimit = 20,
	RequiredRebirth = 3,
	BoothHistoryLimit = 30,
	Setting = {
		All = 1,
		Friends = 2,
		Off = 3
	}
}

t2.ClientMessageDebounce = t2.MessageDebounce + 0.5
t2.ConfirmCountdownSeconds = t2.ReadyDuration
t2.TradableItemTypesInverse = {
	Currency = "Currency",
	Brainrot = "Brainrot"
}
t2.ItemPolicies = {
	[t2.TradableItemTypesInverse.Currency] = {
		Enabled = false,
		InventoryVisible = false
	},
	[t2.TradableItemTypesInverse.Brainrot] = {
		Enabled = true,
		InventoryVisible = true
	}
}

local t3 = {}

t2.SchemaValidation = t3
t3.TradableItemTypes = t.union(t.literal("Currency"), t.literal("Brainrot"))

local function buildItemTypeList(p1) --[[ buildItemTypeList | Line: 58 | Upvalues: t2 (copy) ]]
	local t = {}

	for i, v in ipairs({ t2.TradableItemTypesInverse.Brainrot, t2.TradableItemTypesInverse.Currency }) do
		local v1 = t2.ItemPolicies[v]

		if v1 and p1(v1) then
			table.insert(t, v)
		end
	end

	return t
end

function t2.GetItemPolicy(p1) --[[ GetItemPolicy | Line: 74 | Upvalues: t2 (copy) ]]
	return t2.ItemPolicies[p1]
end
function t2.IsTradableItemType(p1) --[[ IsTradableItemType | Line: 78 | Upvalues: t2 (copy) ]]
	local v1 = t2.ItemPolicies[p1]

	return if v1 == nil then false else v1.Enabled
end
function t2.IsInventoryItemType(p1) --[[ IsInventoryItemType | Line: 83 | Upvalues: t2 (copy) ]]
	local v1 = t2.ItemPolicies[p1]

	return if v1 == nil then false else v1.Enabled and v1.InventoryVisible
end
function t2.HasRequiredRebirth(p1) --[[ HasRequiredRebirth | Line: 88 | Upvalues: t2 (copy) ]]
	return t2.RequiredRebirth <= p1
end
t2.TradableItemTypes = buildItemTypeList(function(p1) --[[ Line: 92 ]]
	return p1.Enabled
end)
t2.InventoryItemTypes = buildItemTypeList(function(p1) --[[ Line: 96 ]]
	return p1.Enabled and p1.InventoryVisible
end)

return t2