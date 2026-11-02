-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local EternityNum = require(ReplicatedStorage.Library.Modules.EternityNum)
local GetPrice = require(ReplicatedStorage.Library.Functions.GetPrice)
local t = { 100, 1000000, 500000000, 100000000000, 100000000000000, 7000000000000000 }
local t2 = {
	GetCost = function(p1) --[[ GetCost | Line: 28 | Upvalues: Asserts (copy), t (copy), EternityNum (copy) ]]
		Asserts.integerNonNegative(p1)

		if p1 < 1 then
			return nil
		end

		local v1 = t[p1]

		if typeof(v1) == "number" then
			return EternityNum.fromNumber(v1)
		end

		return nil
	end
}

function t2.GetRobuxProductId(p1, p2) --[[ GetRobuxProductId | Line: 43 | Upvalues: Asserts (copy), t2 (copy), ReplicatedStorage (copy) ]]
	Asserts.integerNonNegative(p1)
	Asserts.integerNonNegative(p2)

	if p2 ~= 1 then
		return nil
	end

	if t2.GetCost(p1) then
		return require(ReplicatedStorage.Directory.Products).Directory.CarryUpgrade_1.ProductId
	end

	return nil
end
function t2.GetRobuxCost(p1, p2) --[[ GetRobuxCost | Line: 60 | Upvalues: Asserts (copy), t2 (copy), GetPrice (copy) ]]
	Asserts.integerNonNegative(p1)
	Asserts.integerNonNegative(p2)

	local v1 = t2.GetRobuxProductId(p1, p2)

	if not v1 then
		return nil
	end

	local v2, v3 = GetPrice(v1, true)

	if v3 then
		return v2
	end

	return nil
end

return t2