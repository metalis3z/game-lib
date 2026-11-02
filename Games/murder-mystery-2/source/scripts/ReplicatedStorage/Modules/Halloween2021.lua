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
local BattlePass = "Halloween2021Pass"
local GridCreator = require(game.ReplicatedStorage.Modules.GridCreator)
function Module.GenerateTiers(RewardObject, PageObject, PageObjectFunction, TierData)
	local PassDatabase = Database[BattlePass]
	GridCreator.CreatePass(PageObjectFunction, RewardObject, PassDatabase, Module.BattlePassFrame, PageObject)
	Module.YourTier.Text = "Your Tier: " .. _G.PlayerData.Halloween2021.CurrentTier
	local Tier = _G.PlayerData.Halloween2021.CurrentTier
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
		Frame.Next.Visible = _G.PlayerData.Halloween2021.CurrentTier + 1 == Tier
		Frame.Locked.Visible = _G.PlayerData.Halloween2021.CurrentTier < Tier
		Frame.Claim.Visible = false
		Frame.Enter.MouseButton1Click:connect(function()
			Module.GUI.BattlePassFrame.Visible = false
			Module.GUI.TravellerFrame.Visible = true
			if _G.PlayerData.Halloween2021.CurrentTier < Tier then
				Module.GUI.TravellerFrame.NotUnlocked.Visible = true
				Module.GUI.TravellerFrame.NotUnlocked.ResetAnimation:Fire()
				return
			end
			if not _G.PlayerData.Halloween2021.AncientClaimed then
				Module.GUI.TravellerFrame.NotUnlocked.Visible = false
				Module.GUI.TravellerFrame.Unlocked.Visible = true
				Module.GUI.TravellerFrame.Unlocked.ResetAnimation:Fire()
				return
			end
			if not _G.PlayerData.Halloween2021.RadioClaimed then
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
				Module.GUI.Main.Visible = false
				Frame.Claim.Visible = false
				if _G.PlayerData.Halloween2021.ClaimedRewards[TierReward] ~= true then
					Module.ClaimReward(TierReward)
				end
			end)
		end
	end
	Frame.Locked.Visible = _G.PlayerData.Halloween2021.CurrentTier < Tier
	Frame.Next.Visible = _G.PlayerData.Halloween2021.CurrentTier + 1 == Tier
	local Reward = false
	if Tier <= _G.PlayerData.Halloween2021.CurrentTier then
		Reward = not _G.PlayerData.Halloween2021.ClaimedRewards[TierReward] and Database[BattlePass].Rewards[TierReward] ~= nil
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
	local CurrentTier = _G.PlayerData.Halloween2021.CurrentTier
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
local HalloweenEvents = game.ReplicatedStorage.Halloween2021Events
function Module.BuyTiers()
	local TierToBuy = Module.CurrentTierBuy
	local PassCurrency = _G.PlayerData.Credits or 0
	local TierCost = Database[BattlePass].TierCost * TierToBuy
	if not (TierCost <= PassCurrency) then
		return false, TierCost - PassCurrency
	end
	HalloweenEvents.BuyTiers:FireServer(TierToBuy)
	_G.PlayerData.Credits = _G.PlayerData.Credits - TierCost
	_G.PlayerData.Halloween2021.CurrentTier = _G.PlayerData.Halloween2021.CurrentTier + TierToBuy
	Module.CurrentTierBuy = 1
	Module.ChangeBuyTiers(0)

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
		if not (tonumber(RewardString) <= _G.PlayerData.Halloween2021.CurrentTier) or _G.PlayerData.Halloween2021.ClaimedRewards[RewardType] == true then
			return
		end
	else
		return
	end
	_G.PlayerData.Halloween2021.ClaimedRewards[RewardString] = true
	if RewardType.ItemType == "Weapons" or RewardType.ItemType == "Pets" or RewardType.ItemType == "Materials" then
		local WeaponsOwned = _G.PlayerData[RewardType.ItemType].Owned[RewardData]
		_G.PlayerData[RewardType.ItemType].Owned[RewardData] = WeaponsOwned and WeaponsOwned + RewardType.Amount or RewardType.Amount
	else
		table.insert(_G.PlayerData[RewardType.ItemType].Owned, RewardData)
	end
	Module.GenerateTiers(Module.NewPassTierRewardObject, Module.NewPassPageObject, Module.PassTierRewardObjectFunction, true)
	HalloweenEvents.ClaimReward:FireServer(RewardData, RewardString, Type)
end
HalloweenEvents.UpdateGiftTool.OnClientEvent:Connect(function()
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
	Module.GUI.CandyDisplayBox.Text = "You have " .. GridCreator.Commafy(_G.PlayerData.Materials.Owned[Module.Currency]) .. " Candies"
	Module.GUI.PumpkinKeyDisplayBox.Text = "You have " .. GridCreator.Commafy(_G.PlayerData.Materials.Owned[Module.KeyName]) .. " Reaver Keys"
	Module.GUI.PumpkinKeyDisplayBox.Visible = (_G.PlayerData.Materials.Owned[Module.KeyName] or 0) > 0
	Module.GUI.BoxButtonKey.Visible = (_G.PlayerData.Materials.Owned[Module.KeyName] or 0) > 0
	if _G.PlayerData.Halloween2021.AncientClaimed == true then
		if _G.PlayerData.Halloween2021.RadioClaimed ~= true then
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
	--Module.GUI.TotalCandies.Text = "You have earned " .. Module.TotalCurrency + _G.EventCurrencyGained .. " candies total."
end
function Module.UpdateLeaderboard()
	local Player, Amount = HalloweenEvents.GetLeaderboard:InvokeServer()
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
		PlaceFrame.Container.TokenCount.Text = GridCreator.Commafy(BoardTokens.value) .. " Candies"
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
		local OpenedItem = game.ReplicatedStorage.Remotes.Shop.OpenCrate:InvokeServer("KnifeBox1", "MysteryBox", Tokens)
		wait(0.75 - (time() - time()))
		Module.GameGUI.Processing.Visible = false
		if OpenedItem then
			game.ReplicatedStorage.Remotes.Shop.BoxController:Fire("KnifeBox1", OpenedItem)
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