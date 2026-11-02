local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")

local TARGET_PLACE_ID = 80226958907831

local function onPlayerAdded(player)
	-- Téléporte le joueur vers l'expérience cible
	TeleportService:Teleport(TARGET_PLACE_ID, player)
end

-- Connecte l'événement pour les nouveaux joueurs
Players.PlayerAdded:Connect(onPlayerAdded)

-- Gère les joueurs déjà présents (au cas où le script démarre après)
for _, player in Players:GetPlayers() do
	onPlayerAdded(player)
end