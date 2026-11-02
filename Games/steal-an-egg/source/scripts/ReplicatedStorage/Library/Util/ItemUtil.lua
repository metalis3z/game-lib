-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local Interface = require(script.Types.Interface)
local Currency = require(ReplicatedStorage.Library.Types.Currency)
local t = {
	__types = Interface,
	Validate = function(p1, p2) --[[ Validate | Line: 26 | Upvalues: Currency (copy) ]]
		return Currency.SchemaValidation.AllCurrencyTypes(p2.Currency) == true
	end,
	EnsureItemValid = function(p1, p2) --[[ EnsureItemValid | Line: 34 ]]
		local v1 = p1:Validate(p2)

		assert(v1, (("%s is not a valid item."):format(p1:GetName(p2))))
	end,
	GetName = function(p1, p2) --[[ GetName | Line: 44 ]]
		return p2.Currency or "Unknown"
	end,
	GetDescription = function(p1, p2) --[[ GetDescription | Line: 52 ]]
		return ""
	end,
	CanBeBoosted = function(p1, p2) --[[ CanBeBoosted | Line: 60 ]]
		error("not used")
	end,
	GetValue = function(p1, p2) --[[ GetValue | Line: 68 ]]
		p1:EnsureItemValid(p2)

		return 1
	end,
	GetAmount = function(p1, p2) --[[ GetAmount | Line: 77 ]]
		p1:EnsureItemValid(p2)

		return p2.Amount or 1
	end,
	SetAmount = function(p1, p2, p3) --[[ SetAmount | Line: 86 | Upvalues: Asserts (copy) ]]
		Asserts.number(p3)
		p1:EnsureItemValid(p2)
		p2.Amount = p3
	end,
	GetOwnedAmount = function(p1, p2, p3) --[[ GetOwnedAmount | Line: 98 ]]
		p1:EnsureItemValid(p3)

		return p2[p3.Currency or ""] or 0
	end,
	CanAfford = function(p1, p2, p3) --[[ CanAfford | Line: 108 ]]
		p1:EnsureItemValid(p3)

		return p1:GetOwnedAmount(p2, p3) >= p1:GetAmount(p3)
	end,
	Compare = function(p1, p2, p3, p4) --[[ Compare | Line: 119 ]]
		if p4 and p2.Amount ~= p3.Amount then
			return false
		end

		return p2.Currency == p3.Currency
	end
}

local function ModifyStats(p1, p2, p3, p4) --[[ ModifyStats | Line: 133 | Upvalues: Asserts (copy), Interface (copy) ]]
	Asserts.table(p1)
	Asserts.number(p3)

	local Currency = p2.Currency

	assert(Interface.AvailableCurrencies(p2.Currency))
	assert(p1[Currency], (("Player stats do not contain currency: %*"):format(p2.Currency)))
	p1[Currency] = p1[Currency] + p3

	return Currency, p1[Currency]
end

function t.Deduct(p1, p2, p3, p4) --[[ Deduct | Line: 152 | Upvalues: ModifyStats (copy) ]]
	if not p1:Validate(p3) then
		return nil
	end

	local v1 = p1:GetAmount(p3)

	if v1 <= p1:GetOwnedAmount(p2, p3) then
		return ModifyStats(p2, p3, -v1, p4)
	end

	return nil
end
function t.Add(p1, p2, p3, p4) --[[ Add | Line: 167 | Upvalues: ModifyStats (copy) ]]
	if p1:Validate(p3) then
		return ModifyStats(p2, p3, p1:GetAmount(p3), p4)
	end

	return nil
end
function t.Split(p1, p2, p3) --[[ Split | Line: 179 ]]
	local v1 = p2.Amount or 0

	if v1 <= p3 then
		return { p2 }
	end

	local v2 = math.min(v1, p3)
	local v3 = math.floor(v1 / v2)
	local v4 = table.create(v2, v3)

	for i = 1, v1 - v3 * v2 do
		v4[i] = v4[i] + 1
	end

	local t = {}

	for i, v in ipairs(v4) do
		local v5 = table.clone(p2)

		v5.Amount = v
		table.insert(t, v5)
	end

	return t
end
function t.Combine(p1, p2) --[[ Combine | Line: 208 ]]
	local tbl = {}

	for i, v in ipairs(p2) do
		local v1 = p1:GetName(v)

		if tbl[v1] then
			local v2 = tbl[v1]

			v2.Amount = v2.Amount + p1:GetAmount(v)

			continue
		end

		local v3 = table.clone(v)

		v3.Amount = p1:GetAmount(v3)
		tbl[v1] = v3
	end

	local t = {}

	for k, v in pairs(tbl) do
		table.insert(t, v)
	end

	for i, v in ipairs({}) do
		table.insert(t, v)
	end

	return t
end

return t