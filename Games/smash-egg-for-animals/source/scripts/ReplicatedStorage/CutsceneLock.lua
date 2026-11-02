-- CutsceneLock : une seule cinématique à la fois pour un joueur (côté client).
-- Chaque cinématique demande Lock.take(nom) avant de commencer : si une autre est déjà en cours, ou si le joueur est dans
-- l'arène du boss, elle n'est pas jouée du tout. Lock.release(nom) quand elle est finie (sécurité : libéré tout seul après maxTime).
--
-- Chargement du décor : tant qu'une cinématique est en cours, la position de la caméra est envoyée au serveur
-- (ServerScriptService.CutsceneFocusServer), qui y déplace le "point de chargement" du joueur (ReplicationFocus). Ce que la caméra
-- filme est donc chargé même si le personnage est à l'autre bout de la carte. Le personnage, lui, ne bouge pas.
-- Lock.focus(position) : charge un endroit tout de suite (avant de couper vers ce plan) ; attend au plus "timeout" secondes.
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lock = {current = nil, token = 0}

local SEND_EVERY, MOVE_MIN = 0.3, 30 -- on prévient le serveur quand la caméra a bougé de plus de 30 studs
local lastSent
local function send(position)
	local remote = ReplicatedStorage:FindFirstChild("CutsceneFocus")
	if remote then remote:FireServer(position) end
	lastSent = position
end

function Lock.focus(position, timeout)
	if typeof(position) ~= "Vector3" then return end
	send(position)
	local player = Players.LocalPlayer
	if player and timeout ~= 0 then pcall(function() player:RequestStreamAroundAsync(position, timeout or 2) end) end
end

function Lock.busy()
	local player = Players.LocalPlayer
	-- (cinématique d'arrivée IntroClient en cours : attribut IntroState = "playing")
	return Lock.current ~= nil or (player and (player:GetAttribute("InBossArena") == true or player:GetAttribute("InDemonArena") == true or player:GetAttribute("IntroState") == "playing"))
end

function Lock.take(name, maxTime)
	if Lock.busy() then return false end
	Lock.current = name
	Lock.token += 1
	local token = Lock.token
	task.delay(maxTime or 240, function()
		if Lock.token == token and Lock.current == name then Lock.release(name) end
	end)
	-- la caméra est suivie par le chargement tant que la cinématique dure
	task.spawn(function()
		lastSent = nil
		while Lock.token == token and Lock.current == name do
			local camera = workspace.CurrentCamera
			local position = camera and camera.CFrame.Position
			if position and (not lastSent or (position - lastSent).Magnitude > MOVE_MIN) then send(position) end
			task.wait(SEND_EVERY)
		end
	end)
	return true
end

function Lock.release(name)
	if Lock.current == name then
		Lock.current = nil
		send(nil) -- le chargement revient autour du personnage
	end
end

return Lock
