

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local MessagingService = game:GetService("MessagingService")
local DataStoreService = game:GetService("DataStoreService")

local AnimalService = require(ServerScriptService.Services.AnimalService)
local AnimalsData = require(ReplicatedStorage.Datas.Animals)
local MutationsData = require(ReplicatedStorage.Datas.Mutations)
local TraitsData = require(ReplicatedStorage.Datas.Traits)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local Net = require(ReplicatedStorage.Packages.Net)
local NotificationEvent = Net:RemoteEvent("NotificationService/Notify")
local NotificationService = require(ServerScriptService.Services.NotificationService)

local StealService = nil
pcall(function() StealService = require(ServerScriptService.Services.StealService) end)

local MoneyService = nil
pcall(function() MoneyService = require(ServerScriptService.Services.MoneyService) end)

local PlotService = nil
pcall(function() PlotService = require(ServerScriptService.Services.PlotService) end)

local LuckService = nil
pcall(function() LuckService = require(ServerScriptService.Services.LuckService) end)

local BanStore = DataStoreService:GetDataStore("BansV2")

local ANNOUNCE_CHANNEL   = "b82db150-528f-4042-a0b5-ad6aaf1a5c33"
local GLOBAL_SPAWN_CHANNEL = "GlobalBrainrotSpawn"
local GLOBAL_EVENT_TOPIC = "4a6b4703-251a-4564-8840-0169367d6827"
local GLOBAL_STOCK_TOPIC = "GlobalStockUpdate"

local ADMIN_IDS = { 4515418871, 4515418871 }

local function isAdmin(player)
	for _, id in ipairs(ADMIN_IDS) do
		if player.UserId == id then return true end
	end
	return false
end

-- ============================================================
-- ADMIN FOLDER
-- ============================================================

local AdminFolder = Instance.new("Folder")
AdminFolder.Name = "AdminSystem"
AdminFolder.Parent = ReplicatedStorage

local CheckAdmin = Instance.new("RemoteFunction")
CheckAdmin.Name = "CheckAdmin"
CheckAdmin.Parent = AdminFolder

local ExecuteCommand = Instance.new("RemoteEvent")
ExecuteCommand.Name = "ExecuteCommand"
ExecuteCommand.Parent = AdminFolder

local CommandResult = Instance.new("RemoteEvent")
CommandResult.Name = "CommandResult"
CommandResult.Parent = AdminFolder

local GetEvents = Instance.new("RemoteFunction")
GetEvents.Name = "GetEvents"
GetEvents.Parent = AdminFolder

local GetItems = Instance.new("RemoteFunction")
GetItems.Name = "GetItems"
GetItems.Parent = AdminFolder

local GetBrainrots = Instance.new("RemoteFunction")
GetBrainrots.Name = "GetBrainrots"
GetBrainrots.Parent = AdminFolder

local GetLuckyBlocks = Instance.new("RemoteFunction")
GetLuckyBlocks.Name = "GetLuckyBlocks"
GetLuckyBlocks.Parent = AdminFolder

local GetMutations = Instance.new("RemoteFunction")
GetMutations.Name = "GetMutations"
GetMutations.Parent = AdminFolder

local GetTraits = Instance.new("RemoteFunction")
GetTraits.Name = "GetTraits"
GetTraits.Parent = AdminFolder

-- ============================================================
-- GET BASE SKINS — liste toutes les skins de base disponibles
-- ============================================================

local GetBaseSkins = Instance.new("RemoteFunction")
GetBaseSkins.Name = "GetBaseSkins"
GetBaseSkins.Parent = AdminFolder

GetBaseSkins.OnServerInvoke = function(player)
	if not isAdmin(player) then return {} end

	local skinSet = {}
	local list = {}

	local function addSkin(name)
		if type(name) == "string" and name ~= "" and not skinSet[name] then
			skinSet[name] = true
			table.insert(list, name)
		end
	end

	-- Méthode 1 : parcourir Datas.Bases et récupérer tous les noms de skins
	-- Le module Bases a la structure : [rebirthLevel] = { Model = ..., Skins = { SkinName = model } }
	local okBases, BasesData = pcall(function() return require(ReplicatedStorage.Datas.Bases) end)
	if okBases and BasesData then
		for _, baseInfo in pairs(BasesData) do
			if type(baseInfo) == "table" then
				if baseInfo.Skins and type(baseInfo.Skins) == "table" then
					for skinName in pairs(baseInfo.Skins) do addSkin(skinName) end
				end
				if baseInfo.BaseSkins and type(baseInfo.BaseSkins) == "table" then
					for skinName in pairs(baseInfo.BaseSkins) do addSkin(skinName) end
				end
				if baseInfo.SkinList and type(baseInfo.SkinList) == "table" then
					for _, skinName in ipairs(baseInfo.SkinList) do addSkin(skinName) end
				end
			end
		end
	end

	-- Méthode 2 : module BaseSkins dédié
	local okSkins, SkinsData = pcall(function() return require(ReplicatedStorage.Datas.BaseSkins) end)
	if okSkins and SkinsData and type(SkinsData) == "table" then
		for skinName in pairs(SkinsData) do addSkin(skinName) end
	end

	-- Méthode 3 : dossiers dans ReplicatedStorage
	for _, folderName in ipairs({"BaseSkins","BasesSkins","Skins","BaseSkinModels","SkinModels"}) do
		local folder = ReplicatedStorage:FindFirstChild(folderName)
		if folder then
			for _, child in ipairs(folder:GetChildren()) do addSkin(child.Name) end
		end
	end

	-- Méthode 4 : dossiers dans ServerStorage
	if #list == 0 then
		local SS = game:GetService("ServerStorage")
		for _, folderName in ipairs({"BaseSkins","Skins","BaseModels","Bases"}) do
			local folder = SS:FindFirstChild(folderName)
			if folder then
				for _, child in ipairs(folder:GetChildren()) do addSkin(child.Name) end
			end
		end
	end

	-- Méthode 5 : chercher dans workspace.Plots les modèles de base déjà posés
	if #list == 0 then
		local plots = workspace:FindFirstChild("Plots")
		if plots then
			for _, plot in ipairs(plots:GetChildren()) do
				local skin = plot:GetAttribute("Skin") or plot:GetAttribute("BaseSkin")
				if skin then addSkin(skin) end
			end
		end
	end

	-- Méthode 6 : chercher dans les données d'un joueur connecté
	if #list == 0 then
		for _, p in ipairs(Players:GetPlayers()) do
			local ok, ch = pcall(function() return Synchronizer:Get(p) end)
			if ok and ch then
				local unlockedSkins = ch:Get("UnlockedBaseSkins")
				if unlockedSkins and type(unlockedSkins) == "table" then
					for skinName in pairs(unlockedSkins) do addSkin(skinName) end
				end
				local settings = ch:Get("Settings")
				if settings and settings["Base Skin"] then
					addSkin(settings["Base Skin"])
				end
			end
		end
	end

	table.sort(list)
	return list
end

CheckAdmin.OnServerInvoke = function(player)
	print("[Admin] CheckAdmin appelé par", player.Name, "- isAdmin:", isAdmin(player))
	return isAdmin(player)
end

GetEvents.OnServerInvoke = function(player)
	if not isAdmin(player) then return {} end
	local eventsFolder = ServerScriptService.Services.EventService:FindFirstChild("Events")
	if not eventsFolder then return {} end
	local list = {}
	for _, child in ipairs(eventsFolder:GetChildren()) do
		table.insert(list, child.Name)
	end
	table.sort(list)
	return list
end

GetItems.OnServerInvoke = function(player)
	if not isAdmin(player) then return {} end
	local ItemsFolder = ReplicatedStorage:FindFirstChild("Items")
	if not ItemsFolder then return {} end
	local items = {}
	for _, item in ipairs(ItemsFolder:GetChildren()) do
		if item:IsA("Tool") then table.insert(items, item.Name) end
	end
	table.sort(items)
	return items
end

GetBrainrots.OnServerInvoke = function(player)
	if not isAdmin(player) then return {} end
	local list = {}
	for name, data in pairs(AnimalsData) do
		if not data.LuckyBlock then table.insert(list, name) end
	end
	table.sort(list)
	return list
end

GetLuckyBlocks.OnServerInvoke = function(player)
	if not isAdmin(player) then return {} end
	local list = {}
	for name, data in pairs(AnimalsData) do
		if data.LuckyBlock then table.insert(list, name) end
	end
	table.sort(list)
	return list
end

GetMutations.OnServerInvoke = function(player)
	if not isAdmin(player) then return {} end
	local list = {"Normal"}
	for name in pairs(MutationsData) do table.insert(list, name) end
	table.sort(list)
	return list
end

GetTraits.OnServerInvoke = function(player)
	if not isAdmin(player) then return {} end
	local list = {}
	for name in pairs(TraitsData) do table.insert(list, name) end
	table.sort(list)
	return list
end

-- ============================================================
-- BRAINROT COUNT GLOBAL — collecte tous les serveurs
-- ============================================================
local BRAINROT_COUNT_REQUEST  = "AdminBrainrotCountRequest"
local BRAINROT_COUNT_RESPONSE = "AdminBrainrotCountResponse"
local BrainrotCountStore = DataStoreService:GetDataStore("AdminBrainrotCountGlobal")

-- Ce serveur répond aux requêtes des autres serveurs
MessagingService:SubscribeAsync(BRAINROT_COUNT_REQUEST, function(message)
	local data = message.Data
	if not data or not data.RequestId then return end
	-- Compter les brainrots de CE serveur
	local localCounts = {}
	for _, p in ipairs(Players:GetPlayers()) do
		local ok, ch = pcall(function() return Synchronizer:Get(p) end)
		if ok and ch then
			local pods = ch:Get("AnimalPodiums") or {}
			for _, pod in pairs(pods) do
				if type(pod) == "table" and pod.Index then
					local name = pod.Index
					local mut  = pod.Mutation or "Normal"
					if not localCounts[name] then localCounts[name] = {} end
					localCounts[name][mut] = (localCounts[name][mut] or 0) + 1
				end
			end
		end
	end
	-- Publier la réponse
	pcall(function()
		MessagingService:PublishAsync(BRAINROT_COUNT_RESPONSE, {
			RequestId = data.RequestId,
			JobId     = game.JobId,
			Counts    = localCounts,
		})
	end)
end)

-- Résultats en attente par RequestId
local pendingCountRequests = {}

MessagingService:SubscribeAsync(BRAINROT_COUNT_RESPONSE, function(message)
	local data = message.Data
	if not data or not data.RequestId then return end
	local req = pendingCountRequests[data.RequestId]
	if not req then return end
	-- Fusionner les counts de ce serveur
	for name, muts in pairs(data.Counts or {}) do
		if not req.merged[name] then req.merged[name] = {} end
		for mut, count in pairs(muts) do
			req.merged[name][mut] = (req.merged[name][mut] or 0) + count
		end
	end
	req.responses = req.responses + 1
end)

local GetBrainrotData = Instance.new("RemoteFunction")
GetBrainrotData.Name = "GetBrainrotData"
GetBrainrotData.Parent = AdminFolder
GetBrainrotData.OnServerInvoke = function(player)
	if not isAdmin(player) then return {} end

	-- 1. Compter localement ce serveur
	local merged = {}
	for _, p in ipairs(Players:GetPlayers()) do
		local ok, ch = pcall(function() return Synchronizer:Get(p) end)
		if ok and ch then
			local pods = ch:Get("AnimalPodiums") or {}
			for _, pod in pairs(pods) do
				if type(pod) == "table" and pod.Index then
					local name = pod.Index
					local mut  = pod.Mutation or "Normal"
					if not merged[name] then merged[name] = {} end
					merged[name][mut] = (merged[name][mut] or 0) + 1
				end
			end
		end
	end

	-- 2. Demander aux autres serveurs leurs données
	local requestId = tostring(os.time()) .. "_" .. math.random(100000, 999999)
	pendingCountRequests[requestId] = { merged = merged, responses = 0 }

	pcall(function()
		MessagingService:PublishAsync(BRAINROT_COUNT_REQUEST, { RequestId = requestId })
	end)

	-- Attendre les réponses (max 4 secondes)
	task.wait(4)

	local req = pendingCountRequests[requestId]
	pendingCountRequests[requestId] = nil
	if not req then return {} end

	-- 3. Construire le résultat final groupé par rareté
	local result = {}
	for name, data in pairs(AnimalsData) do
		if not data.LuckyBlock then
			local rarity = data.Rarity or "Common"
			if not result[rarity] then result[rarity] = {} end
			table.insert(result[rarity], {
				name        = name,
				displayName = data.DisplayName or name,
				counts      = req.merged[name] or {},
			})
		end
	end

	for _, list in pairs(result) do
		table.sort(list, function(a, b) return a.name < b.name end)
	end
	return result
end

-- ============================================================
-- MESSAGING SUBSCRIPTIONS
-- ============================================================

MessagingService:SubscribeAsync(ANNOUNCE_CHANNEL, function(message)
	local data = message.Data
	if not data or not data.Text then return end
	for _, p in ipairs(Players:GetPlayers()) do
		NotificationEvent:FireClient(p, data.Text, 5, nil, "Top")
	end
end)

MessagingService:SubscribeAsync(GLOBAL_SPAWN_CHANNEL, function(message)
	local data = message.Data
	if typeof(data) ~= "table" then return end
	local brainrot = data.brainrot
	local amount = math.clamp(tonumber(data.amount) or 1, 1, 1000)
	if not brainrot or not AnimalsData[brainrot] then return end
	local mutParam = (data.mutation and data.mutation ~= "None" and data.mutation ~= "Normal") and data.mutation or nil
	local parsedTraits = {}
	if data.traits and type(data.traits) == "table" then
		for _, t in ipairs(data.traits) do
			if type(t) == "string" and TraitsData[t] then table.insert(parsedTraits, t) end
		end
	end
	for i = 1, amount do
		pcall(function()
			AnimalService.spawnAnimalCustom(AnimalsData[brainrot], mutParam, parsedTraits, nil, nil, nil)
		end)
	end
end)

MessagingService:SubscribeAsync(GLOBAL_EVENT_TOPIC, function(message)
	local data = message.Data
	if typeof(data) ~= "table" then return end
	local svc = require(ServerScriptService.Services.EventService)
	if not svc then return end
	if data.Cancel then
		if data.Event then svc:CancelEvent(data.Event) else svc:CancelAllEvents() end
		return
	end
	if data.Event then svc:ExecuteEvent(data.Event, data.Duration) end
end)

MessagingService:SubscribeAsync("GlobalFuseReveal", function(message)
	local data = message.Data
	if not data or not data.Reveal or data.FromServer == game.JobId then return end
	for _, p in ipairs(Players:GetPlayers()) do
		pcall(function()
			local Data = Synchronizer:Get(p)
			if not Data then return end
			local FuseMachine = Data:Get("FuseMachine")
			if not FuseMachine or not FuseMachine.StartTime or FuseMachine.StartTime == 0 then return end
			Data:Set("FuseMachine.FinishTime", workspace:GetServerTimeNow())
			NotificationEvent:FireClient(p, "Servat x LRyze skipped your <font color='#FFD13B'>fuse timer</font>!", 5)
		end)
	end
end)

if StealService then
	local OriginalStartSteal = StealService.StartSteal
	StealService.StartSteal = function(self, player, victimPlotUID, podiumIndex)
		local victimPlotChannel = Synchronizer:Get(victimPlotUID)
		if victimPlotChannel then
			local victimPlayer = victimPlotChannel:Get("Owner")
			if victimPlayer and victimPlayer:GetAttribute("StealProtection") == true then
				NotificationService.Error(player, "You can't steal from this user!")
				return
			end
		end
		return OriginalStartSteal(self, player, victimPlotUID, podiumIndex)
	end
end

local forcedSpeeds = {}
local speedLoops = {}
Players.PlayerRemoving:Connect(function(p)
	forcedSpeeds[p] = nil
	speedLoops[p] = nil
end)

local function protectChar(character)
	for _, part in ipairs(character:GetDescendants()) do
		if part:IsA("BasePart") then
			part:SetAttribute("OriginalCanTouch", part.CanTouch)
			part.CanTouch = false
		end
	end
	local hum = character:FindFirstChildOfClass("Humanoid")
	if hum then
		hum:SetAttribute("OriginalMaxHealth", hum.MaxHealth)
		hum.MaxHealth = math.huge
		hum.Health = math.huge
	end
end

local function unprotectChar(character)
	for _, part in ipairs(character:GetDescendants()) do
		if part:IsA("BasePart") then
			local orig = part:GetAttribute("OriginalCanTouch")
			if orig ~= nil then part.CanTouch = orig; part:SetAttribute("OriginalCanTouch", nil) end
		end
	end
	local hum = character:FindFirstChildOfClass("Humanoid")
	if hum then
		local origH = hum:GetAttribute("OriginalMaxHealth")
		if origH then hum.MaxHealth = origH; hum.Health = origH; hum:SetAttribute("OriginalMaxHealth", nil) end
	end
end

local hitProtected = {}

local function parseTime(input)
	local total = 0
	local m = string.match(tostring(input), "(%d+)m")
	local s = string.match(tostring(input), "(%d+)s")
	if m then total += tonumber(m) * 60 end
	if s then total += tonumber(s) end
	if total == 0 then local raw = tonumber(input); if raw then total = math.floor(raw) end end
	return total
end

-- ============================================================
-- COMMAND HANDLER
-- ============================================================

local function reply(player, success, msg)
	CommandResult:FireClient(player, success, msg or "Done")
end

ExecuteCommand.OnServerEvent:Connect(function(player, command, args)
	if not isAdmin(player) then return end
	args = args or {}

	if command == "addbrainrot" then
		local target = Players:FindFirstChild(args.player or "")
		if not target or not AnimalsData[args.brainrot] then reply(player, false); return end
		local mutation = (args.mutation and args.mutation ~= "" and args.mutation ~= "Normal") and args.mutation or nil
		pcall(function()
			for i = 1, (args.amount or 1) do
				AnimalService.spawnAnimalInBase(target, args.brainrot, mutation, args.traits)
			end
		end)
		reply(player, true, "Brainrot added to {player}")

	elseif command == "spawnbrainrot" then
		if not AnimalsData[args.brainrot] then reply(player, false); return end
		local mutParam = (args.mutation and args.mutation ~= "" and args.mutation ~= "Normal") and args.mutation or nil
		local validTraits = {}
		if args.traits then for _, t in ipairs(args.traits) do if TraitsData[t] then table.insert(validTraits, t) end end end
		pcall(function()
			for i = 1, math.clamp(args.amount or 1, 1, 1000) do
				AnimalService.spawnAnimalCustom(AnimalsData[args.brainrot], mutParam, validTraits, nil, nil, nil)
				task.wait(0.05)
			end
		end)
		reply(player, true, "Brainrot spawned")

	elseif command == "spawnglobalbrainrot" then
		if not AnimalsData[args.brainrot] then reply(player, false); return end
		pcall(function()
			MessagingService:PublishAsync(GLOBAL_SPAWN_CHANNEL, {
				brainrot = args.brainrot, amount = args.amount or 1,
				mutation = args.mutation, traits = args.traits,
			})
		end)
		reply(player, true, "Global brainrot spawned")

	elseif command == "addluckyblock" then
		local target = Players:FindFirstChild(args.player or "")
		if not target or not AnimalsData[args.brainrot] then reply(player, false); return end
		local mutation = (args.mutation and args.mutation ~= "" and args.mutation ~= "Normal") and args.mutation or nil
		pcall(function()
			for i = 1, (args.amount or 1) do
				AnimalService.spawnAnimalInBase(target, args.brainrot, mutation, nil)
			end
		end)
		reply(player, true, "Lucky block given to {player}")

	elseif command == "spawnluckyblock" then
		if not AnimalsData[args.brainrot] then reply(player, false); return end
		local mutParam = (args.mutation and args.mutation ~= "" and args.mutation ~= "Normal") and args.mutation or nil
		pcall(function()
			for i = 1, math.clamp(args.amount or 1, 1, 1000) do
				AnimalService.spawnAnimalCustom(AnimalsData[args.brainrot], mutParam, {}, nil, nil, nil)
				task.wait(0.05)
			end
		end)
		reply(player, true, "Lucky block spawned")

	elseif command == "spawngloballuckyblock" then
		if not AnimalsData[args.brainrot] then reply(player, false); return end
		pcall(function()
			MessagingService:PublishAsync("SpawnGlobalLuckyBlock", {
				blockName = args.brainrot, amount = args.amount or 1, mutation = args.mutation,
			})
		end)
		reply(player, true, "Global lucky block spawned")

	elseif command == "spawnbrainrotalltraits" then
		if not AnimalsData[args.brainrot] then reply(player, false); return end
		local mutParam = (args.mutation and args.mutation ~= "" and args.mutation ~= "Normal") and args.mutation or nil
		local allTraits = {}
		for traitName in pairs(TraitsData) do table.insert(allTraits, traitName) end
		pcall(function()
			for i = 1, math.clamp(args.amount or 1, 1, 100) do
				AnimalService.spawnAnimalCustom(AnimalsData[args.brainrot], mutParam, allTraits, nil, nil, nil)
				task.wait(0.05)
			end
		end)
		reply(player, true, "Brainrot spawned with all traits")

	elseif command == "randomsecret" then
		local secrets = {}
		for name, data in pairs(AnimalsData) do
			if data.Rarity == "Secret" then table.insert(secrets, name) end
		end
		if #secrets == 0 then reply(player, false); return end
		pcall(function()
			AnimalService.spawnAnimalCustom(AnimalsData[secrets[math.random(#secrets)]], nil, nil, nil)
		end)
		reply(player, true, "Random secret spawned")

	elseif command == "randomspooky" then
		local LIST = {
			{ Name = "Vampira Cappucina", Chance = 50 }, { Name = "Zombie Tralala", Chance = 20 },
			{ Name = "Frankentteo", Chance = 10 }, { Name = "La Vacca Jacko Linterino", Chance = 6 },
			{ Name = "Trickolino", Chance = 5.5 }, { Name = "Telemorte", Chance = 5 },
			{ Name = "Los Spooky Combinasionas", Chance = 2.5 }, { Name = "La Casa Boo", Chance = 1 },
		}
		local total = 0; for _, v in ipairs(LIST) do total += v.Chance end
		local roll = math.random() * total; local acc = 0; local chosen = LIST[1].Name
		for _, v in ipairs(LIST) do acc += v.Chance; if roll <= acc then chosen = v.Name; break end end
		pcall(function() AnimalService.spawnAnimalCustom(AnimalsData[chosen], nil, nil, nil) end)
		reply(player, true, "Random spooky spawned")

	elseif command == "randomLimitedBrainrotGlobal" then
		local LIST = {
			{ Name = "Sammyni Spyderini", Chance = 90 },
			{ Name = "Bacuru and Egguru", Chance = 8 },
			{ Name = "Tictac Sahur", Chance = 2 },
		}
		local total = 0; for _, v in ipairs(LIST) do total += v.Chance end
		local roll = math.random() * total; local acc = 0; local chosen = LIST[1].Name
		for _, v in ipairs(LIST) do acc += v.Chance; if roll <= acc then chosen = v.Name; break end end
		pcall(function() MessagingService:PublishAsync(GLOBAL_SPAWN_CHANNEL, { brainrot = chosen, amount = 1 }) end)
		reply(player, true, "Random limited spawned globally")

	elseif command == "spawnrandomserverbrainrot" then
		if not AnimalsData[args.brainrot] then reply(player, false); return end
		local Store = DataStoreService:GetDataStore("GlobalBrainrot_CountOnly")
		local Id = tostring(os.time()) .. "_" .. math.random(100000, 999999)
		pcall(function()
			Store:UpdateAsync(Id, function(s) return s or { Count = 0 } end)
			MessagingService:PublishAsync("GlobalBrainrot_CountOnly", {
				Id = Id, Brainrot = args.brainrot, Amount = args.amount or 1,
			})
		end)
		reply(player, true, "Random brainrot spawned on all servers")

	elseif command == "brainrotgrab" then
		local target = Players:FindFirstChild(args.player or "")
		if not target or not AnimalsData[args.brainrot] then reply(player, false); return end
		pcall(function() AnimalService.spawnAnimalInBase(target, args.brainrot, nil, nil) end)
		reply(player, true, "Brainrot grabbed for {player}")

	elseif command == "executeevent" then
		if not args.event or args.event == "" then reply(player, false); return end
		local svc = require(ServerScriptService.Services.EventService)
		pcall(function() svc:ExecuteEvent(args.event, args.duration) end)
		reply(player, true, "Event started")

	elseif command == "executeglobalevent" then
		if not args.event or args.event == "" then reply(player, false); return end
		pcall(function()
			MessagingService:PublishAsync(GLOBAL_EVENT_TOPIC, { Event = args.event, Duration = args.duration })
		end)
		reply(player, true, "Global event started")

	elseif command == "cancelevent" then
		if not args.event or args.event == "" then reply(player, false); return end
		local svc = require(ServerScriptService.Services.EventService)
		pcall(function() svc:CancelEvent(args.event) end)
		reply(player, true, "Event cancelled")

	elseif command == "cancelglobalevent" then
		pcall(function()
			MessagingService:PublishAsync(GLOBAL_EVENT_TOPIC, { Cancel = true, Event = args.event })
		end)
		reply(player, true, "Global event cancelled")

	elseif command == "globalfusereveal" then
		for _, p in ipairs(Players:GetPlayers()) do
			pcall(function()
				local Data = Synchronizer:Get(p)
				if not Data then return end
				local FuseMachine = Data:Get("FuseMachine")
				if not FuseMachine or not FuseMachine.StartTime or FuseMachine.StartTime == 0 then return end
				Data:Set("FuseMachine.FinishTime", workspace:GetServerTimeNow())
				NotificationEvent:FireClient(p, "Servat x LRyze skipped your <font color='#FFD13B'>fuse timer</font>!", 5)
			end)
		end
		pcall(function() MessagingService:PublishAsync("GlobalFuseReveal", { FromServer = game.JobId, Reveal = true }) end)
		reply(player, true, "Fuse timers revealed globally")

	elseif command == "kick" then
		local target = Players:FindFirstChild(args.player or "")
		if not target then reply(player, false); return end
		target:Kick("Kicked by admin.")
		reply(player, true, "{player} kicked")

	elseif command == "ban" then
		if not args.player or not args.reason then reply(player, false); return end
		local userId
		local ok = pcall(function() userId = Players:GetUserIdFromNameAsync(args.player) end)
		if not ok or not userId then reply(player, false); return end
		pcall(function() BanStore:SetAsync(userId, { Reason = args.reason, Time = os.time() }) end)
		local onlinePlayer = Players:GetPlayerByUserId(userId)
		if onlinePlayer then onlinePlayer:Kick("Banned: " .. args.reason) end
		reply(player, true, "{player} banned")

	elseif command == "unban" then
		if not args.player then reply(player, false); return end
		local userId
		local ok = pcall(function() userId = Players:GetUserIdFromNameAsync(args.player) end)
		if not ok or not userId then reply(player, false); return end
		pcall(function() BanStore:RemoveAsync(userId) end)
		reply(player, true, "{player} unbanned")

	elseif command == "setmoney" then
		local target = Players:FindFirstChild(args.player or "")
		if not target then reply(player, false); return end
		MoneyService:Set(target, args.amount or 0)
		reply(player, true, "Money set for {player}")

	elseif command == "setrebirth" then
		local target = Players:FindFirstChild(args.player or "")
		if not target then reply(player, false); return end
		local amount = args.rebirth or 0
		local RebirthData = require(ReplicatedStorage.Datas.Rebirth)
		local BasesData = require(ReplicatedStorage.Datas.Bases)
		local rebirthInfo = RebirthData[amount]
		if not rebirthInfo then reply(player, false); return end
		local ch
		for i = 1, 20 do ch = Synchronizer:Get(target); if ch then break end; task.wait(0.1) end
		if not ch then reply(player, false); return end
		ch:Set("Rebirth", amount)
		if amount == 0 then
			MoneyService:Set(target, 100)
			local pods = {}; for i = 1, 10 do pods[i] = "Empty" end
			ch:Set("AnimalPodiums", pods)
		elseif rebirthInfo.Rewards and rebirthInfo.Rewards.Cash then
			MoneyService:Set(target, rebirthInfo.Rewards.Cash)
		end
		local baseInfo = BasesData[amount]
		if baseInfo and baseInfo.Model then
			pcall(function() PlotService.replacePlot(target, baseInfo.Model:Clone()) end)
		end
		reply(player, true, "Rebirth set for {player}")

	elseif command == "setname" then
		local target = Players:FindFirstChild(args.player or "")
		if not target or not args.name then reply(player, false); return end
		local char = target.Character
		if char then
			local hum = char:FindFirstChildOfClass("Humanoid")
			if hum then
				hum.DisplayName = args.name
				hum.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.Viewer
			end
		end
		reply(player, true, "Name changed for {player}")

	elseif command == "addspins" then
		local target = Players:FindFirstChild(args.player or "")
		if not target then reply(player, false); return end
		local ch = Synchronizer:Get(target)
		if not ch then reply(player, false); return end
		ch:Increase("DivineSpinWheel.Spins", args.spins or 1)
		reply(player, true, "Spins added to {player}")

	elseif command == "addluck" then
		local index = args.luck or 1
		local EndTime = LuckService:GetEndTime()
		EndTime = (EndTime ~= 0) and (EndTime + 900) or (workspace:GetServerTimeNow() + 900)
		LuckService:StartLuck(index, EndTime)
		local text = index == 1
			and 'Servat x LRyze activated <font color="#79DD2F">2x Luck</font>!'
			or 'Servat x LRyze activated <font color="#F8DB14">4x Luck</font>!'
		for _, p in ipairs(Players:GetPlayers()) do
			NotificationService.Notify(p, text, 5, "Sounds.Sfx.Success")
		end
		reply(player, true, "Luck activated")

	elseif command == "endluck" then
		LuckService:StartLuck(0, 0)
		reply(player, true, "Luck ended")

	elseif command == "forcespeed" then
		local target = Players:FindFirstChild(args.player or "")
		if not target then reply(player, false); return end
		local speed = args.speed or 0
		if speed == 0 then
			speedLoops[target] = nil; forcedSpeeds[target] = nil
			target:SetAttribute("IgnoredByAntiCheat", nil)
			local char = target.Character
			local hum = char and char:FindFirstChildOfClass("Humanoid")
			if hum then hum.WalkSpeed = 35 end
		else
			forcedSpeeds[target] = speed
			target:SetAttribute("IgnoredByAntiCheat", true)
			if not speedLoops[target] then
				speedLoops[target] = true
				task.spawn(function()
					while speedLoops[target] and target.Parent do
						local char = target.Character
						local hum = char and char:FindFirstChildOfClass("Humanoid")
						if hum then hum.WalkSpeed = forcedSpeeds[target] end
						task.wait(0.1)
					end
					target:SetAttribute("IgnoredByAntiCheat", nil)
					speedLoops[target] = nil; forcedSpeeds[target] = nil
				end)
			end
		end
		reply(player, true, "Speed forced for {player}")

	elseif command == "hitprotection" then
		local target = Players:FindFirstChild(args.player or "")
		if not target then reply(player, false); return end
		if args.state == "On" then
			hitProtected[target] = true
			if target.Character then protectChar(target.Character) end
			target.CharacterAdded:Connect(function(char)
				task.wait()
				if hitProtected[target] then protectChar(char) end
			end)
		else
			hitProtected[target] = nil
			if target.Character then unprotectChar(target.Character) end
		end
		reply(player, true, "Hit protection updated for {player}")

	elseif command == "stealprotection" then
		local target = Players:FindFirstChild(args.player or "")
		if not target then reply(player, false); return end
		target:SetAttribute("StealProtection", args.state == "On")
		reply(player, true, "Steal protection updated for {player}")

	elseif command == "resetdata" then
		local target = Players:FindFirstChild(args.player or "")
		if not target then reply(player, false); return end
		local DataService = require(ServerScriptService.Services.DataService)
		DataService:ResetData(target)
		reply(player, true, "Data reset for " .. target.Name)

	elseif command == "resetdatafull" then
		-- Reset data + vide tous les podiums + reset l'argent
		local target = Players:FindFirstChild(args.player or "")
		if not target then reply(player, false); return end
		-- 1. Reset les données complètes
		local DataService = require(ServerScriptService.Services.DataService)
		DataService:ResetData(target)
		-- 2. Vider les podiums via Synchronizer
		task.wait(0.3)
		local ch
		for i = 1, 20 do
			ch = Synchronizer:Get(target)
			if ch then break end
			task.wait(0.1)
		end
		if ch then
			local pods = {}
			for i = 1, 50 do pods[i] = "Empty" end
			ch:Set("AnimalPodiums", pods)
			ch:Set("AnimalAddedOrRemoved", true)
			MoneyService:Set(target, 100)
		end
		reply(player, true, "Full reset done for " .. target.Name)

	elseif command == "wipeself" then
		local DataService = require(ServerScriptService.Services.DataService)
		DataService:ResetData(player)
		reply(player, true, "Your data has been wiped")

	elseif command == "giveitem" then
		local target = Players:FindFirstChild(args.player or "")
		if not target then reply(player, false); return end
		local ItemsFolder = ReplicatedStorage:FindFirstChild("Items")
		if not ItemsFolder then reply(player, false); return end
		local BlockedTools = { ["Flying Carpet"] = true, ["Witch's Broom"] = true }
		local tool = ItemsFolder:FindFirstChild(args.item or "")
		if not tool or not tool:IsA("Tool") then reply(player, false); return end
		local backpack = target:FindFirstChild("Backpack")
		local character = target.Character
		if (backpack and backpack:FindFirstChild(args.item)) or (character and character:FindFirstChild(args.item)) then
			reply(player, false); return
		end
		local toolClone = tool:Clone()
		toolClone.Parent = backpack or target:WaitForChild("Backpack")
		for _, obj in ipairs(toolClone:GetDescendants()) do
			if obj:IsA("Script") or obj:IsA("LocalScript") then
				obj.Disabled = (obj.Name == "RemovalMonitor" and BlockedTools[toolClone.Name]) and true or false
			end
		end
		reply(player, true, "Item given to {player}")

	elseif command == "removeitem" then
		local target = Players:FindFirstChild(args.player or "")
		if not target then reply(player, false); return end
		local removed = false
		local backpack = target:FindFirstChild("Backpack")
		if backpack then
			local tool = backpack:FindFirstChild(args.item or "")
			if tool and tool:IsA("Tool") then tool:Destroy(); removed = true end
		end
		if not removed and target.Character then
			local tool = target.Character:FindFirstChild(args.item or "")
			if tool and tool:IsA("Tool") then tool:Destroy(); removed = true end
		end
		reply(player, removed)

	elseif command == "forceluckybrainrot" then
		local target = Players:FindFirstChild(args.player or "")
		if not target or not AnimalsData[args.brainrot] then reply(player, false); return end
		local ch = Synchronizer:Get(target)
		if not ch then reply(player, false); return end
		ch:Set("ForcedLuckyAnimal", args.brainrot)
		reply(player, true, "Lucky brainrot forced for {player}")

	elseif command == "forcefuse" then
		local target = Players:FindFirstChild(args.player or "")
		if not target or not AnimalsData[args.brainrot] then reply(player, false); return end
		local ch = Synchronizer:Get(target)
		if not ch then reply(player, false); return end
		local mutation = (args.mutation and args.mutation ~= "" and args.mutation ~= "Normal") and args.mutation or nil
		ch:Set("FuseMachine.ForcedBrainrot", { Animal = args.brainrot, Mutation = mutation, Traits = args.traits })
		reply(player, true, "Fusion forced for {player}")

	elseif command == "unlockindex" then
		local target = Players:FindFirstChild(args.player or "")
		if not target then reply(player, false); return end
		local ch
		for i = 1, 20 do ch = Synchronizer:Get(target); if ch then break end; task.wait(0.1) end
		if not ch then reply(player, false); return end
		local Animals = require(ReplicatedStorage.Datas.Animals)
		local ok, IndexData = pcall(function() return require(ReplicatedStorage.Datas.Index) end)
		local index = ch:Get("Index") or {}
		local mutationId = (args.mutation and args.mutation ~= "") and args.mutation or "Default"
		if ok and IndexData then
			local mutationData = IndexData[mutationId]
			local structuredIndex = mutationData and mutationData.Index
			if structuredIndex then
				for animalId in pairs(structuredIndex) do
					index[animalId] = index[animalId] or {}
					if mutationData.CustomIndex then index[animalId][mutationData.CustomIndex.Name] = true
					elseif not mutationData.IsMutation then index[animalId]["Default"] = true
					else index[animalId][mutationId] = true end
				end
			else
				for animalId in pairs(Animals) do
					index[animalId] = index[animalId] or {}
					index[animalId][mutationId] = true
				end
			end
		else
			for animalId in pairs(Animals) do
				index[animalId] = index[animalId] or {}
				index[animalId][mutationId] = true
			end
		end
		ch:Set("Index", index)
		reply(player, true, "Index unlocked for {player}")

	elseif command == "setbaseskin" then
		-- ============================================================
		-- SET BASE SKIN — applique le skin ET unlock tous les animaux
		-- pour ce skin dans l'index du joueur
		-- ============================================================
		local target = Players:FindFirstChild(args.player or "")
		if not target or not args.skin then reply(player, false); return end
		local ch
		for i = 1, 20 do ch = Synchronizer:Get(target); if ch then break end; task.wait(0.1) end
		if not ch then reply(player, false); return end

		local Animals = require(ReplicatedStorage.Datas.Animals)

		-- Unlock le skin dans l'index pour tous les animaux
		local index = ch:Get("Index") or {}
		for animalName in pairs(Animals) do
			index[animalName] = index[animalName] or {}
			index[animalName][args.skin] = true
		end
		ch:Set("Index", index)

		-- Ajouter le skin aux skins débloqués
		local unlockedBases = ch:Get("UnlockedBaseSkins") or {}
		unlockedBases[args.skin] = true
		ch:Set("UnlockedBaseSkins", unlockedBases)

		-- Appliquer le skin actif
		local settings = ch:Get("Settings") or {}
		settings["Base Skin"] = args.skin
		ch:Set("Settings", settings)

		-- Essayer aussi d'appliquer via BaseSkinService si disponible
		pcall(function()
			local BaseSkinService = require(ServerScriptService.Services.BaseSkinService)
			if BaseSkinService and BaseSkinService.ApplySkin then
				BaseSkinService.ApplySkin(target, args.skin)
			end
		end)

		reply(player, true, "Base skin '" .. args.skin .. "' set for " .. target.Name)

	elseif command == "baseposition" then
		local target = Players:FindFirstChild(args.player or "")
		if not target then reply(player, false); return end
		local position = args.position or 1
		local playerPlot = PlotService.getPlot(target)
		if not playerPlot then reply(player, false); return end
		local targetPlot
		for _, plot in ipairs(workspace.Plots:GetChildren()) do
			if plot:GetAttribute("Order") == position then targetPlot = plot; break end
		end
		if not targetPlot or targetPlot == playerPlot then reply(player, false); return end
		for _, p in ipairs(Players:GetPlayers()) do
			if PlotService.getPlot(p) == targetPlot then reply(player, false); return end
		end
		local cfA = playerPlot:GetPivot(); local cfB = targetPlot:GetPivot()
		playerPlot:PivotTo(cfB); targetPlot:PivotTo(cfA)
		local orderA = playerPlot:GetAttribute("Order"); local orderB = targetPlot:GetAttribute("Order")
		playerPlot:SetAttribute("Order", orderB); targetPlot:SetAttribute("Order", orderA)
		reply(player, true, "Base position changed for {player}")

	elseif command == "clearbase" then
		local ch = Synchronizer:Get(player)
		if not ch then reply(player, false); return end
		local AnimalPodiums = ch:Get("AnimalPodiums") or {}
		for idx, data in pairs(AnimalPodiums) do
			if type(data) == "table" and data.Index then AnimalPodiums[idx] = "Empty" end
		end
		ch:Set("AnimalPodiums", AnimalPodiums)
		ch:Set("AnimalAddedOrRemoved", true)
		reply(player, true, "Base cleared")

	elseif command == "NukeBase" then
		local target = Players:FindFirstChild(args.player or "")
		if not target then reply(player, false); return end
		local plot = PlotService.getPlot(target)
		if not plot then reply(player, false); return end
		if args.explode == false then
			local data = Synchronizer:Get(target)
			if not data then reply(player, false); return end
			local rebirthLevel = data:Get("Rebirth") or 0
			local basesData = require(ReplicatedStorage.Datas.Bases)
			local baseTemplate = basesData[rebirthLevel] and basesData[rebirthLevel].Model
			if baseTemplate then pcall(function() PlotService.replacePlot(target, baseTemplate:Clone()) end) end
		else
			local Debris = game:GetService("Debris")
			local debrisFolder = workspace:FindFirstChild("Debris_" .. target.Name)
			if debrisFolder then debrisFolder:ClearAllChildren()
			else
				debrisFolder = Instance.new("Folder")
				debrisFolder.Name = "Debris_" .. target.Name
				debrisFolder.Parent = workspace
			end
			local parts = {}
			for _, obj in ipairs(plot:GetDescendants()) do
				if obj:IsA("BasePart") then table.insert(parts, obj) end
			end
			for _, obj in ipairs(parts) do
				if obj and obj.Parent and obj:IsDescendantOf(plot) then
					local clone = obj:Clone()
					clone:BreakJoints(); clone.Parent = debrisFolder
					clone.Anchored = false; clone.CanCollide = true
					local force = Instance.new("BodyVelocity")
					force.Velocity = Vector3.new(math.random(-40,40), math.random(30,70), math.random(-40,40))
					force.MaxForce = Vector3.new(1e5,1e5,1e5)
					force.Parent = clone; Debris:AddItem(force, 0.2)
					obj:Destroy()
				end
			end
			plot:Destroy()
		end
		reply(player, true, "Base nuked for {player}")

	elseif command == "announce" then
		if not args.text or args.text == "" then reply(player, false); return end
		local message = string.format('<font color="#C84BF5">【%s】</font> %s', player.Name, args.text)
		for _, p in ipairs(Players:GetPlayers()) do
			NotificationEvent:FireClient(p, message, 5, nil, "Top")
		end
		reply(player, true, "Announcement sent")

	elseif command == "globalannounce" then
		if not args.text or args.text == "" then reply(player, false); return end
		pcall(function() MessagingService:PublishAsync(ANNOUNCE_CHANNEL, { Text = args.text }) end)
		reply(player, true, "Global announcement sent")

	elseif command == "rainbowannounce" then
		if not args.text or args.text == "" then reply(player, false); return end
		local gradientText = string.format("<rainbow>%s</rainbow>", args.text)
		pcall(function() MessagingService:PublishAsync("b82db150-528f-4042-a0b5-ad6aaf1a5c333", { Text = args.text }) end)
		for _, p in ipairs(Players:GetPlayers()) do
			NotificationEvent:FireClient(p, gradientText, 5, nil, "Top")
		end
		reply(player, true, "Rainbow announcement sent")

	elseif command == "playerannounce" then
		local target = Players:FindFirstChild(args.player or "")
		if not target or not args.text or args.text == "" then reply(player, false); return end
		NotificationService.Notify(target, args.text, 5, nil, "Top")
		reply(player, true, "Announcement sent to {player}")

	elseif command == "startupdate" then
		if not args.time or args.time == "" then reply(player, false); return end
		local seconds = parseTime(args.time)
		if seconds <= 0 then reply(player, false); return end
		pcall(function() MessagingService:PublishAsync("GLOBAL_UPDATE_COUNTDOWN", seconds) end)
		reply(player, true, "Update countdown started")

	elseif command == "stopupdate" then
		if _G.UpdateCountdownActive then
			_G.UpdateCountdownActive = false
			local ok, GlobalCountdownService = pcall(function()
				return require(ServerScriptService.Services.GlobalCountdownService)
			end)
			if ok then
				GlobalCountdownService.NotifyAll("", 0, nil, "Top", "UpdateIn", true)
				GlobalCountdownService.NotifyAll("", 0, nil, "Top", "UpdateTime", true)
				GlobalCountdownService.NotifyAll("", 0, nil, "Top", "UpdateNow", true)
			end
		end
		reply(player, true, "Update countdown stopped")

	elseif command == "starttacotueday" then
		if not args.time or args.time == "" then reply(player, false); return end
		local seconds = parseTime(args.time)
		if seconds <= 0 then reply(player, false); return end
		local ok, GlobalCountdownService = pcall(function()
			return require(ServerScriptService.Services.GlobalCountdownService)
		end)
		if not ok then reply(player, false); return end
		local LABEL = '<font size="100" color="#FFD700"><b><stroke thickness="3" transparency="0">TACO TUESDAY IN</stroke></b></font>'
		local function buildTime(r)
			local fm = math.floor(r/60); local fs = r%60
			local t = fm>0 and fs>0 and string.format("%dm %ds",fm,fs) or fm>0 and string.format("%dm",fm) or string.format("%ds",fs)
			return string.format('<font size="100" color="#FFFFFF"><b><stroke thickness="3" transparency="0">%s</stroke></b></font>', t)
		end
		if _G.UpdateCountdownActive then _G.UpdateCountdownActive = false; task.wait(0.1) end
		_G.UpdateCountdownActive = true
		task.spawn(function()
			local remaining = seconds
			GlobalCountdownService.NotifyAll(LABEL, 99999, nil, "Top", "UpdateIn", false)
			GlobalCountdownService.NotifyAll(buildTime(remaining), 99999, nil, "Top", "UpdateTime", false)
			while remaining > 0 and _G.UpdateCountdownActive do
				task.wait(1); remaining -= 1
				if not _G.UpdateCountdownActive then break end
				GlobalCountdownService.NotifyAll(buildTime(remaining), 99999, nil, "Top", "UpdateTime", false)
			end
			if not _G.UpdateCountdownActive then return end
			GlobalCountdownService.NotifyAll("", 0, nil, "Top", "UpdateIn", true)
			GlobalCountdownService.NotifyAll("", 0, nil, "Top", "UpdateTime", true)
			GlobalCountdownService.NotifyAll('<font size="100"><b><rainbow>TACO TUESDAY NOW</rainbow></b></font>', 5, nil, "Top", "UpdateNow", false)
			_G.UpdateCountdownActive = nil
		end)
		reply(player, true, "Taco Tuesday countdown started")

	elseif command == "startpoll" then
		if not args.question or not args.option1 or not args.option2 then reply(player, false); return end
		local ok, PollService = pcall(function() return require(ServerScriptService.Services.PollService) end)
		if not ok then reply(player, false); return end
		pcall(function()
			PollService.startPoll({
				question = args.question, option1 = args.option1, option2 = args.option2,
				duration = args.duration or 30, allowSwitch = true,
			})
		end)
		reply(player, true, "Poll started")

	elseif command == "endpoll" then
		local ok, PollService = pcall(function() return require(ServerScriptService.Services.PollService) end)
		if ok then pcall(function() PollService.endActivePoll() end) end
		reply(player, true, "Poll ended")

	elseif command == "morphbrainrot" then
		local target = Players:FindFirstChild(args.player or "")
		if not target or not AnimalsData[args.brainrot] then reply(player, false); return end
		local animalData = AnimalsData[args.brainrot]
		local AnimalModels = ReplicatedStorage.Models.Animals
		local brainrotAsset = AnimalModels:FindFirstChild(animalData.DisplayName)
		if not brainrotAsset then reply(player, false); return end
		local oldChar = target.Character
		if not oldChar then reply(player, false); return end
		local cleanMutation = (args.mutation and args.mutation ~= "" and args.mutation ~= "Normal" and args.mutation ~= "Default") and args.mutation or nil
		local root = oldChar:FindFirstChild("HumanoidRootPart")
		local savedCFrame = root and root.CFrame
		target:LoadCharacter()
		repeat task.wait() until target.Character and target.Character ~= oldChar
		local newChar = target.Character
		local hum = newChar:WaitForChild("Humanoid")
		for _, desc in ipairs(newChar:GetDescendants()) do
			if desc:IsA("BasePart") and desc.Name ~= "HumanoidRootPart" then desc.Transparency = 1
			elseif desc:IsA("Decal") or desc:IsA("SpecialMesh") or desc:IsA("SurfaceAppearance") then desc:Destroy() end
		end
		local clonedModel = brainrotAsset:Clone()
		for _, desc in ipairs(clonedModel:GetDescendants()) do
			if desc:IsA("BasePart") then desc.Anchored = false; desc.CanCollide = false end
		end
		if cleanMutation then
			clonedModel:SetAttribute("Mutation", cleanMutation)
			pcall(function()
				local SharedAnimals = require(ReplicatedStorage.Shared.Animals)
				SharedAnimals:ApplyMutation(clonedModel, animalData.DisplayName, cleanMutation)
			end)
		end
		clonedModel.Parent = newChar
		local hrp = newChar:FindFirstChild("HumanoidRootPart")
		local modelRoot = clonedModel:FindFirstChild("RootPart") or clonedModel:FindFirstChild("FakeRootPart")
			or clonedModel.PrimaryPart or clonedModel:FindFirstChildOfClass("BasePart")
		if savedCFrame then
			local newRoot = newChar:WaitForChild("HumanoidRootPart")
			newRoot.CFrame = savedCFrame
		end
		task.wait()
		if modelRoot and hrp then
			local weld = Instance.new("WeldConstraint")
			weld.Part0 = hrp; weld.Part1 = modelRoot; weld.Parent = modelRoot
		end
		hum.DisplayName = animalData.DisplayName
		hum.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.Viewer
		reply(player, true, "{player} morphed into brainrot")

	elseif command == "morph" then
		local target = Players:FindFirstChild(args.player or "")
		if not target or not args.user then reply(player, false); return end
		local oldChar = target.Character
		if not oldChar then reply(player, false); return end
		local root = oldChar:FindFirstChild("HumanoidRootPart")
		local savedCFrame = root and root.CFrame
		local userId
		local ok = pcall(function() userId = Players:GetUserIdFromNameAsync(args.user) end)
		if not ok or not userId then reply(player, false); return end
		local desc = Players:GetHumanoidDescriptionFromUserId(userId)
		target:LoadCharacter()
		repeat task.wait() until target.Character and target.Character ~= oldChar
		local newChar = target.Character
		local hum = newChar:WaitForChild("Humanoid")
		hum:ApplyDescription(desc)
		task.wait()
		hum.DisplayName = args.user
		hum.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.Viewer
		if savedCFrame then newChar:WaitForChild("HumanoidRootPart").CFrame = savedCFrame end
		reply(player, true, "{player} morphed")

	elseif command == "snapmusic" then
		if not args.variant then reply(player, false); return end
		ServerScriptService:SetAttribute("LastPhaseTheme", args.variant)
		pcall(function() MessagingService:PublishAsync("SnapMusicGlobal", args.variant) end)
		reply(player, true, "Snap music changed")

	elseif command == "settime" then
		game:GetService("Lighting").TimeOfDay = tostring(args.amount or 12)
		reply(player, true, "Time of day set")

	elseif command == "setstock" then
		if not args.stockName or not args.num then reply(player, false); return end
		local attrName = ("StockEvent_%s"):format(string.gsub(args.stockName, "%s", "_"))
		ReplicatedStorage:SetAttribute(attrName, args.num)
		pcall(function()
			MessagingService:PublishAsync(GLOBAL_STOCK_TOPIC, {
				type = "GlobalStockUpdate",
				update = { name = attrName, amount = args.num },
				keyString = args.stockName,
				executioner = player.Name,
			})
		end)
		reply(player, true, "Stock updated")

	elseif command == "addrecipe" then
		if not args.brainrot then reply(player, false); return end
		local ok1, CraftingMachineService = pcall(function()
			return require(ServerScriptService.Services.CraftingMachineService)
		end)
		local ok2, CraftingData = pcall(function()
			return require(game:GetService("ServerStorage").Modules.CraftingData)
		end)
		if not ok1 or not ok2 then reply(player, false); return end
		local foundBrainrot, rarityKey
		for rarity, rarityData in pairs(CraftingData.Rarities) do
			for _, brainrot in ipairs(rarityData.Brainrots) do
				if brainrot.Name == args.brainrot then foundBrainrot = brainrot; rarityKey = rarity; break end
			end
			if foundBrainrot then break end
		end
		if not foundBrainrot then reply(player, false); return end
		local craftables = CraftingMachineService.getList()
		craftables.List[rarityKey] = {
			Name = foundBrainrot.Name,
			CraftTime = CraftingData.Rarities[rarityKey].CraftTime,
			Cost = foundBrainrot.Cost,
			Recipe = foundBrainrot.Recipe,
		}
		CraftingMachineService.updateList(craftables)
		reply(player, true, "Recipe added")

	else
		reply(player, false)
	end
end)

-- Ban check on join
Players.PlayerAdded:Connect(function(p)
	local banData
	local ok = pcall(function() banData = BanStore:GetAsync(p.UserId) end)
	if ok and banData then
		p:Kick("You are banned. Reason: " .. (banData.Reason or "N/A"))
	end
end)

-- ================================================================
-- === FIN ADMINSERVER ===
-- ================================================================

-- ================================================================
-- === DEBUT ADMINCLIENT === (LocalScript dans StarterPlayerScripts)
-- ================================================================

-- AdminClient.lua
-- LocalScript dans StarterPlayerScripts (PAS StarterGui — pour survivre au respawn)

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local mouse = player:GetMouse()

local AdminFolder = ReplicatedStorage:WaitForChild("AdminSystem", 60)
if not AdminFolder then return end

local CheckAdmin      = AdminFolder:WaitForChild("CheckAdmin")
local ExecuteCommand  = AdminFolder:WaitForChild("ExecuteCommand")
local CommandResult   = AdminFolder:WaitForChild("CommandResult")
local GetEvents       = AdminFolder:WaitForChild("GetEvents")
local GetItems        = AdminFolder:WaitForChild("GetItems")
local GetBrainrots    = AdminFolder:WaitForChild("GetBrainrots")
local GetLuckyBlocks  = AdminFolder:WaitForChild("GetLuckyBlocks")
local GetMutations    = AdminFolder:WaitForChild("GetMutations")
local GetTraits       = AdminFolder:WaitForChild("GetTraits")
local GetBrainrotData = AdminFolder:WaitForChild("GetBrainrotData")

task.wait(2)
local isAdmin = CheckAdmin:InvokeServer()
if not isAdmin then return end

-- ============================================================
-- CATEGORIES
-- ============================================================
local CATEGORIES = {

	-- ── 1. BRAINROTS ─────────────────────────────────────────
	{
		name="Brainrots", icon="⚡", color=Color3.fromRGB(255,200,50),
		commands={
			{ name="Add Brainrot",            cmd="addbrainrot",               desc="Add a brainrot to a player",
				fields={{label="Player",key="player",type="player"},{label="Brainrot",key="brainrot",type="brainrot"},{label="Mutation",key="mutation",type="mutation",optional=true},{label="Amount",key="amount",type="number",default="1"},{label="Traits",key="traits",type="traitsmulti",optional=true}} },
			{ name="Spawn Brainrot",          cmd="spawnbrainrot",             desc="Spawn locally in the world",
				fields={{label="Brainrot",key="brainrot",type="brainrot"},{label="Mutation",key="mutation",type="mutation",optional=true},{label="Amount",key="amount",type="number",default="1"},{label="Traits",key="traits",type="traitsmulti",optional=true}} },
			{ name="Spawn Global Brainrot",   cmd="spawnglobalbrainrot",       desc="Spawn on ALL servers",
				fields={{label="Brainrot",key="brainrot",type="brainrot"},{label="Mutation",key="mutation",type="mutation",optional=true},{label="Amount",key="amount",type="number",default="1"},{label="Traits",key="traits",type="traitsmulti",optional=true}} },
			{ name="Add Lucky Block",         cmd="addluckyblock",             desc="Give a lucky block to a player",
				fields={{label="Player",key="player",type="player"},{label="Lucky Block",key="brainrot",type="luckyblock"},{label="Mutation",key="mutation",type="mutation",optional=true},{label="Amount",key="amount",type="number",default="1"}} },
			{ name="Spawn Lucky Block",       cmd="spawnluckyblock",           desc="Spawn a lucky block locally",
				fields={{label="Lucky Block",key="brainrot",type="luckyblock"},{label="Mutation",key="mutation",type="mutation",optional=true},{label="Amount",key="amount",type="number",default="1"}} },
			{ name="Spawn Global Lucky Block",cmd="spawngloballuckyblock",     desc="Spawn lucky blocks everywhere",
				fields={{label="Lucky Block",key="brainrot",type="luckyblock"},{label="Amount",key="amount",type="number",default="1"},{label="Mutation",key="mutation",type="mutation",optional=true}} },
			{ name="Spawn All Traits",        cmd="spawnbrainrotalltraits",    desc="Spawn with all traits",
				fields={{label="Brainrot",key="brainrot",type="brainrot"},{label="Mutation",key="mutation",type="mutation",optional=true},{label="Amount",key="amount",type="number",default="1"}} },
			{ name="Random Secret",           cmd="randomsecret",              desc="Spawn a random secret",           fields={} },
			{ name="Random Spooky",           cmd="randomspooky",              desc="Spawn a random spooky",           fields={} },
			{ name="Random Limited Global",   cmd="randomLimitedBrainrotGlobal",desc="Spawn random limited everywhere", fields={} },
			{ name="Spawn Random Server",     cmd="spawnrandomserverbrainrot", desc="Spawn random on each server",
				fields={{label="Brainrot",key="brainrot",type="brainrot"},{label="Amount",key="amount",type="number",default="1"}} },
			{ name="Brainrot Grab",           cmd="brainrotgrab",              desc="Grab a brainrot for a player",
				fields={{label="Brainrot",key="brainrot",type="brainrot"},{label="Target player",key="player",type="player"}} },
		}
	},

	-- ── 2. EVENTS ────────────────────────────────────────────
	{
		name="Events", icon="🗓️", color=Color3.fromRGB(120,180,255),
		commands={
			{ name="Execute Event",        cmd="executeevent",      desc="Start a local event",        fields={{label="Event",key="event",type="event"},{label="Duration (s)",key="duration",type="number",optional=true}} },
			{ name="Execute Global Event", cmd="executeglobalevent",desc="Start event on all servers", fields={{label="Event",key="event",type="event"},{label="Duration (s)",key="duration",type="number",optional=true}} },
			{ name="Cancel Event",         cmd="cancelevent",       desc="Cancel a local event",       fields={{label="Event",key="event",type="event"}} },
			{ name="Cancel Global Event",  cmd="cancelglobalevent", desc="Cancel event everywhere",    fields={{label="Event (empty=all)",key="event",type="event",optional=true}} },
			{ name="Fuse Reveal Global",   cmd="globalfusereveal",  desc="Reveal all fusions",         fields={} },
		}
	},

	-- ── 3. PLAYERS ───────────────────────────────────────────
	{
		name="Players", icon="👤", color=Color3.fromRGB(100,200,255),
		commands={
			{ name="Kick",                 cmd="kick",              desc="Kick a player",            fields={{label="Player",key="player",type="player"}} },
			{ name="Ban",                  cmd="ban",               desc="Ban a player",             fields={{label="Player name",key="player",type="text"},{label="Reason",key="reason",type="text"}} },
			{ name="Unban",                cmd="unban",             desc="Unban a player",           fields={{label="Player name",key="player",type="text"}} },
			{ name="Set Money",            cmd="setmoney",          desc="Set money",                fields={{label="Player",key="player",type="player"},{label="Amount",key="amount",type="number"}} },
			{ name="Set Rebirth",          cmd="setrebirth",        desc="Set rebirth",              fields={{label="Player",key="player",type="player"},{label="Rebirth",key="rebirth",type="number"}} },
			{ name="Set Name",             cmd="setname",           desc="Change display name",      fields={{label="Player",key="player",type="player"},{label="New name",key="name",type="text"}} },
			{ name="Add Spins",            cmd="addspins",          desc="Add divine spins",         fields={{label="Player",key="player",type="player"},{label="Amount",key="spins",type="number"}} },
			{ name="Add Luck",             cmd="addluck",           desc="Activate luck (1=2x/2=4x)",fields={{label="Index (1=2x|2=4x)",key="luck",type="number"}} },
			{ name="End Luck",             cmd="endluck",           desc="Stop luck",                fields={} },
			{ name="Force Speed",          cmd="forcespeed",        desc="Force speed (0=reset)",    fields={{label="Player",key="player",type="player"},{label="Speed (0=reset)",key="speed",type="number"}} },
			{ name="Hit Protection",       cmd="hitprotection",     desc="Hit protection",           fields={{label="Player",key="player",type="player"},{label="State",key="state",type="onoff"}} },
			{ name="Steal Protection",     cmd="stealprotection",   desc="Steal protection",         fields={{label="Player",key="player",type="player"},{label="State",key="state",type="onoff"}} },
			{ name="Give Item",            cmd="giveitem",          desc="Give an item",             fields={{label="Player",key="player",type="player"},{label="Item",key="item",type="item"}} },
			{ name="Remove Item",          cmd="removeitem",        desc="Remove an item",           fields={{label="Player",key="player",type="player"},{label="Item name",key="item",type="text"}} },
			{ name="Force Lucky Brainrot", cmd="forceluckybrainrot",desc="Force next lucky",         fields={{label="Player",key="player",type="player"},{label="Brainrot",key="brainrot",type="brainrot"}} },
			{ name="Force Fuse",           cmd="forcefuse",         desc="Force fusion",             fields={{label="Player",key="player",type="player"},{label="Brainrot",key="brainrot",type="brainrot"},{label="Mutation",key="mutation",type="mutation",optional=true},{label="Traits",key="traits",type="traitsmulti",optional=true}} },
			{ name="Unlock Index",         cmd="unlockindex",       desc="Unlock index",             fields={{label="Player",key="player",type="player"},{label="Mutation (opt.)",key="mutation",type="text",optional=true}} },
			{ name="Set Base Skin",        cmd="setbaseskin",       desc="Change base skin",         fields={{label="Player",key="player",type="player"},{label="Skin",key="skin",type="text"}} },
			{ name="Base Position",        cmd="baseposition",      desc="Change base position",     fields={{label="Player",key="player",type="player"},{label="Position (1-8)",key="position",type="number"}} },
			{ name="Clear Base",           cmd="clearbase",         desc="Clear own base",           fields={} },
			{ name="Nuke Base",            cmd="NukeBase",          desc="Nuke base (false=restore)",fields={{label="Player",key="player",type="player"},{label="Explode?",key="explode",type="bool",default="true"}} },
		}
	},

	-- ── 4. DATA (reset seulement) ────────────────────────────
	{
		name="Data", icon="🗄️", color=Color3.fromRGB(255,100,100),
		commands={
			{ name="Reset Data Player", cmd="resetdata",    desc="⚠ Reset toutes les données d'un joueur", fields={{label="Nom du joueur (pseudo Roblox)",key="player",type="text"}} },
			{ name="Reset Data + Base", cmd="resetdatafull",desc="⚠ Reset données ET vide toute la base",  fields={{label="Nom du joueur (pseudo Roblox)",key="player",type="text"}} },
			{ name="Wipe Self",         cmd="wipeself",     desc="Reset tes propres données",              fields={} },
		}
	},

	-- ── 5. ANNOUNCE (toutes les commandes d'annonce) ─────────
	{
		name="Announce", icon="📢", color=Color3.fromRGB(255,180,50),
		commands={
			{ name="Announce",           cmd="announce",       desc="Annonce locale (ce serveur)",
				fields={{label="Message",key="text",type="text"}} },
			{ name="Global Announce",    cmd="globalannounce", desc="Annonce sur TOUS les serveurs",
				fields={{label="Message",key="text",type="text"}} },
			{ name="Rainbow Announce",   cmd="rainbowannounce",desc="Annonce arc-en-ciel globale",
				fields={{label="Message",key="text",type="text"}} },
			{ name="Player Announce",    cmd="playerannounce", desc="Annonce privée à un joueur",
				fields={{label="Player",key="player",type="player"},{label="Message",key="text",type="text"}} },
			{ name="Start Update",       cmd="startupdate",    desc="Compte à rebours update global",
				fields={{label="Temps (ex: 5m 30s)",key="time",type="text"}} },
			{ name="Stop Update",        cmd="stopupdate",     desc="Arrêter le compte à rebours",    fields={} },
			{ name="Start Taco Tuesday", cmd="starttacotueday",desc="Compte à rebours Taco Tuesday",
				fields={{label="Temps (ex: 5m 30s)",key="time",type="text"}} },
			{ name="Start Poll",         cmd="startpoll",      desc="Lancer un sondage global",
				fields={{label="Question",key="question",type="text"},{label="Option 1",key="option1",type="text"},{label="Option 2",key="option2",type="text"},{label="Durée (s)",key="duration",type="number",default="30",optional=true}} },
			{ name="End Poll",           cmd="endpoll",        desc="Terminer le sondage actif",      fields={} },
		}
	},

	-- ── 6. BRAINROT COUNT ─────────────────────────────────────
	{ name="Brainrot Count", icon="📊", color=Color3.fromRGB(255,255,255), isCount=true, commands={} },
}

-- ============================================================
-- STATE
-- ============================================================
local currentCategory = 1
local currentCommand  = nil
local isDragging      = false
local dragOffset      = Vector2.new()
local guiVisible      = false
local toggleDebounce  = false
local playerList={} local eventList={} local itemList={}
local brainrotList={} local luckyBlockList={} local mutationList={} local traitList={}
local activeFormFields={} local tabButtons={} local cmdButtons={}
local buildForm

-- ============================================================
-- COULEURS
-- ============================================================
local BG        = Color3.fromRGB(18, 18, 22)
local BG2       = Color3.fromRGB(24, 24, 30)
local BG3       = Color3.fromRGB(30, 30, 38)
local BG_TAB    = Color3.fromRGB(28, 28, 35)
local BG_TAB_ON = Color3.fromRGB(38, 38, 48)
local BORDER    = Color3.fromRGB(255, 255, 255)
local TEXT      = Color3.fromRGB(255, 255, 255)
local TEXT2     = Color3.fromRGB(180, 190, 210)
local TEXT3     = Color3.fromRGB(100, 110, 130)
local GOLD      = Color3.fromRGB(255, 200, 50)
local GREEN     = Color3.fromRGB(50, 200, 90)
local RED       = Color3.fromRGB(220, 60, 60)

local function mkC(p,r) local c=Instance.new("UICorner");c.CornerRadius=UDim.new(0,r or 10);c.Parent=p end
local function mkS(p,col,tr,th) local s=Instance.new("UIStroke");s.Color=col or BORDER;s.Transparency=tr or 0.82;s.Thickness=th or 1;s.Parent=p end

-- ============================================================
-- SCREEN GUI
-- ============================================================
local screenGui = Instance.new("ScreenGui")
screenGui.Name="AdminPanel"; screenGui.ResetOnSpawn=false
screenGui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
screenGui.DisplayOrder=999; screenGui.Parent=player.PlayerGui

local W,H = 900,560

local mainFrame = Instance.new("Frame")
mainFrame.Name="MainFrame"; mainFrame.Size=UDim2.new(0,W,0,H)
mainFrame.Position=UDim2.new(0.5,-W/2,0.5,-H/2)
mainFrame.BackgroundColor3=BG; mainFrame.BackgroundTransparency=0.35
mainFrame.BorderSizePixel=0; mainFrame.Visible=false
mainFrame.ClipsDescendants=true; mainFrame.ZIndex=3
mainFrame.Parent=screenGui; mkC(mainFrame,16); mkS(mainFrame,BORDER,0.75,1)

-- Header
local headerBar=Instance.new("Frame"); headerBar.Size=UDim2.new(1,0,0,56)
headerBar.BackgroundColor3=BG2; headerBar.BackgroundTransparency=0.30
headerBar.BorderSizePixel=0; headerBar.ZIndex=5; headerBar.Parent=mainFrame; mkC(headerBar,16)
local hFill=Instance.new("Frame"); hFill.Size=UDim2.new(1,0,0,16); hFill.Position=UDim2.new(0,0,1,-16)
hFill.BackgroundColor3=BG2; hFill.BackgroundTransparency=0.30; hFill.BorderSizePixel=0; hFill.ZIndex=4; hFill.Parent=headerBar
local hBorder=Instance.new("Frame"); hBorder.Size=UDim2.new(1,0,0,1); hBorder.Position=UDim2.new(0,0,1,-1)
hBorder.BackgroundColor3=BORDER; hBorder.BackgroundTransparency=0.82; hBorder.BorderSizePixel=0; hBorder.ZIndex=6; hBorder.Parent=headerBar

local hIconBg=Instance.new("Frame"); hIconBg.Size=UDim2.new(0,34,0,34); hIconBg.Position=UDim2.new(0,14,0.5,-17)
hIconBg.BackgroundColor3=GOLD; hIconBg.BackgroundTransparency=0.1; hIconBg.BorderSizePixel=0; hIconBg.ZIndex=6; hIconBg.Parent=headerBar; mkC(hIconBg,9)
local hIcon=Instance.new("TextLabel"); hIcon.Size=UDim2.new(1,0,1,0); hIcon.BackgroundTransparency=1
hIcon.Text="⚡"; hIcon.TextSize=18; hIcon.Font=Enum.Font.GothamBold; hIcon.TextColor3=Color3.fromRGB(20,20,20); hIcon.ZIndex=7; hIcon.Parent=hIconBg

local hTitle=Instance.new("TextLabel"); hTitle.Size=UDim2.new(0,160,0,22); hTitle.Position=UDim2.new(0,56,0,9)
hTitle.BackgroundTransparency=1; hTitle.Text="ADMIN PANEL"; hTitle.TextColor3=TEXT; hTitle.TextSize=15
hTitle.Font=Enum.Font.GothamBold; hTitle.TextXAlignment=Enum.TextXAlignment.Left; hTitle.ZIndex=6; hTitle.Parent=headerBar

local hSub=Instance.new("TextLabel"); hSub.Size=UDim2.new(0,260,0,14); hSub.Position=UDim2.new(0,57,0,31)
hSub.BackgroundTransparency=1; hSub.Text="steal a Servat x LRyze  "..player.Name
hSub.TextColor3=TEXT3; hSub.TextSize=10; hSub.Font=Enum.Font.Gotham; hSub.TextXAlignment=Enum.TextXAlignment.Left; hSub.ZIndex=6; hSub.Parent=headerBar

local tabsFrame=Instance.new("Frame"); tabsFrame.Size=UDim2.new(0,520,0,36); tabsFrame.Position=UDim2.new(0,225,0.5,-18)
tabsFrame.BackgroundTransparency=1; tabsFrame.ZIndex=6; tabsFrame.Parent=headerBar
local tabsLayout=Instance.new("UIListLayout"); tabsLayout.FillDirection=Enum.FillDirection.Horizontal
tabsLayout.Padding=UDim.new(0,4); tabsLayout.VerticalAlignment=Enum.VerticalAlignment.Center; tabsLayout.Parent=tabsFrame

local closeBtn=Instance.new("TextButton"); closeBtn.Size=UDim2.new(0,32,0,32); closeBtn.Position=UDim2.new(1,-46,0.5,-16)
closeBtn.BackgroundColor3=RED; closeBtn.BackgroundTransparency=0.1; closeBtn.BorderSizePixel=0
closeBtn.Text="✕"; closeBtn.TextColor3=TEXT; closeBtn.TextSize=14; closeBtn.Font=Enum.Font.GothamBold
closeBtn.ZIndex=7; closeBtn.Parent=headerBar; mkC(closeBtn,9)

-- Body
local body=Instance.new("Frame"); body.Size=UDim2.new(1,-24,1,-68); body.Position=UDim2.new(0,12,0,60)
body.BackgroundTransparency=1; body.ZIndex=3; body.Parent=mainFrame

-- Cmd panel gauche
local cmdListPanel=Instance.new("Frame"); cmdListPanel.Size=UDim2.new(0,340,1,0)
cmdListPanel.BackgroundColor3=BG2; cmdListPanel.BackgroundTransparency=0.35
cmdListPanel.BorderSizePixel=0; cmdListPanel.ZIndex=4; cmdListPanel.Parent=body
mkC(cmdListPanel,12); mkS(cmdListPanel,BORDER,0.82,1)

local cmdSectionLbl=Instance.new("TextLabel"); cmdSectionLbl.Size=UDim2.new(1,-16,0,32); cmdSectionLbl.Position=UDim2.new(0,14,0,4)
cmdSectionLbl.BackgroundTransparency=1; cmdSectionLbl.Text="BRAINROTS"; cmdSectionLbl.TextColor3=GOLD
cmdSectionLbl.TextSize=10; cmdSectionLbl.Font=Enum.Font.GothamBold; cmdSectionLbl.TextXAlignment=Enum.TextXAlignment.Left; cmdSectionLbl.ZIndex=5; cmdSectionLbl.Parent=cmdListPanel

local cmdScroll=Instance.new("ScrollingFrame"); cmdScroll.Size=UDim2.new(1,-8,1,-42); cmdScroll.Position=UDim2.new(0,4,0,38)
cmdScroll.BackgroundTransparency=1; cmdScroll.BorderSizePixel=0; cmdScroll.ScrollBarThickness=3
cmdScroll.ScrollBarImageColor3=GOLD; cmdScroll.CanvasSize=UDim2.new(0,0,0,0)
cmdScroll.AutomaticCanvasSize=Enum.AutomaticSize.Y; cmdScroll.ZIndex=4; cmdScroll.Parent=cmdListPanel
local cmdPad=Instance.new("UIPadding"); cmdPad.PaddingTop=UDim.new(0,4); cmdPad.PaddingBottom=UDim.new(0,4)
cmdPad.PaddingLeft=UDim.new(0,6); cmdPad.PaddingRight=UDim.new(0,6); cmdPad.Parent=cmdScroll
local cmdLayout=Instance.new("UIListLayout"); cmdLayout.Padding=UDim.new(0,4); cmdLayout.Parent=cmdScroll

-- Form panel droite
local formPanel=Instance.new("Frame"); formPanel.Size=UDim2.new(1,-352,1,0); formPanel.Position=UDim2.new(0,352,0,0)
formPanel.BackgroundColor3=BG2; formPanel.BackgroundTransparency=0.35
formPanel.BorderSizePixel=0; formPanel.ZIndex=4; formPanel.Parent=body
mkC(formPanel,12); mkS(formPanel,BORDER,0.82,1)

local selectHint=Instance.new("TextLabel"); selectHint.Size=UDim2.new(1,0,1,0); selectHint.BackgroundTransparency=1
selectHint.Text="← Select a command"; selectHint.TextColor3=TEXT3; selectHint.TextSize=14; selectHint.Font=Enum.Font.Gotham; selectHint.ZIndex=5; selectHint.Parent=formPanel

local formScroll=Instance.new("ScrollingFrame"); formScroll.Size=UDim2.new(1,-8,1,-8); formScroll.Position=UDim2.new(0,4,0,4)
formScroll.BackgroundTransparency=1; formScroll.BorderSizePixel=0; formScroll.ScrollBarThickness=3
formScroll.ScrollBarImageColor3=GOLD; formScroll.CanvasSize=UDim2.new(0,0,0,0)
formScroll.AutomaticCanvasSize=Enum.AutomaticSize.Y; formScroll.Visible=false; formScroll.ZIndex=4; formScroll.Parent=formPanel
local fPad=Instance.new("UIPadding"); fPad.PaddingTop=UDim.new(0,14); fPad.PaddingBottom=UDim.new(0,14)
fPad.PaddingLeft=UDim.new(0,16); fPad.PaddingRight=UDim.new(0,16); fPad.Parent=formScroll
local fLayout=Instance.new("UIListLayout"); fLayout.Padding=UDim.new(0,10); fLayout.Parent=formScroll

-- Notif
local notifHolder=Instance.new("Frame"); notifHolder.Size=UDim2.new(0,300,0,400); notifHolder.Position=UDim2.new(1,-312,1,-410)
notifHolder.BackgroundTransparency=1; notifHolder.Parent=screenGui
local notifLayout=Instance.new("UIListLayout"); notifLayout.VerticalAlignment=Enum.VerticalAlignment.Bottom; notifLayout.Padding=UDim.new(0,8); notifLayout.Parent=notifHolder

-- HUD Button
local hudSG=Instance.new("ScreenGui"); hudSG.Name="AdminHudBtn"; hudSG.ResetOnSpawn=false
hudSG.ZIndexBehavior=Enum.ZIndexBehavior.Sibling; hudSG.DisplayOrder=9999; hudSG.Parent=player.PlayerGui
local hudBtn=Instance.new("TextButton"); hudBtn.Size=UDim2.new(0,46,0,46); hudBtn.Position=UDim2.new(1,-58,1,-58)
hudBtn.BackgroundColor3=BG2; hudBtn.BackgroundTransparency=0.05; hudBtn.BorderSizePixel=0
hudBtn.Text="⚡"; hudBtn.TextColor3=GOLD; hudBtn.TextSize=20; hudBtn.Font=Enum.Font.GothamBold; hudBtn.Parent=hudSG
mkC(hudBtn,13); mkS(hudBtn,GOLD,0.5,1.5)
hudBtn.MouseEnter:Connect(function() TweenService:Create(hudBtn,TweenInfo.new(0.1),{BackgroundColor3=BG3}):Play() end)
hudBtn.MouseLeave:Connect(function() TweenService:Create(hudBtn,TweenInfo.new(0.1),{BackgroundColor3=BG2}):Play() end)

-- ============================================================
-- HELPERS UI
-- ============================================================
local function showNotif(text,success)
	local notif=Instance.new("Frame"); notif.Size=UDim2.new(0,300,0,60); notif.BackgroundColor3=BG2
	notif.BackgroundTransparency=0.05; notif.BorderSizePixel=0; notif.ClipsDescendants=true
	notif.Parent=notifHolder; mkC(notif,14); mkS(notif,BORDER,0.78,1)
	local bar=Instance.new("Frame"); bar.Size=UDim2.new(0,3,0.6,0); bar.Position=UDim2.new(0,0,0.2,0)
	bar.BackgroundColor3=success and GREEN or RED; bar.BackgroundTransparency=0; bar.BorderSizePixel=0; bar.Parent=notif; mkC(bar,2)
	local iconBg=Instance.new("Frame"); iconBg.Size=UDim2.new(0,32,0,32); iconBg.Position=UDim2.new(0,12,0.5,-16)
	iconBg.BackgroundColor3=success and GREEN or RED; iconBg.BackgroundTransparency=0.7; iconBg.BorderSizePixel=0; iconBg.Parent=notif; mkC(iconBg,16)
	local icon=Instance.new("TextLabel"); icon.Size=UDim2.new(1,0,1,0); icon.BackgroundTransparency=1
	icon.Text=success and "✓" or "✕"; icon.TextColor3=TEXT; icon.TextSize=14; icon.Font=Enum.Font.GothamBold; icon.Parent=iconBg
	local lbl=Instance.new("TextLabel"); lbl.Size=UDim2.new(0,210,0,18); lbl.Position=UDim2.new(0,54,0,10)
	lbl.BackgroundTransparency=1; lbl.Text=success and "Command executed" or "Command failed"
	lbl.TextColor3=TEXT; lbl.TextSize=13; lbl.Font=Enum.Font.GothamBold; lbl.TextXAlignment=Enum.TextXAlignment.Left; lbl.Parent=notif
	local sub=Instance.new("TextLabel"); sub.Size=UDim2.new(0,220,0,14); sub.Position=UDim2.new(0,54,0,32)
	sub.BackgroundTransparency=1; sub.Text=tostring(text); sub.TextColor3=TEXT3; sub.TextSize=10
	sub.Font=Enum.Font.Gotham; sub.TextXAlignment=Enum.TextXAlignment.Left; sub.TextTruncate=Enum.TextTruncate.AtEnd; sub.Parent=notif
	local progBg=Instance.new("Frame"); progBg.Size=UDim2.new(1,0,0,2); progBg.Position=UDim2.new(0,0,1,-2)
	progBg.BackgroundColor3=BG3; progBg.BackgroundTransparency=0; progBg.BorderSizePixel=0; progBg.Parent=notif
	local prog=Instance.new("Frame"); prog.Size=UDim2.new(1,0,1,0)
	prog.BackgroundColor3=success and GREEN or RED; prog.BackgroundTransparency=0; prog.BorderSizePixel=0; prog.Parent=progBg; mkC(prog,2)
	notif.Position=UDim2.new(1,10,0,0)
	TweenService:Create(notif,TweenInfo.new(0.3,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{Position=UDim2.new(0,0,0,0)}):Play()
	TweenService:Create(prog,TweenInfo.new(3.5,Enum.EasingStyle.Linear),{Size=UDim2.new(0,0,1,0)}):Play()
	task.delay(3.5,function()
		if notif and notif.Parent then
			TweenService:Create(notif,TweenInfo.new(0.25,Enum.EasingStyle.Quint,Enum.EasingDirection.In),{Position=UDim2.new(1,10,0,0),BackgroundTransparency=1}):Play()
			task.wait(0.3); if notif and notif.Parent then notif:Destroy() end
		end
	end)
end

local activeDropOverlay=nil

local function makeDropdown(placeholder,options)
	local selected=nil; local isOpen=false; local justSelected=false
	local btn=Instance.new("TextButton"); btn.Size=UDim2.new(1,0,0,38)
	btn.BackgroundColor3=BG3; btn.BackgroundTransparency=0.05; btn.BorderSizePixel=0; btn.Text=""
	mkC(btn,9); mkS(btn,BORDER,0.82,1)
	local btnTxt=Instance.new("TextLabel"); btnTxt.Size=UDim2.new(1,-36,1,0); btnTxt.Position=UDim2.new(0,12,0,0)
	btnTxt.BackgroundTransparency=1; btnTxt.Text=placeholder; btnTxt.TextColor3=TEXT3; btnTxt.TextSize=12
	btnTxt.Font=Enum.Font.Gotham; btnTxt.TextXAlignment=Enum.TextXAlignment.Left; btnTxt.TextTruncate=Enum.TextTruncate.AtEnd; btnTxt.Parent=btn
	local arrow=Instance.new("TextLabel"); arrow.Size=UDim2.new(0,24,1,0); arrow.Position=UDim2.new(1,-28,0,0)
	arrow.BackgroundTransparency=1; arrow.Text="▾"; arrow.TextColor3=TEXT3; arrow.TextSize=11; arrow.Font=Enum.Font.Gotham; arrow.Parent=btn
	local function closeOv()
		if activeDropOverlay and activeDropOverlay.Parent then activeDropOverlay:Destroy(); activeDropOverlay=nil end; isOpen=false
	end
	local function openOv()
		closeOv(); isOpen=true
		local ap=btn.AbsolutePosition; local as=btn.AbsoluteSize; local h=math.min(#options,7)*32+46
		local ov=Instance.new("Frame"); ov.Size=UDim2.new(0,as.X,0,h); ov.Position=UDim2.new(0,ap.X,0,ap.Y+as.Y+4)
		ov.BackgroundColor3=BG; ov.BackgroundTransparency=0.02; ov.BorderSizePixel=0; ov.ZIndex=200; ov.ClipsDescendants=true
		ov.Parent=screenGui; mkC(ov,10); mkS(ov,GOLD,0.5,1); activeDropOverlay=ov
		local sb=Instance.new("TextBox"); sb.Size=UDim2.new(1,-12,0,32); sb.Position=UDim2.new(0,6,0,6)
		sb.BackgroundColor3=BG3; sb.BackgroundTransparency=0.05; sb.BorderSizePixel=0
		sb.PlaceholderText="🔍 Search..."; sb.PlaceholderColor3=TEXT3; sb.Text=""
		sb.TextColor3=TEXT; sb.TextSize=11; sb.Font=Enum.Font.Gotham; sb.ClearTextOnFocus=false; sb.ZIndex=202; sb.Parent=ov; mkC(sb,7)
		local sp=Instance.new("UIPadding"); sp.PaddingLeft=UDim.new(0,8); sp.Parent=sb
		local ds=Instance.new("ScrollingFrame"); ds.Size=UDim2.new(1,0,1,-44); ds.Position=UDim2.new(0,0,0,44)
		ds.BackgroundTransparency=1; ds.BorderSizePixel=0; ds.ScrollBarThickness=3; ds.ScrollBarImageColor3=GOLD
		ds.CanvasSize=UDim2.new(0,0,0,0); ds.AutomaticCanvasSize=Enum.AutomaticSize.Y; ds.ZIndex=201; ds.Parent=ov
		local dl=Instance.new("UIListLayout"); dl.Padding=UDim.new(0,2); dl.Parent=ds
		local dp=Instance.new("UIPadding"); dp.PaddingTop=UDim.new(0,3); dp.PaddingBottom=UDim.new(0,3); dp.PaddingLeft=UDim.new(0,4); dp.PaddingRight=UDim.new(0,4); dp.Parent=ds
		local function buildOpts(filter)
			for _,c in ipairs(ds:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end
			local fl=filter:lower()
			for _,opt in ipairs(options) do
				if fl=="" or opt:lower():find(fl,1,true) then
					local ob=Instance.new("TextButton"); ob.Size=UDim2.new(1,0,0,30)
					ob.BackgroundColor3=BG3; ob.BackgroundTransparency=0.3; ob.BorderSizePixel=0; ob.Text=opt
					ob.TextColor3=TEXT2; ob.TextSize=11; ob.Font=Enum.Font.Gotham; ob.TextXAlignment=Enum.TextXAlignment.Left; ob.ZIndex=202; ob.Parent=ds; mkC(ob,7)
					local op2=Instance.new("UIPadding"); op2.PaddingLeft=UDim.new(0,10); op2.Parent=ob
					ob.MouseEnter:Connect(function() TweenService:Create(ob,TweenInfo.new(0.1),{BackgroundTransparency=0.0,TextColor3=TEXT}):Play() end)
					ob.MouseLeave:Connect(function() TweenService:Create(ob,TweenInfo.new(0.1),{BackgroundTransparency=0.3,TextColor3=TEXT2}):Play() end)
					ob.MouseButton1Click:Connect(function()
						justSelected=true; selected=opt; btnTxt.Text=opt; btnTxt.TextColor3=TEXT; closeOv(); task.wait(0.1); justSelected=false
					end)
				end
			end
		end
		buildOpts(""); sb:GetPropertyChangedSignal("Text"):Connect(function() buildOpts(sb.Text) end); task.wait(); sb:CaptureFocus()
	end
	btn.MouseButton1Click:Connect(function() if isOpen then closeOv() else openOv() end end)
	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType==Enum.UserInputType.MouseButton1 then
			if justSelected then return end
			if isOpen and activeDropOverlay then
				local mp=UserInputService:GetMouseLocation(); local op=activeDropOverlay.AbsolutePosition; local os2=activeDropOverlay.AbsoluteSize
				local inB=mp.X>=btn.AbsolutePosition.X and mp.X<=btn.AbsolutePosition.X+btn.AbsoluteSize.X and mp.Y>=btn.AbsolutePosition.Y and mp.Y<=btn.AbsolutePosition.Y+btn.AbsoluteSize.Y
				local inBounds=mp.X>=op.X and mp.X<=op.X+os2.X and mp.Y>=op.Y and mp.Y<=op.Y+os2.Y
				if not inBounds and not inB then closeOv() end
			end
		end
	end)
	return { frame=btn, getValue=function() return selected end,
	setValue=function(v) selected=v; btnTxt.Text=v or placeholder; btnTxt.TextColor3=v and TEXT or TEXT3 end,
	reset=function() selected=nil; btnTxt.Text=placeholder; btnTxt.TextColor3=TEXT3 end,
	updateOptions=function(nl) options=nl end }
end

local function makeMultiDropdown(placeholder,options)
	local selected={}; local isOpen=false; local myOv=nil
	local btn=Instance.new("TextButton"); btn.Size=UDim2.new(1,0,0,38)
	btn.BackgroundColor3=BG3; btn.BackgroundTransparency=0.05; btn.BorderSizePixel=0; btn.Text=""; mkC(btn,9); mkS(btn,BORDER,0.82,1)
	local btnTxt=Instance.new("TextLabel"); btnTxt.Size=UDim2.new(1,-36,1,0); btnTxt.Position=UDim2.new(0,12,0,0)
	btnTxt.BackgroundTransparency=1; btnTxt.Text=placeholder; btnTxt.TextColor3=TEXT3; btnTxt.TextSize=11
	btnTxt.Font=Enum.Font.Gotham; btnTxt.TextXAlignment=Enum.TextXAlignment.Left; btnTxt.TextTruncate=Enum.TextTruncate.AtEnd; btnTxt.Parent=btn
	local arrow=Instance.new("TextLabel"); arrow.Size=UDim2.new(0,24,1,0); arrow.Position=UDim2.new(1,-28,0,0)
	arrow.BackgroundTransparency=1; arrow.Text="▾"; arrow.TextColor3=TEXT3; arrow.TextSize=11; arrow.Font=Enum.Font.Gotham; arrow.Parent=btn
	local function upd() if #selected==0 then btnTxt.Text=placeholder; btnTxt.TextColor3=TEXT3 else btnTxt.Text=table.concat(selected,", "); btnTxt.TextColor3=TEXT end end
	local function closeOv() isOpen=false; if myOv and myOv.Parent then myOv:Destroy() end; myOv=nil end
	local function openOv()
		if activeDropOverlay and activeDropOverlay.Parent then activeDropOverlay:Destroy(); activeDropOverlay=nil end
		isOpen=true; local ap=btn.AbsolutePosition; local as=btn.AbsoluteSize; local h=math.min(#options,7)*32+46
		local ov=Instance.new("Frame"); ov.Size=UDim2.new(0,as.X,0,h); ov.Position=UDim2.new(0,ap.X,0,ap.Y+as.Y+4)
		ov.BackgroundColor3=BG; ov.BackgroundTransparency=0.02; ov.BorderSizePixel=0; ov.ZIndex=200; ov.ClipsDescendants=true
		ov.Parent=screenGui; mkC(ov,10); mkS(ov,GOLD,0.5,1); myOv=ov; activeDropOverlay=ov
		local sb=Instance.new("TextBox"); sb.Size=UDim2.new(1,-12,0,32); sb.Position=UDim2.new(0,6,0,6)
		sb.BackgroundColor3=BG3; sb.BackgroundTransparency=0.05; sb.BorderSizePixel=0
		sb.PlaceholderText="🔍 Search..."; sb.PlaceholderColor3=TEXT3; sb.Text=""
		sb.TextColor3=TEXT; sb.TextSize=11; sb.Font=Enum.Font.Gotham; sb.ClearTextOnFocus=false; sb.ZIndex=202; sb.Parent=ov; mkC(sb,7)
		local sp2=Instance.new("UIPadding"); sp2.PaddingLeft=UDim.new(0,8); sp2.Parent=sb
		local ds=Instance.new("ScrollingFrame"); ds.Size=UDim2.new(1,0,1,-44); ds.Position=UDim2.new(0,0,0,44)
		ds.BackgroundTransparency=1; ds.BorderSizePixel=0; ds.ScrollBarThickness=3; ds.ScrollBarImageColor3=GOLD
		ds.CanvasSize=UDim2.new(0,0,0,0); ds.AutomaticCanvasSize=Enum.AutomaticSize.Y; ds.ZIndex=201; ds.Parent=ov
		local dl=Instance.new("UIListLayout"); dl.Padding=UDim.new(0,2); dl.Parent=ds
		local dp=Instance.new("UIPadding"); dp.PaddingTop=UDim.new(0,3); dp.PaddingBottom=UDim.new(0,3); dp.PaddingLeft=UDim.new(0,4); dp.PaddingRight=UDim.new(0,4); dp.Parent=ds
		local function buildOpts(filter)
			for _,c in ipairs(ds:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end
			local fl=filter:lower()
			for _,opt in ipairs(options) do
				if fl=="" or opt:lower():find(fl,1,true) then
					local isSel=table.find(selected,opt)~=nil
					local ob=Instance.new("TextButton"); ob.Size=UDim2.new(1,0,0,30)
					ob.BackgroundColor3=isSel and BG3 or BG; ob.BackgroundTransparency=isSel and 0.0 or 0.3
					ob.BorderSizePixel=0; ob.Text=""; ob.ZIndex=202; ob.Parent=ds; mkC(ob,7)
					local chk=Instance.new("TextLabel"); chk.Size=UDim2.new(0,20,1,0); chk.Position=UDim2.new(0,6,0,0)
					chk.BackgroundTransparency=1; chk.Text=isSel and "✓" or ""; chk.TextColor3=GOLD; chk.TextSize=11; chk.Font=Enum.Font.GothamBold; chk.ZIndex=203; chk.Parent=ob
					local otxt=Instance.new("TextLabel"); otxt.Size=UDim2.new(1,-30,1,0); otxt.Position=UDim2.new(0,26,0,0)
					otxt.BackgroundTransparency=1; otxt.Text=opt; otxt.TextColor3=isSel and TEXT or TEXT2
					otxt.TextSize=11; otxt.Font=Enum.Font.Gotham; otxt.TextXAlignment=Enum.TextXAlignment.Left; otxt.ZIndex=203; otxt.Parent=ob
					ob.MouseButton1Click:Connect(function()
						local idx=table.find(selected,opt)
						if idx then table.remove(selected,idx); ob.BackgroundTransparency=0.3; chk.Text=""; otxt.TextColor3=TEXT2
						else table.insert(selected,opt); ob.BackgroundTransparency=0.0; chk.Text="✓"; otxt.TextColor3=TEXT end; upd()
					end)
				end
			end
		end
		buildOpts(""); sb:GetPropertyChangedSignal("Text"):Connect(function() buildOpts(sb.Text) end); task.wait(); sb:CaptureFocus()
	end
	btn.MouseButton1Click:Connect(function() if isOpen then closeOv() else openOv() end end)
	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType==Enum.UserInputType.MouseButton1 then
			if isOpen and myOv and myOv.Parent then
				local mp=UserInputService:GetMouseLocation(); local op=myOv.AbsolutePosition; local os2=myOv.AbsoluteSize
				local inO=mp.X>=op.X and mp.X<=op.X+os2.X and mp.Y>=op.Y and mp.Y<=op.Y+os2.Y
				local inB=mp.X>=btn.AbsolutePosition.X and mp.X<=btn.AbsolutePosition.X+btn.AbsoluteSize.X and mp.Y>=btn.AbsolutePosition.Y and mp.Y<=btn.AbsolutePosition.Y+btn.AbsoluteSize.Y
				if not inO and not inB then closeOv() end
			end
		end
	end)
	return { frame=btn, getValue=function() return #selected>0 and selected or nil end, reset=function() selected={}; upd() end }
end

local function makeInput(ph)
	local tb=Instance.new("TextBox"); tb.Size=UDim2.new(1,0,0,38)
	tb.BackgroundColor3=BG3; tb.BackgroundTransparency=0.05; tb.BorderSizePixel=0
	tb.PlaceholderText=ph; tb.PlaceholderColor3=TEXT3; tb.Text=""; tb.TextColor3=TEXT
	tb.TextSize=12; tb.Font=Enum.Font.Gotham; tb.ClearTextOnFocus=false; mkC(tb,9); mkS(tb,BORDER,0.82,1)
	local tp=Instance.new("UIPadding"); tp.PaddingLeft=UDim.new(0,12); tp.Parent=tb
	tb.Focused:Connect(function() TweenService:Create(tb,TweenInfo.new(0.15),{BackgroundColor3=BG3,BackgroundTransparency=0.0}):Play() end)
	tb.FocusLost:Connect(function() TweenService:Create(tb,TweenInfo.new(0.15),{BackgroundColor3=BG3,BackgroundTransparency=0.05}):Play() end)
	return tb
end

local function makeExecBtn(text,isRed)
	local bgC=isRed and RED or GREEN; local bgH=isRed and Color3.fromRGB(240,80,80) or Color3.fromRGB(60,220,100)
	local b=Instance.new("TextButton"); b.Size=UDim2.new(1,0,0,44)
	b.BackgroundColor3=bgC; b.BackgroundTransparency=0.05; b.BorderSizePixel=0
	b.Text=text; b.TextColor3=TEXT; b.TextSize=13; b.Font=Enum.Font.GothamBold; mkC(b,10)
	b.MouseEnter:Connect(function() TweenService:Create(b,TweenInfo.new(0.1),{BackgroundColor3=bgH,BackgroundTransparency=0}):Play() end)
	b.MouseLeave:Connect(function() TweenService:Create(b,TweenInfo.new(0.1),{BackgroundColor3=bgC,BackgroundTransparency=0.05}):Play() end)
	return b
end

local function makeLbl(text,size,color,bold)
	local l=Instance.new("TextLabel"); l.BackgroundTransparency=1; l.Text=text
	l.TextColor3=color or TEXT2; l.TextSize=size or 12
	l.Font=bold and Enum.Font.GothamBold or Enum.Font.Gotham; l.TextXAlignment=Enum.TextXAlignment.Left; return l
end

-- ============================================================
-- BUILD TABS
-- ============================================================
local function buildTabs()
	for _,c in ipairs(tabsFrame:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end
	tabButtons={}
	for i,cat in ipairs(CATEGORIES) do
		local tb=Instance.new("TextButton"); tb.Size=UDim2.new(0,0,0,34); tb.AutomaticSize=Enum.AutomaticSize.X
		tb.BackgroundColor3=BG_TAB; tb.BackgroundTransparency=0.1; tb.BorderSizePixel=0
		tb.Text="  "..cat.icon.."  "..cat.name.."  "; tb.TextColor3=TEXT3; tb.TextSize=12; tb.Font=Enum.Font.Gotham; tb.ZIndex=7; tb.Parent=tabsFrame; mkC(tb,9)
		table.insert(tabButtons,tb)
		local idx=i
		tb.MouseEnter:Connect(function() if idx~=currentCategory then TweenService:Create(tb,TweenInfo.new(0.1),{BackgroundColor3=BG_TAB_ON,TextColor3=TEXT2}):Play() end end)
		tb.MouseLeave:Connect(function() if idx~=currentCategory then TweenService:Create(tb,TweenInfo.new(0.1),{BackgroundColor3=BG_TAB,TextColor3=TEXT3}):Play() end end)
		tb.MouseButton1Click:Connect(function() selectCategory(idx) end)
	end
end

local function setActiveTab(idx)
	for i,tb in ipairs(tabButtons) do
		local cat=CATEGORIES[i]
		if i==idx then tb.BackgroundColor3=BG_TAB_ON; tb.TextColor3=cat.color or GOLD; tb.Font=Enum.Font.GothamBold
		else tb.BackgroundColor3=BG_TAB; tb.TextColor3=TEXT3; tb.Font=Enum.Font.Gotham end
	end
end

-- ============================================================
-- BUILD CMD LIST
-- ============================================================
local function buildCmdList(catIdx)
	for _,c in ipairs(cmdScroll:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end
	cmdButtons={}
	local cat=CATEGORIES[catIdx]; if not cat then return end
	cmdSectionLbl.Text=string.upper(cat.name); cmdSectionLbl.TextColor3=cat.color or GOLD

	for i,cmd in ipairs(cat.commands) do
		local isDataDanger = cat.name=="Data" and (cmd.cmd=="resetdata" or cmd.cmd=="resetdatafull")
		local btn=Instance.new("TextButton"); btn.Size=UDim2.new(1,0,0,58)
		btn.BackgroundColor3=isDataDanger and Color3.fromRGB(40,15,15) or BG3; btn.BackgroundTransparency=0.1
		btn.BorderSizePixel=0; btn.Text=""; btn.ZIndex=5; btn.Parent=cmdScroll; mkC(btn,10)
		local bar=Instance.new("Frame"); bar.Size=UDim2.new(0,3,0.6,0); bar.Position=UDim2.new(0,0,0.2,0)
		bar.BackgroundColor3=isDataDanger and RED or (cat.color or GOLD); bar.BackgroundTransparency=isDataDanger and 0.2 or 0.6
		bar.BorderSizePixel=0; bar.Parent=btn; mkC(bar,2)
		local nl=makeLbl(cmd.name,12,isDataDanger and Color3.fromRGB(255,160,160) or TEXT2,true)
		nl.Size=UDim2.new(1,-16,0,22); nl.Position=UDim2.new(0,14,0,9); nl.Parent=btn
		local dl=makeLbl(cmd.desc,10,TEXT3)
		dl.Size=UDim2.new(1,-16,0,14); dl.Position=UDim2.new(0,14,0,33); dl.Parent=btn
		table.insert(cmdButtons,{btn=btn,bar=bar,nl=nl,isDanger=isDataDanger})
		local cIdx=i; local catRef=cat; local cmdRef=cmd
		btn.MouseEnter:Connect(function()
			if cIdx~=currentCommand then
				TweenService:Create(btn,TweenInfo.new(0.1),{BackgroundTransparency=0.0}):Play()
				TweenService:Create(bar,TweenInfo.new(0.1),{BackgroundTransparency=0.2}):Play()
			end
		end)
		btn.MouseLeave:Connect(function()
			if cIdx~=currentCommand then
				TweenService:Create(btn,TweenInfo.new(0.1),{BackgroundTransparency=0.1}):Play()
				TweenService:Create(bar,TweenInfo.new(0.1),{BackgroundTransparency=isDataDanger and 0.2 or 0.6}):Play()
			end
		end)
		btn.MouseButton1Click:Connect(function()
			if currentCommand then
				local old=cmdButtons[currentCommand]
				if old then
					TweenService:Create(old.btn,TweenInfo.new(0.15),{BackgroundTransparency=0.1}):Play()
					TweenService:Create(old.bar,TweenInfo.new(0.15),{BackgroundTransparency=old.isDanger and 0.2 or 0.6}):Play()
					old.nl.TextColor3=old.isDanger and Color3.fromRGB(255,160,160) or TEXT2
				end
			end
			currentCommand=cIdx
			TweenService:Create(btn,TweenInfo.new(0.15),{BackgroundTransparency=0.0}):Play()
			TweenService:Create(bar,TweenInfo.new(0.15),{BackgroundTransparency=0.0}):Play()
			nl.TextColor3=TEXT; buildForm(catRef,cmdRef)
		end)
	end
end

-- ============================================================
-- BUILD FORM
-- ============================================================
buildForm = function(cat,cmd)
	for _,c in ipairs(formScroll:GetChildren()) do if not c:IsA("UIListLayout") and not c:IsA("UIPadding") then c:Destroy() end end
	activeFormFields={}; selectHint.Visible=false; formScroll.Visible=true

	playerList={}; for _,p in ipairs(Players:GetPlayers()) do table.insert(playerList,p.Name) end
	local ok1,ev=pcall(function() return GetEvents:InvokeServer() end); eventList=(ok1 and ev) and ev or {}
	local ok2,it=pcall(function() return GetItems:InvokeServer() end); itemList=(ok2 and it) and it or {}
	local ok3,br=pcall(function() return GetBrainrots:InvokeServer() end); brainrotList=(ok3 and br) and br or {}
	local ok4,lb=pcall(function() return GetLuckyBlocks:InvokeServer() end); luckyBlockList=(ok4 and lb) and lb or {}
	local ok5,mu=pcall(function() return GetMutations:InvokeServer() end); mutationList=(ok5 and mu) and mu or {"Normal"}
	local ok6,tr=pcall(function() return GetTraits:InvokeServer() end); traitList=(ok6 and tr) and tr or {}

	local title=makeLbl(cmd.name,15,TEXT,true); title.Size=UDim2.new(1,0,0,22); title.LayoutOrder=0; title.Parent=formScroll
	local desc=makeLbl(cmd.desc,11,TEXT3); desc.Size=UDim2.new(1,0,0,16); desc.LayoutOrder=1; desc.Parent=formScroll
	local sep=Instance.new("Frame"); sep.Size=UDim2.new(1,0,0,1); sep.BackgroundColor3=BORDER
	sep.BackgroundTransparency=0.82; sep.BorderSizePixel=0; sep.LayoutOrder=2; sep.Parent=formScroll

	local isDataDanger = cat.name=="Data" and (cmd.cmd=="resetdata" or cmd.cmd=="resetdatafull")
	if isDataDanger then
		local wb=Instance.new("Frame"); wb.Size=UDim2.new(1,0,0,36); wb.BackgroundColor3=RED
		wb.BackgroundTransparency=0.6; wb.BorderSizePixel=0; wb.LayoutOrder=3; wb.Parent=formScroll; mkC(wb,8)
		local wt=makeLbl("⚠  Action irréversible — données perdues définitivement",10,Color3.fromRGB(255,160,160),true)
		wt.Size=UDim2.new(1,-16,1,0); wt.Position=UDim2.new(0,8,0,0); wt.TextWrapped=true; wt.Parent=wb
	end

	local lo=isDataDanger and 4 or 3
	for _,field in ipairs(cmd.fields) do
		local lbl=makeLbl(field.label..(field.optional and " (optionnel)" or ""),10,TEXT3)
		lbl.Size=UDim2.new(1,0,0,16); lbl.LayoutOrder=lo; lo+=1; lbl.Parent=formScroll
		local widget
		if     field.type=="player"      then widget=makeDropdown("Select a player...",#playerList>0 and playerList or {"(no player)"})
		elseif field.type=="event"       then widget=makeDropdown("Select an event...",#eventList>0 and eventList or {"(no event)"})
		elseif field.type=="item"        then widget=makeDropdown("Select an item...",#itemList>0 and itemList or {"(no item)"})
		elseif field.type=="brainrot"    then widget=makeDropdown("Select a brainrot...",#brainrotList>0 and brainrotList or {"(loading...)"})
		elseif field.type=="luckyblock"  then widget=makeDropdown("Select a lucky block...",#luckyBlockList>0 and luckyBlockList or {"(loading...)"})
		elseif field.type=="mutation"    then widget=makeDropdown("Select a mutation...",#mutationList>0 and mutationList or {"Normal"})
		elseif field.type=="traitsmulti" then widget=makeMultiDropdown("Select traits...",#traitList>0 and traitList or {"(loading...)"})
		elseif field.type=="onoff"       then widget=makeDropdown("On / Off",{"On","Off"})
		elseif field.type=="bool"        then widget=makeDropdown("true / false",{"true","false"})
		elseif field.type=="number"      then widget=makeInput(field.label..(field.default and (" — default: "..field.default) or ""))
		elseif field.type=="traits"      then widget=makeInput("Ex: Fireworks, Speed, Taco")
		else                                  widget=makeInput(field.label) end
		if field.default and type(widget)=="table" and widget.setValue then widget.setValue(field.default) end
		if field.default and type(widget)~="table" and widget:IsA("TextBox") then widget.Text=field.default end
		local wf=type(widget)=="table" and widget.frame or widget
		wf.Size=UDim2.new(1,0,0,38); wf.LayoutOrder=lo; lo+=1; wf.Parent=formScroll
		table.insert(activeFormFields,{field=field,widget=widget})
	end

	local sp2=Instance.new("Frame"); sp2.Size=UDim2.new(1,0,0,4); sp2.BackgroundTransparency=1; sp2.LayoutOrder=lo; lo+=1; sp2.Parent=formScroll
	local execBtn=makeExecBtn("▶   Execute  —  "..cmd.name,isDataDanger)
	execBtn.LayoutOrder=lo; execBtn.Parent=formScroll

	execBtn.MouseButton1Click:Connect(function()
		local args={}; local valid=true
		for _,entry in ipairs(activeFormFields) do
			local f=entry.field; local w=entry.widget; local value
			if type(w)=="table" and w.getValue then value=w.getValue()
			elseif typeof(w)=="Instance" and w:IsA("TextBox") then value=w.Text~="" and w.Text or nil end
			if not value and not f.optional then showNotif("Required field missing: "..f.label,false); valid=false; break end
			if value then
				if f.type=="number" then local n=tonumber(value); if not n then showNotif("Invalid numeric: "..f.label,false); valid=false; break end; args[f.key]=n
				elseif f.type=="traitsmulti" then args[f.key]=value
				elseif f.type=="traits" then local t={}; for part in string.gmatch(value,"([^,]+)") do local tr=part:match("^%s*(.-)%s*$"); if tr~="" then table.insert(t,tr) end end; args[f.key]=#t>0 and t or nil
				elseif f.type=="bool" then args[f.key]=value=="true"
				else args[f.key]=value end
			end
		end
		if valid then
			TweenService:Create(execBtn,TweenInfo.new(0.08),{BackgroundTransparency=0.5}):Play()
			task.delay(0.1,function() if execBtn and execBtn.Parent then TweenService:Create(execBtn,TweenInfo.new(0.1),{BackgroundTransparency=0.05}):Play() end end)
			ExecuteCommand:FireServer(cmd.cmd,args)
		end
	end)
end

-- ============================================================
-- SELECT CATEGORY
-- ============================================================
local function closePanel()
	if toggleDebounce then return end; toggleDebounce=true; guiVisible=false
	TweenService:Create(mainFrame,TweenInfo.new(0.20,Enum.EasingStyle.Quad,Enum.EasingDirection.In),{Size=UDim2.new(0,W,0,0),BackgroundTransparency=1}):Play()
	task.delay(0.25,function() if mainFrame and mainFrame.Parent then mainFrame.Visible=false end; toggleDebounce=false end)
end

function selectCategory(idx)
	currentCategory=idx; currentCommand=nil; setActiveTab(idx); buildCmdList(idx)
	for _,c in ipairs(formScroll:GetChildren()) do if not c:IsA("UIListLayout") and not c:IsA("UIPadding") then c:Destroy() end end
	activeFormFields={}; selectHint.Visible=true; formScroll.Visible=false

	local cat=CATEGORIES[idx]

	-- ── BRAINROT COUNT ────────────────────────────────────────
	if cat and cat.isCount then
		selectHint.Visible=false; formScroll.Visible=true
		local hRow=Instance.new("Frame"); hRow.Size=UDim2.new(1,0,0,30); hRow.BackgroundTransparency=1; hRow.LayoutOrder=0; hRow.Parent=formScroll
		local t2=makeLbl("📊  BRAINROT COUNT",13,TEXT,true); t2.Size=UDim2.new(1,-70,1,0); t2.Parent=hRow
		local refBtn=Instance.new("TextButton"); refBtn.Size=UDim2.new(0,68,0,24); refBtn.Position=UDim2.new(1,-70,0.5,-12)
		refBtn.BackgroundColor3=BG3; refBtn.BackgroundTransparency=0.1; refBtn.BorderSizePixel=0; refBtn.Text="↻ Refresh"; refBtn.TextColor3=TEXT2; refBtn.TextSize=10; refBtn.Font=Enum.Font.Gotham; refBtn.Parent=hRow; mkC(refBtn,8); mkS(refBtn,BORDER,0.82,1)
		local loadLbl=makeLbl("⏳ Collecte des données...",11,TEXT3); loadLbl.Size=UDim2.new(1,0,0,20); loadLbl.TextXAlignment=Enum.TextXAlignment.Center; loadLbl.LayoutOrder=1; loadLbl.Parent=formScroll
		local RARITY_COLORS={Secret=Color3.fromRGB(255,100,100),Mythic=Color3.fromRGB(200,80,255),OG=Color3.fromRGB(255,200,0),Legendary=Color3.fromRGB(255,140,0),Epic=Color3.fromRGB(160,80,255),Rare=Color3.fromRGB(80,140,255),Uncommon=Color3.fromRGB(80,200,100),Common=Color3.fromRGB(180,180,180)}
		local function buildCountUI(rawData)
			for _,c in ipairs(formScroll:GetChildren()) do if not c:IsA("UIListLayout") and not c:IsA("UIPadding") then if c.LayoutOrder>=2 then c:Destroy() end end end
			local flat={}
			for rarity,list in pairs(rawData) do
				for _,br in ipairs(list) do local tot=0; for _,n in pairs(br.counts) do tot+=n end; table.insert(flat,{name=br.name,displayName=br.displayName,rarity=rarity,total=tot}) end
			end
			table.sort(flat,function(a,b) if a.total~=b.total then return a.total>b.total end; return a.displayName<b.displayName end)
			local grandTotal=0; for _,br in ipairs(flat) do grandTotal+=br.total end
			local lo=2
			local tr=Instance.new("Frame"); tr.Size=UDim2.new(1,0,0,28); tr.BackgroundColor3=BG3; tr.BackgroundTransparency=0.1; tr.BorderSizePixel=0; tr.LayoutOrder=lo; lo+=1; tr.Parent=formScroll; mkC(tr,8)
			local tl=makeLbl("Total global : "..grandTotal.." brainrots sur "..#flat.." types",11,TEXT,true); tl.Size=UDim2.new(1,-12,1,0); tl.Position=UDim2.new(0,10,0,0); tl.Parent=tr
			for _,br in ipairs(flat) do
				local rarColor=RARITY_COLORS[br.rarity] or Color3.fromRGB(180,180,180)
				local row=Instance.new("Frame"); row.Size=UDim2.new(1,0,0,34); row.BackgroundColor3=BG3; row.BackgroundTransparency=0.15; row.BorderSizePixel=0; row.LayoutOrder=lo; lo+=1; row.Parent=formScroll; mkC(row,8)
				local barL=Instance.new("Frame"); barL.Size=UDim2.new(0,3,0.6,0); barL.Position=UDim2.new(0,0,0.2,0); barL.BackgroundColor3=rarColor; barL.BackgroundTransparency=0.1; barL.BorderSizePixel=0; barL.Parent=row; mkC(barL,2)
				local nL=makeLbl(br.displayName,11,br.total>0 and TEXT or TEXT3,true); nL.Size=UDim2.new(0.55,-12,1,0); nL.Position=UDim2.new(0,10,0,0); nL.TextTruncate=Enum.TextTruncate.AtEnd; nL.Parent=row
				local rL=makeLbl(br.rarity,9,rarColor); rL.Size=UDim2.new(0.25,0,1,0); rL.Position=UDim2.new(0.55,0,0,0); rL.Parent=row
				local cL=Instance.new("TextLabel"); cL.Size=UDim2.new(0.2,-6,1,0); cL.Position=UDim2.new(0.8,0,0,0); cL.BackgroundTransparency=1; cL.Text=br.total>0 and ("x"..br.total) or "—"; cL.TextColor3=br.total>0 and GOLD or TEXT3; cL.TextSize=12; cL.Font=Enum.Font.GothamBold; cL.TextXAlignment=Enum.TextXAlignment.Right; cL.Parent=row
				local rp=Instance.new("UIPadding"); rp.PaddingRight=UDim.new(0,8); rp.Parent=cL
				row.MouseEnter:Connect(function() TweenService:Create(row,TweenInfo.new(0.1),{BackgroundTransparency=0.0}):Play() end)
				row.MouseLeave:Connect(function() TweenService:Create(row,TweenInfo.new(0.1),{BackgroundTransparency=0.15}):Play() end)
			end
		end
		local function loadData()
			for _,c in ipairs(formScroll:GetChildren()) do if not c:IsA("UIListLayout") and not c:IsA("UIPadding") then if c.LayoutOrder>=2 then c:Destroy() end end end
			if loadLbl and loadLbl.Parent then loadLbl.Visible=true end
			refBtn.Text="⏳ Loading..."; refBtn.TextColor3=TEXT3
			task.spawn(function()
				local ok,rawData=pcall(function() return GetBrainrotData:InvokeServer() end)
				if loadLbl and loadLbl.Parent then loadLbl.Visible=false end
				refBtn.Text="↻ Refresh"; refBtn.TextColor3=TEXT2
				if ok and rawData then buildCountUI(rawData)
				else local el=makeLbl("❌ Erreur de chargement",12,RED); el.Size=UDim2.new(1,0,0,24); el.TextXAlignment=Enum.TextXAlignment.Center; el.LayoutOrder=2; el.Parent=formScroll end
			end)
		end
		refBtn.MouseButton1Click:Connect(loadData); loadData()
	end
end

-- ============================================================
-- TOGGLE
-- ============================================================
local function openPanel()
	if toggleDebounce then return end; toggleDebounce=true; guiVisible=true
	mainFrame.Visible=true; mainFrame.Size=UDim2.new(0,W,0,0); mainFrame.BackgroundTransparency=1
	TweenService:Create(mainFrame,TweenInfo.new(0.30,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Size=UDim2.new(0,W,0,H),BackgroundTransparency=0.35}):Play()
	task.delay(0.35,function() toggleDebounce=false end)
end

local function togglePanel()
	if toggleDebounce then return end
	if guiVisible then closePanel() else openPanel() end
end

player.CharacterAdded:Connect(function()
	task.wait(0.1)
	if mainFrame and mainFrame.Parent then
		mainFrame.Visible=guiVisible
		if guiVisible then mainFrame.Size=UDim2.new(0,W,0,H); mainFrame.BackgroundTransparency=0.35 end
		toggleDebounce=false
	end
end)

-- ============================================================
-- INPUT & DRAG
-- ============================================================
UserInputService.InputBegan:Connect(function(input,gp)
	if gp then return end
	if input.KeyCode==Enum.KeyCode.H then togglePanel() end
end)
closeBtn.MouseButton1Click:Connect(closePanel)
hudBtn.MouseButton1Click:Connect(togglePanel)

headerBar.InputBegan:Connect(function(input)
	if input.UserInputType==Enum.UserInputType.MouseButton1 then
		local mp=UserInputService:GetMouseLocation()
		local tp=tabsFrame.AbsolutePosition; local ts=tabsFrame.AbsoluteSize
		local cp=closeBtn.AbsolutePosition; local cs=closeBtn.AbsoluteSize
		local inTabs=mp.X>=tp.X and mp.X<=tp.X+ts.X and mp.Y>=tp.Y and mp.Y<=tp.Y+ts.Y
		local inClose=mp.X>=cp.X and mp.X<=cp.X+cs.X and mp.Y>=cp.Y and mp.Y<=cp.Y+cs.Y
		if not inTabs and not inClose then
			isDragging=true; dragOffset=Vector2.new(mouse.X-mainFrame.AbsolutePosition.X,mouse.Y-mainFrame.AbsolutePosition.Y)
		end
	end
end)
headerBar.InputEnded:Connect(function(input)
	if input.UserInputType==Enum.UserInputType.MouseButton1 then isDragging=false end
end)
RunService.RenderStepped:Connect(function()
	if isDragging and mainFrame.Visible then
		local vp=workspace.CurrentCamera.ViewportSize
		local nx=math.clamp(mouse.X-dragOffset.X,0,vp.X-mainFrame.AbsoluteSize.X)
		local ny=math.clamp(mouse.Y-dragOffset.Y,0,vp.Y-mainFrame.AbsoluteSize.Y)
		mainFrame.Position=UDim2.new(0,nx,0,ny)
	end
end)

-- ============================================================
-- COMMAND RESULT
-- ============================================================
CommandResult.OnClientEvent:Connect(function(success,message)
	showNotif(tostring(message),success==true)
end)

-- ============================================================
-- INIT
-- ============================================================
buildTabs()
selectCategory(1)
print("[AdminClient] INIT ✅")

-- ================================================================
-- === FIN ADMINCLIENT ===
-- ================================================================