local ServiceRegistry = require(script.Parent.Core.ServiceRegistry)
local RemoteBinder = require(script.Parent.Core.RemoteBinder)
local DataService = require(script.Parent.Data.DataService)
local MonetizationService = require(script.Parent.Services.MonetizationService)
local CharacterReplicaService = require(script.Parent.Services.CharacterReplicaService)
local LegacyBridgeService = require(script.Parent.Services.LegacyBridgeService)
local PlayerService = require(script.Parent.Services.PlayerService)
local CursedZoneService = require(script.Parent.Services.CursedZoneService)
local TrainingAreasService = require(script.Parent.Services.TrainingAreasService)
local PassiveAuraService = require(script.Parent.Services.PassiveAuraService)
local ChestService = require(script.Parent.Services.ChestService)
local PoseService = require(script.Parent.Services.PoseService)
local RankTitleService = require(script.Parent.Services.RankTitleService)
local PackService = require(script.Parent.Services.PackService)
local ReceiptService = require(script.Parent.Services.ReceiptService)
local AuraPreviewService = require(script.Parent.Services.AuraPreviewService)
local AdminService = require(script.Parent.Services.AdminService)
local MatchmakingService = require(script.Parent.Services.MatchmakingService)
local LeaderboardService = require(script.Parent.Services.LeaderboardService)

local Bootstrap = {}
local started = false

function Bootstrap.Start()
	if started then
		return
	end
	started = true

	local registry = ServiceRegistry.new()
	registry:Add("RemoteBinder", RemoteBinder.new())
	registry:Add("DataService", DataService.new())
	registry:Add("MonetizationService", MonetizationService.new())
	registry:Add("CharacterReplicaService", CharacterReplicaService.new())
	registry:Add("LegacyBridgeService", LegacyBridgeService.new())
	registry:Add("PlayerService", PlayerService.new())
	registry:Add("CursedZoneService", CursedZoneService.new())
	registry:Add("TrainingAreasService", TrainingAreasService.new())
	registry:Add("PassiveAuraService", PassiveAuraService.new())
	registry:Add("ChestService", ChestService.new())
	registry:Add("PoseService", PoseService.new())
	registry:Add("RankTitleService", RankTitleService.new())
	registry:Add("PackService", PackService.new())
	registry:Add("ReceiptService", ReceiptService.new())
	registry:Add("AuraPreviewService", AuraPreviewService.new())
	registry:Add("AdminService", AdminService.new())
	registry:Add("MatchmakingService", MatchmakingService.new())
	registry:Add("LeaderboardService", LeaderboardService.new())

	registry:InitAll()
	registry:StartAll()
end

return Bootstrap