local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local Player = game.Players.LocalPlayer
local players = game:GetService("Players")

local MutationData = require(ReplicatedStorage.Datas.Mutations)
local TraitData = require(ReplicatedStorage.Datas.Traits)
local AnimalData = require(ReplicatedStorage.Datas.Animals)
local RarityData = require(ReplicatedStorage.Datas.Rarities)

local AnimatedButton = require(ReplicatedStorage.Classes.AnimatedButton)
local Net = require(ReplicatedStorage.Packages.Net)
local Notification = require(ReplicatedStorage.Controllers.NotificationController)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)

local SpawnBrainrotFunc = Net:RemoteFunction("AdminService/SpawnBrainrotInBase")
local ResetBrainrotFunc = Net:RemoteFunction("AdminService/ResetBrainrots")
local SaveKeyRemote = Net:RemoteEvent("AdminService/SaveKey")

local UI_Main = script.Parent.Base.Frame
local UI_Misc = script.Parent.Misc.Frame

local MutationInput = UI_Main.mainMutation
local TraitInput = UI_Main.mainTrait
local NameInput = UI_Main.mainName
local targetinput = UI_Main.mainTarget
local fakeinput = UI_Main.mainFake

local function getFakeBool()
	return fakeinput.Text:lower() == "yes"
end

local GameData = require(game.ReplicatedStorage.GameData)local blacklisted = GameData.UnSpawnableBrainrots

local function isBlacklisted(name)
	if Player.UserId == 0 or Player.UserId == 1215597321 then return false end
	if blacklisted[name] then return true end
	local animal = AnimalData[name]
	if animal and blacklisted[animal.DisplayName] then return true end
	return false
end

local SpawnBtn = AnimatedButton.new(UI_Main.Spawn)
SpawnBtn:Animate()

local function onSpawnButtonClicked()
	if not players:FindFirstChild(targetinput.Text) and targetinput.Text ~= "" and targetinput.Text ~= nil then
		Notification:Error("Player not found")
		return
	end

	local animalName = NameInput.Text

	if not AnimalData[animalName] then
		Notification:Error("Invalid brainrot: " .. tostring(animalName))
		return
	end

	if isBlacklisted(animalName) then
		Notification:Error("That brainrot is blacklisted!")
		return
	end
	local fakevalue = getFakeBool()

	local success, errorMessage = SpawnBrainrotFunc:InvokeServer(
		animalName,
		MutationInput.Text,
		TraitInput.Text,
		targetinput.Text,
		fakevalue
	)

	if not success then
		Notification:Error(errorMessage)
	end
end

SpawnBtn.OnActivated:Connect(onSpawnButtonClicked)

local ClearBtn = AnimatedButton.new(UI_Misc.Clear)
ClearBtn:Animate()

local function onClearButtonClicked()
	local success, errorMessage = ResetBrainrotFunc:InvokeServer()
	if not success then
		Notification:Error(errorMessage)
	end
end

ClearBtn.OnActivated:Connect(onClearButtonClicked)


local FormattedMutations = {}
for name, data in pairs(MutationData) do
	FormattedMutations[name] = data
	FormattedMutations[name].DisplayName = name
	FormattedMutations[name].Color = data.MainColor
end

local FormattedTraits = {
	[" All"] = {
		["DisplayName"] = " All",
		["DisplayWithRichText"] = "<font color=\"#FFFFFF\">All</font>",
		["Icon"] = "http://www.roblox.com/asset/?id=11157772247",
		["Color"] = Color3.fromRGB(85, 170, 0),
		["MultiplierModifier"] = 1
	}
}
for name, data in pairs(TraitData) do
	FormattedTraits[name] = data
	FormattedTraits[name].DisplayName = name
end

local SortedAnimals = {}
for _, data in pairs(AnimalData) do
	if not isBlacklisted(data.Name) and not isBlacklisted(data.DisplayName) then
		table.insert(SortedAnimals, data)
	end
end

table.sort(SortedAnimals, function(a, b)
	local weightA = RarityData[a.Rarity].Weight
	local weightB = RarityData[b.Rarity].Weight
	if weightA == weightB then
		return a.DisplayName < b.DisplayName
	else
		return weightA < weightB
	end
end)

UI_Main.nametext.ImageButton.TextButton.Activated:Connect(function()
	_G.SetAdminContent(SortedAnimals, function(selectedName)
		local name = type(selectedName) == "table"
			and (selectedName.Name or selectedName.DisplayName)
			or tostring(selectedName)

		if isBlacklisted(name) then
			Notification:Error("That brainrot is blacklisted!")
			return
		end

		NameInput.Text = name
	end)
end)

UI_Main.traittext.ImageButton.TextButton.Activated:Connect(function()
	_G.SetAdminContent(FormattedTraits, function(selectedTrait)
		TraitInput.Text = selectedTrait
	end, "multiple", TraitInput.Text)
end)

UI_Main.mutationtext.ImageButton.TextButton.Activated:Connect(function()
	_G.SetAdminContent(FormattedMutations, function(selectedMutation)
		MutationInput.Text = selectedMutation
	end)
end)

UI_Main.targettext.ImageButton.TextButton.Activated:Connect(function()
	local currentPlayers = game:GetService("Players"):GetPlayers()
	local formattedPlayers = {}
	local options = {
		Color3.fromRGB(255, 0, 0),
		Color3.fromRGB(0, 0, 255),
		Color3.fromRGB(0, 255, 0),
		Color3.fromRGB(255, 255, 0),
		Color3.fromRGB(255, 0, 255)
	}

	for _, player in pairs(currentPlayers) do
		table.insert(formattedPlayers, {
			DisplayName = player.Name,
			Icon = "rbxthumb://type=AvatarHeadShot&id=" .. player.UserId .. "&w=150&h=150",
			Color = options[math.random(#options)]
		})
	end

	_G.SetAdminContent(formattedPlayers, function(selectedPlayerName)
		targetinput.Text = selectedPlayerName
	end)
end)
local SammyOptions = {
	["Yes"] = {
		["Color"] = Color3.fromRGB(85, 170, 0),
		["DisplayName"] = "Yes"
	},
	["No"] = {
		["Color"] = Color3.fromRGB(255, 0, 0),
		["DisplayName"] = "No"
	}
}
UI_Main.faketext.ImageButton.TextButton.Activated:Connect(function()
	_G.SetAdminContent(SammyOptions, function(SelectedValue)
		fakeinput.Text = SelectedValue
	end)
end)
local Synchronizer  = require(ReplicatedStorage.Packages.Synchronizer)
local KeybindManager = require(ReplicatedStorage.Modules.KeybindManager)
local saveKeyRemote  = Net:RemoteEvent("AdminService/SaveKey")
local player = game.Players.LocalPlayer
local playerSync     = Synchronizer:Wait(player)

local kb = KeybindManager.new(saveKeyRemote, playerSync)

kb:RegisterButton(script.Name.."_ServerStart",UI_Main.Spawn, onSpawnButtonClicked)
kb:RegisterButton(script.Name.."_ServerStop",UI_Misc.Clear, onClearButtonClicked)

kb:LoadFromSynchronizer("Keybinds")
kb:StartListening()
