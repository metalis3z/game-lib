local XPMultiplierManager = {}

local MessagingService = game:GetService("MessagingService")
local DataStoreService = game:GetService("DataStoreService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local BonusUpdate = ReplicatedStorage:WaitForChild("BonusUpdate")
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local AdminAnnounce = Remotes:WaitForChild("AdminAnnounce")

local TOPIC = "XPMultiplierUpdate"
local DATASTORE_KEY = "GlobalXPMultiplierState"
local ds = DataStoreService:GetDataStore("GlobalXPMultiplier")

local currentMultiplier = 1
local endTime = 0 -- os.time() when event expires, 0 if no event
local expiryTask = nil

local function notifyAllClients(multiplier, remaining)
	if multiplier > 1 then
		BonusUpdate:FireAllClients({
			XP = { mult = multiplier, remaining = remaining or 0 }
		})
	else
		BonusUpdate:FireAllClients({})
	end
end

local function applyLocally(multiplier, newEndTime, announceData)
	-- Cancel any existing expiry task
	if expiryTask then
		expiryTask:Cancel()
		expiryTask = nil
	end

	currentMultiplier = multiplier
	endTime = newEndTime

	if endTime > 0 then
		local remaining = endTime - os.time()
		if remaining > 0 then
			expiryTask = task.delay(remaining, function()
				currentMultiplier = 1
				endTime = 0
				expiryTask = nil
				notifyAllClients(1, 0)
				-- Clear DataStore when event expires
				pcall(function()
					ds:RemoveAsync(DATASTORE_KEY)
				end)
			end)
		else
			-- Already expired
			currentMultiplier = 1
			endTime = 0
		end
	end

	local remaining = 0
	if endTime > 0 then
		remaining = endTime - os.time()
		if remaining < 0 then remaining = 0 end
	end

	notifyAllClients(currentMultiplier, remaining)

	-- Fire admin announcement locally if provided
	if announceData then
		AdminAnnounce:FireAllClients(announceData)
	end
end

function XPMultiplierManager.Get()
	return currentMultiplier
end

function XPMultiplierManager.GetStatus()
	return {
		active = currentMultiplier > 1,
		multiplier = currentMultiplier,
		endTime = endTime,
	}
end

function XPMultiplierManager.Set(multiplier, duration, announceData)
	local newEndTime = 0
	if duration and duration > 0 then
		newEndTime = os.time() + duration
	end

	-- Apply locally
	applyLocally(multiplier, newEndTime, announceData)

	-- Persist to DataStore for new servers joining mid-event
	pcall(function()
		ds:SetAsync(DATASTORE_KEY, {
			multiplier = multiplier,
			endTime = newEndTime,
		})
	end)

	-- Broadcast to all other servers via MessagingService
	pcall(function()
		MessagingService:PublishAsync(TOPIC, {
			action = "set",
			multiplier = multiplier,
			endTime = newEndTime,
			announceData = announceData,
		})
	end)
end

function XPMultiplierManager.Reset(announceData)
	-- Apply locally
	applyLocally(1, 0, announceData)

	-- Clear DataStore
	pcall(function()
		ds:RemoveAsync(DATASTORE_KEY)
	end)

	-- Broadcast to all other servers
	pcall(function()
		MessagingService:PublishAsync(TOPIC, {
			action = "reset",
			announceData = announceData,
		})
	end)
end

function XPMultiplierManager.ResetLocal(announceData)
	applyLocally(1, 0, announceData)
end

-- Subscribe to MessagingService for cross-server updates
MessagingService:SubscribeAsync(TOPIC, function(message)
	local data = message.Data
	if type(data) ~= "table" then return end

	if data.action == "set" then
		applyLocally(data.multiplier, data.endTime, data.announceData)
	elseif data.action == "reset" then
		applyLocally(1, 0, data.announceData)
	end
end)

-- On startup, check DataStore for existing event state (for servers that join mid-event)
task.spawn(function()
	local success, result = pcall(function()
		return ds:GetAsync(DATASTORE_KEY)
	end)
	if success and result then
		if result.endTime > os.time() then
			applyLocally(result.multiplier, result.endTime)
		else
			-- Event already expired, clean up
			pcall(function()
				ds:RemoveAsync(DATASTORE_KEY)
			end)
		end
	end
end)

return XPMultiplierManager
