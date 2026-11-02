local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DataStoreService = game:GetService("DataStoreService")
local MessagingService = game:GetService("MessagingService")

local CountdownStart = Instance.new("RemoteEvent")
CountdownStart.Name = "CountdownStart"
CountdownStart.Parent = ReplicatedStorage

local CountdownStop = Instance.new("RemoteEvent")
CountdownStop.Name = "CountdownStop"
CountdownStop.Parent = ReplicatedStorage

local CountdownSync = Instance.new("RemoteFunction")
CountdownSync.Name = "CountdownSync"
CountdownSync.Parent = ReplicatedStorage

local CountdownStore = DataStoreService:GetDataStore("CountdownStore")
local endTimestamp = nil
local running = false

CountdownSync.OnServerInvoke = function()
	if running and endTimestamp then
		local remaining = endTimestamp - os.time()
		if remaining > 0 then return remaining end
	end
	return nil
end

MessagingService:SubscribeAsync("CountdownStart", function(message)
	local incoming = message.Data
	local remaining = incoming - os.time()
	if remaining > 0 then
		running = true
		endTimestamp = incoming
		CountdownStart:FireAllClients(remaining)
	end
end)

MessagingService:SubscribeAsync("CountdownStop", function()
	running = false
	endTimestamp = nil
	CountdownStop:FireAllClients()
end)

task.spawn(function()
	local ok, saved = pcall(function()
		return CountdownStore:GetAsync("activeCountdown")
	end)
	if ok and saved then
		local remaining = saved - os.time()
		if remaining > 0 then
			running = true
			endTimestamp = saved
		end
	end
end)