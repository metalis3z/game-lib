local BaseCheckService = {}

local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local ServerStorage = game:GetService("ServerStorage")

local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local PlotService = require(ServerScriptService.Services.PlotService)
local SkinService = require(ServerScriptService.Services.SkinService)
local BasesData = require(ReplicatedStorage.Datas.Bases)
local Net = require(ReplicatedStorage.Packages.Net)

local DeleteAnimalRemote = Net:RemoteEvent("BaseCheckService/DeleteAnimal")
local AddAnimalRemote = Net:RemoteEvent("BaseCheckService/AddAnimal")
local PlayerDataStore = DataStoreService:GetDataStore("DATA-FOR-EVERYONESS-V2")
local previews = {}
local ALLOWED_USERS = {
	["do_zynna"] = true,
	["badr_studio"] = true,
}

local function normaliseName(value)
	return tostring(value or ""):gsub("^@", ""):gsub("^%s+", ""):gsub("%s+$", "")
end

function BaseCheckService:IsAllowedPlayer(player)
	return player and ALLOWED_USERS[string.lower(player.Name)] == true
end

local function getUserId(name)
	local success, userId = pcall(Players.GetUserIdFromNameAsync, Players, normaliseName(name))
	if not success then
		return nil, "Joueur introuvable."
	end
	return userId
end

local function getPlayerData(userId)
	local player = Players:GetPlayerByUserId(userId)
	if player then
		local channel = Synchronizer:Get(player)
		if channel then
			return channel:Get(), player
		end
	end

	-- Try multiple times to load the real data from the DataStore.
	local data = nil
	local lastError = nil
	for attempt = 1, 3 do
		local success, result = pcall(PlayerDataStore.GetAsync, PlayerDataStore, tostring(userId))
		if success and type(result) == "table" then
			data = result
			break
		end
		lastError = result
		if attempt < 3 then
			task.wait(1)
		end
	end

	-- If after all retries the data is a valid table, return the real data.
	if data then
		return data, nil
	end

	-- Absolute fallback: default data if the DataStore is truly unavailable.
	local defaultData = {
		Rebirth = 0,
		DisplayName = nil,
		Name = nil,
		AnimalPodiums = {},
		Settings = {},
	}
	return defaultData, nil
end

local function clearPreview(userId)
	local record = previews[userId]
	if not record then
		return
	end

	previews[userId] = nil
	local preview = record.preview
	if preview then
		pcall(function()
			Synchronizer:Destroy(preview.Name)
		end)
		if preview.Parent then
			preview:Destroy()
		end
	end

	-- The original free plot was kept intact while the Base Check was shown.
	-- Put that same plot back instead of creating or deleting a plot.
	local originalPlot = record.originalPlot
	if originalPlot and originalPlot.Parent == ServerStorage then
		originalPlot.Parent = workspace.Plots
		originalPlot:SetAttribute("Loaded", true)
	end
end

local function makePreviewName(data, userId)
	return data.DisplayName or data.Name or ("User_" .. tostring(userId))
end

local function makePreviewAnimalList(source)
	local result = {}
	local traitCounts = {}

	for index, animal in pairs(source or {}) do
		if type(animal) == "table" then
			local copy = {}
			for key, value in pairs(animal) do
				copy[key] = value
			end
			copy.SameTraits = nil
			result[index] = copy

			if type(copy.Traits) == "table" and #copy.Traits > 0 then
				local traits = table.clone(copy.Traits)
				table.sort(traits)
				local signature = table.concat(traits, "|")
				traitCounts[signature] = (traitCounts[signature] or 0) + 1
			end
		else
			result[index] = animal
		end
	end

	for _, animal in pairs(result) do
		if type(animal) == "table" and type(animal.Traits) == "table" and #animal.Traits > 0 then
			local traits = table.clone(animal.Traits)
			table.sort(traits)
			animal.SameTraits = traitCounts[table.concat(traits, "|")] > 1
		end
	end

	return result
end

function BaseCheckService:Clear(targetName)
	local userId, idError = getUserId(targetName)
	if not userId then
		return false, idError
	end
	if not previews[userId] then
		return false, "Aucune Base Check active pour ce joueur."
	end

	clearPreview(userId)
	return true, "Base Check retirée : le plot est redevenu une base vide."
end

function BaseCheckService:Show(targetName)
	local userId, idError = getUserId(targetName)
	if not userId then
		return false, idError
	end

	local data, onlinePlayer, dataError = getPlayerData(userId)
	if not data then
		return false, dataError
	end

	clearPreview(userId)

	local freePlot = PlotService.getFreePlot()
	if not freePlot then
		return false, "Aucune place libre pour afficher cette base."
	end

	local rebirth = tonumber(data.Rebirth) or 0
	local baseInfo = BasesData[rebirth]
	if not baseInfo or not baseInfo.Model then
		return false, "Le niveau de base du joueur est invalide."
	end

	local plotCFrame = freePlot:GetPivot()
	local plotName = freePlot.Name
	local plotOrder = freePlot:GetAttribute("Order")

	-- Keep the exact original plot so `false` can restore it without
	-- removing/rebuilding the slot.
	freePlot.Parent = ServerStorage

	local preview = baseInfo.Model:Clone()
	preview.Name = plotName
	preview:SetAttribute("Order", plotOrder)
	preview:SetAttribute("Tier", rebirth)
	preview:SetAttribute("BaseCheckPreview", true)
	preview:SetAttribute("BaseCheckUserId", userId)
	preview:SetAttribute("BaseCheckUserName", makePreviewName(data, userId))

	local sign = preview:FindFirstChild("PlotSign")
	if sign and sign:FindFirstChild("SurfaceGui") and sign.SurfaceGui:FindFirstChild("Frame") then
		sign.SurfaceGui.Frame.TextLabel.Text = string.format("BASE CHECK: %s", makePreviewName(data, userId))
		if sign:FindFirstChild("YourBase") then
			sign.YourBase.Enabled = false
		end
	end

	local podiums = preview:FindFirstChild("AnimalPodiums")
	if podiums and baseInfo.MaxAnimals then
		for _, podium in ipairs(podiums:GetChildren()) do
			local index = tonumber(podium.Name)
			if index and index > baseInfo.MaxAnimals then
				podium:Destroy()
			end
		end
	end

	preview:PivotTo(plotCFrame)
	preview.Parent = workspace.Plots

	local skin = data.Settings and data.Settings["Base Skin"]
	if skin then
		pcall(function()
			SkinService:Apply(skin, preview)
		end)
	end
	preview:AddTag("Plot")

	local channel = Synchronizer:Create(preview.Name, {
		Owner = onlinePlayer,
		AnimalList = makePreviewAnimalList(data.AnimalPodiums),
		FriendsAllowed = false,
		BaseCheckPreview = true,
	})
	for _, player in ipairs(Players:GetPlayers()) do
		channel:AddListener(player)
	end

	preview:SetAttribute("Loaded", true)
	previews[userId] = {
		preview = preview,
		originalPlot = freePlot,
	}

	return true, string.format("Base Check chargée pour %s.", makePreviewName(data, userId))
end

function BaseCheckService:AddAnimal(player, sourceUserId, podiumIndex)
	if not self:IsAllowedPlayer(player) then
		return false, "Accès refusé."
	end

	local sourceData, _, sourceError = getPlayerData(tonumber(sourceUserId))
	if not sourceData then
		return false, sourceError
	end

	local sourceAnimal = (sourceData.AnimalPodiums or {})[tonumber(podiumIndex)]
	if type(sourceAnimal) ~= "table" then
		return false, "Ce brainrot n'existe plus dans la base d'origine."
	end

	local targetChannel = Synchronizer:Get(player)
	if not targetChannel then
		return false, "Ta base n'est pas encore chargée."
	end

	local freePodium = PlotService.getFreePodium(player)
	if not freePodium then
		return false, "Ta base est pleine."
	end

	local targetIndex = tonumber(freePodium.Name)
	if not targetIndex then
		return false, "Podium cible invalide."
	end

	local copiedAnimal = {}
	for key, value in pairs(sourceAnimal) do
		if key ~= "Steal" and key ~= "Stolen" and key ~= "StealText"
			and key ~= "Machine" and key ~= "InTrade" and key ~= "SameTraits" then
			copiedAnimal[key] = value
		end
	end
	copiedAnimal.LastCollect = workspace:GetServerTimeNow()

	local targetPodiums = targetChannel:Get("AnimalPodiums") or {}
	targetPodiums[targetIndex] = copiedAnimal
	targetChannel:Set("AnimalPodiums", targetPodiums)
	targetChannel:Set("AnimalAddedOrRemoved", true)
	require(ServerScriptService.Services.DataService):SavePlayer(player, false)

	return true, "Brainrot ajouté à ta base. La base d'origine reste intacte."
end

function BaseCheckService:DeleteAnimal(userId, podiumIndex)
	userId = tonumber(userId)
	podiumIndex = tonumber(podiumIndex)
	if not userId or not podiumIndex then
		return false, "Données de podium invalides."
	end

	local data, onlinePlayer, dataError = getPlayerData(userId)
	if not data then
		return false, dataError
	end

	local podiums = data.AnimalPodiums or {}
	if type(podiums[podiumIndex]) ~= "table" then
		return false, "Ce brainrot n'existe plus dans la vraie base."
	end
	podiums[podiumIndex] = "Empty"

	if onlinePlayer then
		local channel = Synchronizer:Get(onlinePlayer)
		if not channel then
			return false, "Les données du joueur ne sont pas prêtes."
		end
		channel:Set("AnimalPodiums", podiums)
		channel:Set("AnimalAddedOrRemoved", true)
		require(ServerScriptService.Services.DataService):SavePlayer(onlinePlayer, false)
	else
		local success, updateError = pcall(PlayerDataStore.UpdateAsync, PlayerDataStore, tostring(userId), function(saved)
			if type(saved) ~= "table" then
				return nil
			end
			saved.AnimalPodiums = saved.AnimalPodiums or {}
			saved.AnimalPodiums[podiumIndex] = "Empty"
			return saved
		end)
		if not success then
			return false, "La suppression hors ligne a échoué : " .. tostring(updateError)
		end
	end

	local preview = previews[userId]
	if preview and preview.Parent then
		local channel = Synchronizer:Get(preview.Name)
		if channel then
			channel:Set("AnimalList", makePreviewAnimalList(podiums))
		end
	end

	return true, "Brainrot supprimé de la vraie base."
end

function BaseCheckService:IsPreview(plot)
	return plot and plot:GetAttribute("BaseCheckPreview") == true
end

DeleteAnimalRemote.OnServerEvent:Connect(function(player, plotName, podiumIndex)
	if typeof(plotName) ~= "string" or typeof(podiumIndex) ~= "number" then
		return
	end

	if not BaseCheckService:IsAllowedPlayer(player) then
		return
	end

	local plot = workspace.Plots:FindFirstChild(plotName)
	if not BaseCheckService:IsPreview(plot) then
		return
	end

	BaseCheckService:DeleteAnimal(plot:GetAttribute("BaseCheckUserId"), podiumIndex)
end)

AddAnimalRemote.OnServerEvent:Connect(function(player, plotName, podiumIndex)
	if typeof(plotName) ~= "string" or typeof(podiumIndex) ~= "number" then
		return
	end
	if not BaseCheckService:IsAllowedPlayer(player) then
		return
	end

	local plot = workspace.Plots:FindFirstChild(plotName)
	if not BaseCheckService:IsPreview(plot) then
		return
	end

	BaseCheckService:AddAnimal(player, plot:GetAttribute("BaseCheckUserId"), podiumIndex)
end)

return BaseCheckService