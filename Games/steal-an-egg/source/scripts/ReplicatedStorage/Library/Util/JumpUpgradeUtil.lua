-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local EternityNum = require(ReplicatedStorage.Library.Modules.EternityNum)
local BASE_JUMP_HEIGHT = Constants.BASE_JUMP_HEIGHT
local t = {}

local function getCostForN(p1, p2) --[[ getCostForN | Line: 22 | Upvalues: EternityNum (copy), t (copy) ]]
	local v1 = EternityNum.fromNumber(1.1653)
	local v2 = EternityNum.fromNumber(1)

	return EternityNum.mul(t.GetCost(p1), EternityNum.div(EternityNum.sub(EternityNum.pow(v1, EternityNum.fromNumber(p2)), v2), EternityNum.sub(v1, v2)))
end

function t.GetCost(p1) --[[ GetCost | Line: 35 | Upvalues: EternityNum (copy), BASE_JUMP_HEIGHT (copy) ]]
	return EternityNum.mul(EternityNum.fromNumber(200), EternityNum.pow(EternityNum.fromNumber(1.1653), EternityNum.fromNumber(p1 + 1 - BASE_JUMP_HEIGHT)))
end
function t.GetCostFor5(p1) --[[ GetCostFor5 | Line: 45 | Upvalues: getCostForN (copy) ]]
	return getCostForN(p1, 5)
end
function t.GetCostFor10(p1) --[[ GetCostFor10 | Line: 49 | Upvalues: getCostForN (copy) ]]
	return getCostForN(p1, 10)
end
function t.GetRobuxCost(p1) --[[ GetRobuxCost | Line: 53 | Upvalues: BASE_JUMP_HEIGHT (copy) ]]
	if BASE_JUMP_HEIGHT <= p1 and p1 < 19 then
		return 9
	end

	if p1 >= 19 and p1 < 39 then
		return 19
	end

	if p1 >= 39 and p1 < 59 then
		return 29
	end

	if p1 >= 59 and p1 < 79 then
		return 49
	end

	if p1 >= 79 and p1 < 99 then
		return 69
	end

	if p1 >= 99 and p1 < 119 then
		return 99
	end

	if p1 >= 119 and p1 < 139 then
		return 139
	end

	if p1 >= 139 and p1 < 159 then
		return 179
	end

	if p1 >= 159 then
		return 229
	end

	return 0
end
function t.GetJumpModifierFromPower(p1) --[[ GetJumpModifierFromPower | Line: 85 | Upvalues: Asserts (copy), Constants (copy) ]]
	Asserts.number(p1)

	local BASE_JUMP_HEIGHT = Constants.BASE_JUMP_HEIGHT

	Asserts.finiteNonNegative(BASE_JUMP_HEIGHT)

	if BASE_JUMP_HEIGHT <= 0 then
		return 0
	end

	return p1 / BASE_JUMP_HEIGHT - 1
end

return t