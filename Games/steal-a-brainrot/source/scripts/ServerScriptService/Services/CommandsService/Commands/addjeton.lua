local module = function(Conch, Config)
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local ServerScriptService = game:GetService("ServerScriptService")
	local Players = game:GetService("Players")
	local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
	local NotificationService = require(ServerScriptService.Services.NotificationService)

	local MSG_TYPE = "AddJetonAnnounce"

	-- Handler pour broadcaster l'annonce sur tous les serveurs
	if not _G._AddJeton_sub then
		_G._AddJeton_sub = true
		task.spawn(function()
			while not _G.MessagingHub do task.wait(0.5) end
			_G.MessagingHub.Register(MSG_TYPE, function(data)
				if type(data) ~= "table" then return end
				local targetName = data.playerName
				local text = data.text
				if not targetName or not text then return end
				local target = Players:FindFirstChild(targetName)
				if target then
					NotificationService.Notify(target, text, 6, "Sounds.Sfx.Blop", "Top")
				end
			end)
		end)
	end

	Conch.register("addjeton", {
		permissions = { Config.RequiredRole or "super-user" },

		arguments = function()
			return
				{
					kind = "argument",
					type = "player",
					name = "Player",
				},
				{
					kind = "argument",
					type = "number",
					name = "Amount",
				}
		end,

		callback = function(player, amount)
			if not player or not player:IsA("Player") then
				return false, "Joueur invalide"
				end

			amount = tonumber(amount) or 1

			local playerChannel = Synchronizer:Get(player)
			if not playerChannel then
				return false, "Player channel not found"
				end

			-- Ajouter les jetons pour le Fyrko Jackpot (JungleMachine)
			local currentJetons = playerChannel:Get("JungleMachineJetons") or 0
			playerChannel:Set("JungleMachineJetons", currentJetons + amount)

			-- Annonce au joueur
			local announceText = string.format(
				"🎰 <b>badr & Zynna</b> give you <b>%d jeton%s</b> for <b> Jackpot</b> !",
				amount, amount > 1 and "s" or ""
			)

			-- Envoyer en local d'abord
			NotificationService.Notify(player, announceText, 6, "Sounds.Sfx.Blop", "Top")

			-- Broadcaster sur les autres serveurs via MessagingHub
			if _G.MessagingHub then
				_G.MessagingHub.Publish(MSG_TYPE, {
					playerName = player.Name,
					text = announceText,
				})
			end

			return string.format("✅ %d jeton%s ajouté%s à %s", amount, amount > 1 and "s" or "", amount > 1 and "s" or "", player.Name)
		end,
	})
end

return module