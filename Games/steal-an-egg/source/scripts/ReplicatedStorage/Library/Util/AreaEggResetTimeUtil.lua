-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local IS_STUDIO = require(ReplicatedStorage.Library.Globals.Constants).IS_STUDIO
local v1 = 300
local manualNightStartsAt = nil
local manualNightEndsAt = nil
local manualNightPeriodIndex = nil
local t = {
	EndingSoonSeconds = 20,
	FinalBlinkSeconds = 10,
	NightDurationSeconds = 10,
	NightGrowthSkipSeconds = 300,
	NightGrowthBonusRate = 30,
	ResetPeriodSeconds = v1
}

local function hashString(p1) --[[ hashString | Line: 35 ]]
	local v1 = 2166136261

	for i = 1, #p1 do
		v1 = (v1 + string.byte(p1, i)) * 16777619 % 2147483647
	end

	if v1 <= 0 then
		return 1
	end

	return v1
end

function t.GetPeriodIndex(p1) --[[ GetPeriodIndex | Line: 50 | Upvalues: Asserts (copy), v1 (copy) ]]
	Asserts.number(p1)

	if manualNightStartsAt ~= nil and manualNightEndsAt ~= nil and manualNightPeriodIndex ~= nil
		and p1 >= manualNightStartsAt and p1 <= manualNightEndsAt + 0.001 then
		return manualNightPeriodIndex
	end
	return math.floor(math.max(p1, 0) / v1)
end
function t.GetNextResetAt(p1) --[[ GetNextResetAt | Line: 55 | Upvalues: Asserts (copy), t (copy), v1 (copy) ]]
	Asserts.number(p1)

	if manualNightStartsAt ~= nil and manualNightEndsAt ~= nil
		and p1 >= manualNightStartsAt and p1 < manualNightEndsAt then
		return manualNightEndsAt
	end
	return (math.floor(math.max(p1, 0) / v1) + 1) * v1
end
function t.GetTimeLeft(p1) --[[ GetTimeLeft | Line: 60 | Upvalues: Asserts (copy), t (copy) ]]
	Asserts.number(p1)

	return math.max(0, t.GetNextResetAt(p1) - p1)
end
function t.GetNightStartsAt(p1) --[[ GetNightStartsAt | Line: 65 | Upvalues: Asserts (copy), t (copy) ]]
	Asserts.number(p1)

	if manualNightStartsAt ~= nil and manualNightEndsAt ~= nil
		and p1 >= manualNightStartsAt and p1 <= manualNightEndsAt then
		return manualNightStartsAt
	end
	return t.GetNextResetAt(p1) - 10
end
function t.GetNightTransitionStartsAt(p1, p2, p3) --[[ GetNightTransitionStartsAt | Line: 70 | Upvalues: Asserts (copy), t (copy) ]]
	Asserts.number(p1)
	Asserts.number(p2)
	Asserts.number(p3)

	return t.GetNightStartsAt(p1) - p2 + p3
end
function t.IsNightTransition(p1, p2, p3) --[[ IsNightTransition | Line: 81 | Upvalues: Asserts (copy), t (copy) ]]
	Asserts.number(p1)
	Asserts.number(p2)
	Asserts.number(p3)

	return not t.IsNight(p1) and t.GetNightTransitionStartsAt(p1, p2, p3) <= p1
end
function t.IsManualNight(p1)
	Asserts.number(p1)

	return manualNightStartsAt ~= nil and manualNightEndsAt ~= nil
		and p1 >= manualNightStartsAt and p1 < manualNightEndsAt
end
function t.SetManualNightWindow(p1, p2)
	Asserts.number(p1)
	Asserts.number(p2)
	assert(p2 > p1, "Manual night must end after it starts")
	manualNightStartsAt = p1
	manualNightEndsAt = p2
	manualNightPeriodIndex = 1_000_000_000 + math.floor(p1 * 1000) % 1_000_000_000
end
function t.IsNight(p1) --[[ IsNight | Line: 94 | Upvalues: Asserts (copy), t (copy) ]]
	Asserts.number(p1)

	if t.IsManualNight(p1) then
		return true
	end
	return t.GetTimeLeft(p1) <= 10
end
function t.GetActivePeriodIndex(p1) --[[ GetActivePeriodIndex | Line: 99 | Upvalues: Asserts (copy), t (copy) ]]
	Asserts.number(p1)

	local v1 = t.GetPeriodIndex(p1)
	if t.IsManualNight(p1) then
		return v1
	end

	if t.IsNight(p1) then
		return v1 + 1
	end

	return v1
end
function t.GetPhaseTimeLeft(p1) --[[ GetPhaseTimeLeft | Line: 105 | Upvalues: Asserts (copy), t (copy) ]]
	Asserts.number(p1)

	local v1 = t.GetTimeLeft(p1)

	if t.IsNight(p1) then
		return v1
	end

	return math.max(0, v1 - 10)
end
function t.GetNextNightAt(p1) --[[ GetNextNightAt | Line: 113 | Upvalues: Asserts (copy), t (copy), v1 (copy) ]]
	Asserts.number(p1)

	local v12 = t.GetNightStartsAt(p1)

	if p1 < v12 then
		return v12
	end

	return v12 + v1
end
function t.GetNightGrowthSecondsAt(p1, p2) --[[ GetNightGrowthSecondsAt | Line: 122 | Upvalues: Asserts (copy) ]]
	Asserts.number(p1)
	Asserts.number(p2)

	return math.clamp(p1 - p2, 0, 10) * 30
end
function t.GetSlotSeed(p1, p2, p3) --[[ GetSlotSeed | Line: 129 | Upvalues: Asserts (copy) ]]
	Asserts.number(p1)
	Asserts.string(p2)
	Asserts.string(p3)

	local v1 = ("%*:%*:%*"):format(p1, p2, p3)
	local v2 = 2166136261

	for i = 1, #v1 do
		v2 = (v2 + string.byte(v1, i)) * 16777619 % 2147483647
	end

	if v2 <= 0 then
		return 1
	end

	return v2
end
function t.IsEndingSoon(p1) --[[ IsEndingSoon | Line: 136 | Upvalues: Asserts (copy) ]]
	Asserts.number(p1)

	return p1 <= 20
end
function t.IsWithinResetWindow(p1, p2) --[[ IsWithinResetWindow | Line: 141 | Upvalues: Asserts (copy), t (copy), v1 (copy) ]]
	Asserts.number(p1)
	Asserts.number(p2)

	local v12 = t.GetNextNightAt(p1)

	return if v12 - p1 <= p2 then true else p1 - (v12 - v1) <= p2
end
function t.IsFinalBlinkWindow(p1) --[[ IsFinalBlinkWindow | Line: 149 | Upvalues: Asserts (copy) ]]
	Asserts.number(p1)

	return p1 <= 10
end
function t.IsBlinkRed(p1) --[[ IsBlinkRed | Line: 154 | Upvalues: Asserts (copy) ]]
	Asserts.number(p1)

	return math.ceil(p1) % 2 == 0
end

return table.freeze(t)