-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: AdminLuckServiceClient, time of decompilation: Sun May  3 10:12:19 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Networker = require(ReplicatedStorage.Packages.Networker)
local Signal = require(ReplicatedStorage.Packages.Signal)
local Vide = require(ReplicatedStorage.Packages.Vide)
local AnnouncementMessages = require(ReplicatedStorage.Source.Core.UI.Components.AnnouncementMessages)
local serverTimeSource = require(ReplicatedStorage.Source.Core.UI.Sources.serverTimeSource)
local AdminLuckServiceUtils = require(ReplicatedStorage.Source.Features.Admin.AdminLuckServiceUtils)
local Sounds = require(ReplicatedStorage.Source.Game.AssetIds.Sounds)

return {
	stateChanged = Signal.new(),
	state = Vide.source(AdminLuckServiceUtils.getDefaultState()),
	init = function(p1) --[[ init ]] -- line: 18
		-- upvalues: Networker (copy), AdminLuckServiceUtils (copy), serverTimeSource (copy), AnnouncementMessages (copy), Sounds (copy)
		p1.networker = Networker.client.new("AdminLuckService", p1)
		p1.state(AdminLuckServiceUtils.getDefaultState())
		p1:setState((p1.networker:fetch("getState")))

		local v10 = AdminLuckServiceUtils.getActiveAnnouncementMessage(p1:getState(), serverTimeSource())

		if v10 then
			AnnouncementMessages.add(v10, {
				Confetti = true,
				Color = Color3.fromRGB(80, 255, 170),
				Sound = Sounds.misc.serverBoost
			})
		end
	end,
	setState = function(p2, p3) --[[ setState ]] -- line: 35
		-- upvalues: AdminLuckServiceUtils (copy)
		local v13 = AdminLuckServiceUtils.reconcileState(p3)

		p2.state(v13)
		p2.stateChanged:Fire(v13)
	end,
	showAnnouncement = function(_, s1: string) --[[ showAnnouncement ]] -- line: 41
		-- upvalues: AnnouncementMessages (copy), Sounds (copy)
		if type(s1) ~= "string" or s1 == "" then
			return
		end

		AnnouncementMessages.add(s1, {
			Confetti = true,
			Color = Color3.fromRGB(80, 255, 170),
			Sound = Sounds.misc.serverBoost
		})
	end,
	getState = function(p5) --[[ getState ]] -- line: 53
		-- upvalues: AdminLuckServiceUtils (copy)
		local state = p5.state

		if not state then
			return AdminLuckServiceUtils.getDefaultState()
		end

		return AdminLuckServiceUtils.reconcileState(state())
	end,
	getCurrentMultiplier = function(p6) --[[ getCurrentMultiplier ]] -- line: 62
		-- upvalues: AdminLuckServiceUtils (copy), serverTimeSource (copy)
		return AdminLuckServiceUtils.getCurrentMultiplier(p6:getState(), serverTimeSource())
	end,
	getTimeRemaining = function(p7) --[[ getTimeRemaining ]] -- line: 66
		-- upvalues: AdminLuckServiceUtils (copy), serverTimeSource (copy)
		return AdminLuckServiceUtils.getTimeRemaining(p7:getState(), serverTimeSource())
	end,
	isActive = function(p8) --[[ isActive ]] -- line: 70
		-- upvalues: AdminLuckServiceUtils (copy), serverTimeSource (copy)
		return AdminLuckServiceUtils.isActive(p8:getState(), serverTimeSource())
	end,
	getDescription = function(p9) --[[ getDescription ]] -- line: 74
		-- upvalues: AdminLuckServiceUtils (copy), serverTimeSource (copy)
		return AdminLuckServiceUtils.getDescription(p9:getState(), serverTimeSource())
	end,
	getRollStatModifier = function(p10) --[[ getRollStatModifier ]] -- line: 78
		-- upvalues: AdminLuckServiceUtils (copy), serverTimeSource (copy)
		return AdminLuckServiceUtils.getRollStatModifier(p10:getState(), serverTimeSource())
	end
}
