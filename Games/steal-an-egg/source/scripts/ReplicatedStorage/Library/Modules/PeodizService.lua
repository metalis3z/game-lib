-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local RunService = game:GetService("RunService")
local t = {}
local t2 = {}

t2.__index = t2

local Functions = require(script.Functions)

function t2.new(p1, p2) --[[ new | Line: 8 | Upvalues: t2 (copy), Functions (copy), t (copy) ]]
	local v2 = setmetatable({}, t2)

	v2.Type = "Heartbeat"
	v2.LifeTime = p1.Time or 1
	v2.Tween = p1.Tween or nil

	if p2 then
		v2.Function = p2
		v2.YieldEvent = Instance.new("BindableEvent")
	end

	if Functions[v2.Type] then
		v2.UpdateFunction = Functions[v2.Type]
	end

	table.insert(t, v2)

	local YieldEvent = v2.YieldEvent

	if p2 and YieldEvent then
		YieldEvent.Event:Wait()
		YieldEvent:Destroy()

		return
	end

	return v2
end
function t2.Heartbeat(p1, p2) --[[ Heartbeat | Line: 36 | Upvalues: t2 (copy), Functions (copy), t (copy) ]]
	local v2 = setmetatable({}, t2)

	v2.Type = "Heartbeat"
	v2.LifeTime = p1.Time or 1
	v2.NoYield = true
	v2.Tween = p1.Tween or nil

	if p2 then
		v2.Function = p2
	end

	if Functions[v2.Type] then
		v2.UpdateFunction = Functions[v2.Type]
	end

	table.insert(t, v2)

	return v2
end
function t2.HeartbeatWait(p1, p2) --[[ HeartbeatWait | Line: 55 | Upvalues: t2 (copy), Functions (copy), t (copy) ]]
	local v2 = setmetatable({}, t2)

	v2.Type = "HeartbeatWait"
	v2.LifeTime = p1.Time or 1

	if p1.WaitTime and p1.WaitTime <= 0 then
		p1.WaitTime = 1 / 60
	end

	p1.WaitTime = p1.WaitTime or 1 / 60
	v2.WaitTime = p1.WaitTime
	v2.Tween = p1.Tween or nil

	if p2 then
		v2.Function = p2
		v2.YieldEvent = Instance.new("BindableEvent")
	end

	if Functions[v2.Type] then
		v2.UpdateFunction = Functions[v2.Type]
	end

	table.insert(t, v2)

	local YieldEvent = v2.YieldEvent

	if p2 and YieldEvent then
		YieldEvent.Event:Wait()
		YieldEvent:Destroy()

		return
	end

	return v2
end
function t2.CustomForLoop(p1, p2) --[[ CustomForLoop | Line: 89 | Upvalues: t2 (copy), Functions (copy), t (copy) ]]
	local v2 = setmetatable({}, t2)

	v2.Type = "CustomForLoop"

	if p1.WaitTime and p1.WaitTime <= 0 then
		p1.WaitTime = 1 / 60
	end

	p1.WaitTime = p1.WaitTime or 1 / 60
	p1.Step = p1.Step or 10
	p1.Start = p1.Start or 0
	p1.End = p1.End or 1
	v2.Step = p1.Step
	v2.Start = p1.Start
	v2.End = p1.End
	v2.WaitTime = p1.WaitTime
	v2.LifeTime = v2.End / v2.Step * v2.WaitTime
	v2.Tween = p1.Tween or nil
	v2.CurrentWaitTime = p1.WaitTime
	v2.CurrentTime = v2.Start / v2.End

	if p2 then
		v2.Function = p2
		v2.YieldEvent = Instance.new("BindableEvent")
	end

	if Functions[v2.Type] then
		v2.UpdateFunction = Functions[v2.Type]
	end

	table.insert(t, v2)

	local YieldEvent = v2.YieldEvent

	if p2 and YieldEvent then
		YieldEvent.Event:Wait()
		YieldEvent:Destroy()

		return
	end

	return v2
end
function t2.CustomForceForLoop(p1, p2) --[[ CustomForceForLoop | Line: 132 | Upvalues: t2 (copy), Functions (copy), t (copy) ]]
	local v2 = setmetatable({}, t2)

	v2.Type = "CustomForceForLoop"

	if p1.WaitTime and p1.WaitTime <= 0 then
		p1.WaitTime = 1 / 60
	end

	p1.WaitTime = p1.WaitTime or 1 / 60
	p1.Step = p1.Step or 10
	p1.Start = p1.Start or 0
	p1.End = p1.End or 1
	v2.StepData = {}
	v2.Step = p1.Step
	v2.Start = p1.Start
	v2.End = p1.End
	v2.WaitTime = p1.WaitTime
	v2.LifeTime = v2.End / v2.Step * v2.WaitTime
	v2.Tween = p1.Tween or nil
	v2.CurrentWaitTime = p1.WaitTime
	v2.CurrentTime = v2.Start / v2.End

	if p2 then
		v2.Function = p2
		v2.YieldEvent = Instance.new("BindableEvent")
	end

	if Functions[v2.Type] then
		v2.UpdateFunction = Functions[v2.Type]
	end

	table.insert(t, v2)

	local YieldEvent = v2.YieldEvent

	if p2 and YieldEvent then
		YieldEvent.Event:Wait()
		YieldEvent:Destroy()

		return
	end

	return v2
end
function t2.ForLoop(p1, p2) --[[ ForLoop | Line: 176 | Upvalues: t2 (copy), Functions (copy), t (copy) ]]
	local v2 = setmetatable({}, t2)

	v2.Type = "ForLoop"

	if p1.WaitTime and p1.WaitTime <= 0 then
		p1.WaitTime = 1 / 60
	end

	p1.WaitTime = p1.WaitTime or 1 / 60
	p1.Step = p1.Step or 10

	if p1.Step < 0 then
		p1.Step = 1
	end

	v2.WaitTime = p1.WaitTime
	v2.LifeTime = p1.WaitTime * p1.Step
	v2.Tween = p1.Tween or nil

	if p2 then
		v2.Function = p2
		v2.YieldEvent = Instance.new("BindableEvent")
	end

	if Functions[v2.Type] then
		v2.UpdateFunction = Functions[v2.Type]
	end

	table.insert(t, v2)

	local YieldEvent = v2.YieldEvent

	if p2 and YieldEvent then
		YieldEvent.Event:Wait()
		YieldEvent:Destroy()

		return
	end

	return v2
end
function t2.ForceForLoop(p1, p2) --[[ ForceForLoop | Line: 215 | Upvalues: t2 (copy), Functions (copy), t (copy) ]]
	local v2 = setmetatable({}, t2)

	v2.Type = "ForceForLoop"

	if p1.WaitTime and p1.WaitTime <= 0 then
		p1.WaitTime = 1 / 60
	end

	p1.WaitTime = p1.WaitTime or 1 / 60
	p1.Step = p1.Step or 10
	v2.StepData = {}
	v2.Step = p1.Step
	v2.WaitTime = p1.WaitTime
	v2.LifeTime = p1.WaitTime * p1.Step
	v2.Tween = p1.Tween or nil

	if p2 then
		v2.Function = p2
		v2.YieldEvent = Instance.new("BindableEvent")
	end

	if Functions[v2.Type] then
		v2.UpdateFunction = Functions[v2.Type]
	end

	table.insert(t, v2)

	local YieldEvent = v2.YieldEvent

	if p2 and YieldEvent then
		YieldEvent.Event:Wait()
		YieldEvent:Destroy()

		return
	end

	return v2
end
function t2.Update(p1, p2) --[[ Update | Line: 253 ]]
	p1.CurrentTime = p1.CurrentTime or 0
	p1.CurrentWaitTime = p1.CurrentWaitTime or 0
	p1.WaitTime = p1.WaitTime or 1 / 60
	p1.LifeTime = p1.LifeTime or 1
	p1.CurrentTime = math.min(p1.CurrentTime + p2 / p1.LifeTime, 1)
	p1.CurrentWaitTime = p1.CurrentWaitTime + p2

	if p1.UpdateFunction then
		p1:UpdateFunction(p2)
	end

	if not p1 or (p1.CurrentTime ~= 1 or p1.Finished) then
		return
	end

	p1:Destroy()
end
function t2.Connect(p1, p2) --[[ Connect | Line: 271 ]]
	if not p2 then
		return
	end

	if not p1.Function then
		p1.Function = p2
	end

	if p1.YieldEvent or p1.NoYield then
		return
	end

	local v1 = Instance.new("BindableEvent")

	p1.YieldEvent = v1
	v1.Event:Wait()
	v1:Destroy()
end
function t2.Destroy(p1) --[[ Destroy | Line: 285 | Upvalues: t (copy) ]]
	if p1.Finished then
		return
	end

	p1.Finished = true

	if p1.YieldEvent then
		p1.YieldEvent:Fire()
	end

	for k, v in pairs(t) do
		if v == p1 then
			table.remove(t, k)

			for k2, v2 in pairs(p1) do
				p1[k2] = nil
			end

			table.clear(p1)

			return
		end
	end
end
RunService.Heartbeat:Connect(function(p1) --[[ Line: 308 | Upvalues: t (copy) ]]
	for k, v in pairs(t) do
		v:Update(p1)
	end
end)

return t2