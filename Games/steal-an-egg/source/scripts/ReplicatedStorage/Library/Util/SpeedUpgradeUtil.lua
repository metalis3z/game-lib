-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local EternityNum = require(ReplicatedStorage.Library.Modules.EternityNum)
local GetPrice = require(ReplicatedStorage.Library.Functions.GetPrice)
local BASE_WALK_SPEED = Constants.BASE_WALK_SPEED
local t = {}

local function getCostForN(p1, p2) --[[ getCostForN | Line: 23 | Upvalues: EternityNum (copy), t (copy) ]]
	local v1 = EternityNum.fromNumber(1.1653)
	local v2 = EternityNum.fromNumber(1)

	return EternityNum.mul(t.GetCost(p1), EternityNum.div(EternityNum.sub(EternityNum.pow(v1, EternityNum.fromNumber(p2)), v2), EternityNum.sub(v1, v2)))
end

function t.GetCost(p1) --[[ GetCost | Line: 36 | Upvalues: EternityNum (copy), BASE_WALK_SPEED (copy) ]]
	return EternityNum.mul(EternityNum.fromNumber(200), EternityNum.pow(EternityNum.fromNumber(1.1653), EternityNum.fromNumber(p1 + 1 - BASE_WALK_SPEED)))
end
function t.GetCostFor5(p1) --[[ GetCostFor5 | Line: 46 | Upvalues: getCostForN (copy) ]]
	return getCostForN(p1, 5)
end
function t.GetCostFor10(p1) --[[ GetCostFor10 | Line: 50 | Upvalues: getCostForN (copy) ]]
	return getCostForN(p1, 10)
end
function t.GetRobuxProductId(p1, p2) --[[ GetRobuxProductId | Line: 54 | Upvalues: Asserts (copy), ReplicatedStorage (copy), BASE_WALK_SPEED (copy), Constants (copy) ]]
	Asserts.integerNonNegative(p1)
	Asserts.integerNonNegative(p2)

	local Products = require(ReplicatedStorage.Directory.Products)

	for i, v in ipairs({
		{
			Min = BASE_WALK_SPEED,
			Max = Constants.BASE_WALK_SPEED,
			Products = {
				[1] = Products.Directory.SpeedUpgrade_1_Tier1,
				[5] = Products.Directory.SpeedUpgrade_5_Tier1,
				[10] = Products.Directory.SpeedUpgrade_10_Tier1
			}
		},
		{
			Min = 19,
			Max = 38,
			Products = {
				[1] = Products.Directory.SpeedUpgrade_1_Tier2,
				[5] = Products.Directory.SpeedUpgrade_5_Tier2,
				[10] = Products.Directory.SpeedUpgrade_10_Tier2
			}
		},
		{
			Min = 39,
			Max = 58,
			Products = {
				[1] = Products.Directory.SpeedUpgrade_1_Tier3,
				[5] = Products.Directory.SpeedUpgrade_5_Tier3,
				[10] = Products.Directory.SpeedUpgrade_10_Tier3
			}
		},
		{
			Min = 59,
			Max = 78,
			Products = {
				[1] = Products.Directory.SpeedUpgrade_1_Tier4,
				[5] = Products.Directory.SpeedUpgrade_5_Tier4,
				[10] = Products.Directory.SpeedUpgrade_10_Tier4
			}
		},
		{
			Min = 79,
			Max = 98,
			Products = {
				[1] = Products.Directory.SpeedUpgrade_1_Tier5,
				[5] = Products.Directory.SpeedUpgrade_5_Tier5,
				[10] = Products.Directory.SpeedUpgrade_10_Tier5
			}
		},
		{
			Min = 99,
			Max = 118,
			Products = {
				[1] = Products.Directory.SpeedUpgrade_1_Tier6,
				[5] = Products.Directory.SpeedUpgrade_5_Tier6,
				[10] = Products.Directory.SpeedUpgrade_10_Tier6
			}
		},
		{
			Min = 119,
			Max = 138,
			Products = {
				[1] = Products.Directory.SpeedUpgrade_1_Tier7,
				[5] = Products.Directory.SpeedUpgrade_5_Tier7,
				[10] = Products.Directory.SpeedUpgrade_10_Tier7
			}
		},
		{
			Min = 139,
			Max = 158,
			Products = {
				[1] = Products.Directory.SpeedUpgrade_1_Tier8,
				[5] = Products.Directory.SpeedUpgrade_5_Tier8,
				[10] = Products.Directory.SpeedUpgrade_10_Tier8
			}
		},
		{
			Min = 159,
			Max = (1 / 0),
			Products = {
				[1] = Products.Directory.SpeedUpgrade_1_Tier9,
				[5] = Products.Directory.SpeedUpgrade_5_Tier9,
				[10] = Products.Directory.SpeedUpgrade_10_Tier9
			}
		}
	}) do
		if v.Min <= p1 and p1 <= v.Max then
			local v1 = v.Products[p2]

			return if v1 then v1.ProductId or nil else nil
		end
	end

	return nil
end
function t.GetRobuxCost(p1, p2) --[[ GetRobuxCost | Line: 153 | Upvalues: Asserts (copy), t (copy), GetPrice (copy) ]]
	Asserts.integerNonNegative(p1)
	Asserts.integerNonNegative(p2)

	local v1 = t.GetRobuxProductId(p1, p2)

	if not v1 then
		return nil
	end

	local v2, v3 = GetPrice(v1, true)

	if v3 then
		return v2
	end

	return nil
end
function t.GetSpeedModifierFromPower(p1) --[[ GetSpeedModifierFromPower | Line: 170 | Upvalues: Asserts (copy), Constants (copy) ]]
	Asserts.number(p1)

	local BASE_WALK_SPEED = Constants.BASE_WALK_SPEED

	Asserts.finiteNonNegative(BASE_WALK_SPEED)

	if BASE_WALK_SPEED <= 0 then
		return 0
	end

	return p1 / BASE_WALK_SPEED - 1
end

return t