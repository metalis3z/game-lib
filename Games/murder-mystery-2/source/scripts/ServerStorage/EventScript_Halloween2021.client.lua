local GameGUI = script.Parent.Parent.Game
local BattlePass = require(game.ReplicatedStorage.Modules.Halloween2021)
local Halloween2021Pass = game.ReplicatedStorage.GetSyncData:InvokeServer("Halloween2021Pass")
local MainGUI = GameGUI.Halloween2021
local BP = MainGUI.Frames.BattlePass
local BuyFrame = BP.BuyTiers.BuyFrame
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
local OpenCrate = require(script.OpenCrate)
local RarityColors = game.ReplicatedStorage.GetSyncData:InvokeServer("Rarity")
if not _G.EventCurrencyGained then
	_G.EventCurrencyGained = 0
end
BattlePass.GUI = MainGUI
BattlePass.GameGUI = GameGUI
BattlePass.BattlePassFrame = MainGUI.Frames.BattlePass.Pass
BattlePass.YourTier = MainGUI.Frames.BattlePass.YourTier.TierNumber
BattlePass.BuyTiersFrame = BP.BuyTiers.BuyFrame
BattlePass.Currency = "Candies"
BattlePass.KeyName = "ReaverKey"
_G.Windows.Frames[MainGUI] = true
_G.Windows.FrameNames.Halloween2021 = MainGUI
local Back = false
GameGUI.Level.Halloween2021.MouseButton1Click:connect(function()
	_G.Windows.ViewFrame(MainGUI)
	Back = false
end)
GameGUI.TabletLevel.Halloween2021.MouseButton1Click:connect(function()
	_G.Windows.ViewFrame(MainGUI)
	Back = false
end)
BP.BuyTiers.TierCost.CandyCost.CandyNumber.Text = Halloween2021Pass.TierCost
BP.BuyTiers.BuyFrame.CandyDisplay.Amount.Text = Halloween2021Pass.TierCost
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
	Challenges = MainGUI.Frames.Skeleton,
	OpenCrate = script.OpenCrate
}
local function ChangePage()
	BP.Left.Visible = BattlePass.CurrentPassPage > 0
	BP.Right.Visible = BattlePass.CurrentPassPage < Halloween2021Pass.TotalTiers / 5 - 1
end
BattlePass.GenerateTiers(script.Tier, script.Page, BattlePass.GenerateTierRewardPC)
ChangePage()
BP.Left.MouseButton1Click:connect(function()
	BattlePass.ChangePage(-1)
	ChangePage()
end)
BP.Right.MouseButton1Click:connect(function()
	BattlePass.ChangePage(1)
	ChangePage()
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
		local Candies, CandiesNeeded = BattlePass.BuyTiers()
		if not Candies then
			BuyFrame.MoreCandies.TextLabel.Text = "You need " .. CandiesNeeded .. " more candies"
			BuyFrame.MoreCandies.Visible = true
			wait(1)
			BuyFrame.MoreCandies.Visible = false
			return
		end
	else
		return
	end
	BuyFrame.Buy.Style = Enum.ButtonStyle.RobloxRoundButton
	ChangePage()
	wait(1)
	BuyFrame.Buy.Style = Enum.ButtonStyle.RobloxRoundDefaultButton
end)
for _, Frame in pairs(MainGUI.Frames.Menu.Container.List:GetChildren()) do
	if Frame:IsA("Frame") then
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
_G.ViewCandies = function()
	for _, Frame in pairs(MainGUI.Frames:GetChildren()) do
		Frame.Visible = Frame.Name == "CurrencyExchange"
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
local CurrencyExchange = MainGUI.Frames.CurrencyExchange
MainGUI.Back.MouseButton1Click:connect(function()
	if CurrencyExchange.Visible == true then
		CurrencyExchange.Visible = false
		MainGUI.Frames.Menu.Visible = true
		return
	end
	if MainGUI.Frames.Menu.Visible then
		if Back then
			_G.Windows.ViewFrame(GameGUI.Shop)
			return
		else
			MainGUI.Visible = false
			return
		end
	end
	if MainGUI.Frames.Traveller.Visible then
		MainGUI.Frames.Traveller.Visible = false
		BP.Visible = true
		return
	end
	if MainGUI.Frames.ItemPack.Visible and MainGUI.Frames.ItemPack.MoreInfo.Visible then
		MainGUI.Frames.ItemPack.MoreInfo.Visible = false
		MainGUI.Frames.ItemPack.Main.Visible = true
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
local HalloweenEvents = game.ReplicatedStorage.Halloween2021Events
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
		HalloweenEvents.BuyCandies:FireServer(Amount)
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
	HalloweenEvents.SellCandies:FireServer(Amount)
	SellCandies.Confirm.Text = "SELL"
	BuyWait = false
end)
local function UpdateExchangeAmounts()
	CurrencyExchange.Gems.Container.Amount.Text = GridCreator.Commafy(_G.PlayerData.Gems or 0)
	CurrencyExchange.Candies.Container.Amount.Text = GridCreator.Commafy(_G.PlayerData.Materials.Owned.Candies or 0)
	CurrencyExchange.Cash.Container.Amount.Text = GridCreator.Commafy(_G.PlayerData.Credits or 0)
end
UpdateExchangeAmounts()
PurchaseCurrency.Exchange.MouseButton1Click:connect(function()
	PurchaseCurrency.Visible = false
	CurrencyExchange.Visible = true
end)
for _, Container in pairs(PurchaseCurrency.Container:GetChildren()) do
	Container.MouseButton1Click:connect(function()
		game.ReplicatedStorage.PurchaseProduct:FireServer(Container.Name, "Candies")
	end)
end
MainGUI.Frames.Traveller.Unlocked.Confirm.MouseButton1Click:connect(function()
	if _G.PlayerData.Materials.Owned.Candies >= 80000 then
		_G.PlayerData.Halloween2021.AncientClaimed = true	
		HalloweenEvents.BuyEventAncient:FireServer()
		MainGUI.Frames.Traveller.Unlocked.Visible = false
		MainGUI.Frames.Traveller.Radio.Visible = true
		MainGUI.Frames.Traveller.Radio.ResetAnimation:Fire()
	end
end)
MainGUI.Frames.Traveller.Radio.Confirm.MouseButton1Click:connect(function()
	if _G.PlayerData.Materials.Owned.Candies >= 5000 then
		_G.PlayerData.Halloween2021.RadioClaimed = true
		HalloweenEvents.BuyHalloweenRadio:FireServer()
		MainGUI.Frames.Traveller.Unlocked.Visible = false
		MainGUI.Frames.Traveller.Radio.Visible = false
		MainGUI.Frames.Traveller.Completed.Visible = true
		MainGUI.Frames.Traveller.Completed.ResetAnimation:Fire()
	end
end)
if _G.PlayerData.Halloween2021.AncientClaimed == true then
	if _G.PlayerData.Halloween2021.RadioClaimed == true then
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
(function()
	for i, ItemData in pairs(Database.Crates.Hallow22.Contents) do
		if BoxContents:FindFirstChild("Item" .. i) then
			BoxContents["Item" .. i].Container.Icon.Image = GetImage(Database.Weapons[ItemData].Image)
			BoxContents["Item" .. i].Container.ItemName.Text = Database.Weapons[ItemData].ItemName
			BoxContents["Item" .. i].Container.ItemName.TextColor3 = RarityColors[Database.Weapons[ItemData].Rarity]
		end
	end
end)()
MainGUI.Frames.Box.Main.Contents.Open.MouseButton1Click:Connect(function()
	if _G.PlayerData.Materials.Owned["Candies"] and _G.PlayerData.Materials.Owned["Candies"] >= 100 then
		MainGUI.Visible = false
		_G.Process("Unboxing")
		local StartTime = time()
		local OpenedItem = game.ReplicatedStorage.Remotes.Shop.OpenCrate:InvokeServer("Hallow22")
		wait(0.75-(time()-StartTime))
		GameGUI.Processing.Visible = false
		if OpenedItem then
			OpenCrate("Hallow22", OpenedItem)
		end
	else
		MainGUI.Frames.Box.Visible = false
		MainGUI.Frames.CurrencyExchange.Visible = true
	end
end)
MainGUI.Frames.Box.Main.Contents.Open2.MouseButton1Click:Connect(function()
	if _G.PlayerData.Materials.Owned["ReaverKey"] and _G.PlayerData.Materials.Owned["ReaverKey"] >= 1 then
		MainGUI.Visible = false
		_G.Process("Unboxing")
		_G.Unboxing = true
		local StartTime = time()
		local OpenedItem = game.ReplicatedStorage.Remotes.Shop.OpenCrate:InvokeServer("Hallow22",false,false,false,true)
		wait(0.75-(time()-StartTime))
		GameGUI.Processing.Visible = false
		if OpenedItem then
			game.ReplicatedStorage.Remotes.Shop.BoxController:Fire("Hallow22",OpenedItem,false,"Weapons")
		end
	else
		_G.ViewBattlePass()
	end
end)
BoxContents.Parent.Parent.GetMore.MouseButton1Click:connect(function()
	MainGUI.Frames.Box.Visible = false
	MainGUI.Frames.CurrencyExchange.Visible = true
end)
MainGUI.Frames.ItemPack.Main.MoreInfo.MouseButton1Click:connect(function()
	MainGUI.Frames.ItemPack.Main.Visible = false
	MainGUI.Frames.ItemPack.MoreInfo.Visible = true
	MainGUI.Frames.ItemPack.MoreInfo.Completed.ResetAnimation:Fire()
end)
BattlePass.LeaderboardFrames = {
	Place1 = script.Place1, 
	Place2 = script.Place2, 
	Place3 = script.Place3, 
	Place = script.Place
}
MainGUI.Frames.ItemPack.MoreInfo.Completed.Confirm.MouseButton1Click:connect(function()
	MainGUI.Frames.ItemPack.Main.Visible = true
	MainGUI.Frames.ItemPack.MoreInfo.Visible = false
end)
MainGUI.Frames.ItemPack.Main.Buy.MouseButton1Click:connect(function()
	game.ReplicatedStorage.GetPack:FireServer(73942664)
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
PassTutorial.Visible = not _G.PlayerData.Halloween2021.Tutorial
for _, v in pairs(PassTutorial:GetDescendants()) do
	if v:IsA("TextButton") then
		v.MouseButton1Click:connect(function()
			TutorialFrame = TutorialFrame + 1
			if not PassTutorial:FindFirstChild("Frame" .. TutorialFrame) then
				_G.PlayerData.Halloween2021.Tutorial = true
				PassTutorial.Visible = false
				HalloweenEvents.Tutorial:FireServer()
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
end)
HalloweenEvents.OpenHalloweenMenu.OnClientEvent:connect(function()
	_G.Windows.ViewFrame(MainGUI)
	Back = false
end)