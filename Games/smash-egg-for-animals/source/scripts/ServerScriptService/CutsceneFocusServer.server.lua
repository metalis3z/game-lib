-- Chargement du décor pendant les cinématiques (voir ReplicatedStorage.CutsceneLock) : le client envoie la position de sa caméra,
-- le serveur y pose un repère invisible et en fait le ReplicationFocus du joueur (le décor autour de la caméra est chargé chez lui).
-- nil : retour au personnage. On ne touche pas à un ReplicationFocus posé par un autre script (cinématique d'arrivée, IntroServer).
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local remote = ReplicatedStorage:WaitForChild("CutsceneFocus")

local folder = Instance.new("Folder")
folder.Name = "CutsceneFocus"
folder.Parent = workspace
local marks, lastAt = {}, {}

remote.OnServerEvent:Connect(function(player, position)
	local now = os.clock()
	if now - (lastAt[player] or 0) < 0.08 then return end -- pas plus de ~12 fois par seconde
	lastAt[player] = now
	local mark = marks[player]
	if typeof(position) ~= "Vector3" then
		if mark and player.ReplicationFocus == mark then player.ReplicationFocus = nil end
		return
	end
	if position.X ~= position.X or position.Magnitude > 50000 then return end -- (NaN, ou hors de la carte)
	if player.ReplicationFocus ~= nil and player.ReplicationFocus ~= mark then return end
	if not mark then
		mark = Instance.new("Part")
		mark.Name = player.Name
		mark.Size = Vector3.one
		mark.Transparency = 1
		mark.Anchored = true
		mark.CanCollide, mark.CanQuery, mark.CanTouch = false, false, false
		mark.Parent = folder
		marks[player] = mark
	end
	mark.Position = position
	player.ReplicationFocus = mark
end)
Players.PlayerRemoving:Connect(function(player)
	if marks[player] then marks[player]:Destroy() end
	marks[player], lastAt[player] = nil, nil
end)
