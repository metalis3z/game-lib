-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LotteryCustom = require(ReplicatedStorage.Library.Functions.LotteryCustom)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local v1 = if Constants.IS_STUDIO then 30 else 180
local v2 = if Constants.IS_STUDIO then 60 else 1200
local v3 = if Constants.IS_STUDIO then 60 else 2400
local t = {}
local list = {}
local t4 = {
	Id = "MagmaWeather",
	Attribute = "MagmaWeather",
	PrimaryMutation = "Magma",
	ManualApplyMutation = true
}

t4.Weight = if Constants.IS_STUDIO then 1000 else 45
t4.Boosts = {
	Magma = 10
}
list[1] = {
	Id = "FrostWeather",
	Attribute = "FrostWeather",
	Weight = 45,
	PrimaryMutation = "Frozen",
	ManualApplyMutation = true,
	Boosts = {
		Frozen = 10
	}
}
list[2] = {
	Id = "ThunderstormWeather",
	Attribute = "ThunderstormWeather",
	Weight = 45,
	PrimaryMutation = "Shocked",
	ManualApplyMutation = true,
	Boosts = {
		Shocked = 10
	}
}
list[3] = t4

local t5 = {}
local t6 = {}
local t7 = { 1767225600 }

for i, v in ipairs(list) do
	t5[v.Id] = v
	table.insert(t6, { v.Id, v.Weight })
end

table.freeze(list)
table.freeze(t6)

local function getIntervalForCycle(p1) --[[ getIntervalForCycle | Line: 88 | Upvalues: v2 (copy), v3 (copy) ]]
	return Random.new(p1 * 7919 + 4101):NextInteger(v2, v3)
end

local function ensureScheduleThrough(p1, p2) --[[ ensureScheduleThrough | Line: 93 | Upvalues: v3 (copy), t7 (copy), v2 (copy) ]]
	while t7[#t7] <= math.max(p1, 1767225600) + math.max(1, p2) * v3 do
		table.insert(t7, t7[#t7] + Random.new((#t7 - 1) * 7919 + 4101):NextInteger(v2, v3))
	end
end

local function findFirstCycleIndexAfter(p1) --[[ findFirstCycleIndexAfter | Line: 103 | Upvalues: t7 (copy) ]]
	local v1 = #t7 + 1
	local v2 = 1

	while v2 < v1 do
		local v3 = math.floor((v2 + v1) / 2)
		local v4 = t7[v3]

		if v4 and p1 < v4 then
			v1 = v3
		else
			v2 = v3 + 1
		end
	end

	return v2 - 1
end

local function getCycleStartTime(p1) --[[ getCycleStartTime | Line: 121 | Upvalues: ensureScheduleThrough (copy), t7 (copy) ]]
	ensureScheduleThrough(1767225600, p1 + 1)

	return t7[p1 + 1]
end

local function chooseCycleWeathersInternal(p1, p2) --[[ chooseCycleWeathersInternal | Line: 126 | Upvalues: t6 (copy), LotteryCustom (copy) ]]
	local v1 = Random.new(p1 * 1543 + 9001)
	local t = {}

	local function chooseNextWeather(p1, p22) --[[ chooseNextWeather | Line: 130 | Upvalues: v1 (copy), t6 (ref), p2 (copy), LotteryCustom (ref) ]]
		if not p22 and v1:NextNumber() >= 1 then
			return nil
		end

		local t = {}

		for i, v in ipairs(t6) do
			local v12 = v[1]

			if not (p2 and p2[v12] or p1 and p1[v12]) then
				table.insert(t, v)
			end
		end

		if #t == 0 then
			return nil
		end

		local v2 = LotteryCustom(v1, t)

		if typeof(v2) == "string" and v2 ~= "" then
			return v2
		end

		return nil
	end

	local v2 = chooseNextWeather(nil, false)

	if not v2 then
		return t
	end

	table.insert(t, v2)

	if v1:NextNumber() < 0 then
		local v3 = chooseNextWeather({
			[v2] = true
		}, true)

		if v3 then
			table.insert(t, v3)
		end
	end

	return t
end

t.DEFAULT_DURATION = v1
t.REFRESH_TIME = v2
t.MIN_INTERVAL = v2
t.MAX_INTERVAL = v3
t.WEATHER_DROP_CHANCE = 1
t.ADDITIONAL_WEATHER_CHANCE = 0
t.UPCOMING_SCHEDULE_ATTRIBUTE = "WeatherUpcomingSchedule"
function t.GetEntries() --[[ GetEntries | Line: 179 | Upvalues: list (copy) ]]
	return table.clone(list)
end
function t.GetEntry(p1) --[[ GetEntry | Line: 183 | Upvalues: t5 (copy) ]]
	return t5[p1]
end
function t.GetWeights() --[[ GetWeights | Line: 187 | Upvalues: t6 (copy) ]]
	return table.clone(t6)
end
function t.GetCycleIndex(p1) --[[ GetCycleIndex | Line: 191 | Upvalues: ensureScheduleThrough (copy), findFirstCycleIndexAfter (copy) ]]
	ensureScheduleThrough(p1, 1)

	return math.max(0, findFirstCycleIndexAfter(p1) - 1)
end
function t.GetTimeIntoCycle(p1) --[[ GetTimeIntoCycle | Line: 196 | Upvalues: t (copy), ensureScheduleThrough (copy), t7 (copy) ]]
	local v1 = t.GetCycleIndex(p1)

	ensureScheduleThrough(1767225600, v1 + 1)

	return p1 - t7[v1 + 1]
end
function t.GetSecondsToNextRefresh(p1) --[[ GetSecondsToNextRefresh | Line: 201 | Upvalues: ensureScheduleThrough (copy), findFirstCycleIndexAfter (copy), t7 (copy) ]]
	ensureScheduleThrough(p1, 1)

	local v1 = findFirstCycleIndexAfter(p1)

	ensureScheduleThrough(1767225600, v1 + 1)

	return math.max(0, t7[v1 + 1] - p1)
end
function t.ChooseCycleWeathers(p1, p2) --[[ ChooseCycleWeathers | Line: 209 | Upvalues: chooseCycleWeathersInternal (copy) ]]
	return chooseCycleWeathersInternal(p1, p2)
end
function t.GetUpcomingWeathers(p1, p2, p3) --[[ GetUpcomingWeathers | Line: 213 | Upvalues: ensureScheduleThrough (copy), findFirstCycleIndexAfter (copy), t7 (copy), v1 (copy), chooseCycleWeathersInternal (copy) ]]
	if p2 <= 0 then
		return {}
	end

	ensureScheduleThrough(p1, p2)

	local v12 = findFirstCycleIndexAfter(p1)
	local t = {}
	local v2 = nil

	if p3 then
		ensureScheduleThrough(1767225600, v12 + 1)

		if t7[v12 + 1] - p1 < v1 then
			v2 = p3
		end
	end

	for i = v12, v12 + p2 - 1 do
		ensureScheduleThrough(1767225600, i + 1)

		local v3 = t7[i + 1]
		local v4 = chooseCycleWeathersInternal(i, v2)

		v2 = nil

		for i2, v in ipairs(v4) do
			if p1 < v3 then
				table.insert(t, {
					WeatherId = v,
					StartsAt = v3
				})

				if p2 <= #t then
					return t
				end
			end
		end
	end

	return t
end

return t