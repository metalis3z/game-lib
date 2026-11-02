-- announcelocate
-- Envoie une annonce dans le serveur où se trouve le joueur ciblé.
-- Chaque serveur reçoit le broadcast, vérifie s'il a le joueur, et affiche si oui.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players           = game:GetService("Players")

local Net   = require(ReplicatedStorage.Packages.Net)
local Conch = require(ReplicatedStorage.Packages.Conch)

local NotificationEvent = Net:RemoteEvent("NotificationService/Notify")
local MSG_TYPE          = "AnnounceLocate_v2"
local THIS_JOB_ID       = game.JobId

local function sendAnnounce(displayName, text)
	local formatted = string.format('<font color="#00BFFF"><b>%s</b></font>: %s', displayName, text)
	for _, player in ipairs(Players:GetPlayers()) do
		NotificationEvent:FireClient(player, formatted, 6, "Sounds.Sfx.Blop", "Top")
	end
end

local function registerHandler()
	if not _G.MessagingHub then return end
	_G.MessagingHub.Register(MSG_TYPE, function(data)
		if typeof(data) ~= "table" then return end
		if data._jobId == THIS_JOB_ID then return end -- évite doublon sur sender

		local targetName  = tostring(data.targetName  or ""):lower()
		local displayName = tostring(data.displayName or "Admin")
		local text        = tostring(data.text        or "")
		if targetName == "" or text == "" then return end

		-- Ce serveur a-t-il le joueur ?
		for _, p in ipairs(Players:GetPlayers()) do
			if p.Name:lower() == targetName or p.DisplayName:lower() == targetName then
				sendAnnounce(displayName, text)
				return
			end
		end
	end)
end

task.spawn(function()
	while not _G.MessagingHub do task.wait(0.5) end
	registerHandler()
end)

local module = function(_, Config)
	Conch.register("announcelocate", {
		description = "Envoie une annonce dans le serveur où se trouve un joueur.",
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return
				{ kind="argument", type="string", name="Joueur"  },
				{ kind="argument", type="string", name="Message" }
		end,
		callback = function(targetName, text)
			if not targetName or targetName == "" then return "❌ Pseudo du joueur requis." end
			if not text      or text      == "" then return "❌ Message requis."           end

			-- Récupérer le DisplayName de l'exécuteur (même système que globalplayerannounce)
			local displayName = "Admin"
			pcall(function()
				local ctx = Conch.get_command_context()
				if ctx and ctx.executor and ctx.executor.player then
					displayName = ctx.executor.player.DisplayName
				end
			end)

			-- Chercher le joueur localement d'abord
			for _, p in ipairs(Players:GetPlayers()) do
				if p.Name:lower() == targetName:lower()
				or p.DisplayName:lower() == targetName:lower() then
					-- Il est sur CE serveur
					sendAnnounce(displayName, text)
					return string.format('✅ "%s" est sur ce serveur — annonce envoyée.', p.DisplayName)
				end
			end

			-- Il est ailleurs: broadcaster à tous les serveurs
			-- Chaque serveur vérifie s'il a le joueur et affiche si oui
			if _G.MessagingHub then
				_G.MessagingHub.Publish(MSG_TYPE, {
					targetName  = targetName,
					displayName = displayName,
					text        = text,
				})
			end

			return string.format('✅ Recherche de "%s" sur tous les serveurs — annonce envoyée dans le sien.', targetName)
		end,
	})
end

return module
