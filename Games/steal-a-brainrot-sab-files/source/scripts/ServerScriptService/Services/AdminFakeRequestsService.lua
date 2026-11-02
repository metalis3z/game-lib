local Players           = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService       = game:GetService("HttpService")

local Net = require(ReplicatedStorage.Packages.Net)

local RemoteCreateTradeInvite = Net:RemoteEvent("TradeService/CreateInvite")
local RemoteCreateDuelInvite  = Net:RemoteEvent("DuelsMachineService/CreateInvite")
local AdminFakeRequests       = Net:RemoteFunction("AdminPanel/FakeRequests")


local MAX_PER_TYPE   = 140
local SEND_INTERVAL  = 0.12
local INVITE_TTL     = 30


local usernamePool: {{id: number, name: string}} = {}
local POOL_TARGET = 25

local FALLBACK_USERS = {
	{ id = 156, name = "builderman" },
	{ id = 1,   name = "Roblox" },
	{ id = 261, name = "shedletsky" },
	{ id = 16,  name = "Erik.Cassel" },
}

local function fetchRandomUser(): {id: number, name: string}?
	for _ = 1, 6 do
		local id = math.random(100000000, 2000000000)
		local ok, name = pcall(function()
			return Players:GetNameFromUserIdAsync(id)
		end)
		if ok and typeof(name) == "string" and #name > 0 then
			return { id = id, name = name }
		end
	end
	return nil
end

local function takeRandomUser(): {id: number, name: string}
	if #usernamePool > 0 then
		return table.remove(usernamePool, math.random(1, #usernamePool)) :: any
	end
	local user = fetchRandomUser()
	if user then return user end
	return FALLBACK_USERS[math.random(1, #FALLBACK_USERS)]
end

local function sendFakeTradeInvite(targetPlayer: Player)
	local user = takeRandomUser()
	local inviteId = HttpService:GenerateGUID(false)
	pcall(function()
		RemoteCreateTradeInvite:FireClient(targetPlayer, inviteId, {
			from = user.id,
			expires = workspace:GetServerTimeNow() + INVITE_TTL,
			senderName = user.name,
			senderDisplayName = user.name,
			senderDisplayUserId = user.id,
		})
	end)
end

local function sendFakeDuelInvite(targetPlayer: Player)
	local user = takeRandomUser()
	local inviteId = "invite_fake_" .. HttpService:GenerateGUID(false)
	pcall(function()
		RemoteCreateDuelInvite:FireClient(targetPlayer, inviteId, {
			from = user.id,
			to = targetPlayer.UserId,
			expires = workspace:GetServerTimeNow() + INVITE_TTL,
			serverId = game.JobId,
		})
	end)
end

local AdminFakeRequestsService = {}

function AdminFakeRequestsService:Start()
	task.spawn(function()
		while true do
			if #usernamePool < POOL_TARGET then
				local user = fetchRandomUser()
				if user then
					table.insert(usernamePool, user)
				else
					task.wait(0.5)
				end
			else
				task.wait(2)
			end
		end
	end)

	AdminFakeRequests.OnServerInvoke = function(player, tradeAmount, duelAmount)
		tradeAmount = math.clamp(math.floor(tonumber(tradeAmount) or 0), 0, MAX_PER_TYPE)
		duelAmount  = math.clamp(math.floor(tonumber(duelAmount)  or 0), 0, MAX_PER_TYPE)

		if tradeAmount == 0 and duelAmount == 0 then
			return false, "Set at least one amount"
		end

		local targetPlayer = player

		task.spawn(function()
			local maxAmount = math.max(tradeAmount, duelAmount)
			for i = 1, maxAmount do
				if not targetPlayer.Parent then break end
				if i <= tradeAmount then sendFakeTradeInvite(targetPlayer) end
				if i <= duelAmount  then sendFakeDuelInvite(targetPlayer)  end
				task.wait(SEND_INTERVAL)
			end
		end)

		return true, ("Sent %d trade + %d duel"):format(tradeAmount, duelAmount)
	end
end

return AdminFakeRequestsService