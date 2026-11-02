-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)

local function createEvent(p1, p2, p3, p4) --[[ createEvent | Line: 30 | Upvalues: Asserts (copy) ]]
	Asserts.positiveInteger(p1)
	Asserts.positiveInteger(p2)
	Asserts.positiveInteger(p3)
	Asserts.finite(p4)
	assert(p4 >= 1, "Recovery event egg growth multiplier must be at least one")
	assert(if p1 % 300 == 0 then true else false, "Recovery event start timestamp must align with the five-minute area egg stock period")
	assert(if p2 % 300 == 0 then true else false, "Recovery event duration must align with the five-minute area egg stock period")

	return table.freeze({
		StartsAt = p1,
		EndsAt = p1 + p2,
		DurationSeconds = p2,
		LuckVirtualRolls = p3,
		EggGrowthMultiplier = p4
	})
end

local t = { createEvent(1786366800, 12600, 2, 2), (createEvent(1786515000, 12600, 2, 2)) }
local t2 = {
	LuckPeriodSeconds = 300
}

for i = 2, #t do
	assert(t[i - 1].EndsAt <= t[i].StartsAt, "Recovery events must be ordered and cannot overlap")
end

table.freeze(t)
function t2.GetActiveEventAt(p1) --[[ GetActiveEventAt | Line: 78 | Upvalues: Asserts (copy), t (copy) ]]
	Asserts.finite(p1)

	for i, v in ipairs(t) do
		if p1 < v.StartsAt then
			break
		end

		if p1 < v.EndsAt then
			return v
		end
	end

	return nil
end
function t2.GetEventAtOrAfter(p1) --[[ GetEventAtOrAfter | Line: 93 | Upvalues: Asserts (copy), t (copy) ]]
	Asserts.finite(p1)

	for i, v in ipairs(t) do
		if p1 < v.EndsAt then
			return v
		end
	end

	return nil
end
function t2.GetGrowthBonusSeconds(p1, p2) --[[ GetGrowthBonusSeconds | Line: 105 | Upvalues: Asserts (copy), t (copy) ]]
	Asserts.finite(p1)
	Asserts.finite(p2)

	if p2 <= p1 then
		return 0
	end

	local sum = 0

	for i, v in ipairs(t) do
		if p2 <= v.StartsAt then
			break
		end

		if p1 < v.EndsAt then
			local v1 = math.max(p1, v.StartsAt)

			sum = sum + (math.min(p2, v.EndsAt) - v1) * (v.EggGrowthMultiplier - 1)
		end
	end

	return sum
end
function t2.GetLuckVirtualRollsAt(p1) --[[ GetLuckVirtualRollsAt | Line: 128 | Upvalues: t2 (copy) ]]
	local v1 = t2.GetActiveEventAt(p1)

	if v1 then
		return v1.LuckVirtualRolls
	end

	return 1
end

return table.freeze(t2)