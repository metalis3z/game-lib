game.ReplicatedStorage.EntityInfo.HaltDamage.OnServerEvent:Connect(function(pl)
	if pl.Character:GetAttribute("CrucifixEnabled", true) then
		if pl.Character.Crucifix:GetAttribute("EternityDurability") == 1 then
			pl.Character.Crucifix:SetAttribute("EternityDurability", pl.Character.Crucifix:GetAttribute("EternityDurability") - 1)
			pl.Character.Humanoid.Health -= 100
			game.ReplicatedStorage.EntityInfo.DeathHint:FireClient(pl, {"You died to ...", "Crucifix?", "Its, Its Impossible! But..", "This crucifix has taken another side, side of evil", "Don't waste your entire eternity bar on the crucifix next time."}, "Yellow")
		else
			pl.Character.Crucifix:SetAttribute("EternityDurability", pl.Character.Crucifix:GetAttribute("EternityDurability") - 1)
			game.ReplicatedStorage.EntityInfo.CrucifixHaltJumpscare:FireClient(pl)
		end
	else
		pl.Character.Humanoid.Health -= 30
	end
end)

game.ReplicatedStorage.EntityInfo.HaltResult.OnServerEvent:Connect(function(pl)
	local module = require(game.ReplicatedStorage.ClientModules.Module_AdminPanel)

	if game.MarketplaceService:PlayerOwnsAsset(pl, module.gamepass_id) and pl.PlayerStats.AdminPanel.Value == true then
		return
	end
	local ach = "SurviveHalt"
	local p1_player = pl

	if game.Players[p1_player.Name].InGameStats.Achievements:FindFirstChild(ach) then
		local achive = game.Players[p1_player.Name].InGameStats.Achievements:FindFirstChild(ach)
		local req = require(game.ReplicatedStorage.Achievements)[ach]

		if achive.Value == false then
			achive.Value = true
			if not game:GetService("BadgeService"):UserHasBadgeAsync(p1_player.UserId, req.BadgeId) then
				game.ReplicatedStorage.EntityInfo.AchievementUnlock:FireClient(p1_player, ach)
				game:GetService("BadgeService"):AwardBadge(p1_player.UserId, req.BadgeId)
			end
		end

	end
end)