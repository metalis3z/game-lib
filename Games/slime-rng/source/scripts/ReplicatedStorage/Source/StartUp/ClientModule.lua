local ReplicatedStorage = game:GetService("ReplicatedStorage")

local client = require(ReplicatedStorage.Packages.DataService).client
local SoundController = require(ReplicatedStorage.Source.Core.Platform.SoundController)
local AdminLuckServiceClient = require(ReplicatedStorage.Source.Features.Admin.AdminLuckServiceClient)
local AdminServiceClient = require(ReplicatedStorage.Source.Features.Admin.AdminServiceClient)
local BoostServiceClient = require(ReplicatedStorage.Source.Features.Boosts.BoostServiceClient)
local CodeServiceClient = require(ReplicatedStorage.Source.Features.Codes.CodeServiceClient)
local CraftingMachineServiceClient = require(ReplicatedStorage.Source.Features.Crafting.CraftingMachineServiceClient)
local RecipeInstanceServiceClient = require(ReplicatedStorage.Source.Features.Crafting.RecipeInstanceServiceClient)
local ConsoleControlsClient = require(ReplicatedStorage.Source.Features.Console.ConsoleControlsClient)
local CraftingServiceClient = require(ReplicatedStorage.Source.Features.Crafting.CraftingServiceClient)
local FriendsServiceClient = require(ReplicatedStorage.Source.Features.Friends.FriendsServiceClient)
local GameplayServiceClient = require(ReplicatedStorage.Source.Features.Gameplay.GameplayServiceClient)
local IndexServiceClient = require(ReplicatedStorage.Source.Features.Index.IndexServiceClient)
local InventoryServiceClient = require(ReplicatedStorage.Source.Features.Inventory.InventoryServiceClient)
local LikeGroupServiceClient = require(ReplicatedStorage.Source.Features.LikeGroup.LikeGroupServiceClient)
local LootServiceClient = require(ReplicatedStorage.Source.Features.Loot.LootServiceClient)
local LuckLadderServiceClient = require(ReplicatedStorage.Source.Features.LuckLadder.LuckLadderServiceClient)
local MultiplayerViewServiceClient = require(ReplicatedStorage.Source.Features.MultiplayerView.MultiplayerViewServiceClient)
local Products = require(ReplicatedStorage.Source.Features.Monetization.Modules.Products)
local MonetizationServiceClient = require(ReplicatedStorage.Source.Features.Monetization.MonetizationServiceClient)
local NotificationServiceClient = require(ReplicatedStorage.Source.Features.Notifications.NotificationServiceClient)
local OfflineEarningsServiceClient = require(ReplicatedStorage.Source.Features.OfflineEarnings.OfflineEarningsServiceClient)
local RebirthServiceClient = require(ReplicatedStorage.Source.Features.Rebirth.RebirthServiceClient)
local RollServiceClient = require(ReplicatedStorage.Source.Features.Roll.RollServiceClient)
local SettingInitializer = require(ReplicatedStorage.Source.Features.Settings.SettingInitializer)
local SettingsServiceClient = require(ReplicatedStorage.Source.Features.Settings.SettingsServiceClient)
local TutorialServiceClient = require(ReplicatedStorage.Source.Features.Tutorial.TutorialServiceClient)
local UpgradeServiceClient = require(ReplicatedStorage.Source.Features.Upgrades.UpgradeServiceClient)
local XpTransferMachineServiceClient = require(ReplicatedStorage.Source.Features.XpTransfer.XpTransferMachineServiceClient)
local XpTransferServiceClient = require(ReplicatedStorage.Source.Features.XpTransfer.XpTransferServiceClient)
local ZonesServiceClient = require(ReplicatedStorage.Source.Features.Zones.ZonesServiceClient)
local Sounds = require(ReplicatedStorage.Source.Game.AssetIds.Sounds)
local MountUI = require(script.Parent.MountUI)
local Menu = require(ReplicatedStorage.Source.Features.App.Components.Menu)
local AutoRejoinServiceClient = require(ReplicatedStorage.Source.Features.AutoRejoin.AutoRejoinServiceClient)
local LeaderboardServiceClient = require(ReplicatedStorage.Source.Features.Leaderboards.LeaderboardServiceClient)
local MonetizationSlice = require(ReplicatedStorage.Source.Features.Monetization.MonetizationSlice)
local SocialEventServiceClient = require(ReplicatedStorage.Source.Features.SocialEvents.SocialEventServiceClient)
local TitleServiceClient = require(ReplicatedStorage.Source.Features.Titles.TitleServiceClient)

task.spawn(function() client:init() end)

task.spawn(function()
	local getInitData = ReplicatedStorage:WaitForChild("GetInitData", 10)
	if not getInitData then return end
	local attempts = 0
	repeat
		task.wait(0.5)
		attempts += 1
		if not client._data then
			pcall(function() getInitData:InvokeServer() end)
		end
	until client._data or attempts >= 20
end)

client:waitForData()

local function spawnInit(fn)
	task.spawn(function()
		pcall(fn)
	end)
end

MonetizationServiceClient:init(Products)
MonetizationServiceClient.giftReceived:Connect(function(p1, p2)
	MonetizationSlice.giftReceivedData({ product = p1, giftData = p2 })
	Menu.setOpenedMenu("GiftReceivedMenu", true)
end)
AdminServiceClient:init()
SettingsServiceClient:init()
SettingInitializer:init()
spawnInit(function() TutorialServiceClient:init(TutorialServiceClient) end)
BoostServiceClient:init()
FriendsServiceClient:init()
LikeGroupServiceClient:init()
NotificationServiceClient:init()
LootServiceClient:init()
RebirthServiceClient:init()
OfflineEarningsServiceClient:init()
MountUI()

spawnInit(function() AdminLuckServiceClient:init() end)
spawnInit(function() LuckLadderServiceClient:init() end)
spawnInit(function() GameplayServiceClient:init() end)
spawnInit(function() MultiplayerViewServiceClient:init() end)
spawnInit(function() UpgradeServiceClient:init() end)
spawnInit(function() RollServiceClient:init() end)
spawnInit(function() InventoryServiceClient:init() end)
spawnInit(function() IndexServiceClient:init() end)
spawnInit(function() CraftingServiceClient:init() end)
spawnInit(function() XpTransferServiceClient:init() end)
spawnInit(function() RecipeInstanceServiceClient:init() end)
spawnInit(function() CraftingMachineServiceClient:init() end)
spawnInit(function() XpTransferMachineServiceClient:init() end)
spawnInit(function() ConsoleControlsClient:init() end)
spawnInit(function() ZonesServiceClient:init() end)
spawnInit(function() CodeServiceClient:init() end)
spawnInit(function() AutoRejoinServiceClient:init() end)
spawnInit(function() TitleServiceClient:init() end)
spawnInit(function() LeaderboardServiceClient:init() end)
spawnInit(function() SocialEventServiceClient:init() end)

for _, v in Sounds do
	for _, sound in v do
		SoundController:Load(sound)
	end
end
return {}