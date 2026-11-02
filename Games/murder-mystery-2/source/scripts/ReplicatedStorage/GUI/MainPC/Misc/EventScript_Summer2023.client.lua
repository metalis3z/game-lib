local GameGUI = script.Parent.Parent.Game
local BattlePass = require(game.ReplicatedStorage.Modules.SummerModule)
local Christmas2021Pass = game.ReplicatedStorage.GetSyncData:InvokeServer("Summer2023Pass")
local MainGUI = GameGUI.Summer2023
local BP = MainGUI.Frames.BattlePass
local BuyFrame = BP.BuyTiers.BuyFrame
local GodlyShop = MainGUI.Frames.GodlyShop
local PurchaseCurrency = MainGUI.Frames.PurchaseCurrency
local GridCreator = require(game.ReplicatedStorage.Modules.GridCreator)
local Database = {
	Weapons = game.ReplicatedStorage.GetSyncData:InvokeServer("Item"), 
	Materials = game.ReplicatedStorage.GetSyncData:InvokeServer("Materials"), 
	Crates = game.ReplicatedStorage.GetSyncData:InvokeServer("MysteryBox")
}
local AssetURL = "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId="
local function GetImage(Image) 
	local Return
	if _G.Cache[Image] ~= nil then 
		return _G.Cache[Image]
	else
		local NewImage = (tonumber(Image) and AssetURL..Image) or Image 
		NewImage = NewImage .. "&bust="..math.random(1,10000)
		_G.Cache[Image] = NewImage
		return NewImage 
	end
end
local RarityColors = game.ReplicatedStorage.GetSyncData:InvokeServer("Rarity")
if not _G.EventCurrencyGained then
	_G.EventCurrencyGained = 0
end
BattlePass.GUI = MainGUI
BattlePass.BattlePassFrame = MainGUI.Frames.BattlePass.Pass
BattlePass.YourTier = MainGUI.Frames.BattlePass.YourTier.TierNumber
BattlePass.BuyTiersFrame = BP.BuyTiers.BuyFrame
BattlePass.Currency = "SummerTokens"
BattlePass.KeyName = "SnowKey2021"
local BoxName = "KnifeBox1";
_G.Windows.Frames[MainGUI] = true
_G.Windows.FrameNames.SummerBattlepass = MainGUI
for _, Frame in pairs(MainGUI:GetDescendants()) do
	if Frame.Name == "CurrencyIcon" then
		Frame.Parent.Image = "http://www.roblox.com/asset/?id=14263728218"
	end
end
local Back = false
GameGUI.Level.SummerButton.MouseButton1Click:connect(function()
	_G.Windows.ViewFrame(MainGUI)
	Back = false
end)
GameGUI.Shop.Main.Featured.Offers.Open.MouseButton1Click:Connect(function()
	_G.Windows.ViewFrame(MainGUI)
	Back = false
end)
BP.BuyTiers.TierCost.CandyCost.CandyNumber.Text = Christmas2021Pass.TierCost
BP.BuyTiers.BuyFrame.CandyDisplay.Amount.Text = Christmas2021Pass.TierCost
BattlePass.GUI = {
	Main = MainGUI, 
	CandyDisplay = BP.YourCandies.Container, 
	CandyDisplay2 = PurchaseCurrency.Candies.Container.Amount, 
	CandyDisplayBox = MainGUI.Frames.Box.Main.Contents.Keys, 
	PumpkinKeyDisplayBox = MainGUI.Frames.Box.Main.Contents.Keys2, 
	BoxButtonCandies = MainGUI.Frames.Box.Main.Contents.Open, 
	BoxButtonKey = MainGUI.Frames.Box.Main.Contents.Open2, 
	BattlePassFrame = MainGUI.Frames.BattlePass, 
	TravellerFrame = MainGUI.Frames.Traveller, 
}
BattlePass.GenerateTiers(script.Tier, script.Page, BattlePass.GenerateTierRewardPC)
BP.Left.Visible = BattlePass.CurrentPassPage > 0
BP.Right.Visible = BattlePass.CurrentPassPage < Christmas2021Pass.TotalTiers / 5 - 1
BP.Left.MouseButton1Click:connect(function()
	BattlePass.ChangePage(-1)
	BP.Left.Visible = BattlePass.CurrentPassPage > 0
	BP.Right.Visible = BattlePass.CurrentPassPage < Christmas2021Pass.TotalTiers / 5 - 1
end)
BP.Right.MouseButton1Click:connect(function()
	BattlePass.ChangePage(1)
	BP.Left.Visible = BattlePass.CurrentPassPage > 0
	BP.Right.Visible = BattlePass.CurrentPassPage < Christmas2021Pass.TotalTiers / 5 - 1
end)
BuyFrame.Plus1.MouseButton1Click:connect(function()
	BattlePass.ChangeBuyTiers(1)
end)
BuyFrame.Minus1.MouseButton1Click:connect(function()
	BattlePass.ChangeBuyTiers(-1)
end)
BuyFrame.Plus10.MouseButton1Click:connect(function()
	BattlePass.ChangeBuyTiers(10)
end)
BuyFrame.Minus10.MouseButton1Click:connect(function()
	BattlePass.ChangeBuyTiers(-10)
end)
local t = 0
BuyFrame.Buy.MouseButton1Click:connect(function()
	if time() - t >= 1 then
		t = time()
		local Tokens, TokensNeeded = BattlePass.BuyTiers()
		if not Tokens then
			BuyFrame.MoreCandies.TextLabel.Text = "You need " .. TokensNeeded .. " more summer tokens"
			BuyFrame.MoreCandies.Visible = true
			wait(1)
			BuyFrame.MoreCandies.Visible = false
			return
		end
	else
		return
	end
	BuyFrame.Buy.Style = Enum.ButtonStyle.RobloxRoundButton
	BP.Left.Visible = BattlePass.CurrentPassPage > 0
	BP.Right.Visible = BattlePass.CurrentPassPage < Christmas2021Pass.TotalTiers / 5 - 1
	wait(1)
	BuyFrame.Buy.Style = Enum.ButtonStyle.RobloxRoundDefaultButton
end)
for _, Frame in pairs(MainGUI.Frames.Menu.Container.List:GetChildren()) do
	if Frame:IsA("Frame") == true then
		Frame.Container.Button.MouseButton1Click:connect(function()
			for _, v in pairs(MainGUI.Frames:GetChildren()) do
				if Frame.Name == "MM2Shop" then
					MainGUI.Visible = false
					GameGUI.Shop.Visible = true
				else
					v.Visible = v.Name == Frame.Name
					MainGUI.Back.Visible = true
				end
			end
		end)
	end
end
local CurrencyExchange = MainGUI.Frames.CurrencyExchange
MainGUI.Back.MouseButton1Click:connect(function()
	if MainGUI.Frames.Menu.Visible then
		if Back then
			_G.Windows.ViewFrame(GameGUI.Shop)
			return
		else
			MainGUI.Visible = false
			return
		end
	end
	if MainGUI.Frames.Gifts.Visible then
		MainGUI.Frames.Gifts.Visible = false
		MainGUI.Frames.BoxMenu.Visible = true
		return
	end
	if MainGUI.Frames.Traveller.Visible then
		MainGUI.Frames.Traveller.Visible = false
		BP.Visible = true
		return
	end
	if CurrencyExchange.Visible == true then
		CurrencyExchange.Visible = false
		PurchaseCurrency.Visible = true
		return
	end
	for _, Frame in pairs(MainGUI.Frames:GetChildren()) do
		Frame.Visible = Frame.Name == "Menu"
	end
end)
BattlePass.UpdateCandies()
MainGUI.Close.MouseButton1Click:connect(function()
	for _, Frame in pairs(MainGUI.Frames:GetChildren()) do
		Frame.Visible = Frame.Name == "Menu"
	end
	MainGUI.Visible = false
end)
_G.ViewHalloweenBox = function()
	for _, Frame in pairs(MainGUI.Frames:GetChildren()) do
		Frame.Visible = Frame.Name == "Box"
	end
end
for _, Frame in pairs(MainGUI.Frames.BoxMenu:GetChildren()) do
	if Frame:IsA("Frame") then
		Frame.Container.Button.MouseButton1Click:connect(function()
			for _, v in pairs(MainGUI.Frames:GetChildren()) do
				v.Visible = v.Name == Frame.Name
				MainGUI.Back.Visible = true
			end
		end)
	end
end
local ChristmasEvents = game.ReplicatedStorage.Summer2023Events
MainGUI.Frames.Gifts.BoxIcon.Open.MouseButton1Click:connect(function()
	if (_G.PlayerData.SummerTokens or 0) >= 100 then
		_G.PlayerData.SummerTokens = _G.PlayerData.SummerTokens - 100
		_G.PlayerData.SummerGiftInventory = _G.PlayerData.SummerGiftInventory + 1
		ChristmasEvents.BuyGift:FireServer()
		_G.NewItem("GiftVisual", "You Got...", nil, "Materials")
		if game.Players.LocalPlayer.Character:FindFirstChild("GiftTool") or game.Players.LocalPlayer.Backpack:FindFirstChild("GiftTool") then
			return
		end
		local Gift = Instance.new("Tool", game.Players.LocalPlayer.Backpack)
		Gift.Name = "Loading Gifts..."
		game.ReplicatedStorage.GiftTool:Clone().Parent = game.Players.LocalPlayer.Backpack
		Gift:Destroy()
	end
end)
MainGUI.Frames.Gifts.BoxIcon.GetMore.MouseButton1Click:connect(function()
	MainGUI.Frames.Gifts.Visible = false
	MainGUI.Frames.PurchaseCurrency.Visible = true
end)
local GiftName = "SummerGiftsGiven"
MainGUI.Frames.Gifts.RewardIcon.Open.MouseButton1Click:connect(function()
	if (_G.PlayerData[GiftName] or 0) >= 100 then
		MainGUI.Frames.Gifts.RewardIcon.Open.Visible = false
		MainGUI.Frames.Gifts.RewardIcon.OpenComplete.Visible = true
		MainGUI.Frames.Gifts.RewardIcon.Completed.Visible = true
		ChristmasEvents.ClaimGiftReward:FireServer()
	end
end)
local OnMobile = false
if game:GetService("UserInputService").KeyboardEnabled == false then
	OnMobile = game:GetService("UserInputService").TouchEnabled == true
end
local BuyCandies = CurrencyExchange.BuyCandies
local function GemText()
	if not tonumber(BuyCandies.GemBox.Text) then
		BuyCandies.GemBox.Text = ""
		return
	end
	BuyCandies.GemBox.Text = math.floor(tonumber(BuyCandies.GemBox.Text))
	BuyCandies.CandyAmount.Text = tonumber(BuyCandies.GemBox.Text) * 10
end
if OnMobile then
	BuyCandies.GemBox.FocusLost:connect(GemText)
else
	BuyCandies.GemBox.Changed:connect(GemText)
end
local SellCandies = CurrencyExchange.SellCandies
local function CandiesText()
	if not tonumber(SellCandies.CandyBox.Text) then
		SellCandies.CandyBox.Text = ""
		return
	end
	SellCandies.CandyBox.Text = math.floor(tonumber(SellCandies.CandyBox.Text))
	SellCandies.CoinAmount.Text = tonumber(SellCandies.CandyBox.Text)
end
if OnMobile then
	SellCandies.CandyBox.FocusLost:connect(CandiesText)
else
	SellCandies.CandyBox.Changed:connect(CandiesText)
end
local BuyWait = false
BuyCandies.Confirm.MouseButton1Click:connect(function()
	if BuyWait then
		return
	end
	if tonumber(BuyCandies.GemBox.Text) <= _G.PlayerData.Gems then
		BuyWait = true
		local Amount = tonumber(BuyCandies.GemBox.Text)
		BuyCandies.GemBox.Text = 0
		BuyCandies.Confirm.Text = "Buying..."
		GemText()
		ChristmasEvents.BuyTokens:InvokeServer(Amount)
		BuyCandies.Confirm.Text = "BUY"
		BuyWait = false
		BattlePass.UpdateTotalCandies()
	end
end)
SellCandies.Confirm.MouseButton1Click:connect(function()
	if BuyWait then
		return
	end
	BuyWait = true
	local Amount = tonumber(SellCandies.CandyBox.Text)
	SellCandies.CandyBox.Text = 0
	SellCandies.Confirm.Text = "Selling..."
	CandiesText()
	ChristmasEvents.SellTokens:InvokeServer(Amount)
	SellCandies.Confirm.Text = "SELL"
	BuyWait = false
end)
local function GiveTool()
	if (_G.PlayerData.SummerGiftInventory or 0) >= 1 then
		if game.Players.LocalPlayer.Character:FindFirstChild("GiftTool") or game.Players.LocalPlayer.Backpack:FindFirstChild("GiftTool") then
			return
		end
		local Gift = Instance.new("Tool", game.Players.LocalPlayer.Backpack)
		Gift.Name = "Loading Gifts..."
		game.ReplicatedStorage.GiftTool:Clone().Parent = game.Players.LocalPlayer.Backpack
		Gift:Destroy()
	end
end
local function RemoveTool()
	if game.Players.LocalPlayer.Character:FindFirstChild("GiftTool") or game.Players.LocalPlayer.Backpack:FindFirstChild("GiftTool") and _G.PlayerData.SummerGiftInventory < 1 then
		game.Players.LocalPlayer.Backpack.GiftTool:Destroy()
	end
end
local function UpdateExchangeAmounts()
	CurrencyExchange.Candies.Container.Amount.Text = GridCreator.Commafy(_G.PlayerData.SummerTokens or 0)
	CurrencyExchange.Gems.Container.Amount.Text = GridCreator.Commafy(_G.PlayerData.Gems or 0)
	CurrencyExchange.Cash.Container.Amount.Text = GridCreator.Commafy(_G.PlayerData.Credits or 0)
end
GiveTool()
RemoveTool()
UpdateExchangeAmounts()
PurchaseCurrency.Exchange.MouseButton1Click:connect(function()
	PurchaseCurrency.Visible = false
	CurrencyExchange.Visible = true
end)
_G.ViewPurchaseCurrency = function()
	for _, Frame in pairs(MainGUI.Frames:GetChildren()) do
		Frame.Visible = Frame.Name == "PurchaseCurrency"
	end
	_G.Windows.ViewFrame(MainGUI)
	Back = false
end
_G.ViewBattlePass = function()
	for _, Frame in pairs(MainGUI.Frames:GetChildren()) do
		Frame.Visible = Frame.Name == "BattlePass"
	end
	_G.Windows.ViewFrame(MainGUI)
	Back = false
end
for _, Frame in pairs(PurchaseCurrency.Container:GetChildren()) do
	Frame.MouseButton1Click:connect(function()
		game.ReplicatedStorage.PurchaseProduct:FireServer(Frame.Name, "SummerTokens")
	end)
end
MainGUI.Frames.Traveller.Unlocked.Confirm.MouseButton1Click:connect(function()
	if _G.PlayerData.SummerTokens >= 25000 then
		_G.PlayerData.Summer2023.AncientClaimed = true
		ChristmasEvents.BuyEventAncient:FireServer()
		MainGUI.Frames.Traveller.Unlocked.Visible = false
		MainGUI.Frames.Traveller.Radio.Visible = true
		MainGUI.Frames.Traveller.Radio.ResetAnimation:Fire()
	end
end)
MainGUI.Frames.Traveller.Radio.Confirm.MouseButton1Click:connect(function()
	if _G.PlayerData.SummerTokens >= 10000 then
		_G.PlayerData.Summer2023.RadioClaimed = true
		ChristmasEvents.BuyEventRadio:FireServer()
		MainGUI.Frames.Traveller.Unlocked.Visible = false
		MainGUI.Frames.Traveller.Radio.Visible = false
		MainGUI.Frames.Traveller.Completed.Visible = true
		MainGUI.Frames.Traveller.Completed.ResetAnimation:Fire()
	end
end)
if _G.PlayerData.Summer2023.AncientClaimed == true then
	if _G.PlayerData.Summer2023.RadioClaimed == true then
		MainGUI.Frames.Traveller.NotUnlocked.Visible = false
		MainGUI.Frames.Traveller.Unlocked.Visible = false
		MainGUI.Frames.Traveller.Radio.Visible = false
		MainGUI.Frames.Traveller.Completed.Visible = true
	else
		MainGUI.Frames.Traveller.NotUnlocked.Visible = false
		MainGUI.Frames.Traveller.Unlocked.Visible = false
		MainGUI.Frames.Traveller.Radio.Visible = true
	end
end
local Details = MainGUI.Frames.Summer.Main.Challenge.WeaponDetails
local Weapons = MainGUI.Frames.Summer.Main.Challenge.Weapons
local ChallengesDone = 0
local ChallengeText = ""
local function UpdateSantaChallenges()
	ChallengesDone = 0
	for i = 1, 10 do
		local Frame = Weapons["Item" .. i]
		Frame.Container.Completed.Visible = false
		if _G.PlayerData.Weapons.Owned[Frame.Container.ItemID.Text] ~= nil then
			ChallengesDone = ChallengesDone + 1
			Frame.Container.Completed.Visible = true
		end
	end
end
local function UpdateSantaChallenges2()
	MainGUI.Frames.Summer.Main.Challenge.Complete.Progress.Text = ChallengesDone .. "/10 Weapons Owned"
	MainGUI.Frames.Summer.Main.Challenge.Complete.Confirm.Style = ChallengesDone < 10 and Enum.ButtonStyle.RobloxRoundButton or Enum.ButtonStyle.RobloxRoundDefaultButton
end
for i = 1, 10 do
	local Frame = Weapons["Item" .. i]
	if _G.PlayerData.Weapons.Owned[Frame.Container.ItemID.Text] ~= nil then
		ChallengesDone = ChallengesDone + 1
		Frame.Container.Completed.Visible = true
	end
	Frame.Container.ActionButton.MouseButton1Click:connect(function()
		Details.ItemFrame.Container.Icon.Image = Frame.Container.Icon.Image
		Details.ItemFrame.Container.ItemName.Text = Frame.Container.ItemName.Text
		Details.ItemFrame.Container.ItemName.TextColor3 = Frame.Container.ItemName.TextColor3
		Details.Visible = true
	end)
end

UpdateSantaChallenges2()

if not _G.PlayerData.Summer2023.ChallengeTutorial then
	MainGUI.Frames.Summer.Main.Challenge.Visible = false
	MainGUI.Frames.Summer.Main.Tutorial.Visible = true
end

MainGUI.Frames.Summer.Main.Tutorial.Confirm.MouseButton1Click:connect(function()
	MainGUI.Frames.Summer.Main.Challenge.Visible = true
	MainGUI.Frames.Summer.Main.Tutorial.Visible = false
	_G.PlayerData.Summer2023.ChallengeTutorial = true
	ChristmasEvents.CompleteChallengeTutorial:FireServer()
end)

if ChallengeText == "Completed" then
	MainGUI.Frames.Summer.Main.Challenge.Visible = false
	MainGUI.Frames.Summer.Main.Confirm.Visible = false
	MainGUI.Frames.Summer.Main.Tutorial.Visible = false
	MainGUI.Frames.Summer.Main.Completed.Visible = true
	_G.PlayerData.Summer2023.SantaChallengeCompleted = true;
end

if _G.PlayerData.Summer2023.SantasList == "Completed" then
	MainGUI.Frames.Summer.Main.Challenge.Visible = false
	MainGUI.Frames.Summer.Main.Confirm.Visible = false
	MainGUI.Frames.Summer.Main.Tutorial.Visible = false
	MainGUI.Frames.Summer.Main.Completed.Visible = true
end

MainGUI.Frames.Summer.Main.Challenge.Complete.Confirm.MouseButton1Click:connect(function()
	if ChallengesDone >= 10 then
		MainGUI.Frames.Summer.Main.Challenge.Visible = false
		MainGUI.Frames.Summer.Main.Confirm.Visible = true
	end
end)

MainGUI.Frames.Summer.Main.Confirm.Confirm.MouseButton1Click:connect(function()
	if ChallengesDone >= 10 then
		MainGUI.Frames.Summer.Main.Confirm.Visible = false
		MainGUI.Frames.Summer.Main.Completed.Visible = true
		_G.PlayerData.Summer2023.SantasList = "Completed"
		ChallengeText = "Completed"
		ChristmasEvents.ConfirmSantasChallenge:FireServer()
	end
end) 

Details.Description.Close.MouseButton1Click:connect(function()
	Details.Visible = false
end)

if _G.PlayerData.Summer2023.SantaChallengeCompleted or _G.PlayerData.Summer2023.SantasList == "Completed" then
	MainGUI.Frames.Summer.Main.Challenge.Visible = false
	MainGUI.Frames.Summer.Main.Confirm.Visible = false
	MainGUI.Frames.Summer.Main.Tutorial.Visible = false
	MainGUI.Frames.Summer.Main.Completed.Visible = true
end

game.ReplicatedStorage.UpdateDataClient.Event:connect(function()
	UpdateSantaChallenges()
	UpdateSantaChallenges2()
end)
MainGUI.Frames.GodlyShop.Mythical.BuyItem.MouseButton1Click:Connect(function()
	game:GetService("MarketplaceService"):PromptGamePassPurchase(game.Players.LocalPlayer, 220123321)
end)
--[[local TutorialFrame = 1
local PassTutorial = BP.Tutorial
PassTutorial.Visible = not _G.PlayerData.Summer2023.Tutorial
for _, v in pairs(PassTutorial:GetDescendants()) do
	if v:IsA("TextButton") then
		v.MouseButton1Click:connect(function()
			TutorialFrame = TutorialFrame + 1
			if not PassTutorial:FindFirstChild("Frame" .. TutorialFrame) then
				_G.PlayerData.Summer2023.Tutorial = true
				PassTutorial.Visible = false
				ChristmasEvents.Tutorial:FireServer()
				return
			end
			for _, Frame in pairs(PassTutorial:GetChildren()) do
				Frame.Visible = Frame.Name == "Frame" .. TutorialFrame
			end
		end)
	end
end--]]
game.ReplicatedStorage.UpdateDataClient.Event:connect(function()
	BattlePass.UpdateCandies()
	UpdateExchangeAmounts()
	GiveTool()
	RemoveTool()
end)
ChristmasEvents.OpenEventMenu.OnClientEvent:connect(function()
	_G.Windows.ViewFrame(MainGUI)
	Back = false
end)
spawn(function()
	while true do
		if _G.PlayerData.SummerGiftInventory >= 1 then
			GiveTool()
		end
		if _G.PlayerData.SummerGiftInventory < 1 then
			RemoveTool()
		end
		BattlePass.UpdateCandies()
		UpdateSantaChallenges()
		UpdateSantaChallenges2()
		wait(1)
	end
end)
