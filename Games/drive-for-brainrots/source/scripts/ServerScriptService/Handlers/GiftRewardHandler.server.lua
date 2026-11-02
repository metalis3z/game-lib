--!strict
-- LOCATION: ServerScriptService/Handlers/GiftRewardHandler
-- Handles the Gift Reward system: group check + Smurf Cat reward

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local DataManager = require(ServerScriptService.Handlers.DataManager)
local ItemManager = require(ServerScriptService.Modules.ItemManager)
local Events = ReplicatedStorage:WaitForChild("Events")
local CheckInGroup = ReplicatedStorage:WaitForChild("CheckInGroup")

-- ── Configuration ────────────────────────────────────────────────────────
-- IMPORTANT: Replace with your actual Roblox Group ID
local GROUP_ID = 0 -- <-- CHANGE THIS TO YOUR GROUP ID
local REWARD_ITEM = "Smurf Cat"
local REWARD_MUTATION = "Normal"
local REWARD_RARITY = "Mythical"
local REWARD_LEVEL = 1

-- Track who has already claimed
local claimedPlayers = {}

-- ── Create RemoteEvents if needed ────────────────────────────────────────
if not Events:FindFirstChild("GiftClaimResult") then
	local re = Instance.new("RemoteEvent")
	re.Name = "GiftClaimResult"
	re.Parent = Events
end
local GiftClaimResult = Events.GiftClaimResult

-- ── CheckInGroup handler ─────────────────────────────────────────────────
CheckInGroup.OnServerEvent:Connect(function(player: Player)
	-- Check if already claimed
	if claimedPlayers[player.UserId] then
		GiftClaimResult:FireClient(player, false, "You already claimed this reward!")
		return
	end

	-- Check if player is in the group
	local isInGroup = false
	local success, result = pcall(function()
		return player:IsInGroup(GROUP_ID)
	end)

	if success then
		isInGroup = result
	else
		GiftClaimResult:FireClient(player, false, "Error checking group. Try again.")
		return
	end

	if not isInGroup then
		GiftClaimResult:FireClient(player, false, "You must join the group first!")
		return
	end

	-- Player is in group - give reward
	claimedPlayers[player.UserId] = true
	ItemManager.GiveItemToPlayer(player, REWARD_ITEM, REWARD_MUTATION, REWARD_RARITY, REWARD_LEVEL)
	GiftClaimResult:FireClient(player, true, "You received Smurf Cat!")

	-- Notification
	local notifEvent = Events:FindFirstChild("ShowNotification")
	if notifEvent then
		notifEvent:FireClient(player, "Reward Claimed!", "You received Smurf Cat for joining the group!", "Success")
	end
end)

-- ── Cleanup on player leave ──────────────────────────────────────────────
Players.PlayerRemoving:Connect(function(player: Player)
	claimedPlayers[player.UserId] = nil
end)

print("[GiftRewardHandler] Active (Group ID: " .. tostring(GROUP_ID) .. ")")
local GiftRewardHandler = {}
return GiftRewardHandler