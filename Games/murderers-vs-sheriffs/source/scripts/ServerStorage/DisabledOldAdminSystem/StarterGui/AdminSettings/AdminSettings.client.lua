local ReplicatedStorage = game.ReplicatedStorage
local Parent = script.Parent
local Button = require(game.ReplicatedStorage.ClientServices.Button)
local Sync = require(game.ReplicatedStorage.Database.Sync)
local Players = game:GetService("Players")
local DataButtonsAndTextBoxes = Parent.Container.EventFrames.ScrollingFrame.ButtonsData
local GiveCoinsButton = Button.createButton(DataButtonsAndTextBoxes.GiveCoins)

GiveCoinsButton.clickEnd = function()
	local Event = game.ReplicatedStorage.Remotes.AdminSettings.GiveCurrency
	local PlayerName = DataButtonsAndTextBoxes.TextBoxPlayer.TextBox.Text
	local Amount = DataButtonsAndTextBoxes.TextBoxAmount.TextBox.Text
	local result = Event:InvokeServer(Players:FindFirstChild(PlayerName), Amount or 1, "Coins")
	
	DataButtonsAndTextBoxes.GiveCoins.Container.TextLabel.Text = result.message
	wait(3)
	DataButtonsAndTextBoxes.GiveCoins.Container.TextLabel.Text = "Give Coins"
end

local GiveGemsButton = Button.createButton(DataButtonsAndTextBoxes.GiveGems)
GiveGemsButton.clickEnd = function()
	local Event = game.ReplicatedStorage.Remotes.AdminSettings.GiveCurrency
	local PlayerName = DataButtonsAndTextBoxes.TextBoxPlayer.TextBox.Text
	local Amount = DataButtonsAndTextBoxes.TextBoxAmount.TextBox.Text
	local result = Event:InvokeServer(Players:FindFirstChild(PlayerName), Amount or 1, "Gems")
	
	DataButtonsAndTextBoxes.GiveGems.Container.TextLabel.Text = result.message
	wait(3)
	DataButtonsAndTextBoxes.GiveGems.Container.TextLabel.Text = "Give Gems"
end

local GiveItemButton = Button.createButton(DataButtonsAndTextBoxes.GiveItem)
GiveItemButton.clickEnd = function()
	local Event = game.ReplicatedStorage.Remotes.AdminSettings.GiveItem
	local PlayerName = DataButtonsAndTextBoxes.TextBoxPlayer.TextBox.Text
	local Amount = DataButtonsAndTextBoxes.TextBoxAmount.TextBox.Text
	local ItemName = DataButtonsAndTextBoxes.TextBoxItemName.TextBox.Text
	local result = Event:InvokeServer(Players:FindFirstChild(PlayerName), ItemName or "Whiteout", Amount or 1)
	
	DataButtonsAndTextBoxes.GiveItem.Container.TextLabel.Text = result.message
	wait(3)
	DataButtonsAndTextBoxes.GiveItem.Container.TextLabel.Text = "Give Item"
end

local GiveToyButton = Button.createButton(DataButtonsAndTextBoxes.GiveToy)
GiveToyButton.clickEnd = function()
	local Event = game.ReplicatedStorage.Remotes.AdminSettings.GiveToy
	local PlayerName = DataButtonsAndTextBoxes.TextBoxPlayer.TextBox.Text
	local Amount = DataButtonsAndTextBoxes.TextBoxAmount.TextBox.Text
	local ItemName = DataButtonsAndTextBoxes.TextBoxItemName.TextBox.Text
	local result = Event:InvokeServer(Players:FindFirstChild(PlayerName), ItemName or "Whiteout", Amount or 1)
	
	DataButtonsAndTextBoxes.GiveToy.Container.TextLabel.Text = result.message
	wait(3)
	DataButtonsAndTextBoxes.GiveToy.Container.TextLabel.Text = "Give Toy"
end

local function ResetMapsColor()
	for _, frameButton in ipairs(Parent.Container.EventFrames.ScrollingFrame.ButtonsGameplay2.Frame:GetChildren()) do
		if frameButton:IsA("Frame") and frameButton:FindFirstChild("Container") then
			frameButton.Container.Background.BackgroundColor3 = Color3.fromRGB(209, 66, 66)
			frameButton.Container.Shadow.BackgroundColor3 = Color3.fromRGB(99, 31, 31)
		end
	end
end

for MapID, MapData in pairs(Sync.Maps) do
	local Temp = script.ButtonFrame:Clone()
	Temp.Container.Icon.Image = MapData.MapImage
	Temp.Parent = Parent.Container.EventFrames.ScrollingFrame.ButtonsGameplay2.Frame
	
	local button = Button.createButton(Temp)
	button.clickEnd = function()
		local result = game.ReplicatedStorage.Remotes.AdminSettings.SetMap:InvokeServer(MapID)
		if result.exp then
			Parent.Container.EventFrames.ScrollingFrame.TitleGameplay2.Text = result.message
			wait(3)
			Parent.Container.EventFrames.ScrollingFrame.TitleGameplay2.Text = "Current Map:"
			return
		end
		Parent.Container.EventFrames.ScrollingFrame.TitleGameplay2.Text = "Current Map: " .. result.message
		ResetMapsColor()
		Temp.Container.Background.BackgroundColor3 = Color3.fromRGB(111, 255, 0)
		Temp.Container.Shadow.BackgroundColor3 = Color3.fromRGB(59, 131, 0)
	end
end

game.ReplicatedStorage.Remotes.Gameplay.LoadingMap.OnClientEvent:Connect(function() 
	ResetMapsColor()
	Parent.Container.EventFrames.ScrollingFrame.TitleGameplay2.Text = "Current Map:"	
end)

local GameplayButtons = Parent.Container.EventFrames.ScrollingFrame.ButtonsGameplay.Frame
local GiveGunButton = Button.createButton(GameplayButtons.GiveGun)
GiveGunButton.clickEnd = function()
	local TextBoxPlr = Parent.Container.EventFrames.ScrollingFrame.ButtonsGameplay.TextBoxPlayer.TextBox.Text
	local Event = game.ReplicatedStorage.Remotes.AdminSettings.GiveWeapon
	local result = Event:InvokeServer(Players:FindFirstChild(TextBoxPlr), "Gun")	
	
	GameplayButtons.GiveGun.Container.TextLabel.Text = result.message
	wait(3)
	GameplayButtons.GiveGun.Container.TextLabel.Text = "Give Gun"
end

local GiveKnifeButton = Button.createButton(GameplayButtons.GiveKnife)
GiveKnifeButton.clickEnd = function()
	local TextBoxPlr = Parent.Container.EventFrames.ScrollingFrame.ButtonsGameplay.TextBoxPlayer.TextBox.Text
	local Event = game.ReplicatedStorage.Remotes.AdminSettings.GiveWeapon
	local result = Event:InvokeServer(Players:FindFirstChild(TextBoxPlr), "Knife")	
	
	GameplayButtons.GiveKnife.Container.TextLabel.Text = result.message
	wait(3)
	GameplayButtons.GiveKnife.Container.TextLabel.Text = "Give Knife"
end

local EndRoundButton = Button.createButton(GameplayButtons.EndRound)
EndRoundButton.clickEnd = function()
	local Event = game.ReplicatedStorage.Remotes.AdminSettings.GiveWeapon
	local result = Event:InvokeServer()	
end

local BecomeAMurderer = Button.createButton(GameplayButtons.BecomeAMurderer)
BecomeAMurderer.clickEnd = function()
	local TextBoxPlr = Parent.Container.EventFrames.ScrollingFrame.ButtonsGameplay.TextBoxPlayer.TextBox.Text
	local Event = game.ReplicatedStorage.Remotes.AdminSettings.BecomeARole
	local result = Event:InvokeServer(Players:FindFirstChild(TextBoxPlr), "Murderer")
	
	GameplayButtons.BecomeAMurderer.Container.TextLabel.Text = result.message
	wait(3)
	GameplayButtons.BecomeAMurderer.Container.TextLabel.Text = "Become a Murderer"
end

local BecomeASheriff = Button.createButton(GameplayButtons.BecomeASheriff)
BecomeASheriff.clickEnd = function()
	local TextBoxPlr = Parent.Container.EventFrames.ScrollingFrame.ButtonsGameplay.TextBoxPlayer.TextBox.Text
	local Event = game.ReplicatedStorage.Remotes.AdminSettings.BecomeARole
	local result = Event:InvokeServer(Players:FindFirstChild(TextBoxPlr), "Sheriff")
	
	GameplayButtons.BecomeASheriff.Container.TextLabel.Text = result.message
	wait(3)
	GameplayButtons.BecomeASheriff.Container.TextLabel.Text = "Become a Sheriff"
end

local CloseButton = Button.createButton(Parent.Container.Title.Close)
CloseButton.clickEnd = function()
	Parent.Visible = false
end

require(ReplicatedStorage.Modules.WindowService):RegisterFrame(Parent, "AdminSettings")

--// Fixed By @PlayFede