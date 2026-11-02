--credit to prince games studio
local t = {}
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local LightingController = require(game.StarterPlayer.StarterPlayerScripts.Controllers.LightingController)
local TimeCycleData = require(game.ReplicatedStorage.SharedModules.TimeCycleData)
local t2 = {}
local v1 = nil

function t.Start(p1, p2, p3) --[[ Start | Line: 15 | Upvalues: LightingController (copy), t2 (copy), TimeCycleData (copy), Lighting (copy), v1 (ref), RunService (copy) ]]
	local t = {}

	for v12, v2 in LightingController:GetDefault() do
		t[v12] = v2
	end

	for v3, v4 in t2 do
		t[v3] = v4
	end

	t.ClockTime = nil
	LightingController:TransitionTo(t)

	local Lasts = TimeCycleData.Data.Day.Lasts
	local sum = 0

	for v5, v6 in TimeCycleData.Data do
		sum = sum + v6.Lasts
	end

	local function getDayProgress() --[[ getDayProgress | Line: 37 | Upvalues: sum (ref), TimeCycleData (ref) ]]
		local v1 = workspace:GetAttribute("CycleOffset") or 0
		local v2 = (os.time() + v1) % sum
		local t = {}
		local sum2 = 0

		for v3, v4 in TimeCycleData.Data do
			table.insert(t, {
				Name = v3,
				Duration = v4.Lasts,
				Order = v4.StartOrder
			})
		end

		table.sort(t, function(p1, p2) --[[ Line: 46 ]]
			return p1.Order < p2.Order
		end)

		for v5, v6 in t do
			if v6.Name == "Day" then
				return math.clamp((v2 - sum2) / v6.Duration, 0, 1)
			end

			sum2 = sum2 + v6.Duration
		end

		return 0
	end

	Lighting.ClockTime = 7 + 8 * getDayProgress()

	if not v1 then
		v1 = RunService.Heartbeat:Connect(function() --[[ Line: 66 | Upvalues: getDayProgress (copy), Lighting (ref) ]]
			local v1 = getDayProgress()

			if not workspace:GetAttribute("TimeFrozen") then
				Lighting.Ambient = Color3.fromHSV(0, 0, 0.5 + 0.3 * v1)
				Lighting.ClockTime = 7 + 8 * v1
			end
		end)

		return
	end

	v1:Disconnect()
	v1 = RunService.Heartbeat:Connect(function() --[[ Line: 66 | Upvalues: getDayProgress (copy), Lighting (ref) ]]
		local v1 = getDayProgress()

		if not workspace:GetAttribute("TimeFrozen") then
			Lighting.Ambient = Color3.fromHSV(0, 0, 0.5 + 0.3 * v1)
			Lighting.ClockTime = 7 + 8 * v1
		end
	end)
end
function t.End(p1) --[[ End | Line: 76 | Upvalues: v1 (ref) ]]
	if not v1 then
		return
	end

	v1:Disconnect()
	v1 = nil
end

return t