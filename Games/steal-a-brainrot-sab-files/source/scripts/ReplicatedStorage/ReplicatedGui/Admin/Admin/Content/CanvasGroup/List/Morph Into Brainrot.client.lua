local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game.Players.LocalPlayer

local MutationsData = require(ReplicatedStorage.Datas.Mutations)
local TraitsData = require(ReplicatedStorage.Datas.Traits)
local AnimalsData = require(ReplicatedStorage.Datas.Animals)
local RaritiesData = require(ReplicatedStorage.Datas.Rarities)
local GameData = require(ReplicatedStorage.GameData)
require(ReplicatedStorage.Shared.Animals)

local AnimatedButton = require(ReplicatedStorage.Classes.AnimatedButton)
local Net = require(ReplicatedStorage.Packages.Net)
local NotificationController = require(ReplicatedStorage.Controllers.NotificationController)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local KeybindManager = require(ReplicatedStorage.Modules.KeybindManager)

local MorphRemote = Net:RemoteFunction("AdminService/Morph")
local UnmorphRemote = Net:RemoteFunction("AdminService/UnMorph")
local SaveKeyRemote = Net:RemoteEvent("AdminService/SaveKey")

local MorphFrame = script.Parent.Morph.Frame
local InputMutation = MorphFrame.mainMutation
local InputTrait = MorphFrame.mainTrait
local InputName = MorphFrame.mainName
local InputSpeed = MorphFrame.mainSpeed
local InputHead = MorphFrame.mainHead
local InputRoad = MorphFrame.mainRoad

local PlayerData = Synchronizer:Wait(Players)
assert(PlayerData)

for _, obj in pairs(workspace:GetDescendants()) do
	if obj:IsA("Model") and (obj:GetAttribute("Index") and obj:GetAttribute("NoOverhead") and obj.PrimaryPart) then
		obj.PrimaryPart:WaitForChild("Info"):WaitForChild("AnimalOverhead").Enabled = false
	end
end

workspace.DescendantAdded:Connect(function(obj)
	if obj:IsA("Model") and (obj:GetAttribute("Index") and obj:GetAttribute("NoOverhead") and obj.PrimaryPart) then
		obj.PrimaryPart:WaitForChild("Info"):WaitForChild("AnimalOverhead").Enabled = false
	end
end)

local function PerformMorph()
	local animalName = InputName.Text

	if GameData.UnSpawnableBrainrots and GameData.UnSpawnableBrainrots[animalName] then
		NotificationController:Error("You cannot morph into this brainrot.")
		return
	end

	local isRoad = (InputRoad.Text:lower() == "yes")

	local success, errorMessage = MorphRemote:InvokeServer(
		animalName, 
		InputMutation.Text, 
		InputTrait.Text, 
		InputSpeed.Text, 
		InputHead.Text,
		isRoad
	)

	if not success then
		NotificationController:Error(errorMessage)
	end
end

local function PerformUnmorph()
	local success, errorMessage = UnmorphRemote:InvokeServer()
	if not success then
		NotificationController:Error(errorMessage)
	end
end

local MorphBtn = AnimatedButton.new(MorphFrame.Morph)
MorphBtn:Animate()
MorphBtn.OnActivated:Connect(PerformMorph)

local UnmorphBtn = AnimatedButton.new(MorphFrame.Unmorph)
UnmorphBtn:Animate()
UnmorphBtn.OnActivated:Connect(PerformUnmorph)

local MutationList = {}
for name, data in pairs(MutationsData) do
	MutationList[name] = data
	MutationList[name].DisplayName = name
	MutationList[name].Color = data.MainColor
end

local TraitList = {
	[" All"] = {
		["DisplayName"] = " All",
		["DisplayWithRichText"] = "<font color=\"#FFFFFF\">All</font>",
		["Icon"] = "http://www.roblox.com/asset/?id=11157772247",
		["Color"] = Color3.fromRGB(85, 170, 0),
		["MultiplierModifier"] = 1
	}
}
for name, data in pairs(TraitsData) do
	TraitList[name] = data
	TraitList[name].DisplayName = name
end

local ToggleList = {
	["Yes"] = { Color = Color3.fromRGB(85, 170, 0), DisplayName = "Yes" },
	["No"] = { Color = Color3.fromRGB(255, 0, 0), DisplayName = "No" }
}

local SortedAnimals = {}
for _, animal in pairs(AnimalsData) do
	if not (GameData.UnSpawnableBrainrots and GameData.UnSpawnableBrainrots[animal.Name or animal.DisplayName]) then
		table.insert(SortedAnimals, animal)
	end
end

table.sort(SortedAnimals, function(a, b)
	local rarityA = RaritiesData[a.Rarity]
	local rarityB = RaritiesData[b.Rarity]
	local weightA = rarityA and rarityA.Weight or 0
	local weightB = rarityB and rarityB.Weight or 0
	return weightA == weightB and a.DisplayName < b.DisplayName or weightA < weightB
end)

MorphFrame.nametext.ImageButton.TextButton.Activated:Connect(function()
	_G.SetAdminContent(SortedAnimals, function(val) InputName.Text = val end)
end)

MorphFrame.traittext.ImageButton.TextButton.Activated:Connect(function()
	_G.SetAdminContent(TraitList, function(val) InputTrait.Text = val end, "multiple", InputTrait.Text)
end)

MorphFrame.mutationtext.ImageButton.TextButton.Activated:Connect(function()
	_G.SetAdminContent(MutationList, function(val) InputMutation.Text = val end)
end)

MorphFrame.speedtext.ImageButton.TextButton.Activated:Connect(function()
	_G.SetAdminContent(ToggleList, function(val) InputSpeed.Text = val end)
end)

MorphFrame.headText.ImageButton.TextButton.Activated:Connect(function()
	_G.SetAdminContent(ToggleList, function(val) InputHead.Text = val end)
end)

MorphFrame.RoadText.ImageButton.TextButton.Activated:Connect(function()
	_G.SetAdminContent(ToggleList, function(val) InputRoad.Text = val end)
end)

local kb = KeybindManager.new(SaveKeyRemote, PlayerData)

kb:RegisterButton(script.Name .. "_Morph", MorphFrame.Morph, PerformMorph)
kb:RegisterButton(script.Name .. "_Unmorph", MorphFrame.Unmorph, PerformUnmorph)

kb:LoadFromSynchronizer("Keybinds")
kb:StartListening()