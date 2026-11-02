-- Server entry point.
--
-- The original server scripts did not survive the dump; this rebuilds them against the
-- contract the surviving client expects. Shared modules that run on both sides
-- (CONSTANTS, EnumBuilder, ReplicatedClass) are used as they are.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Modules = ReplicatedStorage:WaitForChild("Modules")
local Server = ServerScriptService:WaitForChild("Server")

require(Server.LogTap).Start()

-- Re-uploaded animation ids (ServerStorage.AnimationOverrides), visible to clients before they load.
require(Modules:WaitForChild("AnimationOverrides")).Publish()
-- Replacement sound ids (ServerStorage.SoundOverrides), likewise.
require(Modules:WaitForChild("SoundOverrides")).Publish()

local RemoteFallbacks = require(Server.RemoteFallbacks)

-- Answers RequestConstants; the client's CONSTANTS.INIT is the first thing it asks for.
require(Modules:WaitForChild("CONSTANTS")).INIT()
-- Builds the enums both sides encode replication with.
require(Modules:WaitForChild("EnumBuilder"))

local PlayerDataService = require(Server.PlayerDataService)
local PlayerService = require(Server.PlayerService)
local MiscService = require(Server.MiscService)
local FighterService = require(Server.FighterService)
local EquipmentService = require(Server.EquipmentService)
local DebugService = require(Server.DebugService)
local RewardService = require(Server.RewardService)
local TaskService = require(Server.TaskService)
local ShopService = require(Server.ShopService)
local ClaimService = require(Server.ClaimService)
local DailyService = require(Server.DailyService)
local EnemyService = require(Server.EnemyService)
local ItemService = require(Server.ItemService)
local ShootingRangeService = require(Server.ShootingRangeService)
local LeaderboardService = require(Server.LeaderboardService)
local DuelService = require(Server.DuelService)
local QueuePadService = require(Server.QueuePadService)
local AdminPanelService = require(Server.AdminPanelService)

-- Everything that listens to PlayerDataService.Loaded starts before it.
PlayerService.Start()
DebugService.Start()
TaskService.Start()
DailyService.Start()
PlayerDataService.Start()
MiscService.Start()
FighterService.Start()
EquipmentService.Start()
RewardService.Start()
ShopService.Start()
ClaimService.Start()
EnemyService.Start()
ItemService.Start()
ShootingRangeService.Start()
LeaderboardService.Start()
DuelService.Start()
QueuePadService.Start()
-- ReplicatedStorage.AdminPanelRemote (outside Remotes, so RemoteFallbacks never sees it)
AdminPanelService.Start()

RemoteFallbacks.MarkHandled(FighterService.Collection.RequestRemote)
RemoteFallbacks.MarkHandled(EnemyService.Collection.RequestRemote)
RemoteFallbacks.MarkHandled(QueuePadService.Collection.RequestRemote)
RemoteFallbacks.MarkHandled(DuelService.Collection.RequestRemote)

for _, service in { MiscService, EquipmentService, DebugService, RewardService, ShopService, ClaimService, ShootingRangeService, FighterService, ItemService, LeaderboardService, DuelService, QueuePadService } do
	for _, remote in service.Remotes do
		RemoteFallbacks.MarkHandled(remote)
	end
end

local Remotes = ReplicatedStorage.Remotes
for _, remote in {
	Remotes.Misc.RequestConstants,
	Remotes.Data.RequestPlayerData,
	Remotes.Data.ChangeSettings,
	Remotes.Data.SwitchSettingsProfile,
	Remotes.Data.DefaultSettings,
	Remotes.Data.LoadingScreenDone,
} do
	RemoteFallbacks.MarkHandled(remote)
end

-- Last: answers whatever no service above has taken over.
RemoteFallbacks.Start()

print("[Server] online")
