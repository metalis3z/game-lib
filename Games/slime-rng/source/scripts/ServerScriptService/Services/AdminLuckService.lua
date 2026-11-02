local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local AdminLuckServiceUtils = require(ReplicatedStorage.Source.Features.Admin.AdminLuckServiceUtils)

local AdminLuckService = {}

local currentState = AdminLuckServiceUtils.getDefaultState()

local remoteEvent = nil


local function broadcastState()
	if not remoteEvent then return end
	remoteEvent:FireAllClients("setState", currentState)
end

local function broadcastStateWithAnnouncement(announcement: string)
	if not remoteEvent then return end
	remoteEvent:FireAllClients("setState", currentState)
	if announcement and announcement ~= "" then
		remoteEvent:FireAllClients("showAnnouncement", announcement)
	end
end

local function fireStateToPlayer(player: Player)
	if not remoteEvent then return end
	remoteEvent:FireClient(player, "setState", currentState)
end


function AdminLuckService:setState(multiplier: number, durationSeconds: number?, startedByName: string?)
	local dur    = durationSeconds or 900
	local expiry = math.floor(workspace:GetServerTimeNow()) + dur

	currentState = AdminLuckServiceUtils.reconcileState({
		multiplier     = multiplier,
		expirationTime = expiry,
		startedByName  = startedByName,
	})

	local announcement = AdminLuckServiceUtils.getStartAnnouncementMessage(startedByName, dur)
	broadcastStateWithAnnouncement(announcement)

	print(string.format(
		"[AdminLuckService] Luck set to x%s by %s | expires in %ds",
		tostring(multiplier), tostring(startedByName), dur
		))
end

function AdminLuckService:clearState()
	currentState = AdminLuckServiceUtils.getDefaultState()
	broadcastState()
	print("[AdminLuckService] Luck cleared")
end

function AdminLuckService:getState()
	return AdminLuckServiceUtils.reconcileState(currentState)
end

local function tickLuck()
	while true do
		task.wait(5)
		local now   = math.floor(workspace:GetServerTimeNow())
		local state = AdminLuckServiceUtils.reconcileState(currentState)
		if state.multiplier > 1 and state.expirationTime > 0 and now >= state.expirationTime then
			print("[AdminLuckService] Luck expired, clearing")
			AdminLuckService:clearState()
		end
	end
end

function AdminLuckService:init()
	local networker031 = ReplicatedStorage.Packages._Index["leifstout_networker@0.3.1"].networker
	local remotes = networker031:WaitForChild("_remotes", 10)
	if not remotes then
		warn("[AdminLuckService] _remotes not found")
		return
	end

	local svcRemotes = remotes:WaitForChild("AdminLuckService", 10)
	if not svcRemotes then
		warn("[AdminLuckService] AdminLuckService remotes not found")
		return
	end

	local rf = svcRemotes:FindFirstChild("RemoteFunction")
	if rf then
		rf.OnServerInvoke = function(player, method, ...)
			if method == "getState" then
				return self:getState()
			end
			warn("[AdminLuckService] Unknown method:", method)
			return nil
		end
		print("[AdminLuckService] OnServerInvoke set")
	else
		warn("[AdminLuckService] RemoteFunction not found")
	end

	remoteEvent = svcRemotes:FindFirstChild("RemoteEvent")
	if not remoteEvent then
		warn("[AdminLuckService] RemoteEvent not found — state broadcasts won't work")
	end

	Players.PlayerAdded:Connect(function(player)
		task.wait(2)
		fireStateToPlayer(player)
	end)

	task.spawn(tickLuck)

	print("[AdminLuckService] Initialized")
end

return AdminLuckService