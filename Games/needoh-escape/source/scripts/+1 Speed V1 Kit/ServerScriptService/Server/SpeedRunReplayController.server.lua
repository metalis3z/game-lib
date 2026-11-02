--!strict
-- LOCATION: ServerScriptService/Controllers/SpeedRunReplayHandler
-- Receives SubmitReplay from clients.
-- Compares against any previously stored replay:
--   * If new time is FASTER (or no replay exists) -> overwrite/store.
--   * If new time is SLOWER -> discard immediately (never write).
-- Receives RequestReplay from clients, fetches and delivers.

local Players             = game:GetService("Players")
local ReplicatedStorage   = game:GetService("ReplicatedStorage")
local DataStoreService    = game:GetService("DataStoreService")
local ServerScriptService = game:GetService("ServerScriptService")

local PlayerController: any

local function getPC(): any
	if PlayerController then return PlayerController end
	local ok, m = pcall(function()
		return require(ServerScriptService.Controllers.PlayerController)
	end)
	if ok then PlayerController = m
	else warn("[ReplayHandler] Failed to require PlayerController:", m) end
	return PlayerController
end

local ReplayStore = DataStoreService:GetDataStore("SpeedRunReplays_v1")

local MAX_FRAMES         = 12000
local MAX_REVIVE_MARKERS = 50

-- How many seconds of tolerance between client-reported time and the server's
-- saved BestSpeedRunTime before we reject the submission as tampered.
local TIME_TOLERANCE_SECS = 2

local events: {[string]: RemoteEvent} = {}

-- [ HELPERS ] ----------------------------------------------------------------

local function timeStringToSeconds(s: string): number?
	local m, sec, ms = s:match("(%d+):(%d+)%.(%d+)")
	if not m then return nil end
	return tonumber(m) * 60 + tonumber(sec) + tonumber(ms) / 1000
end

local function validateFrames(frames: any): boolean
	if type(frames) ~= "table" then return false end
	if #frames == 0 or #frames > MAX_FRAMES then return false end
	for i = 1, math.min(20, #frames) do
		local f = frames[i]
		if type(f) ~= "table" or #f ~= 6 then return false end
		for _, v in ipairs(f) do
			if type(v) ~= "number" or v ~= v then return false end
		end
	end
	return true
end

-- [ SUBMIT ] -----------------------------------------------------------------

local function onSubmitReplay(player: Player, finalTime: any, frames: any, reviveMarkers: any)
	-- Basic type validation
	if type(finalTime) ~= "number" or finalTime <= 0 then
		warn("[ReplayHandler] Rejected bad finalTime from", player.Name)
		return
	end
	if not validateFrames(frames) then
		warn("[ReplayHandler] Rejected bad frames from", player.Name)
		return
	end
	if type(reviveMarkers) ~= "table" then reviveMarkers = {} end
	if #reviveMarkers > MAX_REVIVE_MARKERS then
		warn("[ReplayHandler] Rejected too many revive markers from", player.Name)
		return
	end

	local pc = getPC()
	if not pc then warn("[ReplayHandler] PlayerController unavailable."); return end

	local profile = pc:GetProfile(player)
	if not profile then warn("[ReplayHandler] No profile for", player.Name); return end

	-- Cross-check with server-authoritative BestSpeedRunTime
	local serverBest = profile.Data.BestSpeedRunTime
	if type(serverBest) == "string" and serverBest ~= "" then
		local serverSecs = timeStringToSeconds(serverBest)
		if serverSecs then
			-- Reject if client time doesn't match the server record within tolerance
			if math.abs(finalTime - serverSecs) > TIME_TOLERANCE_SECS then
				warn("[ReplayHandler] Time mismatch for", player.Name,
					"| client:", string.format("%.3f", finalTime),
					"| server:", string.format("%.3f", serverSecs), "— rejecting.")
				return
			end
		end
	end

	-- Fetch the currently stored replay to compare times
	task.spawn(function()
		local fetchOk, existing = pcall(function()
			return ReplayStore:GetAsync(tostring(player.UserId))
		end)

		-- If the fetch itself failed, be conservative and skip storing
		-- (don't wipe a good replay due to a transient DataStore error).
		if not fetchOk then
			warn("[ReplayHandler] GetAsync failed while checking existing replay for",
				player.Name, ":", existing, "— skipping store.")
			return
		end

		-- If an existing replay is present, only overwrite if new time is faster.
		if existing and type(existing) == "table" then
			local existingTime = existing.time
			if type(existingTime) == "number" and existingTime > 0 then
				if finalTime >= existingTime then
					print("[ReplayHandler] Not a PB for", player.Name,
						"| new:", string.format("%.3f", finalTime),
						"| existing:", string.format("%.3f", existingTime),
						"— discarding replay.")
					return
				end
				print("[ReplayHandler] New PB for", player.Name,
					"| old:", string.format("%.3f", existingTime),
					"| new:", string.format("%.3f", finalTime), "— overwriting.")
			end
		else
			print("[ReplayHandler] First replay ever for", player.Name,
				"| time:", string.format("%.3f", finalTime))
		end

		-- Resolve display name (best-effort)
		local nameOk, username = pcall(function()
			return Players:GetNameFromUserIdAsync(player.UserId)
		end)
		if not nameOk then username = player.Name end

		local blob = {
			userId   = player.UserId,
			username = username,
			time     = finalTime,
			recorded = os.time(),
			frames   = frames,
			revives  = reviveMarkers,
		}

		local storeOk, storeErr = pcall(function()
			ReplayStore:SetAsync(tostring(player.UserId), blob)
		end)
		if storeOk then
			print("[ReplayHandler] Saved PB replay for", player.Name,
				"| time:", string.format("%.3f", finalTime),
				"| frames:", #frames)
		else
			warn("[ReplayHandler] SetAsync failed for", player.Name, ":", storeErr)
		end
	end)
end

-- [ REQUEST ] ----------------------------------------------------------------

local function onRequestReplay(requestingPlayer: Player, targetUserId: any)
	if type(targetUserId) ~= "number" then
		warn("[ReplayHandler] Bad targetUserId:", targetUserId)
		return
	end

	task.spawn(function()
		local ok, result = pcall(function()
			return ReplayStore:GetAsync(tostring(targetUserId))
		end)
		if ok and result then
			events.DeliverReplay:FireClient(requestingPlayer, result)
		else
			if not ok then
				warn("[ReplayHandler] GetAsync failed for userId", targetUserId, ":", result)
			end
			events.DeliverReplay:FireClient(requestingPlayer, nil)
		end
	end)
end

-- [ SETUP ] ------------------------------------------------------------------

local function setupEvents()
	local e = ReplicatedStorage:FindFirstChild("Events")
	if not e then
		e = Instance.new("Folder")
		e.Name   = "Events"
		e.Parent = ReplicatedStorage
	end

	local function mk(cl: string, nm: string): RemoteEvent
		local x = e:FindFirstChild(nm)
		if not x then
			x = Instance.new(cl)
			x.Name   = nm
			x.Parent = e
		end
		return x :: RemoteEvent
	end

	events.SubmitReplay  = mk("RemoteEvent", "SubmitReplay")
	events.RequestReplay = mk("RemoteEvent", "RequestReplay")
	events.DeliverReplay = mk("RemoteEvent", "DeliverReplay")

	events.SubmitReplay.OnServerEvent:Connect(onSubmitReplay)
	events.RequestReplay.OnServerEvent:Connect(onRequestReplay)

	print("[ReplayHandler] Events wired.")
end

setupEvents()