-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: SettingInitializer, time of decompilation: Sun May  3 10:11:55 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MusicPlayer = require(ReplicatedStorage.Source.Core.Platform.MusicPlayer)
local AnnouncementMessages = require(ReplicatedStorage.Source.Core.UI.Components.AnnouncementMessages)
local Sounds = require(ReplicatedStorage.Source.Game.AssetIds.Sounds)
local RollSlice = require(ReplicatedStorage.Source.Features.Roll.RollSlice)
local SettingsServiceClient = require(script.Parent.SettingsServiceClient)
local SettingsServiceUtils = require(script.Parent.SettingsServiceUtils)
local SettingsState = require(script.Parent.SettingsState)

return {
	initialized = false,
	musicPlayer = nil,
	init = function(p1) --[[ init ]] -- line: 18
		-- upvalues: SettingsState (copy), MusicPlayer (copy), Sounds (copy), SettingsServiceClient (copy), SettingsServiceUtils (copy), RollSlice (copy), AnnouncementMessages (copy)
		if p1.initialized then
			return
		end

		p1.initialized = true
		SettingsState.init()
		p1.musicPlayer = MusicPlayer.new(Sounds.music, {
			Name = "BackgroundMusic",
			StartingSong = 1
		})
		SettingsServiceClient:subscribe("music", function(b1: boolean) -- line: 30
			-- upvalues: p1 (copy)
			if not p1.musicPlayer then
				return
			end

			p1.musicPlayer:setEnabled(b1)
		end)
		SettingsServiceClient:subscribe("rareRollCutscenes", function(p2) -- line: 38
			-- upvalues: SettingsServiceUtils (copy), RollSlice (copy)
			if SettingsServiceUtils.getRareRollCutsceneThreshold(p2) ~= nil then
				return
			end

			RollSlice.actions.clearPendingRareRollCutscene()
		end)

		if SettingsState.get("luckOverrideEnabled") == true then
			task.defer(function() -- line: 47
				-- upvalues: AnnouncementMessages (copy)
				AnnouncementMessages.add("[WARNING] Luck override is ON in settings.\nTURN IT OFF UNLESS YOU WANT BAD SLIMES!", {
					Duration = 10,
					Color = Color3.fromRGB(255, 0, 0),
					Size = UDim2.new(1, 0, 0, 70),
					Position = UDim2.fromOffset(0, 100)
				})
			end)
		end
	end,
	getMusicPlayer = function(p3) --[[ getMusicPlayer ]] -- line: 61
		return p3.musicPlayer
	end
}
