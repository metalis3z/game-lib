-- LuckLadderServiceClient (Client ModuleScript)
-- Place: ReplicatedStorage > Source > Features > LuckLadder > LuckLadderServiceClient

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Networker = require(ReplicatedStorage.Packages.Networker)
local Signal = require(ReplicatedStorage.Packages.Signal)
local Vide = require(ReplicatedStorage.Packages.Vide)
local AnnouncementMessages = require(ReplicatedStorage.Source.Core.UI.Components.AnnouncementMessages)
local serverTimeSource = require(ReplicatedStorage.Source.Core.UI.Sources.serverTimeSource)
local LuckLadderServiceUtils = require(ReplicatedStorage.Source.Features.LuckLadder.LuckLadderServiceUtils)
local Sounds = require(ReplicatedStorage.Source.Game.AssetIds.Sounds)

-- Separate module-level signal so it doesn't collide with the "stateChanged" method key
local stateChangedSignal = Signal.new()

return {
	-- Public signal — other clients (RollServiceClient etc.) connect to this
	stateChanged = stateChangedSignal,

	init = function(p1)
		p1.networker = Networker.client.new("LuckLadderService", p1)
		p1.state = Vide.source(LuckLadderServiceUtils.getDefaultState())

		-- Fetch current state from server on join
		local initialState = p1.networker:fetch("getState")
		if initialState then
			local reconciled = LuckLadderServiceUtils.reconcileState(initialState)
			p1.state(reconciled)
			stateChangedSignal:Fire(reconciled)
		end

		-- Show active announcement if server luck is already running
		local v10 = LuckLadderServiceUtils.getActiveAnnouncementMessage(p1:getState(), serverTimeSource())
		if v10 then
			AnnouncementMessages.add(v10, {
				Confetti = true,
				Color = Color3.fromRGB(47, 255, 92),
				Sound = Sounds.misc.serverBoost,
			})
		end
	end,

	-- Called by Networker when server fires re:FireAllClients("stateChanged", newState)
	-- Key name MUST match the string the server passes to FireAllClients
	stateChanged = function(p2, p3)
		local reconciled = LuckLadderServiceUtils.reconcileState(p3)
		p2.state(reconciled)
		stateChangedSignal:Fire(reconciled)
	end,

	-- Called by Networker when server fires re:FireAllClients("announcement", message)
	announcement = function(_, s1: string)
		if type(s1) ~= "string" or s1 == "" then
			return
		end
		AnnouncementMessages.add(s1, {
			Confetti = true,
			Color = Color3.fromRGB(47, 255, 92),
			Sound = Sounds.misc.serverBoost,
		})
	end,

	-- ── State accessors ───────────────────────────────────────────────────────

	getState = function(p5)
		local state = p5.state
		if not state then
			return LuckLadderServiceUtils.getDefaultState()
		end
		return LuckLadderServiceUtils.reconcileState(state())
	end,

	getCurrentMultiplier = function(p6)
		return LuckLadderServiceUtils.getCurrentMultiplier(p6:getState(), serverTimeSource())
	end,

	getNextMultiplier = function(p7)
		return LuckLadderServiceUtils.getNextMultiplier(p7:getCurrentMultiplier())
	end,

	getTimeRemaining = function(p8)
		return LuckLadderServiceUtils.getTimeRemaining(p8:getState(), serverTimeSource())
	end,

	isActive = function(p9)
		return LuckLadderServiceUtils.isActive(p9:getState(), serverTimeSource())
	end,

	getRollStatModifier = function(p10)
		return LuckLadderServiceUtils.getRollStatModifier(p10:getState(), serverTimeSource())
	end,
}