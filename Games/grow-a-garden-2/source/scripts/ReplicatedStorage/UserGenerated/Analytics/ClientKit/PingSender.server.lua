--credit to quartz games studio
local RunService = game:GetService("RunService")
local Ping = script.Parent:WaitForChild("Ping")
local v1 = 0
local v2 = 0

local function SendPing() --[[ SendPing | Line: 27 | Upvalues: v2 (ref), Ping (copy) ]]
	v2 = v2 + 1
	Ping:FireServer(v2, workspace:GetServerTimeNow())
end

RunService.Heartbeat:Connect(function(p1) --[[ Line: 34 | Upvalues: v1 (ref), v2 (ref), Ping (copy) ]]
	v1 = v1 + p1

	if not (v1 >= 1) then
		return
	end

	v1 = v1 % 1
	v2 = v2 + 1
	Ping:FireServer(v2, workspace:GetServerTimeNow())
end)
task.spawn(SendPing)