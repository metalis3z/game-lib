local GameGUI = script.Parent.Parent.Game
local BattlePass = require(game.ReplicatedStorage.Modules.Christmas2021)
local Christmas2021Pass = game.ReplicatedStorage.GetSyncData:InvokeServer("Christmas2021Pass")
local MainGUI = GameGUI.Christmas2021
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
BattlePass.Currency = "SnowTokens"
BattlePass.KeyName = "SnowKey2021"
local BoxName = "KnifeBox1";
_G.Windows.Frames[MainGUI] = true
_G.Windows.FrameNames.Christmas2021 = MainGUI
for _, Frame in pairs(MainGUI:GetDescendants()) do
	if Frame.Name == "CurrencyIcon" then
		Frame.Parent.Image = "http://www.roblox.com/asset/?id=4521691392"
	end
end
local Back = false
GameGUI.Level.Christmas2021.MouseButton1Click:connect(function()
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
	OpenCrate = script.OpenCrate
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
			BuyFrame.MoreCandies.TextLabel.Text = "You need " .. TokensNeeded .. " more tokens"
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
	if MainGUI.Frames.Box.Visible then
		MainGUI.Frames.Box.Visible = false
		MainGUI.Frames.BoxMenu.Visible = true
		return
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
local ChristmasEvents = game.ReplicatedStorage.Christmas2021Events
MainGUI.Frames.Gifts.BoxIcon.Open.MouseButton1Click:connect(function()
	if (_G.PlayerData.SnowTokens or 0) >= 1000 then
		_G.PlayerData.SnowTokens = _G.PlayerData.SnowTokens - 1000
		_G.PlayerData.GiftInventory2021 = _G.PlayerData.GiftInventory2021 + 1
		MainGUI.Visible = false
		_G.NewItem("GiftVisual", "You Got...", nil, "Materials")
		ChristmasEvents.BuyGift:FireServer()
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
local GiftName = "GiftsGiven2021"
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
	if (_G.PlayerData.GiftInventory2021 or 0) >= 1 then
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
	if game.Players.LocalPlayer.Character:FindFirstChild("GiftTool") or game.Players.LocalPlayer.Backpack:FindFirstChild("GiftTool") and _G.PlayerData.GiftInventory2021 < 1 then
		game.Players.LocalPlayer.Backpack.GiftTool:Destroy()
	end
end
local function UpdateExchangeAmounts()
	CurrencyExchange.Candies.Container.Amount.Text = GridCreator.Commafy(_G.PlayerData.SnowTokens or 0)
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
		game.ReplicatedStorage.PurchaseProduct:FireServer(Frame.Name, "SnowTokens")
	end)
end
MainGUI.Frames.Traveller.Unlocked.Confirm.MouseButton1Click:connect(function()
	if _G.PlayerData.SnowTokens >= 80000 then
		_G.PlayerData.Christmas2021.AncientClaimed = true
		ChristmasEvents.BuyEventAncient:FireServer()
		MainGUI.Frames.Traveller.Unlocked.Visible = false
		MainGUI.Frames.Traveller.Radio.Visible = true
		MainGUI.Frames.Traveller.Radio.ResetAnimation:Fire()
	end
end)
MainGUI.Frames.Traveller.Radio.Confirm.MouseButton1Click:connect(function()
	if _G.PlayerData.SnowTokens >= 5000 then
		_G.PlayerData.Christmas2021.RadioClaimed = true
		ChristmasEvents.BuyEventRadio:FireServer()
		MainGUI.Frames.Traveller.Unlocked.Visible = false
		MainGUI.Frames.Traveller.Radio.Visible = false
		MainGUI.Frames.Traveller.Completed.Visible = true
		MainGUI.Frames.Traveller.Completed.ResetAnimation:Fire()
	end
end)
if _G.PlayerData.Christmas2021.AncientClaimed == true then
	if _G.PlayerData.Christmas2021.RadioClaimed == true then
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
local BoxContents = MainGUI.Frames.Box.Main.Contents.Container;
local Remote = game.ReplicatedStorage;
local Remotes = Remote.Remotes;
(function()
	for i, ItemData in pairs(Database.Crates[BoxName].Contents) do
		if BoxContents:FindFirstChild("Item" .. i) then
			BoxContents["Item" .. i].Container.Icon.Image = GetImage(Database.Weapons[ItemData].Image)
			BoxContents["Item" .. i].Container.ItemName.Text = Database.Weapons[ItemData].ItemName
			BoxContents["Item" .. i].Container.ItemName.TextColor3 = RarityColors[Database.Weapons[ItemData].Rarity]
		end
	end
end)()
BoxContents.Parent.Open.Activated:Connect(function(Player)
	if _G.PlayerData.Credits and _G.PlayerData.Credits >= 0 then
		MainGUI.Visible = false
		_G.Process("Unboxing");
		local StartTime = time();
		local OpenedItem = Remotes.Shop.OpenCrate:InvokeServer(BoxName,true,false,false,false,false,false,false);
		wait( 0.75-(time()-StartTime));
		GameGUI.Processing.Visible = false
		game.ReplicatedStorage.Remotes.Shop.BoxController:Fire(BoxName,OpenedItem,false,"Weapons")
	end
end)
BoxContents.Parent.Parent.GetMore.MouseButton1Click:connect(function()
	MainGUI.Frames.Box.Visible = false
	MainGUI.Frames.PurchaseCurrency.Visible = true
end)
BattlePass.ConnectBox()
BattlePass.LeaderboardFrames = {
	Place1 = script.Place1, 
	Place2 = script.Place2, 
	Place3 = script.Place3, 
	Place = script.Place
}
MainGUI.Frames.Leaderboard.Tokens.MouseButton1Click:connect(function()
	MainGUI.Frames.Leaderboard.Contents.Tokens.Visible = true
	MainGUI.Frames.Leaderboard.Contents.Gifts.Visible = false
	MainGUI.Frames.Leaderboard.Tokens.Style = Enum.ButtonStyle.RobloxRoundDefaultButton
	MainGUI.Frames.Leaderboard.Gifts.Style = Enum.ButtonStyle.RobloxRoundButton
end)
MainGUI.Frames.Leaderboard.Gifts.MouseButton1Click:connect(function()
	MainGUI.Frames.Leaderboard.Contents.Tokens.Visible = false
	MainGUI.Frames.Leaderboard.Contents.Gifts.Visible = true
	MainGUI.Frames.Leaderboard.Tokens.Style = Enum.ButtonStyle.RobloxRoundButton
	MainGUI.Frames.Leaderboard.Gifts.Style = Enum.ButtonStyle.RobloxRoundDefaultButton
end)
MainGUI.Frames.ItemPack.Main.Buy.MouseButton1Click:connect(function()
	game.ReplicatedStorage.GetPack:FireServer(73937794)
end)
GodlyShop.Iceflake.BuyItem.MouseButton1Click:connect(function()
	game.ReplicatedStorage.GetPack:FireServer(73942920)
end)
GodlyShop.Icebeam.BuyItem.MouseButton1Click:connect(function()
	game.ReplicatedStorage.GetPack:FireServer(73943315)
end)
GodlyShop.Bundle.BuyItem.MouseButton1Click:connect(function()
	game.ReplicatedStorage.GetPack:FireServer(73943760)
end)
for _, Frame in pairs(GameGUI.Dock:GetChildren()) do
	if Frame:IsA("ImageButton") then
		Frame.MouseButton1Click:connect(function()
			if Frame.Name ~= "Shop" then
				MainGUI.Visible = false
			end
		end)
	end
end
local TutorialFrame = 1
local PassTutorial = BP.Tutorial
PassTutorial.Visible = not _G.PlayerData.Christmas2021.Tutorial
for _, v in pairs(PassTutorial:GetDescendants()) do
	if v:IsA("TextButton") then
		v.MouseButton1Click:connect(function()
			TutorialFrame = TutorialFrame + 1
			if not PassTutorial:FindFirstChild("Frame" .. TutorialFrame) then
				_G.PlayerData.Christmas2021.Tutorial = true
				PassTutorial.Visible = false
				ChristmasEvents.Tutorial:FireServer()
				return
			end
			for _, Frame in pairs(PassTutorial:GetChildren()) do
				Frame.Visible = Frame.Name == "Frame" .. TutorialFrame
			end
		end)
	end
end
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
