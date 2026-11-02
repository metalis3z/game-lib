local DataModule
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ActiveEventManager = require("../../ActiveEventManager")

local Sync = require("../../../Sync")

local DataTable

local function InitializeEventHandler(ActualDataModule)
	DataModule = ActualDataModule
	DataTable = DataModule.GetDataTable()
end

local CurrentEvent = ActiveEventManager:GetActiveEventInfo()
if not CurrentEvent then
	return InitializeEventHandler
end

local EventTitle = CurrentEvent.Title
local RemotesFolder = ReplicatedStorage.Remotes.Events:FindFirstChild(CurrentEvent.Title .. "Remotes")

local CurrentEventTitle = CurrentEvent.Title
local CurrentEventBattlePass = CurrentEvent.EventStartInfo.BattlePass
local CurrentEventCurrency = CurrentEvent.EventStartInfo.CurrencyName

local function ClaimItem(Player, ID)
	DataModule.GiveItem(Player, ID, 1, "Weapons")
	game.ReplicatedStorage.ItemGift:FireClient(Player, ID, "Weapons")
end

local function Claim(Player, RewardType, RewardID, RewardAmount)
	RewardAmount = RewardAmount or 1
	if RewardType == "Weapons" or RewardType == "Pets" or RewardType == "Materials" then
		DataModule.GiveItem(Player, RewardID, RewardAmount, RewardType)
	else
		DataModule.GiveOther(Player, RewardID, RewardType)
		ReplicatedStorage.Remotes.Inventory.ChangeInventoryItem:FireClient(Player, RewardType, RewardID, RewardAmount)
	end
	ReplicatedStorage.ItemGift:FireClient(Player, RewardID, RewardType)
end

ReplicatedStorage.Insight.CoinCollected.Event:Connect(function(Player)
	local Profile = DataTable[Player.Name]
	if not Profile then return end
	local EventData = Profile[CurrentEventTitle]
	if not EventData then return end
	local DailyQuest = EventData.Quests.DailyCoins
	local WeeklyQuest = EventData.Quests.WeeklyCoins
	local TotalQuest = EventData.Quests.Rewards
	if not DailyQuest or not WeeklyQuest then return end
	local MaxLimit = 12
	local DailyLimit = 240
	if DailyQuest.Progress < DailyLimit then
		DailyQuest.Progress += 1
	end
	local ProgressUpdates = {
		DailyCoins = DailyQuest.Progress,
		WeeklyCoins = WeeklyQuest.Progress,
		Rewards = nil
	}

	local DailyInfo = CurrentEvent.EventStartInfo.Quests.DailyCoins.Quests
	local DailyCompleted = false
	for Index, Def in ipairs(DailyInfo) do
		if DailyQuest.Progress >= Def.ChallengeAmount and not DailyQuest.Claimed[Index] then
			DailyQuest.Claimed[Index] = true
			DailyCompleted = true
			Claim(Player, Def.RewardType, Def.RewardID, Def.RewardAmount)
			ReplicatedStorage.ChatMessage:FireClient(Player, {
				text = "You have completed a quest: Collect " .. Def.ChallengeAmount .. " coins"
			})
		end
	end
	
	local WeeklyInfo = CurrentEvent.EventStartInfo.Quests.WeeklyCoins.Quests
	local WeeklyCompleted = false
	for Index, Def in ipairs(DailyInfo) do
		if WeeklyQuest.Progress >= Def.ChallengeAmount and not WeeklyQuest.Claimed[Index] then
			WeeklyQuest.Claimed[Index] = true
			WeeklyCompleted = true
			Claim(Player, Def.RewardType, Def.RewardID, Def.RewardAmount)
			ReplicatedStorage.ChatMessage:FireClient(Player, {
				text = "You have completed a quest: Collect " .. Def.ChallengeAmount .. " coins"
			})
		end
	end


	for QuestId, Value in pairs(ProgressUpdates) do
		if Value then
			RemotesFolder.EventQuestProgressed:FireClient(Player, QuestId, Value)
		end
	end

	ReplicatedStorage.Remotes.Inventory.ChangeProfileData:FireClient(Player, CurrentEventTitle, EventData)
end)
ReplicatedStorage.Insight.BoxOpen.Event:Connect(function(Player)
	local Profile = DataTable[Player.Name]
	if not Profile then return end

	local EventData = Profile[CurrentEventTitle]
	if not EventData then return end

	local TotalQuest = EventData.Quests.Rewards
	if not TotalQuest then return end

	local MaxLimit = 12
	if TotalQuest.Progress < MaxLimit then
		TotalQuest.Progress += 1
	end

	local TotalInfo = CurrentEvent.EventStartInfo.Quests.Rewards.Quests
	for TIndex, TDef in ipairs(TotalInfo) do
		if TotalQuest.Progress >= TDef.ChallengeAmount
			and not TotalQuest.Claimed[TIndex] then

			TotalQuest.Claimed[TIndex] = true
			Claim(Player, TDef.RewardType, TDef.RewardID, TDef.RewardAmount)

			ReplicatedStorage.ChatMessage:FireClient(Player, {
				text = "You have completed a quest: Open " .. TDef.ChallengeAmount .. " Summer boxes"
			})
		end
	end

	RemotesFolder.EventQuestProgressed:FireClient(
		Player,
		"Rewards",
		TotalQuest.Progress
	)

	ReplicatedStorage.Remotes.Inventory.ChangeProfileData:FireClient(
		Player,
		CurrentEventTitle,
		EventData
	)
end)



return InitializeEventHandler;