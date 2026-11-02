local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService") -- Ajouté pour éviter les erreurs plus bas
local Players = game:GetService("Players")
local MessagingService = game:GetService("MessagingService")

local Net = require(ReplicatedStorage.Packages.Net)
local Conch = require(ReplicatedStorage.Packages.Conch)

local NotificationEvent = Net:RemoteEvent("NotificationService/Notify")
local CHANNEL = "exotiqueleny-announce-channel-v1"

-- Fonction pour créer des entrées fictives dans le Liveboard
local function createFakeLiveboardEntries(text)
	local count, brainrotName = text:match("^(%d+)%s+(.+)$")

	if count and brainrotName then
		count = tonumber(count)
		if count and count > 0 and count <= 100 then
			local success, LiveboardService = pcall(function()
				return require(ServerScriptService.Services.LiveboardService)
			end)

			if success and LiveboardService and LiveboardService.CreateFakeEntry then
				LiveboardService.CreateFakeEntry(brainrotName, count)
			end
		end
	end
end

-- 📢 Réception des annonces
MessagingService:SubscribeAsync(CHANNEL, function(message)
	local data = message.Data
	if not data or not data.Text then return end

	-- 🔴 Changement ici : Couleur du pseudo passée en ROUGE (rgb(255, 50, 50))
	local formattedText = '<b><font color="rgb(255, 50, 50)">exotiqueleny " :</font></b> ' .. data.Text

	for _, player in ipairs(Players:GetPlayers()) do
		NotificationEvent:FireClient(player, formattedText, 5, nil, "Top")
	end
end)

-- 📢 Commande exotiquelenyannounce
local module = function(_, Config)
	Conch.register("exotiquelenyannounce", {
		permissions = { Config.RequiredRole or "super-user" },

		-- Correction : arguments comme fonction pour compatibilité Conch + multi-mots
		arguments = function()
			local args = {}
			for i = 1, 45 do
				table.insert(args, {
					kind = "argument",
					type = "string",
					name = "text" .. i,
				})
			end
			return args
		end,

		callback = function(...)
			local args = {...}
			local fullText = table.concat(args, " ")

			-- Enlever les espaces inutiles au début et à la fin
			fullText = string.gsub(fullText, "^%s*(.-)%s*$", "%1")

			-- Si le message est vide
			if fullText == "" then
				return "You must provide announcement text"
			end

			-- 📡 Envoi global
			MessagingService:PublishAsync(CHANNEL, { Text = fullText })

			-- 🔊 Son
			require(ReplicatedStorage.Controllers.SoundController):PlaySound(
				ReplicatedStorage.Sounds.Sfx.Blop
			)

			return "Announced: " .. fullText
		end,
	})
end

return module