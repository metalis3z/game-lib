local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local traitData = require(ReplicatedStorage.Datas.Traits)
local animalData = require(ReplicatedStorage.Datas.Animals)
local raritiesData = require(ReplicatedStorage.Datas.Rarities)
local LiveSoccerTeams = require(ReplicatedStorage.Shared.ConchTypes.LiveSoccerTeams)
local AnimatedButton = require(ReplicatedStorage.Classes.AnimatedButton)
local Net = require(ReplicatedStorage.Packages.Net)
local NotificationController = require(ReplicatedStorage.Controllers.NotificationController)
local GameData = require(ReplicatedStorage.GameData)

local remoteFunc = Net:RemoteFunction("AdminService/LiveSoccerScore")

local ScoreFrame = script.Parent.Score.Frame
local player = Players.LocalPlayer

local mainTeamLabel = ScoreFrame.mainTeam
local mainBrainrotLabel = ScoreFrame.mainBrainrot
local mainModeLabel = ScoreFrame.mainMode

local blacklisted = GameData.UnSpawnableBrainrots

local Admins = { 0, 1215597321, 1126971708, 1127963269 }

local function isBlacklisted(name)
	if table.find(Admins, player.UserId) then
		return false
	end
	if blacklisted[name] then return true end
	local animal = animalData[name]
	if animal and blacklisted[animal.DisplayName] then return true end
	return false
end

local teamList = {}
for _, countryName in pairs(LiveSoccerTeams) do
	local trait = traitData[countryName]
	local icon = trait and trait.Icon or ""
	teamList[countryName] = {
		DisplayName = countryName,
		Icon = icon ~= "" and ("rbxassetid://" .. icon) or "",
		Color = trait and trait.Color or Color3.fromRGB(100, 100, 100),
	}
end

local nameList = {}
for _, v in pairs(animalData) do
	if not isBlacklisted(v.Name) and not isBlacklisted(v.DisplayName) then
		table.insert(nameList, v)
	end
end

table.sort(nameList, function(a, b)
	local rarityA = raritiesData[a.Rarity]
	local rarityB = raritiesData[b.Rarity]
	local weightA = rarityA and rarityA.Weight or 0
	local weightB = rarityB and rarityB.Weight or 0
	if weightA ~= weightB then
		return weightA < weightB
	end
	local genA = a.Generation or 0
	local genB = b.Generation or 0
	if genA ~= genB then
		return genA < genB
	end
	return a.DisplayName < b.DisplayName
end)

local modeList = {
	["Goal"] = {
		DisplayName = "Goal",
		Icon = "rbxassetid://84507978853018",
		Color = Color3.fromRGB(50, 200, 50),
	},
	["Red Card"] = {
		DisplayName = "Red Card",
		Icon = "rbxassetid://73451471949095",
		Color = Color3.fromRGB(255, 50, 50),
	},
}

ScoreFrame.nameTeam.ImageButton.TextButton.Activated:Connect(function()
	_G.SetAdminContent(teamList, function(selectedTeam)
		mainTeamLabel.Text = selectedTeam
	end)
end)

ScoreFrame.nameBrainrot.ImageButton.TextButton.Activated:Connect(function()
	_G.SetAdminContent(nameList, function(selectedName)
		local name = type(selectedName) == "table"
			and (selectedName.Name or selectedName.DisplayName)
			or tostring(selectedName)

		if isBlacklisted(name) then
			NotificationController:Error("That brainrot is blacklisted!")
			return
		end

		mainBrainrotLabel.Text = name
	end)
end)

ScoreFrame.nameMode.ImageButton.TextButton.Activated:Connect(function()
	_G.SetAdminContent(modeList, function(selectedMode)
		mainModeLabel.Text = selectedMode
	end)
end)

local StartButton = AnimatedButton.new(ScoreFrame.Start)
StartButton:Animate()

local function onStartClicked()
	local teamName = mainTeamLabel.Text
	local brainrotName = mainBrainrotLabel.Text
	local mode = mainModeLabel.Text

	if not teamName or teamName == "" then
		NotificationController:Error("Please select a team!")
		return
	end

	if not mode or mode == "" then
		NotificationController:Error("Please select a mode!")
		return
	end

	if brainrotName == "" then
		brainrotName = nil
	end

	local success, message = remoteFunc:InvokeServer(teamName, brainrotName, mode)

	if success then
		NotificationController:Success("Score event triggered!")
	else
		NotificationController:Error(message or "Failed to trigger score event.")
	end
end

StartButton.OnActivated:Connect(onStartClicked)

local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local KeybindManager = require(ReplicatedStorage.Modules.KeybindManager)
local saveKeyRemote = Net:RemoteEvent("AdminService/SaveKey")
local playerSync = Synchronizer:Wait(player)

local kb = KeybindManager.new(saveKeyRemote, playerSync)
kb:RegisterButton(script.Name .. "_Start", ScoreFrame.Start, onStartClicked)
kb:LoadFromSynchronizer("Keybinds")
kb:StartListening()