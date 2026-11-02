-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local RunService = game:GetService("RunService")
local Signal = require(script.Parent.Signal)
local t = {}

function t.new(p1, p2) --[[ new | Line: 28 | Upvalues: t (copy), Signal (copy), RunService (copy) ]]
	local v1 = setmetatable({}, {
		__index = t
	})

	v1.TimeOut = p1
	v1.Callback = p2
	v1.TimeElapsed = 0
	v1.Elapsed = Signal.new()
	v1.Elapsed:Connect(p2)
	v1.HeartbeatConnection = RunService.Heartbeat:Connect(function(p1) --[[ Line: 40 | Upvalues: v1 (copy) ]]
		v1:_Interval(p1)
	end)

	return v1
end
function t._Interval(p1, p2) --[[ _Interval | Line: 47 ]]
	p1.TimeElapsed = p1.TimeElapsed + p2

	if p1.TimeElapsed >= p1.TimeOut * 10 then
		p1.TimeElapsed = p1.TimeElapsed - math.floor(p1.TimeElapsed / p1.TimeOut) * p1.TimeOut

		return
	end

	if not (p1.TimeElapsed >= p1.TimeOut) then
		return
	end

	p1.TimeElapsed = p1.TimeElapsed - p1.TimeOut
	p1.Elapsed:Fire()
end
function t.On(p1) --[[ On | Line: 69 | Upvalues: RunService (copy) ]]
	if p1.HeartbeatConnection and p1.HeartbeatConnection.Connected then
		return
	end

	p1.HeartbeatConnection = RunService.Heartbeat:Connect(function(p12) --[[ Line: 76 | Upvalues: p1 (copy) ]]
		p1:_Interval(p12)
	end)
end
function t.Off(p1) --[[ Off | Line: 81 ]]
	if p1.HeartbeatConnection then
		p1.HeartbeatConnection:Disconnect()
	end
end
function t.Destroy(p1) --[[ Destroy | Line: 91 ]]
	p1:Off()
	p1.Elapsed:Destroy()
	table.clear(p1)
end

return t