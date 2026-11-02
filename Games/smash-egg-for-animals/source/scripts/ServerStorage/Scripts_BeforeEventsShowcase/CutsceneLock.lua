-- CutsceneLock : une seule cinématique à la fois pour un joueur (côté client).
-- Chaque cinématique demande Lock.take(nom) avant de commencer : si une autre est déjà en cours, ou si le joueur est dans
-- l'arène du boss, elle n'est pas jouée du tout. Lock.release(nom) quand elle est finie (sécurité : libéré tout seul après maxTime).
local Players = game:GetService("Players")
local Lock = {current = nil, token = 0}

function Lock.busy()
	local player = Players.LocalPlayer
	return Lock.current ~= nil or (player and player:GetAttribute("InBossArena") == true)
end

function Lock.take(name, maxTime)
	if Lock.busy() then return false end
	Lock.current = name
	Lock.token += 1
	local token = Lock.token
	task.delay(maxTime or 240, function()
		if Lock.token == token and Lock.current == name then Lock.current = nil end
	end)
	return true
end

function Lock.release(name)
	if Lock.current == name then Lock.current = nil end
end

return Lock
