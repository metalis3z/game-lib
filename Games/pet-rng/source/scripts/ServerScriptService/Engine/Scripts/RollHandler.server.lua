local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MessagingService = game:GetService("MessagingService")
local dataManager = require(game:GetService("ServerScriptService").Engine.Scripts.Data.DataManager.ChangeData)
local petSystem = require(ReplicatedStorage.Engine.Modules.PetSystem)

local RSEngine = ReplicatedStorage.Engine
local Modules = RSEngine.Modules
local petSystem = require(Modules.PetSystem)
local pets = require(ReplicatedStorage.DataModules.Pets)
local roll = RSEngine.RemotesEvents.Roll
local rollPet = require(RSEngine.Modules.Roll)

local function getChance(rarity, totalRarity)
	return math.round(1/rarity * totalRarity)
end

local function getAccumulated(weightsTable)
	local totalWeight = 0
	for _, weight in pairs(weightsTable) do
		totalWeight = totalWeight + weight.weight
	end
	return totalWeight
end

roll.OnServerEvent:Connect(function(plr, pet)
	local petInfo = nil
	for _, aPet in pairs(pets) do
		if aPet.name == pet then
			petInfo = aPet
		end
	end
	
	if not petInfo then return end
	
	local accumulated = getAccumulated(pets)
	local rarity = getChance(petInfo.weight, accumulated)
	local rarityText = "1/" .. rarity
	if petInfo.weight <= 0.001 then
		local message = {user = plr.Name, weight = rarityText, title = petInfo.title, name = petInfo.name}
		MessagingService:PublishAsync("GlobalAnnouncement", message)
	end
	
	local luckybadge = game:GetService("BadgeService")
	if rarity >= 100 then
		luckybadge:AwardBadge(plr.UserId, 3098980375906858)
	end
	local veryluckybadge = game:GetService("BadgeService")
	if rarity >= 1000 then
		veryluckybadge:AwardBadge(plr.UserId, 1658116258862853)
	end
	local megaluckybadge = game:GetService("BadgeService")
	if rarity >= 10000 then
		megaluckybadge:AwardBadge(plr.UserId, 3182917038540954)
	end
	local godluckybadge = game:GetService("BadgeService")
	if rarity >= 100000 then
		godluckybadge:AwardBadge(plr.UserId, 2166285786704533)
	end
	local impossibleluckybadge = game:GetService("BadgeService")
	if rarity >= 1000000 then
		impossibleluckybadge:AwardBadge(plr.UserId, 2569603176522987)
	end
	
	dataManager.AddRoll(plr, 1)
	dataManager.AddPet(plr, petInfo.name)
end)

game.Players.PlayerAdded:Connect(function(player)
	petSystem.UpdatePets(player)
end)

MessagingService:SubscribeAsync("GlobalAnnouncement", function(message)
	local text = "[Global]: " .. message.Data.user .. " rolled a " .. message.Data.title .. " " .. message.Data.name .. " [" .. message.Data.weight .. "]"
	game.ReplicatedStorage.Engine.RemotesEvents.DisplayMessage:FireAllClients(text)
end)