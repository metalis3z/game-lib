local ReplicatedStorage = game:GetService("ReplicatedStorage")
local dataStoreService = game:GetService("DataStoreService")
local dataStore = dataStoreService:GetDataStore("Knobs")
local dataStor2e = dataStoreService:GetDataStore("DeathFigure")

local achimve = require(game.ReplicatedStorage.Achievements)

-- Created and Fixed by BUILDG Studios

game:GetService("Players").PlayerAdded:Connect(function(player)
	
	local gamefolder = Instance.new("Folder", player)
	gamefolder.Name = "InGameStats"
	
	-- About new
	
	local Achievements = Instance.new("Folder", gamefolder)
	Achievements.Name = "Achievements"
	
	for Module, value in pairs(achimve) do
		local Achievement = Instance.new("BoolValue")
		Achievement.Parent = Achievements
		Achievement.Name = Module
	end
	
	-- Old Stuff
	
	local FloorsEscaped = Instance.new("BoolValue", gamefolder)
	FloorsEscaped.Name = "FloorsEscaped"
	
	local DoorOpened = Instance.new("NumberValue", gamefolder)
	DoorOpened.Name = "DoorOpened"
	
	local SeekInCutsene = Instance.new("BoolValue", gamefolder)
	SeekInCutsene.Name = "SeekInCutsene"
	
	local FriendsInGame = Instance.new("NumberValue", gamefolder)
	FriendsInGame.Name = "FriendsInGame"
	
	local statsfolder = Instance.new("Folder", player)
	statsfolder.Name = "Stats"

	local itemfolder = Instance.new("Folder", player)
	itemfolder.Name = "Items"
	
	local lighter = Instance.new("BoolValue", itemfolder)
	lighter.Name = "Lighter"

	local Vitamins = Instance.new("BoolValue", itemfolder)
	Vitamins.Name = "Vitamins"

	local Lockpick = Instance.new("BoolValue", itemfolder)
	Lockpick.Name = "Lockpick"

	local Flashlight = Instance.new("BoolValue", itemfolder)
	Flashlight.Name = "Flashlight" -- StressMult
	
	local StressMult = Instance.new("NumberValue", statsfolder)
	StressMult.Name = "StressMult" -- StressMult	
	
	local DonateState = Instance.new("NumberValue", statsfolder)
	DonateState.Name = "DonateState" -- DonateState

	local BoostState = Instance.new("BoolValue", statsfolder)
	BoostState.Name = "BoostState" -- BoostState
	
	local HaltScore = Instance.new("NumberValue", statsfolder)
	HaltScore.Name = "HaltScore" -- HaltScore
	HaltScore.Value = 0
	
	
	local lighter = Instance.new("BoolValue", itemfolder)
	lighter.Name = "LighterBuyed"

	local Vitamins = Instance.new("BoolValue", itemfolder)
	Vitamins.Name = "VitaminsBuyed"

	local Lockpick = Instance.new("BoolValue", itemfolder)
	Lockpick.Name = "LockpickBuyed"

	local Flashlight = Instance.new("BoolValue", itemfolder)
	Flashlight.Name = "FlashlightBuyed"
	
	local gold = Instance.new("NumberValue", statsfolder)
	gold.Name = "Gold"	
	
	local Death = Instance.new("StringValue", statsfolder)
	Death.Name = "Death"
	
	local KnobsToEarn = Instance.new("BoolValue", statsfolder)
	KnobsToEarn.Name = "KnobsGiven"
	
	gold.Changed:Connect(function()
		ReplicatedStorage.Bricks.GetGold:FireClient(player, gold.Value)
	end)
	
	wait(5.5)
	
	if player.PlayerStats.TotalBoosts.Value >= 0 then
		player.PlayerStats.TotalBoosts.Value = player.PlayerStats.TotalBoosts.Value - 1
		BoostState.Value = true
	end
end)