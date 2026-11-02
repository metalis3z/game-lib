local MessagingService = game:GetService("MessagingService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local DataStoreService = game:GetService("DataStoreService")

local Animals = require(ReplicatedStorage.Datas.Animals)
local Rarities = require(ReplicatedStorage.Datas.Rarities)
local AnimalService = require(ServerScriptService.Services.AnimalService)
local NotificationService = require(ServerScriptService.Services.NotificationService)

local Store = DataStoreService:GetDataStore("GlobalBrainrot_CountOnly")
local Channel = "GlobalBrainrot_CountOnly"

local Subscribed = false

local function ColoredName(Index)
	local Animal = Animals[Index]
	if not Animal then return Index end

	local Rarity = Rarities[Animal.Rarity]
	if Rarity and Rarity.GradientPreset then
		local Tag = string.lower(Rarity.GradientPreset)
		return "<" .. Tag .. ">" .. (Animal.DisplayName or Index) .. "</" .. Tag .. ">"
	end

	if Rarity and Rarity.Color then
		return '<font color="#' .. Rarity.Color:ToHex() .. '">' .. (Animal.DisplayName or Index) .. "</font>"
	end

	return Animal.DisplayName or Index
end

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
		local Brainrot = Data.Brainrot
		local Amount = tonumber(Data.Amount)

		if not Id or not Brainrot or not Amount then return end
		if not Animals[Brainrot] then return end

		local SpawnIndex = nil

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

		if not SpawnIndex or SpawnIndex > Amount then return end

		pcall(function()
			AnimalService.spawnAnimalCustom(Animals[Brainrot], nil, {}, nil, nil, nil)
		end)

		NotifyServer('<font color="#FFFFFF">Kaizou spawned a '..ColoredName(Brainrot) ..' in your server!</font>')
	end)
end

local Module = function(Conch, Config)
	Conch.register("spawnrandomserverbrainrot", {
		permissions = { Config.RequiredRole or "super-user" },

		arguments = function()
			return 
				{
					kind = "argument",
					type = "Brainrot",
					name = "Brainrot",
				},
			{
				kind = "argument",
				type = "number",
				name = "Amount",
			}
		end,

		callback = function(Brainrot, Amount)
			Amount = math.clamp(tonumber(Amount) or 1, 1, 1000)
			if not Animals[Brainrot] then return "invalid brainrot" end

			local Id = tostring(os.time()) .. "_" .. math.random(100000, 999999)

			Store:UpdateAsync(Id, function(State)
				if State then return State end
				return { Count = 0 }
			end)

			MessagingService:PublishAsync(Channel, {
				Id = Id,
				Brainrot = Brainrot,
				Amount = Amount
			})

			return "spawned"
		end,
	})
end

return Module