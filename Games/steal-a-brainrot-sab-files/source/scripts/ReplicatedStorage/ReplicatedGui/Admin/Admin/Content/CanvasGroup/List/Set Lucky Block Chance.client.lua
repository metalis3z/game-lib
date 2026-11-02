local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local AnimatedButton = require(ReplicatedStorage.Classes.AnimatedButton)
local raritiesData = require(ReplicatedStorage.Datas.Rarities)
local animalData = require(ReplicatedStorage.Datas.Animals)
local luckyBlocksData = require(ReplicatedStorage.Datas.LuckyBlocks)
local Net = require(ReplicatedStorage.Packages.Net)
local NotificationController = require(ReplicatedStorage.Controllers.NotificationController)

local SetLuckyBlockChanceRemote = Net:RemoteFunction("AdminService/SetLuckyBlockChance")
local SetLuckyBlockEvent = Net:RemoteEvent("AdminService/SetLuckyBlock")

local UI_Root = script.Parent.LuckyBlock.Frame
local mainNameLabel = UI_Root.mainName
local mainBrainrotLabel = UI_Root.mainBrainrot
local mainChanceLabel = UI_Root.mainChance

local gamedata = require(ReplicatedStorage.GameData)local blacklisted = gamedata.UnSpawnableBrainrots
local player = Players.LocalPlayer

local function isBlacklisted(name)
	if player.UserId == 0 or player.UserId == 1215597321 then return false end
	if blacklisted[name] then return true end

	local animal = animalData[name]
	if animal and blacklisted[animal.DisplayName] then return true end

	return false
end

local function sortByRarity(a, b)
	local weightA = raritiesData[a.Rarity].Weight
	local weightB = raritiesData[b.Rarity].Weight

	if weightA == weightB then
		return a.DisplayName < b.DisplayName
	end
	return weightA < weightB
end


local SyncLuckyBlockEvent = Net:RemoteEvent("SyncLuckyBlock")
SyncLuckyBlockEvent.OnClientEvent:Connect(function(data)
	local blockData = luckyBlocksData[data.LuckyBlock]
	if not blockData then return end

	local foundIndex = nil
	for i, animalEntry in ipairs(blockData.Animals) do
		if animalEntry.Name == data.Name then
			foundIndex = i
			break
		end
	end

	if data.Removed then
		if foundIndex then table.remove(blockData.Animals, foundIndex) end
	else
		if foundIndex then
			blockData.Animals[foundIndex].Chance = data.Chance
		else
			table.insert(blockData.Animals, { Name = data.Name, Chance = data.Chance })
		end
	end
end)


local SetButton = AnimatedButton.new(UI_Root.Set)
SetButton:Animate()

local function onSetButtonClicked()
	if not blacklisted then
		warn("Blacklist table is missing!")
		return
	end

	if isBlacklisted(mainNameLabel.Text) then
		NotificationController:Error("That lucky block is blacklisted!")
		return
	end

	if isBlacklisted(mainBrainrotLabel.Text) then
		NotificationController:Error("That brainrot is blacklisted!")
		return
	end

	if not animalData[mainBrainrotLabel.Text] then
		NotificationController:Error("Invalid brainrot: " .. mainBrainrotLabel.Text)
		return
	end

	local chance = tonumber(mainChanceLabel.Text)
	if not chance then
		NotificationController:Error("Chance must be a valid number!")
		return
	end
	local success, message = SetLuckyBlockChanceRemote:InvokeServer(
		mainNameLabel.Text,
		mainBrainrotLabel.Text,
		chance
	)
	if not success then
		NotificationController:Error(message or "Unknown Error")
	else
		NotificationController:Success("Successfully set chance!")
	end
end
SetButton.OnActivated:Connect(onSetButtonClicked)

local RemoveButton = AnimatedButton.new(UI_Root.RemoveButton)
RemoveButton:Animate()

local function onRemoveButtonClicked()
	local animalName = mainBrainrotLabel.Text

	if not blacklisted then
		warn("Blacklist table is missing!")
		return
	end

	if isBlacklisted(animalName) then
		NotificationController:Error("You can't modify blacklisted items!")
		return
	end

	if not animalData[animalName] then
		NotificationController:Error("Invalid brainrot: " .. animalName)
		return
	end

	local success, message = SetLuckyBlockChanceRemote:InvokeServer(
		mainNameLabel.Text,
		animalName,
		nil,
		true
	)
	if not success then NotificationController:Error(message) end
end
RemoveButton.OnActivated:Connect(onRemoveButtonClicked)


local luckyBlockList = {}
for _, animal in pairs(animalData) do
	if animal.LuckyBlock and not isBlacklisted(animal.Name) and not isBlacklisted(animal.DisplayName) then
		table.insert(luckyBlockList, animal)
	end
end
table.sort(luckyBlockList, sortByRarity)

UI_Root.nametext.ImageButton.TextButton.Activated:Connect(function()
	_G.SetAdminContent(luckyBlockList, function(selectedName)
		if isBlacklisted(selectedName) then
			NotificationController:Error("That lucky block is blacklisted!")
			return
		end
		mainNameLabel.Text = selectedName
	end)
end)

local animalList = {}
for _, animal in pairs(animalData) do
	if not isBlacklisted(animal.Name) and not isBlacklisted(animal.DisplayName) then
		table.insert(animalList, animal)
	end
end
table.sort(animalList, sortByRarity)

UI_Root.brainrottext.ImageButton.TextButton.Activated:Connect(function()
	_G.SetAdminContent(animalList, function(selectedAnimal)
		if isBlacklisted(selectedAnimal) then
			NotificationController:Error("That brainrot is blacklisted!")
			return
		end
		mainBrainrotLabel.Text = selectedAnimal
	end)
end)

local Synchronizer  = require(ReplicatedStorage.Packages.Synchronizer)
local KeybindManager = require(ReplicatedStorage.Modules.KeybindManager)
local saveKeyRemote  = Net:RemoteEvent("AdminService/SaveKey")
local player = game.Players.LocalPlayer
local playerSync     = Synchronizer:Wait(player)

local kb = KeybindManager.new(saveKeyRemote, playerSync)

kb:RegisterButton(script.Name.."_ServerStart",UI_Root.Set, onSetButtonClicked)
kb:RegisterButton(script.Name.."_ServerStop",UI_Root.RemoveButton, onRemoveButtonClicked)

kb:LoadFromSynchronizer("Keybinds")
kb:StartListening()
