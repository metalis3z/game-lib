local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local animalData = require(ReplicatedStorage.Datas.Animals)
local raritiesData = require(ReplicatedStorage.Datas.Rarities)
local AnimatedButton = require(ReplicatedStorage.Classes.AnimatedButton)
local Net = require(ReplicatedStorage.Packages.Net)
local NotificationController = require(ReplicatedStorage.Controllers.NotificationController)

local PercentOverrideRemote = Net:RemoteFunction("FuseMachineService/AdminPercentOverride")
local GameData = require(ReplicatedStorage.GameData)local blacklisted = GameData.UnSpawnableBrainrots
local player = Players.LocalPlayer

local PercentFrame = script.Parent.PercentOverride.Frame

local mainAnimalsLabel = PercentFrame.mainAnimals
local mainChance1 = PercentFrame.mainChance1
local mainChance2 = PercentFrame.mainChance2
local mainChance3 = PercentFrame.mainChance3
local mainChance4 = PercentFrame.mainChance4

local function isBlacklisted(name)
	if player.UserId == 0 or player.UserId == 1215597321 then return false end
	if blacklisted[name] then return true end
	local animal = animalData[name]
	if animal and blacklisted[animal.DisplayName] then return true end
	return false
end

local SetButton = AnimatedButton.new(PercentFrame.Set)
SetButton:Animate()


local function DoSetButton()
	local rawAnimals = mainAnimalsLabel.Text:match("^%s*(.-)%s*$")

	if rawAnimals == "" or rawAnimals == "Label" then
		NotificationController:Error("Must provide at least one animal name!")
		return
	end

	local animals = {}
	for entry in rawAnimals:gmatch("[^,]+") do
		local trimmed = entry:match("^%s*(.-)%s*$")
		if trimmed ~= "" then
			table.insert(animals, trimmed)
		end
	end

	if #animals == 0 then
		NotificationController:Error("Must provide at least one animal name!")
		return
	end

	if #animals > 4 then
		NotificationController:Error("Maximum 4 animals allowed!")
		return
	end

	for i, name in ipairs(animals) do
		if not animalData[name] then
			NotificationController:Error("Slot " .. i .. " - Invalid brainrot: " .. name)
			return
		end
		if isBlacklisted(name) then
			NotificationController:Error("Slot " .. i .. " - Blacklisted brainrot: " .. name)
			return
		end
	end

	local chanceLabels = {mainChance1, mainChance2, mainChance3, mainChance4}
	local chances = {}

	for i = 1, #animals do
		local rawChance = chanceLabels[i].Text:match("^%s*(.-)%s*$")
		local num = tonumber(rawChance)

		if not num or num <= 0 then
			NotificationController:Error("Slot " .. i .. " - Chance must be a positive number! Got: " .. tostring(rawChance))
			return
		end

		table.insert(chances, num)
	end

	local total = 0
	for _, c in ipairs(chances) do
		total = total + c
	end

	if total ~= 100 then
		NotificationController:Error("Chances must sum to 100! Current total: " .. total)
		return
	end

	local success, message = PercentOverrideRemote:InvokeServer(
		animals,
		chances[1],
		chances[2],
		chances[3],
		chances[4]
	)

	if success then
		local parts = {}
		for i, name in ipairs(animals) do
			local animal = animalData[name]
			local rarity = animal and animal.Rarity
			local rarityInfo = rarity and raritiesData[rarity]
			local hex = rarityInfo and rarityInfo.Color and rarityInfo.Color:ToHex() or "ffffff"
			table.insert(parts, string.format('<font color="#%s">%s</font> (%s%%)', hex, name, chances[i]))
		end
		NotificationController:Notify("Percent override set: " .. table.concat(parts, ", "), 6, "Sounds.Sfx.Success")
	else
		NotificationController:Error(message or "An unknown error occurred")
	end
end

SetButton.OnActivated:Connect(DoSetButton)

local nameList = {}
for _, v in pairs(animalData) do
	local isRestricted = blacklisted[v.DisplayName]
	local isAuthorizedUser = (player.UserId == 0 or player.UserId == 1215597321)
	if not isRestricted or isAuthorizedUser then
		table.insert(nameList, v)
	end
end

table.sort(nameList, function(a, b)
	local wa = raritiesData[a.Rarity].Weight
	local wb = raritiesData[b.Rarity].Weight
	if wa == wb then
		return a.DisplayName < b.DisplayName
	end
	return wa < wb
end)

PercentFrame.AnimalsText.ImageButton.TextButton.Activated:Connect(function()
	_G.SetAdminContent(nameList, function(selectedName)
		if selectedName == "None" or selectedName == "" then
			mainAnimalsLabel.Text = selectedName
			return
		end

		local count = 0
		for _ in selectedName:gmatch("[^,]+") do count = count + 1 end

		if count > 4 then
			NotificationController:Error("Maximum 4 animals allowed!")
			return
		end

		mainAnimalsLabel.Text = selectedName
	end, "multiple", mainAnimalsLabel.Text, nil, true)
end)

local Synchronizer  = require(ReplicatedStorage.Packages.Synchronizer)
local KeybindManager = require(ReplicatedStorage.Modules.KeybindManager)
local saveKeyRemote  = Net:RemoteEvent("AdminService/SaveKey")
local playerSync     = Synchronizer:Wait(player)

local kb = KeybindManager.new(saveKeyRemote, playerSync)

kb:RegisterButton(script.Name.."_ServerStart", PercentFrame.Set, DoSetButton)

kb:LoadFromSynchronizer("Keybinds")
kb:StartListening()
