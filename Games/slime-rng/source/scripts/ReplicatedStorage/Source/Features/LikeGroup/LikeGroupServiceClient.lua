-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: LikeGroupServiceClient, time of decompilation: Sun May  3 10:11:31 2026 ]]
local AvatarEditorService = game:GetService("AvatarEditorService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local client = require(ReplicatedStorage.Packages.DataService).client
local Networker = require(ReplicatedStorage.Packages.Networker)
local Vide = require(ReplicatedStorage.Packages.Vide)
local Menu = require(ReplicatedStorage.Source.Features.App.Components.Menu)
local LikeGroupServiceUtils = require(ReplicatedStorage.Source.Features.LikeGroup.LikeGroupServiceUtils)

return {
	init = function(p1) --[[ init ]] -- line: 12
		-- upvalues: Networker (copy), Vide (copy), client (copy), Menu (copy), AvatarEditorService (copy)
		p1.networker = Networker.client.new("LikeGroupService", p1)
		p1.luckActive = Vide.source(client:get("likeGroupLuckActive") or false)

		if p1.luckActiveChangedConn then
			p1.luckActiveChangedConn:Disconnect()
		end

		local v9 = 720 - client:get({
			"stats",
			"timePlayed"
		})

		if v9 > 0 then
			task.delay(v9, function() -- line: 21
				-- upvalues: Menu (copy)
				Menu.setOpenedMenu("likeGroupMenu", true)
			end)
		end

		local v10 = 1200 - client:get({
			"stats",
			"timePlayed"
		})

		if v10 > 0 then
			task.delay(v10, function() -- line: 28
				-- upvalues: AvatarEditorService (copy)
				pcall(function() -- line: 29
					-- upvalues: AvatarEditorService (copy)
					AvatarEditorService:PromptSetFavorite(92416421522960, Enum.AvatarItemType.Asset, true)
				end)
			end)
		end

		p1.luckActiveChangedConn = client:getChangedSignal("likeGroupLuckActive"):Connect(function(p2) -- line: 35
			-- upvalues: p1 (copy)
			p1.luckActive(p2 or false)
		end)
	end,
	hasLuckBonus = function(p3) --[[ hasLuckBonus ]] -- line: 40
		return p3.luckActive() or false
	end,
	getLuckBonus = function(p4) --[[ getLuckBonus ]] -- line: 44
		-- upvalues: LikeGroupServiceUtils (copy)
		return LikeGroupServiceUtils.getLuckBonus(p4:hasLuckBonus())
	end,
	getLuckActiveSource = function(p5) --[[ getLuckActiveSource ]] -- line: 48
		return p5.luckActive
	end,
	confirmPrompt = function(p6) --[[ confirmPrompt ]] -- line: 52
		p6.networker:fire("requestConfirmPrompt")
	end
}
