local MemoryStoreService = game:GetService("MemoryStoreService")
local MessagingService = game:GetService("MessagingService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local HttpService = game:GetService("HttpService")

local Animals = require(ReplicatedStorage.Datas.Animals)
local Rarities = require(ReplicatedStorage.Datas.Rarities)
local AnimalService = require(ServerScriptService.Services.AnimalService)
local NotificationService = require(ServerScriptService.Services.NotificationService)

local SlotMap = MemoryStoreService:GetHashMap("GlobalBrainrot_Slots")
local Channel = "GlobalBrainrot_CountOnly"
local SLOT_TTL = 120
local SHARD_COUNT = 8

local ClaimedIds = {}

local SuccessSound = ReplicatedStorage.Sounds.Sfx.Success

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

local function NotifyAllPlayers(Text)
	for _, Player in ipairs(Players:GetPlayers()) do
		NotificationService.Notify(Player, Text, 5, SuccessSound)
	end
end

local function ClaimSpawnSlot(Id, Amount)
	local EffectiveShards = math.min(Amount, SHARD_COUNT)
	local ShardIndex = math.random(1, EffectiveShards)
	local Key = Id .. ":" .. ShardIndex
	local Base = math.floor(Amount / EffectiveShards)
	local Extra = Amount % EffectiveShards
	local ShardCap = Base + (ShardIndex <= Extra and 1 or 0)

	local didClaim = false

	local ok, err = pcall(function()
		SlotMap:UpdateAsync(Key, function(Old)
			local Current = Old or 0
			if Current >= ShardCap then
				didClaim = false
				return Current
			end
			didClaim = true
			return Current + 1
		end, SLOT_TTL)
	end)

	if not ok then
		warn("ClaimSpawnSlot UpdateAsync error:", err)
		return false
	end

	return didClaim
end

local function HandleSpawnMessage(Data)
	if typeof(Data) ~= "table" then return end

	local Id = Data.Id
	local Brainrot = Data.Brainrot
	local Amount = tonumber(Data.Amount)
	local Mutation = (Data.Mutation ~= nil and Data.Mutation ~= "nil") and Data.Mutation or nil

	if not Id or not Brainrot or not Amount then return end
	if not Animals[Brainrot] then return end
	if ClaimedIds[Id] then return end

	task.wait(math.random() * 1.5)

	local claimed = ClaimSpawnSlot(Id, Amount)
	if not claimed then return end

	ClaimedIds[Id] = true
	task.delay(SLOT_TTL + 5, function()
		ClaimedIds[Id] = nil
	end)

	local ok, spawnResult = pcall(AnimalService.SpawnForcedAnimal, Animals[Brainrot], Mutation)
	if not ok then
		warn("SpawnForcedAnimal error:", spawnResult)
		return
	end

	if spawnResult == false then
		warn("SpawnForcedAnimal returned false for", Brainrot)
		return
	end

	NotifyAllPlayers(
		'<font color="#FFFFFF">Sammy spawned a ' .. ColoredName(Brainrot) .. ' in your server!</font>'
	)
end

task.spawn(function()
	local ok, err = pcall(function()
		MessagingService:SubscribeAsync(Channel, function(message)
			HandleSpawnMessage(message.Data)
		end)
	end)
	if not ok then
		warn("GlobalBrainrot: Failed to subscribe to channel:", err)
	end
end)

local function GetAllAnimalsList()
	local animalList = {}
	for animalIndex, animalData in pairs(Animals) do
		if not animalData.HideFromIndex then
			table.insert(animalList, { Index = animalIndex, Data = animalData })
		end
	end
	table.sort(animalList, function(a, b)
		return (a.Data.Generation or 0) < (b.Data.Generation or 0)
	end)
	return animalList
end

return function(context, Brainrot, Amount, mutation)
	local player = context.Executor
	if not player then
		return "❌ Could not find your player instance."
	end

	if not Brainrot or Brainrot == "" or string.lower(tostring(Brainrot)) == "list" then
		local animalList = GetAllAnimalsList()
		local result = "📋 **All Animals in Game:**\n"
		local count = 0
		for _, animal in ipairs(animalList) do
			count += 1
			local rarity = animal.Data.Rarity or "Unknown"
			local displayName = animal.Data.DisplayName or animal.Index
			result ..= string.format("%d. %s (%s)\n", count, displayName, rarity)
			if count >= 50 then
				result ..= "... and " .. (#animalList - 50) .. " more animals!"
				break
			end
		end
		result ..= string.format("\n**Total: %d animals**", #animalList)
		return result
	end

	Amount = math.clamp(tonumber(Amount) or 1, 1, 10000)
	if not Animals[Brainrot] then
		return "❌ Invalid brainrot: " .. tostring(Brainrot)
	end

	local Id = HttpService:GenerateGUID(false)
	local cleanMutation = (mutation ~= nil and mutation ~= "nil" and mutation ~= "") and mutation or nil

	local publishOk, publishErr = pcall(function()
		MessagingService:PublishAsync(Channel, {
			Id = Id,
			Brainrot = Brainrot,
			Amount = Amount,
			Mutation = cleanMutation,
		})
	end)

	if not publishOk then
		return "❌ Failed to publish to servers: " .. tostring(publishErr)
	end

	return string.format("✅ Spawned %s x%d across servers!", ColoredName(Brainrot), Amount)
end