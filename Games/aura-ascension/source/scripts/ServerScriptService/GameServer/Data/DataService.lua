local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")
local RunService = game:GetService("RunService")

local GameConfig = require(script.Parent.Parent.Config.GameConfig)
local ProfileTemplate = require(script.Parent.ProfileTemplate)
local TableUtil = require(script.Parent.Parent.Core.TableUtil)

local DataService = {}
DataService.__index = DataService

local RETRY_ATTEMPTS = 3
local SHUTDOWN_SAVE_TIMEOUT = 25

local function deepNormalize(value, defaults)
	if type(defaults) ~= "table" then
		if value == nil then
			return defaults
		end
		return value
	end

	local normalized = type(value) == "table" and value or {}
	for key, defaultValue in pairs(defaults) do
		normalized[key] = deepNormalize(normalized[key], defaultValue)
	end
	return normalized
end

function DataService.new()
	return setmetatable({
		Store = nil,
		Profiles = {},
		Dirty = {},
		Saving = {},
		PersistenceEnabled = not RunService:IsStudio(),
		ShutdownInProgress = false,
		SessionId = game.JobId ~= "" and game.JobId or ("studio_%d"):format(os.time()),
		ProfileLoaded = Instance.new("BindableEvent"),
		ProfileReleased = Instance.new("BindableEvent"),
	}, DataService)
end

function DataService:Init()
	if self.PersistenceEnabled then
		self.Store = DataStoreService:GetDataStore(GameConfig.DataStoreName)
	end
end

function DataService:Start()
	Players.PlayerAdded:Connect(function(player)
		task.spawn(function()
			self:LoadProfile(player)
		end)
	end)

	Players.PlayerRemoving:Connect(function(player)
		self:ReleaseProfile(player, true)
	end)

	for _, player in ipairs(Players:GetPlayers()) do
		task.spawn(function()
			self:LoadProfile(player)
		end)
	end

	task.spawn(function()
		while not self.ShutdownInProgress do
			task.wait(GameConfig.AutoSaveInterval)
			for player in pairs(self.Dirty) do
				if player.Parent == Players then
					self:SaveProfile(player, false)
				end
			end
		end
	end)

	game:BindToClose(function()
		self.ShutdownInProgress = true
		self:FlushAllProfiles(SHUTDOWN_SAVE_TIMEOUT)
	end)
end

function DataService:_profileKey(player)
	return ("player_%d"):format(player.UserId)
end

function DataService:_makeDefaultProfile()
	local profile = TableUtil.DeepCopy(ProfileTemplate)
	local now = os.time()
	profile._Meta.FirstJoinAt = now
	profile._Meta.LastJoinAt = now
	profile._Meta.LastSaveAt = now
	profile._Meta.Session.JobId = self.SessionId
	profile._Meta.Session.ExpiresAt = now + GameConfig.SessionLeaseSeconds
	return profile
end

function DataService:_normalizeProfile(profile)
	profile = deepNormalize(profile, ProfileTemplate)
	profile._Meta.Version = ProfileTemplate._Meta.Version
	profile._Meta.Session = deepNormalize(profile._Meta.Session, ProfileTemplate._Meta.Session)
	return profile
end

function DataService:_withRetries(work, validateResult)
	local lastError = nil
	for attempt = 1, RETRY_ATTEMPTS do
		local success, result = pcall(work)
		if success then
			local isValid = validateResult == nil or validateResult(result)
			if isValid then
				return true, result
			end
			lastError = "INVALID_RESULT"
		else
			lastError = result
		end
		task.wait(1 + attempt)
	end
	return false, lastError
end

function DataService:LoadProfile(player)
	if self.Profiles[player] then
		return self.Profiles[player]
	end

	if not self.PersistenceEnabled then
		local profile = self:_normalizeProfile(self:_makeDefaultProfile())
		profile._Meta.LoadMode = "StudioMemory"
		self.Profiles[player] = profile
		self.Dirty[player] = true
		self.ProfileLoaded:Fire(player, TableUtil.DeepCopy(profile))
		return profile
	end

	local profile
	local now = os.time()
	local key = self:_profileKey(player)

	local success, storeResult = self:_withRetries(function()
		return self.Store:UpdateAsync(key, function(current)
			current = self:_normalizeProfile(current or self:_makeDefaultProfile())
			local session = current._Meta.Session or {}
			local sessionOwnedByThisServer = session.JobId == self.SessionId
			local leaseExpired = (session.ExpiresAt or 0) <= now
			if session.JobId and session.JobId ~= "" and not sessionOwnedByThisServer and not leaseExpired then
				return nil
			end
			current._Meta.LastJoinAt = now
			current._Meta.Session.JobId = self.SessionId
			current._Meta.Session.ExpiresAt = now + GameConfig.SessionLeaseSeconds
			profile = current
			return current
		end)
	end, function(result)
		return profile ~= nil and type(result) == "table"
	end)

	if not success or not profile then
		warn("[DataService] Falling back to an in-memory profile for", player.Name, storeResult)
		profile = self:_makeDefaultProfile()
		profile._Meta.LoadError = tostring(storeResult)
	end

	profile = self:_normalizeProfile(profile)
	self.Profiles[player] = profile
	self.Dirty[player] = true
	self.ProfileLoaded:Fire(player, TableUtil.DeepCopy(profile))
	return profile
end

function DataService:GetProfile(player)
	return self.Profiles[player]
end

function DataService:WaitForProfile(player, timeoutSeconds)
	timeoutSeconds = timeoutSeconds or 10
	local startedAt = os.clock()
	while player.Parent == Players and os.clock() - startedAt < timeoutSeconds do
		local profile = self.Profiles[player]
		if profile then
			return profile
		end
		task.wait(0.1)
	end
	return nil
end

function DataService:Mutate(player, mutator)
	local profile = self.Profiles[player]
	if not profile then
		return nil
	end

	mutator(profile)
	self:_normalizeProfile(profile)
	profile._Meta.Session.JobId = self.SessionId
	profile._Meta.Session.ExpiresAt = os.time() + GameConfig.SessionLeaseSeconds
	self.Dirty[player] = true
	return profile
end

function DataService:_waitForSaveSlot(player, timeoutSeconds)
	timeoutSeconds = timeoutSeconds or 10
	local startedAt = os.clock()
	while self.Saving[player] do
		if os.clock() - startedAt >= timeoutSeconds then
			return false
		end
		task.wait(0.1)
	end
	return true
end

function DataService:SaveProfile(player, releasing)
	local profile = self.Profiles[player]
	if not profile then
		return true
	end

	if not self:_waitForSaveSlot(player, releasing and 15 or 5) then
		warn("[DataService] Timed out waiting for active save for", player.Name)
		return false
	end

	self.Saving[player] = true
	local ok, result = pcall(function()
		if not self.PersistenceEnabled then
			self.Dirty[player] = nil
			if releasing then
				self.Profiles[player] = nil
				self.ProfileReleased:Fire(player)
			end
			return true
		end

		local key = self:_profileKey(player)
		local now = os.time()
		profile._Meta.LastSaveAt = now
		profile._Meta.Session.JobId = releasing and "" or self.SessionId
		profile._Meta.Session.ExpiresAt = releasing and 0 or (now + GameConfig.SessionLeaseSeconds)
		local snapshot = self:_normalizeProfile(TableUtil.DeepCopy(profile))

		local success, saveResult = self:_withRetries(function()
			return self.Store:UpdateAsync(key, function(current)
				current = self:_normalizeProfile(current or self:_makeDefaultProfile())
				local session = current._Meta.Session or {}
				local sessionOwnedByThisServer = session.JobId == self.SessionId or session.JobId == ""
				local leaseExpired = (session.ExpiresAt or 0) <= now
				if session.JobId and session.JobId ~= "" and not sessionOwnedByThisServer and not leaseExpired then
					return nil
				end
				return snapshot
			end)
		end, function(updateResult)
			return updateResult ~= nil
		end)

		if not success then
			warn("[DataService] Failed to save profile for", player.Name, saveResult)
			profile._Meta.Session.JobId = self.SessionId
			profile._Meta.Session.ExpiresAt = now + GameConfig.SessionLeaseSeconds
			return false
		end

		self.Dirty[player] = nil
		if releasing then
			self.Profiles[player] = nil
			self.ProfileReleased:Fire(player)
		end
		return true
	end)
	self.Saving[player] = nil

	if not ok then
		warn("[DataService] Unexpected save failure for", player.Name, result)
		return false
	end
	return result
end

function DataService:ReleaseProfile(player, saveBeforeRelease)
	if saveBeforeRelease == false then
		self.Profiles[player] = nil
		self.Dirty[player] = nil
		self.Saving[player] = nil
		self.ProfileReleased:Fire(player)
		return true
	end
	return self:SaveProfile(player, true)
end

function DataService:FlushAllProfiles(timeoutSeconds)
	timeoutSeconds = timeoutSeconds or SHUTDOWN_SAVE_TIMEOUT
	local players = Players:GetPlayers()
	if #players == 0 then
		return true
	end

	local completed = 0
	local failures = 0
	for _, player in ipairs(players) do
		task.spawn(function()
			local success = self:ReleaseProfile(player, true)
			if not success then
				failures += 1
			end
			completed += 1
		end)
	end

	local deadline = os.clock() + timeoutSeconds
	while completed < #players and os.clock() < deadline do
		task.wait(0.1)
	end

	if completed < #players then
		warn("[DataService] Shutdown flush timed out", completed, #players)
		return false
	end
	if failures > 0 then
		warn("[DataService] Shutdown flush completed with failures", failures, #players)
		return false
	end
	return true
end

return DataService