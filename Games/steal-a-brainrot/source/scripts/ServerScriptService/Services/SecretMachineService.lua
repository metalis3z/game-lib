local SecretMachineService = {}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local ServerStorage = game:GetService("ServerStorage")

local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local Net = require(ReplicatedStorage.Packages.Net)
local NotificationService = require(ServerScriptService.Services.NotificationService)

local SecretMachineData = require(ServerStorage.Modules.SecretMachineData)

-- RemoteEvents / RemoteFunctions
local Spin   = Net:RemoteFunction("SecretMachineService/Spin")   -- client demande un spin
local Fetch  = Net:RemoteFunction("SecretMachineService/Fetch")  -- client récupère son état

-- Constante : nb de secondes dans un jour
local DAY_SECONDS = 86400

-- --------------------------------------------------------------------------
-- Utilitaires
-- --------------------------------------------------------------------------

-- Retourne le timestamp du début du "jour" courant (minuit UTC)
local function getTodayStamp()
	local now = os.time()
	return now - (now % DAY_SECONDS)
 end

-- Tire un secret aléatoire selon les poids
local function rollSecret()
	local totalWeight = 0
	for _, s in ipairs(SecretMachineData.Secrets) do
		totalWeight = totalWeight + s.Weight
	end
	local roll = math.random(1, totalWeight)
	local cumul = 0
	for _, s in ipairs(SecretMachineData.Secrets) do
		cumul = cumul + s.Weight
		if roll <= cumul then
			return s
		end
	end
	return SecretMachineData.Secrets[1]
end

-- --------------------------------------------------------------------------
-- RemoteFunction : Fetch (le client demande son état)
-- --------------------------------------------------------------------------
Fetch.OnServerInvoke = function(player)
	local data = Synchronizer:Get(player)
	if not data then return nil end

	local sm = data:Get("SecretMachine") or {}
	local today = getTodayStamp()
	local freeUsed = (sm.LastFreeDay == today)

	return {
		FreeUsed     = freeUsed,
		CostPerSpin  = SecretMachineData.CostPerSpin,
		History      = sm.History or {},
	}
end

-- --------------------------------------------------------------------------
-- RemoteFunction : Spin (le client veut tourner la machine)
-- --------------------------------------------------------------------------
Spin.OnServerInvoke = function(player)
	local data = Synchronizer:Get(player)
	if not data then
		return { Success = false, Reason = "Données introuvables" }
	end

	local sm = data:Get("SecretMachine") or {}
	local today = getTodayStamp()
	local freeUsed = (sm.LastFreeDay == today)

	if not freeUsed then
		-- Utiliser le spin gratuit
		sm.LastFreeDay = today
	else
		-- Payer en coins
		local coins = data:Get("Coins") or 0
		if coins < SecretMachineData.CostPerSpin then
			return { Success = false, Reason = "Pas assez de coins ! (" .. SecretMachineData.CostPerSpin .. " requis)" }
		end
		data:Set("Coins", coins - SecretMachineData.CostPerSpin)
	end

	-- Tirer le secret
	local secret = rollSecret()

	-- Sauvegarder dans l'historique (garder les 20 derniers)
	local history = sm.History or {}
	table.insert(history, 1, { Name = secret.Name, Rarity = secret.Rarity, Emoji = secret.Emoji })
	if #history > 20 then
		table.remove(history, #history)
	end
	sm.History = history

	data:Set("SecretMachine", sm)

	NotificationService.Notify(player, secret.Emoji .. " Tu as obtenu : " .. secret.Name .. " !", 5, "Sounds.Sfx.Success")

	return {
		Success    = true,
		Secret     = secret,
		FreeUsed   = true,
		CostPerSpin = SecretMachineData.CostPerSpin,
		History    = sm.History,
	}
end

-- --------------------------------------------------------------------------
-- Init
-- --------------------------------------------------------------------------
function SecretMachineService:Start()
	Players.PlayerAdded:Connect(function(player)
		local data = Synchronizer:Wait(player)
		if data then
			if not data:Get("SecretMachine") then
				data:Set("SecretMachine", { LastFreeDay = 0, History = {} })
			end
		end
	end)
end

return SecretMachineService
