local Module = {
	GUI = nil, 
	BattlePassFrame = nil, 
	YourTier = nil, 
	CurrentPassPage = 0, 
	Currency = nil
}
EventCurrentTierBuy = 1
Module.BuyTiersFrame = nil
Module.LeaderboardFrames = {}
Module.NewPassTierRewardObject = nil
Module.NewPassPageObject = nil
Module.PassTierRewardObjectFunction = nil
local Database = game.ReplicatedStorage.GetSyncData:InvokeServer()
local DatabaseName = "Christmas2021Pass"
local GridCreator = require(game.ReplicatedStorage.Modules.GridCreator)
local DataName = "Christmas2021"
function Module.GenerateTiers(RewardObject, PageObject, PageObjectFunction, TierData)
	Database = game.ReplicatedStorage.GetSyncData:InvokeServer()
	local PassDatabase = Database[DatabaseName]
	GridCreator.CreatePass(PageObjectFunction, RewardObject, PassDatabase, Module.BattlePassFrame, PageObject)
	Module.YourTier.Text = "Your Tier: " .. _G.PlayerData[DataName].CurrentTier
	local Tier = _G.PlayerData[DataName].CurrentTier
	if PassDatabase.TotalTiers <= Tier then
		Tier = Tier - 1
	end
	local PageNumber = math.floor(Tier / 5)
	if not TierData then
		for _, Frame in pairs(Module.BattlePassFrame:GetChildren()) do
			Frame.Visible = Frame.Name == "Page" .. PageNumber
		end
		Module.CurrentPassPage = PageNumber
	end
	Module.CurrentTierBuy = 1
	Module.ChangeBuyTiers(0)
	Module.NewPassTierRewardObject = RewardObject
	Module.NewPassPageObject = PageObject
	Module.PassTierRewardObjectFunction = PageObjectFunction
end
local PassFrame = {}
function Module.GenerateTierRewardPC(Frame, TierData, Tier)
	if TierData.Traveller == true then
		Frame.Container.Icon.Image = TierData.Image
		Frame.Title.TierNumber.Text = "???"
		Frame.Enter.Visible = true
		Frame.Next.Visible = _G.PlayerData[DataName].CurrentTier + 1 == Tier
		Frame.Locked.Visible = _G.PlayerData[DataName].CurrentTier < Tier
		Frame.Claim.Visible = false
		Frame.Enter.MouseButton1Click:connect(function()
			Module.GUI.BattlePassFrame.Visible = false
			Module.GUI.TravellerFrame.Visible = true
			if _G.PlayerData[DataName].CurrentTier < Tier then
				Module.GUI.TravellerFrame.NotUnlocked.Visible = true
				Module.GUI.TravellerFrame.NotUnlocked.ResetAnimation:Fire()
				return
			end
			if not _G.PlayerData[DataName].AncientClaimed then
				Module.GUI.TravellerFrame.NotUnlocked.Visible = false
				Module.GUI.TravellerFrame.Unlocked.Visible = true
				Module.GUI.TravellerFrame.Unlocked.ResetAnimation:Fire()
				return
			end
			if not _G.PlayerData[DataName].RadioClaimed then
				Module.GUI.TravellerFrame.NotUnlocked.Visible = false
				Module.GUI.TravellerFrame.Radio.Visible = true
				Module.GUI.TravellerFrame.Radio.ResetAnimation:Fire()
				return
			end
			Module.GUI.TravellerFrame.NotUnlocked.Visible = false
			Module.GUI.TravellerFrame.Radio.Visible = false
			Module.GUI.TravellerFrame.Completed.Visible = true
			Module.GUI.TravellerFrame.Completed.ResetAnimation:Fire()
		end)
		return
	end
	local TierReward = tostring(Tier)
	if TierData.ItemID then
		GridCreator.MakeItemFrame(Frame, TierData, false)
		if not PassFrame[Frame] then
			PassFrame[Frame] = Frame.Claim.MouseButton1Click:connect(function()
				Frame.Claim.Visible = false
				if _G.PlayerData[DataName].ClaimedRewards[TierReward] ~= true then
					Module.ClaimReward(TierReward)
				end
			end)
		end
	end
	Frame.Locked.Visible = _G.PlayerData[DataName].CurrentTier < Tier
	Frame.Next.Visible = _G.PlayerData[DataName].CurrentTier + 1 == Tier
	local Reward = false
	if Tier <= _G.PlayerData[DataName].CurrentTier then
		Reward = not _G.PlayerData[DataName].ClaimedRewards[TierReward] and Database[DatabaseName].Rewards[TierReward] ~= nil
	end
	Frame.Claim.Visible = Reward
	Frame.Title.TierNumber.Text = Tier
end
function Module.ChangePage(NextPage)
	Module.CurrentPassPage = Module.CurrentPassPage + NextPage
	for _, Frame in pairs(Module.BattlePassFrame:GetChildren()) do
		Frame.Visible = Frame.Name == "Page" .. Module.CurrentPassPage
	end
end
function Module.ChangeBuyTiers(Tier)
	local CurrentTier = _G.PlayerData[DataName].CurrentTier
	local TotalTiers = Database[DatabaseName].TotalTiers
	local BuyButton
	Module.CurrentTierBuy = Module.CurrentTierBuy + Tier
	if Module.CurrentTierBuy < 1 then
		Module.CurrentTierBuy = 1
	end
	if TotalTiers < Module.CurrentTierBuy + CurrentTier then
		Module.CurrentTierBuy = TotalTiers - CurrentTier
	end
	if Module.CurrentTierBuy > 1 then
		BuyButton = "s"
	else
		BuyButton = ""
	end
	Module.BuyTiersFrame.Buy.Text = "Buy " .. Module.CurrentTierBuy .. " Tier" .. tostring(BuyButton)
	Module.BuyTiersFrame.CandyDisplay.Amount.Text = Module.CurrentTierBuy * Database[DatabaseName].TierCost
	if TotalTiers <= CurrentTier then
		Module.BuyTiersFrame.Parent.Visible = false
		Module.BattlePassFrame.Parent.PassComplete.Visible = true
	end
end
local ChristmasEvents = game.ReplicatedStorage.Christmas2021Events
function Module.BuyTiers()
	local TierToBuy = Module.CurrentTierBuy
	local Currency = _G.PlayerData[Module.Currency] or 0
	local Cost = Database[DatabaseName].TierCost * TierToBuy
	print("Tiers To Buy: " .. TierToBuy)
	print("Current Tier: " .. _G.PlayerData[DataName].CurrentTier)
	if not (Cost <= Currency) then
		return false, Cost - Currency
	end
	ChristmasEvents.BuyTiers:FireServer(TierToBuy)
	_G.PlayerData[Module.Currency] = _G.PlayerData[Module.Currency] - Cost
	_G.PlayerData[DataName].CurrentTier = _G.PlayerData[DataName].CurrentTier + TierToBuy
	Module.CurrentTierBuy = 1
	Module.ChangeBuyTiers(0)
	print(" -- ")
	print("Tiers To Buy: " .. Module.CurrentTierBuy)
	print("Current Tier: " .. _G.PlayerData[DataName].CurrentTier)
	Module.UpdateCandies()
	Module.GenerateTiers(Module.NewPassTierRewardObject, Module.NewPassPageObject, Module.PassTierRewardObjectFunction)
	return true
end
function Module.ClaimReward(Reward)
	local RewardData
	local RewardString = tostring(Reward)
	local Type = Database[DatabaseName].Rewards[RewardString].ItemType
	local RewardType = Database[DatabaseName].Rewards[RewardString]
	if RewardType then
		RewardData = RewardType.ItemID
		if not (tonumber(RewardString) <= _G.PlayerData[DataName].CurrentTier) or _G.PlayerData[DataName].ClaimedRewards[RewardType] == true then
			return
		end
	else
		return
	end
	_G.PlayerData[DataName].ClaimedRewards[RewardString] = true
	if RewardType.ItemType == "Weapons" or RewardType.ItemType == "Pets" or RewardType.ItemType == "Materials" then
		local WeaponsOwned = _G.PlayerData[RewardType.ItemType].Owned[RewardData]
		_G.PlayerData[RewardType.ItemType].Owned[RewardData] = WeaponsOwned and WeaponsOwned + RewardType.Amount or RewardType.Amount
	else
		table.insert(_G.PlayerData[RewardType.ItemType].Owned, RewardData)
	end
	Module.GenerateTiers(Module.NewPassTierRewardObject, Module.NewPassPageObject, Module.PassTierRewardObjectFunction, true)
	ChristmasEvents.ClaimReward:FireServer(RewardData, RewardString, Type)
end
ChristmasEvents.UpdateGiftTool.OnClientEvent:Connect(function()
	Module.UpdateCandies()
end)
local GiftName = "GiftsGiven2021"
function Module.UpdateCandies()
	Module.GUI.CandyDisplay.Amount.Text = GridCreator.Commafy(_G.PlayerData[Module.Currency] or 0)
	Module.GUI.CandyDisplay2.Text = GridCreator.Commafy(_G.PlayerData[Module.Currency] or 0)
	Module.GUI.CandyDisplayBox.Text = "You have " .. GridCreator.Commafy(_G.PlayerData[Module.Currency] or 0) .. " Snow Tokens"
	Module.GUI.PumpkinKeyDisplayBox.Text = "You have " .. GridCreator.Commafy(_G.PlayerData.Materials.Owned[Module.KeyName] or 0) .. " Snow Keys"
	Module.GUI.PumpkinKeyDisplayBox.Visible = (_G.PlayerData.Materials.Owned[Module.KeyName] or 0) > 0
	Module.GUI.BoxButtonKey.Visible = (_G.PlayerData.Materials.Owned[Module.KeyName] or 0) > 0
	Module.GUI.Main.Frames.Gifts.BoxIcon.GetMore.Tokens.Text = "You have " .. GridCreator.Commafy(_G.PlayerData[Module.Currency] or 0) .. " Snow Tokens"
	Module.GUI.Main.Frames.Gifts.RewardIcon.Open.Gifts.Text = "You have given " .. (_G.PlayerData[GiftName] or 0) .. "  gifts"
	Module.GUI.Main.Frames.Gifts.RewardIcon.OpenComplete.Gifts.Text = "You have given " .. (_G.PlayerData[GiftName] or 0) .. " gifts"
	if _G.PlayerData.GiftRewardClaimed2021 == true then
		Module.GUI.Main.Frames.Gifts.RewardIcon.Open.Visible = false
		Module.GUI.Main.Frames.Gifts.RewardIcon.OpenComplete.Visible = true
		Module.GUI.Main.Frames.Gifts.RewardIcon.Completed.Visible = true
	end
	if _G.PlayerData.Christmas2021.AncientClaimed == true then
		if _G.PlayerData.Christmas2021.RadioClaimed ~= true then
			Module.GUI.TravellerFrame.Unlocked.Visible = false
			Module.GUI.TravellerFrame.Radio.Visible = true
			return
		end
	else
		return
	end
	Module.GUI.TravellerFrame.Unlocked.Visible = false
	Module.GUI.TravellerFrame.Radio.Visible = false
	Module.GUI.TravellerFrame.Completed.Visible = true
end
Module.TotalCurrency = 0
function Module.UpdateTotalCandies()
	Module.GUI.TotalCandies.Text = "You have earned " .. Module.TotalCurrency + _G.EventCurrencyGained .. " snow tokens total."
end
function Module.UpdateLeaderboard()
	local Player, Amount, CollectedTokens, Time = ChristmasEvents.GetLeaderboard:InvokeServer()
	Module.TotalCurrency = CollectedTokens or 0
	Module.UpdateTotalCandies()
	local Frame = Module.GUI.LeaderboardTokens.Container
	Frame:ClearAllChildren()
	local Rank = 1
	local RankFrame = 0
	local Ranks = {}
	local function AddLeaderboard(Leaderboard, DataStore)
		local LeaderboardFrames = (Module.LeaderboardFrames["Place" .. Rank] or Module.LeaderboardFrames.Place):Clone()
		if Rank < 4 then
			LeaderboardFrames.Container.PlayerImage.Image = game.ReplicatedStorage.GetPlayerImage:Invoke(DataStore.key)
		end
		LeaderboardFrames.Container.Username.Text = "#" .. Rank .. " - " .. DataStore.key
		LeaderboardFrames.Container.TokenCount.Text = GridCreator.Commafy(DataStore.value) .. " Tokens"
		LeaderboardFrames.Parent = Frame
		LeaderboardFrames.Position = UDim2.new(0, 0, 0, RankFrame)
		LeaderboardFrames.Name = DataStore.key
		table.insert(Ranks, LeaderboardFrames)
		RankFrame = RankFrame + LeaderboardFrames.AbsoluteSize.Y
		Rank = Rank + 1
	end
	for TopPlayers, TopCollected in pairs(Player) do
		AddLeaderboard(TopPlayers, TopCollected)
	end
	if Module.GUI.LeaderboardTimeLeft then
		local localTime = math.floor(Time / 86400)
		local dayTime = math.floor(Time % 86400 / 3600)
		local timeText = localTime .. "d, " .. dayTime .. "h"
		if localTime < 1 then
			timeText = dayTime .. "h"
			if dayTime == 1 then
				timeText = "Less than 2 hours"
			end
		end
		if Time <= 3600 then
			timeText = "Less than 1 hour!"
		end
		if Time <= 0 then
			timeText = "ENDED!"
		end
		Module.GUI.LeaderboardTimeLeft.Text = "Time Left: " .. timeText
	end
end
function Module.UpdateLeaderboard2()
	local Gifts, Player, Amount = ChristmasEvents.GetLeaderboard:InvokeServer()
	local Frame = Module.GUI.LeaderboardGifts.Container
	Frame:ClearAllChildren()
	local Rank = 1
	local RankFrame = 0
	local Ranks = {}
	local function AddLeaderboard(Leaderboard, DataStore)
		local LeaderboardFrames = (Module.LeaderboardFrames["Place" .. Rank] or Module.LeaderboardFrames.Place):Clone()
		if Rank < 4 then
			LeaderboardFrames.Container.PlayerImage.Image = game.ReplicatedStorage.GetPlayerImage:Invoke(DataStore.key)
		end
		LeaderboardFrames.Container.Username.Text = "#" .. Rank .. " - " .. DataStore.key
		LeaderboardFrames.Container.TokenCount.Text = GridCreator.Commafy(DataStore.value) .. " Gifts"
		LeaderboardFrames.Parent = Frame
		LeaderboardFrames.Position = UDim2.new(0, 0, 0, RankFrame)
		LeaderboardFrames.Name = DataStore.key
		table.insert(Ranks, LeaderboardFrames)
		RankFrame = RankFrame + LeaderboardFrames.AbsoluteSize.Y
		Rank = Rank + 1
	end
	for TopPlayers, TopCollected in pairs(Player) do
		AddLeaderboard(TopPlayers, TopCollected)
	end
end
local Box = "Christmas2021Box"
function Module.OpenKeyBox(Tokens)
	local BoxAmount = false
	if Tokens == Module.KeyName then
		BoxAmount = 1
	end
	if BoxAmount <= (_G.PlayerData.Materials.Owned[Tokens] or 0) then
		_G.PlayerData.Materials.Owned[Tokens] = _G.PlayerData.Materials.Owned[Tokens] - BoxAmount
		Module.GUI.Main.Visible = false
		_G.Process("Unboxing")
		local OpenedItem = game.ReplicatedStorage.Remotes.Shop.OpenCrate:InvokeServer(Box, false, false, false, false, false, false, true)
		wait(0.75 - (time() - time()))
		Module.GUI.Main.Parent.Processing.Visible = false
		if OpenedItem then
			game.ReplicatedStorage.Remotes.Shop.BoxController:Fire(Box, OpenedItem, false, "Weapons")
		end
	end
end
function Module.OpenTokensBox(Tokens)
	local BoxAmount
	if Tokens == Module.Currency then
		BoxAmount = 800
	end
	if BoxAmount <= (_G.PlayerData[Tokens] or 0) then
		_G.PlayerData[Tokens] = _G.PlayerData[Tokens] - BoxAmount
		Module.GUI.Main.Visible = false
		_G.Process("Unboxing")
		local OpenedItem = game.ReplicatedStorage.Remotes.Shop.OpenCrate:InvokeServer(Box, false, false, false, false, false, true, false)
		wait(0.75 - (time() - time()))
		Module.GUI.Main.Parent.Processing.Visible = false
		if OpenedItem then
			game.ReplicatedStorage.Remotes.Shop.BoxController:Fire(Box, OpenedItem, false, "Weapons")
		end
	end
end
function Module.ConnectBox(Box)
	Module.GUI.BoxButtonCandies.MouseButton1Click:connect(function()
		Module.OpenTokensBox(Module.Currency)
	end)
	Module.GUI.BoxButtonKey.MouseButton1Click:connect(function()
		Module.OpenKeyBox(Module.KeyName)
	end)
end
local ProgressData = "ChallengeProgess2021"
local Missions = {
	Login = "Mission1", 
	Murderer = "Mission2", 
	Innocent = "Mission3"
}
local MissionTimer = 0
local DaysOfMissions = {
	Login = 0, 
	Murderer = 6, 
	Innocent = 4
}
function Module.UpdateChallenges()
	local Challenges = Module.GUI.Challenges
	local Missions = {}
	for _, CompletedMissions in pairs(Challenges.Main.Dailies.Missions.Container:GetChildren()) do
		if CompletedMissions:IsA("Frame") then
			table.insert(Missions, CompletedMissions)
		end
	end
	for _, Bones in pairs(Missions) do
		Bones.Visible = false
	end
	for DailyMissions = 1, _G.PlayerData.SkellyBones do
		Missions[DailyMissions].Visible = true
	end
	for MissionType, MissionProgress in pairs(_G.PlayerData[ProgressData]) do
		if MissionType ~= "Day" then
			local Frame = nil
			Frame = Module.GUI.Challenges.Main.Dailies.Missions[Missions[MissionType]]
			if MissionTimer < 1 then
				Frame.Icon.Progress.Visible = false
				Frame.Icon.Claim.Visible = false
			elseif MissionProgress == "Unclaimed" then
				Frame.Icon.Claim.Visible = true
				Frame.Icon.Completed.Visible = false
			elseif MissionProgress == "Claimed" then
				Frame.Icon.Completed.Visible = true
				Frame.Icon.Progress.Visible = false
				Frame.Icon.Claim.Visible = false
			elseif MissionType ~= "Login" then
				Frame.Icon.Progress.Visible = true
				Frame.Icon.Progress.Text = MissionProgress .. "/" .. DaysOfMissions[MissionType]
			end
		end
	end
	local Daily = false
	if _G.PlayerData[DataName].CurrentTier < 40 then
		Daily = _G.PlayerData[DataName].Tutorial == true
	end
	Challenges.Main.Dailies.Visible = Daily
	Challenges.Main.BPTutorial.Visible = not _G.PlayerData[DataName].Tutorial
	Challenges.Main.BPComplete.Visible = _G.PlayerData[DataName].CurrentTier >= 40
end
local SantaChallengesData = nil
local SantasList = 0
local SantasChallenges = {}
local function Contents(Rarity)
	for Item, MysteryBox in pairs(Database.MysteryBox) do
		for _, Content in pairs(MysteryBox.Contents) do
			if Content == Rarity then
				return Item
			end
		end
	end
end
function Module.UpdateSantasChallenge()
	if SantaChallengesData == nil then
		return
	end
	local Details = Module.GUI.SantaChallenge.Challenge.WeaponDetails
	local Weapons = Module.GUI.SantaChallenge.Challenge.Weapons
	local Item = Database.Item
	SantasList = 0
	if SantaChallengesData ~= "Completed" then
		for i, BoxData in pairs(SantaChallengesData) do
			local Frame = Weapons["Item" .. i]
			Frame.Container.Icon.Image = Item[BoxData].Image
			Frame.Container.ItemName.Text = Item[BoxData].ItemName
			Frame.Container.ItemName.TextColor3 = Database.Rarity[Item[BoxData].Rarity]
			if _G.PlayerData.Weapons.Owned[BoxData] ~= nil then
				SantasList = SantasList + 1
				Frame.Container.Completed.Visible = true
			end
			if SantasChallenges[Frame] ~= nil then
				SantasChallenges[Frame]:disconnect()
			end
			SantasChallenges[Frame] = Frame.Container.ActionButton.MouseButton1Click:connect(function()
				Details.ItemFrame.Container.Icon.Image = Item[BoxData].Image
				Details.ItemFrame.Container.ItemName.Text = Item[BoxData].ItemName
				Details.ItemFrame.Container.ItemName.TextColor3 = Database.Rarity[Item[BoxData].Rarity]
				Details.Description.BoxName.Text = Database.MysteryBox[Contents(BoxData)].Name
				Details.Visible = true
			end)		
		end
	else
		Module.GUI.SantaChallenge.Challenge.Visible = false
		Module.GUI.SantaChallenge.Completed.Visible = true
	end
	Module.GUI.SantaChallenge.Challenge.Complete.Progress.Text = SantasList .. "/10 Weapons Owned"
	Module.GUI.SantaChallenge.Challenge.Complete.Confirm.Style = SantasList < 10 and Enum.ButtonStyle.RobloxRoundButton or Enum.ButtonStyle.RobloxRoundDefaultButton
end
function Module.GenerateSantasChallenge()
	local Details = Module.GUI.SantaChallenge.Challenge.WeaponDetails
	SantaChallengesData = ChristmasEvents.GetSantaChallenges:InvokeServer()
	if SantaChallengesData ~= "Completed" then
		Module.UpdateSantasChallenge()
	else
		Module.GUI.SantaChallenge.Challenge.Visible = false
		Module.GUI.SantaChallenge.Completed.Visible = true
	end
	if not _G.PlayerData[DataName].ChallengeTutorial then
		Module.GUI.SantaChallenge.Challenge.Visible = false
		Module.GUI.SantaChallenge.Tutorial.Visible = true
	end
	Module.GUI.SantaChallenge.Tutorial.Confirm.MouseButton1Click:connect(function()
		Module.GUI.SantaChallenge.Challenge.Visible = true
		Module.GUI.SantaChallenge.Tutorial.Visible = false
		_G.PlayerData[DataName].ChallengeTutorial = true
		ChristmasEvents.CompleteChallengeTutorial:FireServer()
	end)
	Details.Description.Close.MouseButton1Click:connect(function()
		Details.Visible = false
	end)
	Module.GUI.SantaChallenge.Challenge.Complete.Confirm.MouseButton1Click:connect(function()
		if SantasList >= 10 then
			Module.GUI.SantaChallenge.Challenge.Visible = false
			Module.GUI.SantaChallenge.Confirm.Visible = true
		end
	end)
	Module.GUI.SantaChallenge.Confirm.Confirm.MouseButton1Click:connect(function()
		if SantasList >= 10 then
			Module.GUI.SantaChallenge.Confirm.Visible = false
			Module.GUI.SantaChallenge.Completed.Visible = true
			_G.PlayerData.SantasList2020 = "Completed"
			ChristmasEvents.ConfirmSantasChallenge:FireServer()
		end
	end)
end
local DailyTypes = {
	Mission1 = "Login", 
	Mission2 = "Murderer", 
	Mission3 = "Innocent"
}
function Module.ConnectChallengeClaims()
	local AmountOfDays, ChallengeTimer = ChristmasEvents.GetChallengeTimer:InvokeServer()
	MissionTimer = ChallengeTimer
	for _, Frame in pairs(Module.GUI.Challenges.Main.Dailies.Missions:GetChildren()) do
		Frame.Icon.Claim.MouseButton1Click:connect(function()
			if _G.PlayerData[ProgressData].Day ~= AmountOfDays or MissionTimer < 1 then
				return
			end
			local DailyData = DailyTypes[Frame.Name]
			local Login
			Frame.Icon.Claim.Visible = false
			Frame.Icon.Completed.Visible = true
			Frame.Icon.Progress.Visible = false
			_G.PlayerData[ProgressData][DailyData] = "Claimed"
			if DailyTypes[Frame.Name] == "Login" then
				Login = 2
			else
				Login = 1
			end
			_G.PlayerData.SkellyBones = _G.PlayerData.SkellyBones + Login
			if _G.PlayerData.SkellyBones >= 4 then
				_G.PlayerData[DataName].CurrentTier = _G.PlayerData[DataName].CurrentTier + 1
				Module.GenerateTiers(Module.NewPassTierRewardObject, Module.NewPassPageObject, Module.PassTierRewardObjectFunction, true)
			end
			if _G.PlayerData.SkellyBones > 4 then
				_G.PlayerData.SkellyBones = _G.PlayerData.SkellyBones - 4
			end
			Module.UpdateChallenges()
			ChristmasEvents.ClaimChallenge:FireServer(DailyData)
		end)
	end
	Module.GUI.Challenges.Main.Dailies.Time.MainTimer.Text = string.format("%02i:%02i:%02i", MissionTimer / 3600, MissionTimer / 60 % 60, MissionTimer % 60)
	spawn(function()
		while wait(1) do
			MissionTimer = MissionTimer - 1
			Module.GUI.Challenges.Main.Dailies.Time.MainTimer.Text = string.format("%02i:%02i:%02i", MissionTimer / 3600, MissionTimer / 60 % 60, MissionTimer % 60)
			if MissionTimer <= 1 then
				Module.GUI.Challenges.Main.Dailies.Time.MainTimer.Text = "Now! Reset"
				Module.GUI.Challenges.Main.Dailies.Missions.Mission1.Icon.Claim.Visible = false
				Module.GUI.Challenges.Main.Dailies.Missions.Mission2.Icon.Claim.Visible = false
				Module.GUI.Challenges.Main.Dailies.Missions.Mission3.Icon.Claim.Visible = false
			end		
		end
	end)
end
return Module

