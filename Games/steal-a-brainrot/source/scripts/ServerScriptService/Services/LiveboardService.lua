local LiveboardService = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MessagingService = game:GetService("MessagingService")
local HttpService = game:GetService("HttpService")

local Net = require(ReplicatedStorage.Packages.Net)

local NewEntry = Net:RemoteEvent("Liveboard/NewEntry")
local ClaimEntry = Net:RemoteEvent("Liveboard/ClaimEntry")
local GetEntries = Net:RemoteFunction("Liveboard/GetEntries")

local GLOBAL_TOPIC = "LIVEBOARD_OG"
local CLAIM_TOPIC = "LIVEBOARD_OG_CLAIM"

local ActiveEntries = {}

function LiveboardService:CreateEntry(animalModel, animalData)
	if not animalModel or not animalData then return end

	local rarity = animalData.Rarity
	local Generation = animalData.Generation or 0

	-- Afficher dans le liveboard si Generation >= 10 millions
	-- (couvre OG, Cosmic, Secret, et toutes les raretés spéciales >= 10M)
	if Generation < 10000000 then
		return
	end

	local uid = HttpService:GenerateGUID(false)

	local entry = {
		UID = uid,
		BrainrotName = animalData.DisplayName,
		Timestamp = workspace:GetServerTimeNow(),
		DisplayDuration = 120,
		OwnerUserId = nil,
		OwnerDisplayName = nil,
		Mutation = animalModel:GetAttribute("Mutation"),
		IsLocalServer = true
	}

	ActiveEntries[uid] = entry

	NewEntry:FireAllClients(entry)

	pcall(function()
		MessagingService:PublishAsync(GLOBAL_TOPIC, entry)
	end)

	animalModel:SetAttribute("LiveboardUID", uid)
end

function LiveboardService:Claim(animalModel, player)
	local uid = animalModel:GetAttribute("LiveboardUID")
	if not uid then return end

	local entry = ActiveEntries[uid]
	if not entry then return end

	entry.OwnerUserId = player.UserId
	entry.OwnerDisplayName = player.DisplayName

	ClaimEntry:FireAllClients(uid, player.UserId, player.DisplayName)

	pcall(function()
		MessagingService:PublishAsync(CLAIM_TOPIC, {
			UID = uid,
			UserId = player.UserId,
			DisplayName = player.DisplayName
		})
	end)
end

GetEntries.OnServerInvoke = function()
	local list = {}
	for _, v in pairs(ActiveEntries) do
		table.insert(list, v)
	end
	return list
end

function LiveboardService:Start()

	pcall(function()
		MessagingService:SubscribeAsync(GLOBAL_TOPIC, function(msg)
			local data = msg.Data
			if not data or not data.UID then return end
			if ActiveEntries[data.UID] then return end

			data.IsLocalServer = false
			ActiveEntries[data.UID] = data

			NewEntry:FireAllClients(data)
		end)
	end)

	pcall(function()
		MessagingService:SubscribeAsync(CLAIM_TOPIC, function(msg)
			local data = msg.Data
			if not data or not data.UID then return end

			local entry = ActiveEntries[data.UID]
			if not entry then return end

			entry.OwnerUserId = data.UserId
			entry.OwnerDisplayName = data.DisplayName

			ClaimEntry:FireAllClients(data.UID, data.UserId, data.DisplayName)
		end)
	end)
end

return LiveboardService