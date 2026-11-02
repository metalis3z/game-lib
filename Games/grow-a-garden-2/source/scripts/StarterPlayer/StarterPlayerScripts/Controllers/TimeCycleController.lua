--credit to quartz games studio
local ReplicatedStorage = game.ReplicatedStorage
local TimeCycleData = require(ReplicatedStorage.SharedModules.TimeCycleData)

require(ReplicatedStorage.ClientModules.Skybox)

local MusicController = require(game.StarterPlayer.StarterPlayerScripts.Controllers.MusicController)
local Phases = script.Phases
local t = {}
local v1 = nil
local v2 = nil
local t2 = {
	StartOrder = 1
}

for v3, v4 in TimeCycleData.Data do
	table.insert(t, {
		Name = v3,
		Weathers = v4.Weathers,
		Duration = v4.Lasts,
		Order = v4.StartOrder
	})
end

table.sort(t, function(p1, p2) --[[ Line: 24 ]]
	return p1.Order < p2.Order
end)

local sum = 0

for v5, v6 in t do
	sum = sum + v6.Duration
end

local function pickWeather(p1, p2) --[[ pickWeather | Line: 31 ]]
	local sum = 0

	for v1, v2 in p1.Weathers do
		sum = sum + v2.Chance
	end

	local v3 = p2:NextNumber() * sum
	local sum2 = 0

	for v4, v5 in p1.Weathers do
		sum2 = sum2 + v5.Chance

		if v3 <= sum2 then
			return v4, v5
		end
	end

	for v6, v7 in p1.Weathers do
		return v6, v7
	end
end

local function getCycleState() --[[ getCycleState | Line: 49 | Upvalues: sum (ref), t (copy) ]]
	local v2 = math.floor(os.time() / sum)
	local v3 = workspace:GetAttribute("ActivePhase")

	if not v3 then
		local v4

		repeat
			task.wait(0.1)
			v4 = workspace:GetAttribute("ActivePhase")
		until v4

		v3 = v4
	end

	for v5, v6 in t do
		if v6.Name == v3 then
			return v2, v5, v6, 0, v6.Duration
		end
	end

	return v2, #t
end

local function getWeatherForPhase(p1, p2, p3) --[[ getWeatherForPhase | Line: 88 | Upvalues: pickWeather (copy) ]]
	return pickWeather(p3, (Random.new(p1 * 1000 + p2)))
end

local function startPhaseModule(p1, p2, p3) --[[ startPhaseModule | Line: 94 | Upvalues: v1 (ref), v2 (ref), Phases (copy), MusicController (copy) ]]
	if v1 and v1.End then
		v1:End()
	end

	v2 = p2

	local v12 = Phases:FindFirstChild(p1)

	if v12 then
		v1 = require(v12)

		if not v1.NoMusic then
			MusicController:SetActiveWeather(p2)
		end

		if v1.Start then
			v1:Start(p2, p3)
		end
	else
		MusicController:SetActiveWeather(p2)
		v1 = nil
	end
end

function t2.GetCurrentWeather(p1) --[[ GetCurrentWeather | Line: 120 | Upvalues: v2 (ref) ]]
	return v2
end
function t2.Init(p1) --[[ Init | Line: 124 ]] end
function t2.Start(p1) --[[ Start | Line: 127 | Upvalues: getCycleState (copy), pickWeather (copy), startPhaseModule (copy) ]]
	task.spawn(function() --[[ Line: 128 | Upvalues: getCycleState (ref), pickWeather (ref), startPhaseModule (ref) ]]
		while true do
			local v1, v2
			local v3, v4, v5, _, _2 = getCycleState()
			local v6 = workspace:GetAttribute("ActiveWeather")

			if type(v6) == "string" and (v5.Weathers and v5.Weathers[v6]) then
				v1 = v5.Weathers[v6]
				v2 = v6
			else
				local v7, v8 = pickWeather(v5, (Random.new(v3 * 1000 + v4)))

				v2 = v7
				v1 = v8
			end

			startPhaseModule(v2, v2, v1)

			local v9 = coroutine.running()
			local v10 = false
			local v11 = nil
			local v12 = nil

			local function resume() --[[ resume | Line: 152 | Upvalues: v10 (ref), v11 (ref), v12 (ref), v9 (copy) ]]
				if v10 then
					return
				end

				v10 = true

				if v11 then
					v11:Disconnect()
				end

				if v12 then
					v12:Disconnect()
				end

				task.spawn(v9)
			end

			v11 = workspace:GetAttributeChangedSignal("ActivePhase"):Connect(resume)
			v12 = workspace:GetAttributeChangedSignal("ActiveWeather"):Connect(resume)
			coroutine.yield()
		end
	end)
end

return t2