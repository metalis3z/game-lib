
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local EventsFolder = ReplicatedStorage:WaitForChild("Controllers"):WaitForChild("EventController"):WaitForChild("Events")

local EventTimes = {}
local randomdurttion = {300, 120, 180, 240}

for _, eventModule in ipairs(EventsFolder:GetChildren()) do
	if eventModule:IsA("ModuleScript") then
		local duration = randomdurttion[math.random(1, #randomdurttion)]
		EventTimes[eventModule.Name] = { Duration = duration }
	end
end

return EventTimes
