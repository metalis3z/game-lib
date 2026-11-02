local Module = {
	GUI = nil, 
	GameGUI = nil,
	BattlePassFrame = nil, 
	YourTier = nil, 
	CurrentPassPage = 0, 
	Currency = nil
}
EventCurrentTierBuy = 1
Module.BuyTiersFrame = nil
Module.LeaderboardFrames = {}
Module.NewPassTierRewardObject = nil
if not _G.EventCurrencyGained then
	_G.EventCurrencyGained = 0
end
Module.NewPassPageObject = nil
Module.TotalCurrency = 0
Module.PassTierRewardObjectFunction = nil
local Database = game.ReplicatedStorage.GetSyncData:InvokeServer()
local BattlePass = "Christmas2022Pass"
local GridCreator = require(game.ReplicatedStorage.Modules.GridCreator)
function Module.GenerateTiers(RewardObject, PageObject, PageObjectFunction, TierData)
	local PassDatabase = Database[BattlePass]
	GridCreator.CreatePass(PageObjectFunction, RewardObject, PassDatabase, Module.BattlePassFrame, PageObject)
	Module.YourTier.Text = "Your Tier: " .. _G.PlayerData.Christmas2022.CurrentTier
	local Tier = _G.PlayerData.Christmas2022.CurrentTier
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
		Frame.Next.Visible = _G.PlayerData.Christmas2022.CurrentTier + 1 == Tier
		Frame.Locked.Visible = _G.PlayerData.Christmas2022.CurrentTier < Tier
		Frame.Claim.Visible = false
		Frame.Enter.MouseButton1Click:connect(function()
			Module.GUI.BattlePassFrame.Visible = false
			Module.GUI.TravellerFrame.Visible = true
			if _G.PlayerData.Christmas2022.CurrentTier < Tier then
				Module.GUI.TravellerFrame.NotUnlocked.Visible = true
				Module.GUI.TravellerFrame.NotUnlocked.ResetAnimation:Fire()
				return
			end
			if not _G.PlayerData.Christmas2022.AncientClaimed then
				Module.GUI.TravellerFrame.NotUnlocked.Visible = false
				Module.GUI.TravellerFrame.Unlocked.Visible = true
				Module.GUI.TravellerFrame.Unlocked.ResetAnimation:Fire()
				return
			end
			if not _G.PlayerData.Christmas2022.RadioClaimed then
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
				if _G.PlayerData.Christmas2022.ClaimedRewards[TierReward] ~= true then
					Module.ClaimReward(TierReward)
				end
			end)
		end
	end
	Frame.Locked.Visible = _G.PlayerData.Christmas2022.CurrentTier < Tier
	Frame.Next.Visible = _G.PlayerData.Christmas2022.CurrentTier + 1 == Tier
	local Reward = false
	if Tier <= _G.PlayerData.Christmas2022.CurrentTier then
		Reward = not _G.PlayerData.Christmas2022.ClaimedRewards[TierReward] and Database[BattlePass].Rewards[TierReward] ~= nil
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
function Module.ChangeBuyTiers(tier)
	local CurrentTier = _G.PlayerData.Christmas2022.CurrentTier
	local TotalTiers = Database[BattlePass].TotalTiers
	local BuyButton
	Module.CurrentTierBuy = Module.CurrentTierBuy + tier
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
	Module.BuyTiersFrame.CandyDisplay.Amount.Text = Module.CurrentTierBuy * Database[BattlePass].TierCost
	if TotalTiers <= CurrentTier then
		Module.BuyTiersFrame.Parent.Visible = false
		Module.BattlePassFrame.Parent.PassComplete.Visible = true
	end
end
local ChristmasEvents = game.ReplicatedStorage.Christmas2022Events
function Module.BuyTiers()
	local TierToBuy = Module.CurrentTierBuy
	local PassCurrency = _G.PlayerData.Materials.Owned[Module.Currency] or 0
	local TierCost = Database[BattlePass].TierCost * TierToBuy
	print("Tiers To Buy: " .. TierToBuy)
	print("Current Tier: " .. _G.PlayerData.Christmas2022.CurrentTier)
	if not (TierCost <= PassCurrency) then
		return false, TierCost - PassCurrency
	end
	ChristmasEvents.BuyTiers:FireServer(TierToBuy)
	_G.PlayerData.Materials.Owned[Module.Currency] = _G.PlayerData.Materials.Owned[Module.Currency] - TierCost
	_G.PlayerData.Christmas2022.CurrentTier = _G.PlayerData.Christmas2022.CurrentTier + TierToBuy
	Module.CurrentTierBuy = 1
	Module.ChangeBuyTiers(0)
	print(" -- ")
	print("Tiers To Buy: " .. Module.CurrentTierBuy)
	print("Current Tier: " .. _G.PlayerData.Christmas2022.CurrentTier)
	Module.UpdateCandies()
	Module.GenerateTiers(Module.NewPassTierRewardObject, Module.NewPassPageObject, Module.PassTierRewardObjectFunction)
	return true
end
function Module.ClaimReward(Reward)
	local RewardData
	local RewardString = tostring(Reward)
	local Type = Database[BattlePass].Rewards[RewardString].ItemType
	local RewardType = Database[BattlePass].Rewards[RewardString]
	if RewardType then
		RewardData = RewardType.ItemID
		if not (tonumber(RewardString) <= _G.PlayerData.Christmas2022.CurrentTier) or _G.PlayerData.Christmas2022.ClaimedRewards[RewardType] == true then
			return
		end
	else
		return
	end
	_G.PlayerData.Christmas2022.ClaimedRewards[RewardString] = true
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
function Module.ConnectBox(box)
	Module.GUI.BoxButtonCandies.MouseButton1Click:connect(function()
		Module.OpenBox(Module.Currency)
	end)
	Module.GUI.BoxButtonKey.MouseButton1Click:connect(function()
		Module.OpenBox(Module.KeyName)
	end)
end
function Module.UpdateCandies()
	Module.GUI.CandyDisplay.Amount.Text = GridCreator.Commafy(_G.PlayerData.Materials.Owned[Module.Currency])
	Module.GUI.CandyDisplay2.Text = GridCreator.Commafy(_G.PlayerData.Materials.Owned[Module.Currency])
	Module.GUI.CandyDisplayBox.Text = "You have " .. GridCreator.Commafy(_G.PlayerData.Materials.Owned[Module.Currency]) .. " Snow Tokens"
	Module.GUI.PumpkinKeyDisplayBox.Text = "You have " .. GridCreator.Commafy(_G.PlayerData.Materials.Owned[Module.KeyName]) .. " Snow Keys"
	Module.GUI.PumpkinKeyDisplayBox.Visible = (_G.PlayerData.Materials.Owned[Module.KeyName] or 0) > 0
	Module.GUI.BoxButtonKey.Visible = (_G.PlayerData.Materials.Owned[Module.KeyName] or 0) > 0
	if _G.PlayerData.Christmas2022.AncientClaimed == true then
		if _G.PlayerData.Christmas2022.RadioClaimed ~= true then
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
function Module.UpdateTotalCandies()
	Module.GUI.TotalCandies.Text = "You have earned " .. Module.TotalCurrency + _G.EventCurrencyGained .. " Snow Tokens in total."
end
function Module.UpdateLeaderboard()
	local Player, Amount = ChristmasEvents.GetLeaderboard:InvokeServer()
	Module.TotalCurrency = Amount or 0
	Module.UpdateTotalCandies()
	local Tokens = Module.GUI.LeaderboardTokens.Container
	Tokens:ClearAllChildren()
	local PlaceNumber = 1
	local PlaceNumberPosition = 0
	local Places = {}
	local function AddLeaderboard(BoardPlayers, BoardTokens)
		local PlaceFrame = (Module.LeaderboardFrames["Place" .. PlaceNumber] or Module.LeaderboardFrames.Place):Clone()
		if PlaceNumber < 4 then
			PlaceFrame.Container.PlayerImage.Image = game.ReplicatedStorage.GetPlayerImage:Invoke(BoardTokens.key)
		end
		PlaceFrame.Container.Username.Text = "#" .. PlaceNumber .. " - " .. BoardTokens.key
		PlaceFrame.Container.TokenCount.Text = GridCreator.Commafy(BoardTokens.value) .. " Snow Tokens"
		PlaceFrame.Parent = Tokens
		PlaceFrame.Position = UDim2.new(0, 0, 0, PlaceNumberPosition)
		PlaceFrame.Name = BoardTokens.key
		table.insert(Places, PlaceFrame)
		PlaceNumberPosition = PlaceNumberPosition + PlaceFrame.AbsoluteSize.Y
		PlaceNumber = PlaceNumber + 1
	end
	for Players, Token in pairs(Player) do
		AddLeaderboard(Players, Token)
	end
end
--[[local CompletedChallenges = nil
local ChallengeDone = 0
local Challenges = {}
local function Contents(p17)
	for v50, v51 in pairs(Database.MysteryBox) do
		for v52, v53 in pairs(v51.Contents) do
			if v53 == p17 then
				return v50
			end
		end
	end
end
function Module.UpdateSantasChallenge()
	if Challenges == nil then return end
	local WeaponDetails = Module.GUI.SantaChallenge.Challenge.WeaponDetails
	local ChallengeWeapons = Module.GUI.SantaChallenge.Challenge.Weapons
	local Item = Database.Item
	ChallengeDone = 0
	if CompletedChallenges ~= "Completed" then
		for Challenge, ChallengeItem in pairs(CompletedChallenges) do
			local ChallengeData = ChallengeWeapons["Item" .. Challenge]
			ChallengeData.Container.Icon.Image = Item[ChallengeItem].Image
			ChallengeData.Container.ItemName.Text = Item[ChallengeItem].ItemName
			ChallengeData.Container.ItemName.TextColor3 = Database.Rarity[Item[ChallengeItem].Rarity]
			if _G.PlayerData.Weapons.Owned[ChallengeItem] ~= nil then
				ChallengeDone = ChallengeDone + 1
				ChallengeData.Container.Completed.Visible = true
			end
			if Challenges[ChallengeData] ~= nil then
				Challenges[ChallengeData]:disconnect()
			end
			Challenges[ChallengeData] = ChallengeData.Container.ActionButton.MouseButton1Click:connect(function()
				WeaponDetails.ItemFrame.Container.Icon.Image = Item[ChallengeItem].Image
				WeaponDetails.ItemFrame.Container.ItemName.Text = Item[ChallengeItem].ItemName
				WeaponDetails.ItemFrame.Container.ItemName.TextColor3 = Module.Rarity[Item[ChallengeItem].Rarity]
				WeaponDetails.Description.BoxName.Text = Module.MysteryBox[Contents(ChallengeItem)].Name
				WeaponDetails.Visible = true
			end)
		end
	else
		Module.GUI.SantaChallenge.Challenge.Visible = false
		Module.GUI.SantaChallenge.Completed.Visible = true
	end;
	Module.GUI.SantaChallenge.Challenge.Complete.Progress.Text = ChallengeDone .. "/10 Weapons Owned";
	Module.GUI.SantaChallenge.Challenge.Complete.Confirm.Style = ChallengeDone < 10 and Enum.ButtonStyle.RobloxRoundButton or Enum.ButtonStyle.RobloxRoundDefaultButton
end
function Module.GenerateSantasChallenge()
	local WeaponDetails = Module.GUI.SantaChallenge.Challenge.WeaponDetails
	CompletedChallenges = ChristmasEvents.GetSantaChallenges:InvokeServer()
	if CompletedChallenges ~= "Completed" then
		Module.UpdateSantasChallenge()
	else
		Module.GUI.SantaChallenge.Challenge.Visible = false
		Module.GUI.SantaChallenge.Completed.Visible = true
	end
	if not _G.PlayerData.Christmas2022.ChallengeTutorial then
		Module.GUI.SantaChallenge.Challenge.Visible = false
		Module.GUI.SantaChallenge.Tutorial.Visible = true
	end;
	Module.GUI.SantaChallenge.Tutorial.Confirm.MouseButton1Click:connect(function()
		Module.GUI.SantaChallenge.Challenge.Visible = true
		Module.GUI.SantaChallenge.Tutorial.Visible = false
		_G.PlayerData.Chistmas2022.ChallengeTutorial = true
		ChristmasEvents.CompleteChallengeTutorial:FireServer()
	end)
	WeaponDetails.Description.Close.MouseButton1Click:connect(function()
		WeaponDetails.Visible = false;
	end)
	Module.GUI.SantaChallenge.Challenge.Complete.Confirm.MouseButton1Click:connect(function()
		if ChallengeDone >= 10 then
			Module.GUI.SantaChallenge.Challenge.Visible = false
			Module.GUI.SantaChallenge.Confirm.Visible = true
		end;
	end);
	Module.GUI.SantaChallenge.Confirm.Confirm.MouseButton1Click:connect(function()
		if ChallengeDone >= 10 then
			Module.GUI.SantaChallenge.Confirm.Visible = false
			Module.GUI.SantaChallenge.Completed.Visible = true
			_G.PlayerData.SantasList2020 = "Completed"
			ChristmasEvents.ConfirmSantasChallenge:FireServer()
		end
	end)
end]]
function Module.OpenBox(Tokens)
	local Candies
	if Tokens == Module.Currency then
		Candies = 600
	else
		Candies = false
		if Tokens == Module.KeyName then
			Candies = 1
		end
	end
	if Candies <= (_G.PlayerData.Materials.Owned[Tokens] or 0) then
		_G.PlayerData.Materials.Owned[Tokens] = _G.PlayerData.Materials.Owned[Tokens] - Candies
		Module.GUI.Main.Visible = false
		_G.Process("Unboxing")
		local OpenedItem = game.ReplicatedStorage.Remotes.Shop.OpenCrate:InvokeServer("Halloween2021Box", "MysteryBox", Tokens)
		wait(0.75 - (time() - time()))
		Module.GameGUI.Processing.Visible = false
		if OpenedItem then
			game.ReplicatedStorage.Remotes.Shop.BoxController:Fire("Halloween2021Box", OpenedItem)
		end
	end
end
			

local LoginTextMissions = {
	Login = "Mission1", 
	Murderer = "Mission2", 
	Innocent = "Mission3"
}
local LoginNumberMissions = {
	Login = 0, 
	Murderer = 6, 
	Innocent = 4
}
local LoginToMission = {
	Mission1 = "Login", 
	Mission2 = "Murderer", 
	Mission3 = "Innocent"
}
return Module