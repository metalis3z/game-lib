local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local DataService = require(ReplicatedStorage.Packages.DataService).server
local LuckLadderServiceUtils = require(ReplicatedStorage.Source.Features.LuckLadder.LuckLadderServiceUtils)

local LuckLadderService = {}

local currentState = LuckLadderServiceUtils.getDefaultState()

local function getRemoteEvent()
	local networker031 = ReplicatedStorage.Packages._Index["leifstout_networker@0.3.1"].networker
	local remotes = networker031:FindFirstChild("_remotes")
	local svc = remotes and remotes:FindFirstChild("LuckLadderService")
	return svc and svc:FindFirstChild("RemoteEvent")
end

local function broadcastState()
	local re = getRemoteEvent()
	if re then
		re:FireAllClients("stateChanged", currentState)
	end
end

function LuckLadderService:applyPurchase(player: Player, purchasedMultiplier: number)
	local now = os.time()
	local duration = LuckLadderServiceUtils.getDuration() -- 900 seconds

	local currentMult = LuckLadderServiceUtils.getCurrentMultiplier(currentState, now)
	local newMult = LuckLadderServiceUtils.resolvePurchaseMultiplier(currentMult, purchasedMultiplier)

	currentState = {
		multiplier         = newMult,
		expirationTime     = now + duration,
		lastPurchaserName  = player.Name,
	}

	print(string.format(
		"[LuckLadderService] %s activated Server Luck x%d (expires in %ds)",
		player.Name, newMult, duration
		))

	broadcastState()

	local announcement = LuckLadderServiceUtils.getPurchaseAnnouncementMessage(player.Name, newMult)
	local re = getRemoteEvent()
	if re then
		re:FireAllClients("announcement", announcement)
	end
end

function LuckLadderService:getState()
	return currentState
end

function LuckLadderService:init()
	local networker031 = ReplicatedStorage.Packages._Index["leifstout_networker@0.3.1"].networker
	local remotes = networker031:WaitForChild("_remotes", 10)
	if not remotes then
		warn("[LuckLadderService] _remotes not found")
		return
	end

	local svcRemotes = remotes:WaitForChild("LuckLadderService", 10)
	if not svcRemotes then
		warn("[LuckLadderService] LuckLadderService remotes not found")
		return
	end

	local rf = svcRemotes:FindFirstChild("RemoteFunction")
	if rf then
		rf.OnServerInvoke = function(player, method, ...)
			if method == "getState" then
				return currentState
			end
			warn("[LuckLadderService] Unknown method:", method)
			return nil
		end
		print("[LuckLadderService] OnServerInvoke set")
	end

	Players.PlayerAdded:Connect(function(player)
		task.wait(1)
		local re = getRemoteEvent()
		if re then
			re:FireClient(player, "stateChanged", currentState)
		end
	end)

	task.spawn(function()
		while true do
			task.wait(10)
			local now = os.time()
			if currentState.multiplier > 1 and now >= currentState.expirationTime then
				currentState = LuckLadderServiceUtils.getDefaultState()
				print("[LuckLadderService] Server Luck expired")
				broadcastState()
			end
		end
	end)

	print("[LuckLadderService] Initialized")
end

return LuckLadderService