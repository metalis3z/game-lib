local LocalWinsMultiplierManager = {}

local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local DataHandler = require(ServerScriptService:WaitForChild("DataService"):WaitForChild("DataHandler"))

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local UpdateUI = Remotes:WaitForChild("UpdateUI")

local expiryTasks = {} -- [player] = thread renvoyé par task.delay

local function cancelExpiryTask(player)
	-- task.delay renvoie un thread : on l'annule avec task.cancel(), pas :Cancel()
	if expiryTasks[player] then
		local ok = pcall(function()
			task.cancel(expiryTasks[player])
		end)
		if not ok then
			warn("⚠️ Impossible d'annuler l'expiryTask de " .. player.Name .. " (déjà terminé ?)")
		end
		expiryTasks[player] = nil
	end
end

function LocalWinsMultiplierManager.Set(player, multiplier, duration)
	local data = DataHandler.Get(player)
	if not data then return false end

	cancelExpiryTask(player)

	data.WinsMultiplier = multiplier

	local ok, err = pcall(function()
		UpdateUI:FireClient(player, { WinsMultiplier = multiplier })
	end)
	if not ok then
		warn("⚠️ Erreur UpdateUI (Set) pour " .. player.Name .. " : " .. tostring(err))
	end

	if duration and duration > 0 then
		expiryTasks[player] = task.delay(duration, function()
			local d = DataHandler.Get(player)
			if d then
				d.WinsMultiplier = 1
			end
			expiryTasks[player] = nil
			if player.Parent then
				local okFire, errFire = pcall(function()
					UpdateUI:FireClient(player, { WinsMultiplier = 1 })
				end)
				if not okFire then
					warn("⚠️ Erreur UpdateUI (expiry) pour " .. player.Name .. " : " .. tostring(errFire))
				end
			end
		end)
	end

	return true
end

function LocalWinsMultiplierManager.Reset(player)
	local data = DataHandler.Get(player)
	if not data then return false end

	cancelExpiryTask(player)

	data.WinsMultiplier = 1

	local ok, err = pcall(function()
		UpdateUI:FireClient(player, { WinsMultiplier = 1 })
	end)
	if not ok then
		warn("⚠️ Erreur UpdateUI (Reset) pour " .. player.Name .. " : " .. tostring(err))
	end

	return true
end

-- Nettoyage à la déconnexion pour éviter les fuites mémoire
Players = game:GetService("Players")
Players.PlayerRemoving:Connect(function(player)
	cancelExpiryTask(player)
end)

return LocalWinsMultiplierManager