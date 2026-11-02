-- Free "like the game + join the group" reward (GUI.Folder.FreeGiftFrame).
-- Only group membership is verifiable in-game, so the claim checks the
-- GameConfig.Group.GroupId community and grants GameConfig.FreeGift.CashAmount
-- once per player (FreeGiftClaimed profile flag).
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local GroupService = game:GetService("GroupService")

local PlayerDataService = require(ServerScriptService.Source.Services.PlayerDataService)
local GameConfig = require(ReplicatedStorage.Source.Configs.GameConfig)

local FreeGiftService = {}

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local GiftRemotes = Remotes:WaitForChild("FreeGiftService")
local ClaimFunc = GiftRemotes:WaitForChild("Claim")
local RequestDataFunc = GiftRemotes:WaitForChild("RequestData")
local DataUpdateEvent = GiftRemotes:WaitForChild("DataUpdate")

local function getGroupId()
	return (GameConfig.Group and GameConfig.Group.GroupId) or 0
end

local function getCashAmount()
	return (GameConfig.FreeGift and GameConfig.FreeGift.CashAmount) or 0
end

-- player:IsInGroup caches its answer for the whole session, so a player who
-- joins the group while in-game would stay "not in group" until rejoin.
-- GroupService:GetGroupsAsync re-queries, so it goes first; IsInGroup is the
-- fallback when the fresh lookup errors.
local function isInGroup(player)
	local groupId = getGroupId()
	if groupId == 0 then return false end

	local ok, groups = pcall(GroupService.GetGroupsAsync, GroupService, player.UserId)
	if ok and type(groups) == "table" then
		for _, group in ipairs(groups) do
			if group.Id == groupId then
				return true
			end
		end
		return false
	end

	local ok2, inGroup = pcall(player.IsInGroup, player, groupId)
	return ok2 and inGroup == true
end

local function buildPayload(data)
	return {
		Claimed = data.FreeGiftClaimed == true,
		CashAmount = getCashAmount(),
	}
end

local function onClaim(player)
	local data = PlayerDataService.GetPlayerData(player)
	if not data then
		return { Success = false, Reason = "NoData" }
	end

	if data.FreeGiftClaimed then
		return { Success = false, Reason = "AlreadyClaimed" }
	end

	if not isInGroup(player) then
		return { Success = false, Reason = "NotInGroup" }
	end

	local amount = getCashAmount()
	PlayerDataService.AddStat(player, "Cash", amount)
	local LeaderboardService = require(ServerScriptService.Source.Services.LeaderboardService)
	pcall(function() LeaderboardService.AddTotalCash(player, amount) end)

	data.FreeGiftClaimed = true
	DataUpdateEvent:FireClient(player, buildPayload(data))

	return { Success = true, Amount = amount }
end

local function onRequestData(player)
	local data = PlayerDataService.GetPlayerData(player)
	if not data then return nil end
	return buildPayload(data)
end

function FreeGiftService.Init()
	ClaimFunc.OnServerInvoke = onClaim
	RequestDataFunc.OnServerInvoke = onRequestData

	PlayerDataService.ProfileLoaded.Event:Connect(function(player, data)
		task.defer(function()
			if data then
				DataUpdateEvent:FireClient(player, buildPayload(data))
			end
		end)
	end)
end

return FreeGiftService
