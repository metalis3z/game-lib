-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Variables = require(ReplicatedStorage.Library.Variables)
local v1 = Random.new()
local v2 = 0
local t = {}

t.__index = t
function t.new() --[[ new | Line: 208 | Upvalues: t (copy), RunService (copy), v1 (copy) ]]
	local v2 = setmetatable({}, t)

	v2.Amplitude = 1
	v2.Frequency = 1
	v2.FadeInTime = 1
	v2.FadeOutTime = 1
	v2.SustainTime = 0
	v2.Sustain = false
	v2.PositionInfluence = Vector3.new(1, 1, 1)
	v2.RotationInfluence = Vector3.new(1, 1, 1)
	v2.TimeFunction = if RunService:IsRunning() then time else os.clock
	v2._timeOffset = v1:NextNumber(-1000000, 1000000)
	v2._startTime = 0
	v2._running = false
	v2._signalConnections = {}
	v2._renderBindings = {}

	return v2
end
function t.InverseSquare(p1, p2) --[[ InverseSquare | Line: 259 ]]
	if p2 < 1 then
		p2 = 1
	end

	return p1 * (1 / (p2 * p2))
end
function t.NextRenderName() --[[ NextRenderName | Line: 275 | Upvalues: v2 (ref) ]]
	v2 = v2 + 1

	return ("__shake_%.4i__"):format(v2)
end
function t.Start(p1) --[[ Start | Line: 288 ]]
	p1._startTime = p1.TimeFunction()
	p1._running = true
end
function t.Stop(p1) --[[ Stop | Line: 300 | Upvalues: RunService (copy) ]]
	p1._running = false

	for v1, v2 in p1._renderBindings do
		RunService:UnbindFromRenderStep(v2)
	end

	table.clear(p1._renderBindings)

	for v3, v4 in p1._signalConnections do
		v4:Disconnect()
	end

	table.clear(p1._signalConnections)
end
function t.IsShaking(p1) --[[ IsShaking | Line: 318 ]]
	return p1._running
end
function t.StopSustain(p1) --[[ StopSustain | Line: 327 ]]
	local v1 = p1.TimeFunction()

	p1.Sustain = false
	p1.SustainTime = v1 - p1._startTime - p1.FadeInTime
end
function t.Update(p1) --[[ Update | Line: 355 | Upvalues: Variables (copy) ]]
	local v1 = false
	local v2 = p1.TimeFunction()
	local v3 = v2 - p1._startTime
	local v4 = (v2 + p1._timeOffset) / p1.Frequency % 10000
	local v5 = 1
	local v6 = if v3 < p1.FadeInTime then v3 / p1.FadeInTime else 1

	if not p1.Sustain and p1.FadeInTime + p1.SustainTime < v3 then
		if p1.FadeOutTime == 0 then
			v1 = true
		else
			v5 = 1 - (v3 - p1.FadeInTime - p1.SustainTime) / p1.FadeOutTime

			if not p1.Sustain and p1.FadeInTime + p1.SustainTime + p1.FadeOutTime <= v3 then
				v1 = true
			end
		end
	end

	local v7 = math.noise(v4, 0) / 2
	local v8 = math.noise(0, v4) / 2
	local v9 = math.noise(v4, v4) / 2
	local v10 = Vector3.new(v7, v8, v9) * p1.Amplitude * math.min(v6, v5)

	if v1 then
		p1:Stop()
	end

	local v11 = p1.PositionInfluence * v10
	local v12 = p1.RotationInfluence * v10

	if Variables.IsInteractingWithNpc then
		v11 = Vector3.new(0, 0, 0)
		v12 = Vector3.new(0, 0, 0)
	end

	return v11, v12, v1
end
function t.OnSignal(p1, p2, p3) --[[ OnSignal | Line: 421 ]]
	local v1 = p2:Connect(function() --[[ Line: 422 | Upvalues: p3 (copy), p1 (copy) ]]
		p3(p1:Update())
	end)

	table.insert(p1._signalConnections, v1)

	return v1
end
function t.BindToRenderStep(p1, p2, p3, p4) --[[ BindToRenderStep | Line: 451 | Upvalues: RunService (copy) ]]
	RunService:BindToRenderStep(p2, p3, function() --[[ Line: 452 | Upvalues: p4 (copy), p1 (copy) ]]
		p4(p1:Update())
	end)
	table.insert(p1._renderBindings, p2)
end
function t.Clone(p1) --[[ Clone | Line: 488 | Upvalues: t (copy) ]]
	local v1 = t.new()

	for v2, v3 in {
		"Amplitude",
		"Frequency",
		"FadeInTime",
		"FadeOutTime",
		"SustainTime",
		"Sustain",
		"PositionInfluence",
		"RotationInfluence",
		"TimeFunction"
	} do
		v1[v3] = p1[v3]
	end

	return v1
end
function t.Destroy(p1) --[[ Destroy | Line: 510 ]]
	p1:Stop()
end

return {
	new = t.new,
	InverseSquare = t.InverseSquare,
	NextRenderName = t.NextRenderName
}