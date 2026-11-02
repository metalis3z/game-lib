local ReplicatedStorage = game:GetService("ReplicatedStorage")
local EventsFolder = ReplicatedStorage.Controllers.EventController.Events
local EventTimes = {}
local RandomDuration = {300, 120, 180, 240}
for _, EventModule in ipairs(EventsFolder:GetChildren()) do
	if EventModule:IsA("ModuleScript") then
		local Duration = RandomDuration[math.random(1, #RandomDuration)]
		EventTimes[EventModule.Name] = { Duration = Duration }
	end
end
return EventTimes