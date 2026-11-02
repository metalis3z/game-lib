local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local MSG_TYPE = "GlobalAddSpins"
local THIS_JOB_ID = game.JobId

-- Handler : reçoit le message des autres serveurs
local function registerHandler()
	if not _G.MessagingHub then return end

	_G.MessagingHub.Register(MSG_TYPE, function(data)
		if typeof(data) ~= "table" then return end
		if data.senderJobId == THIS_JOB_ID then return end

		local amount = tonumber(data.amount) or 1
		local Players = game:GetService("Players")
		local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
		local NotificationService = require(ServerScriptService.Services.NotificationService)

		for _, player in ipairs(Players:GetPlayers()) do
			local ch = Synchronizer:Get(player)
			if ch then
				ch:Increase("DivineSpinWheel.Spins", amount)
				NotificationService.Success(player,
					string.format(" Vous avez reçu <b>%d spin%s</b> offert%s par l'admin !",
						amount, amount > 1 and "s" or "", amount > 1 and "s" or ""))
			end
		end
	end)
end

-- Attendre MessagingHub
task.spawn(function()
	while not _G.MessagingHub do task.wait(0.5) end
	registerHandler()
end)

local module = function(Conch, Config)
	local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
	local NotificationService = require(ServerScriptService.Services.NotificationService)
	local Players = game:GetService("Players")

	Conch.register("globaladdspins", {
		permissions = { Config.RequiredRole or "super-user" },

		arguments = function()
			return {
				kind = "argument",
				type = "number",
				name = "Amount",
			}
		end,

		callback = function(amount)
			amount = math.clamp(tonumber(amount) or 1, 1, 10000)

			-- Ajouter les spins sur CE serveur
			local count = 0
			for _, player in ipairs(Players:GetPlayers()) do
				local ch = Synchronizer:Get(player)
				if ch then
					ch:Increase("DivineSpinWheel.Spins", amount)
					NotificationService.Success(player,
						string.format("🎰 Vous avez reçu <b>%d spin%s</b> offert%s par l'admin !",
							amount, amount > 1 and "s" or "", amount > 1 and "s" or ""))
					count += 1
				end
			end

			-- Envoyer aux autres serveurs
			if _G.MessagingHub then
				_G.MessagingHub.Publish(MSG_TYPE, {
					amount = amount,
					senderJobId = THIS_JOB_ID,
				})
			end

			return string.format("✅ %d spin(s) ajouté(s) à %d joueur(s) sur ce serveur + broadcast global", amount, count)
		end,
	})
end

return module
