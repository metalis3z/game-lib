local MessagingService = game:GetService("MessagingService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local DataStoreService = game:GetService("DataStoreService")

local Animals = require(ReplicatedStorage.Datas.Animals)
local AnimalService = require(ServerScriptService.Services.AnimalService)
local NotificationService = require(ServerScriptService.Services.NotificationService)

-- On utilise un nouveau DataStore/Channel pour ne pas mélanger avec l'autre commande
local Store = DataStoreService:GetDataStore("GlobalSecret_CountOnly")
local Channel = "GlobalSecret_CountOnly"

local Subscribed = false

local function NotifyServer(Text)
	local Sound = ReplicatedStorage.Sounds.Sfx.Success
	for _, Player in ipairs(Players:GetPlayers()) do
		NotificationService.Notify(Player, Text, 5, Sound)
	end
end

if not Subscribed then
	Subscribed = true

	MessagingService:SubscribeAsync(Channel, function(Message)
		local Data = Message.Data
		if typeof(Data) ~= "table" then return end

		local Id = Data.Id
		local Amount = tonumber(Data.Amount)

		if not Id or not Amount then return end

		local SpawnIndex = nil

		-- Le serveur tente de s'inscrire dans la limite autorisée
		pcall(function()
			Store:UpdateAsync(Id, function(State)
				if type(State) ~= "table" then
					State = { Count = 0 }
				end

				State.Count += 1
				SpawnIndex = State.Count
				return State
			end)
		end)

		-- Si la limite de serveurs est atteinte, on annule pour ce serveur
		if not SpawnIndex or SpawnIndex > Amount then return end

		-- Le serveur a été sélectionné ! On tire un Secret au hasard.
		local secretList = {}
		for animalName, data in pairs(Animals) do
			if data.Rarity == "Secret" and data.DisplayName ~= "Lucky Block" then
				table.insert(secretList, animalName)
			end
		end

		if #secretList > 0 then
			local randomSecret = secretList[math.random(1, #secretList)]
			pcall(function()
				AnimalService.spawnAnimalCustom(Animals[randomSecret], nil, {}, nil, nil, nil)
			end)
		end

		-- La notification personnalisée avec le texte "Random Secret" en rose fluo
		NotifyServer('<font color="#FFFFFF">Ilovespaghetti spawned a </font><font color="#FF00FF">Random Secret</font><font color="#FFFFFF"> in your server!</font>')
	end)
end

local Module = function(Conch, Config)
	Conch.register("spawnrandomserversecret", {
		permissions = { Config.RequiredRole or "super-user" },

		arguments = function()
			return 
				{
					kind = "argument",
					type = "number",
					name = "Amount of Servers",
				}
		end,

		callback = function(Amount)
			Amount = math.clamp(tonumber(Amount) or 1, 1, 1000)

			-- Création d'un ID unique pour cet event précis
			local Id = tostring(os.time()) .. "_" .. math.random(100000, 999999)

			-- Initialisation du compteur à 0
			Store:UpdateAsync(Id, function(State)
				if State then return State end
				return { Count = 0 }
			end)

			-- Envoi du signal à tous les serveurs
			MessagingService:PublishAsync(Channel, {
				Id = Id,
				Amount = Amount
			})

			return "Spawned a Random Secret in " .. Amount .. " server(s)!"
		end,
	})
end

return Module