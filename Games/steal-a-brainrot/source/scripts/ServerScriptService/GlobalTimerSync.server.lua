local MessagingService = game:GetService("MessagingService")
local MemoryStoreService = game:GetService("MemoryStoreService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local TOPIC = "GlobalTimerUpdate_v1"
local MAP_NAME = "GlobalTimerState_v1"
local map = MemoryStoreService:GetSortedMap(MAP_NAME)

local function applyState(data)
	if not data or data.running ~= true then
		ReplicatedStorage:SetAttribute("GlobalTimerRunning", false)
		ReplicatedStorage:SetAttribute("GlobalTimerTitle", "")
		ReplicatedStorage:SetAttribute("GlobalTimerEndTime", 0)
		return
	end

	ReplicatedStorage:SetAttribute("GlobalTimerRunning", true)
	ReplicatedStorage:SetAttribute("GlobalTimerTitle", data.title or "UPDATE IN")
	ReplicatedStorage:SetAttribute("GlobalTimerEndTime", data.endTime or 0)
end

task.spawn(function()
	local ok, value = pcall(function()
		return map:GetAsync("Current")
	end)

	if ok and value and value.running and value.endTime and value.endTime > workspace:GetServerTimeNow() then
		applyState(value)
	else
		applyState(nil)
	end
end)

local ok, sub = pcall(function()
	return MessagingService:SubscribeAsync(TOPIC, function(message)
		local data = message.Data
		applyState(data)
	end)
end)

if not ok then
	warn("GlobalTimer subscribe failed:", sub)
end