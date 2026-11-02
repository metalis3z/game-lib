local ReplicatedStorage = game.ReplicatedStorage
local Parent = script.Parent
local Button = require(game.ReplicatedStorage.ClientServices.Button)
local Sync = require(game.ReplicatedStorage.Database.Sync)
local Players = game:GetService("Players")
local MapTextBox = script.Parent.Container.EventFrames.ScrollingFrame.ButtonsGameplay.TextBoxMap
local ConfirmButton = script.Parent.Container.EventFrames.ScrollingFrame.ButtonsGameplay.Frame.SetMap

Button.createButton(ConfirmButton, function()
	local typedMap = MapTextBox.TextBox.Text
	if typedMap == "" then return end
	
	local Event = game.ReplicatedStorage.Remotes.Admin.SetMap
	local result = Event:InvokeServer(typedMap)
	ConfirmButton.Container.TextLabel.Text = result.message
	
	if result.exp == false then
		MapTextBox.BackgroundColor3 = Color3.fromRGB(111, 255, 0)
	else
		MapTextBox.BackgroundColor3 = Color3.fromRGB(255, 111, 111)
	end
end)

local GameplayButtons = Parent.Container.EventFrames.ScrollingFrame.ButtonsGameplay.Frame
local BecomeAMurderer = Button.createButton(GameplayButtons.BecomeAMurderer)
BecomeAMurderer.clickEnd = function()
	local TextBoxPlr = Parent.Container.EventFrames.ScrollingFrame.ButtonsGameplay.TextBoxPlayer.TextBox.Text
	local Event = game.ReplicatedStorage.Remotes.Admin.BecomeRole
	local result = Event:InvokeServer(Players:FindFirstChild(TextBoxPlr), "Murderer")
	GameplayButtons.BecomeAMurderer.Container.TextLabel.Text = result.message
	wait(3)
	GameplayButtons.BecomeAMurderer.Container.TextLabel.Text = "Become a Murderer"
end

local BecomeASheriff = Button.createButton(GameplayButtons.BecomeASheriff)
BecomeASheriff.clickEnd = function()
	local TextBoxPlr = Parent.Container.EventFrames.ScrollingFrame.ButtonsGameplay.TextBoxPlayer.TextBox.Text
	local Event = game.ReplicatedStorage.Remotes.Admin.BecomeRole
	local result = Event:InvokeServer(Players:FindFirstChild(TextBoxPlr), "Sheriff")
	GameplayButtons.BecomeASheriff.Container.TextLabel.Text = result.message
	wait(3)
	GameplayButtons.BecomeASheriff.Container.TextLabel.Text = "Become a Sheriff"
end

local CloseButton = Button.createButton(Parent.Container.Title.Close)
CloseButton.clickEnd = function()
	Parent.Visible = false
end

require(ReplicatedStorage.Modules.WindowService):RegisterFrame(Parent, "AdminGGSettings")

--// Fixed By @PlayFede