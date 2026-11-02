--credit to leon games studio
--[[
	SocialPopupService  (MODDED)
	====================================================================
	Lado servidor del popup social (cliente: StarterPlayerScripts.SocialPopupClient).
	Sólo persiste la intención de "favorito": cuando el jugador toca el botón
	Favorite, el cliente dispara SocialPopupRemote("Favorited") y aquí marcamos
	el atributo FavoritedGame. GameServer lo guarda/restaura en el perfil
	(PROFILE_TEMPLATE.FavoritedGame), por eso una vez marcado el popup ya no
	vuelve a pedir el favorito.

	La pertenencia al grupo NO se persiste: el cliente la chequea con
	player:IsInGroup(GROUP_ID) cada vez.
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local remote = ReplicatedStorage:WaitForChild("SocialPopupRemote")

remote.OnServerEvent:Connect(function(player: Player, action)
	if action == "Favorited" then
		player:SetAttribute("FavoritedGame", true) -- GameServer lo persiste al salir
	end
end)

print("[SocialPopupService] listo — escuchando SocialPopupRemote")
