--!strict
-- LOCATION: ServerScriptService/Controllers/PlayerController

local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")
local CollectionService = game:GetService("CollectionService")
local Debris = game:GetService("Debris") 

local ProfileStoreModule = require(ServerScriptService.Modules.ProfileStore)
local ItemConfigurations = require(ReplicatedStorage.Modules.ItemConfigurations)
local ProductConfigurations = require(ReplicatedStorage.Modules.ProductConfigurations)
local NumberFormatter = require(ReplicatedStorage.Modules.NumberFormatter)
local UpgradesConfiguration = require(ReplicatedStorage.Modules.UpgradesConfiguration)
local ItemManager 
local SlotManager 

local DATA_VERSION = "TemplateData001" 

local MAX_OFFLINE_TIME = 8 * 60 * 60
local INCOME_SCALING = 1.125 
local VIP_TAG = "V.I.P"
local GROUP_ID = 0 

local MUTATION_MULTIPLIERS = {
	["Normal"] = 1,
	["Gold"] = 1.2,
	["Golden"] = 2,
	["Diamond"] = 1.45,
	["Ruby"] = 4,
	["Neon"] = 5,
	["Lava"] = 1.2,
}

type ItemData = { Name: string, Mutation: string, Rarity: string, Level: number }
type SlotData = { Item: ItemData?, Level: number, Stored: number }
type FloorData = { [string]: SlotData }

type PlayerData = {
	Money: number,
	Rebirths: number,
	Power: number,
	BaseLevel: number,
	OnboardingStep: number, 
	LastSaveTime: number,
	SpinNumber: number,
	LastDailySpin: number,
	DailySpins: number,
	LastDailySpinDay: string,
	DailySpins: number,
	LastDailySpinDay: string,
	Inventory: {ItemData},
	Plots: { [string]: FloorData },
	DiscoveredItems: {[string]: boolean},
	ClaimedPacks: {[string]: boolean},
	UnlockedWeights: {[string]: boolean},
	[string]: any 
}

local Template: PlayerData = {
	Money = 0,
	Rebirths = 0,
	Power = 0,
	BaseLevel = 0,
	OnboardingStep = 1, 
	LastSaveTime = 0,
	SpinNumber = 0,     
	LastDailySpin = 0,   
	DailySpins = 0,
	LastDailySpinDay = "",
	DailySpins = 0,
	LastDailySpinDay = "",
	Inventory = {},
	Plots = { Floor1 = {}, Floor2 = {}, Floor3 = {} },
	DiscoveredItems = {},
	ClaimedPacks = {},
	UnlockedWeights = {}, 
}

for upgradeName, config in pairs(UpgradesConfiguration.Upgrades) do
	Template[upgradeName] = config.DefaultValue
end

local GameProfileStore = ProfileStoreModule.New(DATA_VERSION, Template)

local PlayerController = {}
PlayerController.PendingOfflineEarnings = {} 
local profiles: {[Player]: any} = {}
local vipCache: {[Player]: boolean} = {}
local deadPlayers: {[Player]: boolean} = {} 
local loadingInventory: {[Player]: boolean} = {} 

PlayerController.isShuttingDown = false

local function playPurchaseEffects(player: Player)
	local Events = ReplicatedStorage:FindFirstChild("Events")
	local effectEvent = Events and Events:FindFirstChild("TriggerUIEffect")
	if effectEvent then
		effectEvent:FireClient(player, "HighlightLight")
	end

	local character = player.Character
	local root = character and character:FindFirstChild("HumanoidRootPart")
	local TemplatesFolder = ReplicatedStorage:FindFirstChild("Templates")
	local confettiTemplate = TemplatesFolder and TemplatesFolder:FindFirstChild("Confetti")

	if root and confettiTemplate then
		local confetti = confettiTemplate:Clone()
		confetti.Parent = root
		for _, child in ipairs(confetti:GetChildren()) do
			if child:IsA("ParticleEmitter") then
				child:Emit(child:GetAttribute("EmitCount") or 50)
			end
		end
		Debris:AddItem(confetti, 3)
	end
end

local function grantPackRewards(player: Player, packName: string)
	local profile = profiles[player]
	if not profile then return end

	if profile.Data.ClaimedPacks[packName] then return end

	local rewards = ProductConfigurations.PackRewards[packName]
	if not rewards then return end

	profile.Data.ClaimedPacks[packName] = true
	PlayerController:AddMoney(player, rewards.Money)

	if ItemManager then
		for _, item in ipairs(rewards.Items) do
			local itemConf = ItemConfigurations.GetItemData(item.Name)
			local rarity = itemConf and itemConf.Rarity or "Common"
			ItemManager.GiveItemToPlayer(player, item.Name, item.Mutation, rarity, item.Level)
		end
	end

	local Events = ReplicatedStorage:FindFirstChild("Events")
	local notif = Events and Events:FindFirstChild("ShowNotification")
	if notif then 
		notif:FireClient(player, "Gamepass bought!", "Success") 
	end

	playPurchaseEffects(player) 
end

function PlayerController:GrantVIP(player: Player)
	vipCache[player] = true
	player:SetAttribute("IsVIP", true)
end

function PlayerController:IsVIP(player: Player)
	return vipCache[player] == true
end

local function checkVIP(player: Player)
	local passId = ProductConfigurations.GamePasses.VIP
	if not passId then return end

	local success, hasPass = pcall(function()
		return MarketplaceService:UserOwnsGamePassAsync(player.UserId, passId)
	end)

	if success and hasPass then
		PlayerController:GrantVIP(player)
	end
end

local function setupVIPTouch(part: BasePart)
	if part:GetAttribute("TouchConnected") then return end
	part:SetAttribute("TouchConnected", true)

	part.Touched:Connect(function(hit)
		local player = Players:GetPlayerFromCharacter(hit.Parent)
		if player and not vipCache[player] then
			if not player.Character:GetAttribute("PromptDebounce") then
				player.Character:SetAttribute("PromptDebounce", true)
				local passId = ProductConfigurations.GamePasses.VIP
				if passId then
					MarketplaceService:PromptGamePassPurchase(player, passId)
				end
				task.wait(2)
				if player.Character then player.Character:SetAttribute("PromptDebounce", nil) end
			end
		end
	end)
end

local function calculateOfflineEarnings(player: Player, profile: any)
	local lastTime = profile.Data.LastSaveTime
	if not lastTime or lastTime == 0 then return end

	local now = os.time()
	local diff = now - lastTime
	if diff < 60 then return end 

	local timeToCalc = math.min(diff, MAX_OFFLINE_TIME)
	local totalEarned = 0

	for _, floorData in pairs(profile.Data.Plots) do
		for _, slotData in pairs(floorData) do
			if slotData.Item then
				local itemConf = ItemConfigurations.GetItemData(slotData.Item.Name)
				if itemConf then
					local base = itemConf.Income
					local mutMult = MUTATION_MULTIPLIERS[slotData.Item.Mutation] or 1
					local level = slotData.Level or 1
					local levelMult = INCOME_SCALING ^ (level - 1)

					local reb = profile.Data.Rebirths or 0
					local rebMult = 1 + (reb * 0.5)

					local vipMult = PlayerController:IsVIP(player) and 1.25 or 1

					local rate = base * mutMult * levelMult * rebMult * vipMult
					local earnings = rate * timeToCalc

					totalEarned += earnings
				end
			end
		end
	end

	if totalEarned > 0 then
		PlayerController.PendingOfflineEarnings[player] = math.floor(totalEarned)
		task.delay(1, function() 
			if player and player.Parent then
				local events = ReplicatedStorage:FindFirstChild("Events")
				local showEvent = events and events:FindFirstChild("ShowOfflineEarnings")
				if showEvent then
					showEvent:FireClient(player, math.floor(totalEarned))
				end
			end
		end)
	end
end

local function checkAndGrantGroupReward(player: Player, profile: any)
	if profile.Data.ClaimedPacks["GroupReward"] then return end

	local currentStep = profile.Data.OnboardingStep or 1
	if currentStep < 4 then return end 

	local targetGroupId = GROUP_ID
	if targetGroupId <= 0 then return end 

	task.spawn(function()
		local success, isInGroup = pcall(function()
			return player:IsInGroup(targetGroupId)
		end)

		if success and isInGroup then
			profile.Data.ClaimedPacks["GroupReward"] = true
			PlayerController:AddMoney(player, 1000)

			local Events = ReplicatedStorage:FindFirstChild("Events")
			local notif = Events and Events:FindFirstChild("ShowNotification")
			if notif then 
				notif:FireClient(player, "Thanks for joining the group! +$1,000", "Success") 
			end
		end
	end)
end

function PlayerController:GetProfile(player: Player) return profiles[player] end

function PlayerController:DeductMoney(player: Player, amount: number): boolean
	local profile = profiles[player]
	if not profile then return false end
	if profile.Data.Money >= amount then
		profile.Data.Money -= amount
		player.leaderstats.Money.Value = profile.Data.Money
		return true
	end
	return false
end

function PlayerController:AddMoney(player: Player, amount: number)
	local profile = profiles[player]
	if profile then
		profile.Data.Money += amount
		player.leaderstats.Money.Value = profile.Data.Money
	end
end

function PlayerController:IncrementBaseLevel(player: Player)
	local profile = profiles[player]
	if profile then profile.Data.BaseLevel += 1; return profile.Data.BaseLevel end
	return 0
end

function PlayerController:SetupSharedInstances()
	local eventsFolder = ReplicatedStorage:FindFirstChild("Events")
	if not eventsFolder then 
		eventsFolder = Instance.new("Folder"); eventsFolder.Name = "Events"; eventsFolder.Parent = ReplicatedStorage
	end
	local function createRemote(type: "RemoteEvent", name: string)
		if not eventsFolder:FindFirstChild(name) then
			local r = Instance.new(type); r.Name = name; r.Parent = eventsFolder
		end
	end
	local function createRemoteFunc(type: "RemoteFunction", name: string)
		if not eventsFolder:FindFirstChild(name) then
			local r = Instance.new(type); r.Name = name; r.Parent = eventsFolder
		end
	end

	createRemote("RemoteEvent", "ShowNotification") 
	createRemote("RemoteEvent", "RequestBaseUpgrade")
	createRemote("RemoteEvent", "RequestRebirth")
	createRemote("RemoteEvent", "UpdateRebirthUI")
	createRemote("RemoteEvent", "RefreshIndex")
	createRemote("RemoteEvent", "SetOnboardingStep") 
	createRemote("RemoteEvent", "ShowOfflineEarnings")
	createRemote("RemoteEvent", "ClaimOfflineEarnings")
	createRemote("RemoteEvent", "HideOfflineUI")

	createRemoteFunc("RemoteFunction", "GetUnlockedWeights")
	createRemote("RemoteEvent", "UpdateWeightsUI")
	createRemote("RemoteEvent", "ResetWeightsUI")

	-- Injected to prevent infinite yields in other systems
	createRemote("RemoteEvent", "ToggleMorphVisibility")
	createRemote("RemoteEvent", "ShowPowerPopUp")
	createRemote("RemoteEvent", "ShowCashPopUp") 
end

local function syncInventoryData(player: Player)
	local profile = profiles[player]
	if not profile or deadPlayers[player] then return end

	local isSyncingFromSave = loadingInventory[player]
	local inventoryData = {}
	local newDiscovery = false

	local function scanContainer(container: Instance)
		for _, item in ipairs(container:GetChildren()) do
			if item:IsA("Tool") and item:GetAttribute("IsTemporary") ~= true then
				local name = item:GetAttribute("OriginalName")
				if name then
					local data = {
						Name = name,
						Mutation = item:GetAttribute("Mutation") or "Normal",
						Rarity = item:GetAttribute("Rarity") or "Common",
						Level = item:GetAttribute("Level") or 1
					}
					if not isSyncingFromSave then table.insert(inventoryData, data) end
					local key = data.Mutation .. "_" .. data.Name
					if not profile.Data.DiscoveredItems[key] then
						profile.Data.DiscoveredItems[key] = true
						newDiscovery = true
					end
				end
			end
		end
	end

	if player:FindFirstChild("Backpack") then scanContainer(player.Backpack) end
	if player.Character then scanContainer(player.Character) end
	if not isSyncingFromSave then profile.Data.Inventory = inventoryData end

	if newDiscovery then
		local Events = ReplicatedStorage:FindFirstChild("Events")
		if Events:FindFirstChild("RefreshIndex") then Events.RefreshIndex:FireClient(player) end
	end
end

local function loadInventory(player: Player, profile: any)
	if not ItemManager then return end
	loadingInventory[player] = true
	deadPlayers[player] = false

	if player:FindFirstChild("Backpack") then player.Backpack:ClearAllChildren() end
	if player:FindFirstChild("StarterGear") then player.StarterGear:ClearAllChildren() end

	local savedInv = profile.Data.Inventory or {}
	for _, itemData in ipairs(savedInv) do
		ItemManager.GiveItemToPlayer(player, itemData.Name, itemData.Mutation, itemData.Rarity, itemData.Level)
		local key = itemData.Mutation .. "_" .. itemData.Name
		if not profile.Data.DiscoveredItems[key] then profile.Data.DiscoveredItems[key] = true end
	end

	task.wait() 
	loadingInventory[player] = false
	syncInventoryData(player)
end

local function createLeaderstats(player: Player, data: PlayerData)
	local ls = Instance.new("Folder")
	ls.Name = "leaderstats"
	ls.Parent = player

	local upgradesFolder = Instance.new("Folder")
	upgradesFolder.Name = "UpgradesData"
	upgradesFolder.Parent = player

	local function createNumberValue(name: string, val: number, parent: Instance)
		local nv = Instance.new("NumberValue")
		nv.Name = name
		nv.Value = val
		nv.Parent = parent
		nv.Changed:Connect(function(newVal) data[name] = newVal end)
	end

	createNumberValue("Money", data.Money, ls)
	createNumberValue("Rebirths", data.Rebirths, ls)
	createNumberValue("Power", data.Power or 0, ls)

	for upgradeName, _ in pairs(UpgradesConfiguration.Upgrades) do
		createNumberValue(upgradeName, data[upgradeName], upgradesFolder)
	end
end

local function onPlayerAdded(player: Player)
	checkVIP(player)
	deadPlayers[player] = false
	loadingInventory[player] = false

	local profile = GameProfileStore:StartSessionAsync(tostring(player.UserId), {
		Cancel = function() return player.Parent ~= Players end
	})

	if not profile then 
		player:Kick("Data load failed. Please rejoin.") 
		return 
	end

	profile:AddUserId(player.UserId)
	profile:Reconcile() 

	player:SetAttribute("OnboardingStep", profile.Data.OnboardingStep or 1)
	player:SetAttribute("SpinNumber", profile.Data.SpinNumber or 0)
	player:SetAttribute("LastDailySpin", profile.Data.LastDailySpin or 0)

	profile.OnSessionEnd:Connect(function() 
		profiles[player] = nil
		player:Kick("Session released") 
	end)

	if player.Parent == Players then
		profiles[player] = profile
		createLeaderstats(player, profile.Data)

		player:WaitForChild("Backpack").ChildAdded:Connect(function() syncInventoryData(player) end)
		player.Backpack.ChildRemoved:Connect(function() syncInventoryData(player) end)

		player.CharacterAdded:Connect(function(char)
			deadPlayers[player] = false
			task.wait(0.2)
			loadInventory(player, profile)
			local hum = char:WaitForChild("Humanoid", 10)
			if hum then hum.Died:Connect(function() deadPlayers[player] = true end) end
			char.ChildAdded:Connect(function(child) if child:IsA("Tool") then syncInventoryData(player) end end)
			char.ChildRemoved:Connect(function(child) if child:IsA("Tool") then syncInventoryData(player) end end)
		end)

		task.spawn(function()
			for packName, passId in pairs(ProductConfigurations.GamePasses) do
				if (packName == "StarterPack" or packName == "ProPack") and not profile.Data.ClaimedPacks[packName] then
					local success, hasPass = pcall(function() return MarketplaceService:UserOwnsGamePassAsync(player.UserId, passId) end)
					if success and hasPass then grantPackRewards(player, packName) end
				end
			end
		end)

		checkAndGrantGroupReward(player, profile)
		calculateOfflineEarnings(player, profile)

		-- Only now that the profile is loaded and the CharacterAdded listener
		-- (which restores profile.Data.Inventory into the Backpack) is wired
		-- up, is it safe to spawn the character. This closes the race that
		-- could wipe a player's saved inventory.
		player:LoadCharacter()
	else
		profile:EndSession()
	end
end

local function onPlayerRemoving(player: Player)
	vipCache[player] = nil
	deadPlayers[player] = nil 
	loadingInventory[player] = nil 
	PlayerController.PendingOfflineEarnings[player] = nil

	-- Sync ActiveEvent from visual items to profile BEFORE saving
	if SlotManager and SlotManager.SyncActiveEvents then
		pcall(SlotManager.SyncActiveEvents, player)
	end

	local profile = profiles[player]
	if profile then 
		profile.Data.LastSaveTime = os.time()
		profile:EndSession()
		profiles[player] = nil 
	end
end

function PlayerController:Init(controllers)
	ItemManager = require(ServerScriptService.Modules.ItemManager)
	SlotManager = require(ServerScriptService.Modules.SlotManager)
	if SlotManager.Init then SlotManager:Init(controllers) end

	local Events = ReplicatedStorage:WaitForChild("Events")

	local getIndexFunc = Events:FindFirstChild("GetIndexData") or Instance.new("RemoteFunction", Events)
	getIndexFunc.Name = "GetIndexData"
	getIndexFunc.OnServerInvoke = function(player)
		local retries = 0
		while not profiles[player] and retries < 100 do
			task.wait(0.1)
			retries += 1
		end
		local start = os.time()
		while loadingInventory[player] do
			if os.time() - start > 5 then break end
			task.wait(0.1)
		end
		local profile = PlayerController:GetProfile(player)
		return profile and profile.Data.DiscoveredItems or {}
	end

	local getWeightsFunc = Events:FindFirstChild("GetUnlockedWeights")
	if getWeightsFunc then
		getWeightsFunc.OnServerInvoke = function(player)
			local retries = 0
			while not profiles[player] and retries < 100 do
				task.wait(0.1)
				retries += 1
			end

			local start = os.time()
			while loadingInventory[player] do
				if os.time() - start > 5 then break end
				task.wait(0.1)
			end

			local profile = PlayerController:GetProfile(player)
			return profile and profile.Data.UnlockedWeights or {} 
		end
	end

	Events.SetOnboardingStep.OnServerEvent:Connect(function(player, step)
		local profile = profiles[player]
		if profile then
			local current = profile.Data.OnboardingStep or 1
			if step > current then
				profile.Data.OnboardingStep = step
				player:SetAttribute("OnboardingStep", step) 
				if step == 4 then checkAndGrantGroupReward(player, profile) end
			end
		end
	end)

	Events.ClaimOfflineEarnings.OnServerEvent:Connect(function(player)
		local pending = PlayerController.PendingOfflineEarnings[player]
		if pending and pending > 0 then
			PlayerController:AddMoney(player, pending)
			PlayerController.PendingOfflineEarnings[player] = nil
			local notif = Events:FindFirstChild("ShowNotification")
			if notif then notif:FireClient(player, "Claimed offline earnings!", "Success") end
		end
	end)

	-- Restored ToggleMorphVisibility Connection
	local toggleMorphEvent = Events:FindFirstChild("ToggleMorphVisibility")
	if toggleMorphEvent then
		toggleMorphEvent.OnServerEvent:Connect(function(player, isMorphed)
			if type(isMorphed) == "boolean" then
				player:SetAttribute("IsMorphed", isMorphed)
			end
		end)
	end

	MarketplaceService.PromptGamePassPurchaseFinished:Connect(function(player, passId, wasPurchased)
		if wasPurchased then
			if passId == ProductConfigurations.GamePasses.VIP then
				PlayerController:GrantVIP(player)

				local notif = Events:FindFirstChild("ShowNotification")
				if notif then notif:FireClient(player, "VIP Purchased! Enjoy +25% Income & Gold Tag!", "Success") end
				playPurchaseEffects(player)

				if SlotManager and SlotManager.RefreshAllSlots then SlotManager.RefreshAllSlots(player) end
			end
			local packName = ProductConfigurations.GetGamePassById(passId)
			if packName and (packName == "StarterPack" or packName == "ProPack") then grantPackRewards(player, packName) end
			playPurchaseEffects(player) 
		end
	end)

	for _, part in ipairs(CollectionService:GetTagged(VIP_TAG)) do if part:IsA("BasePart") then setupVIPTouch(part) end end
	CollectionService:GetInstanceAddedSignal(VIP_TAG):Connect(function(part) if part:IsA("BasePart") then setupVIPTouch(part) end end)
end

function PlayerController:Start()
	-- Disable automatic character spawning so we can guarantee the player's
	-- profile (and the CharacterAdded listener that restores their saved
	-- Inventory) is fully ready BEFORE their character/backpack exists.
	-- Without this, a fast-spawning character can race ahead of the
	-- DataStore load, skip loadInventory(), and any inventory change after
	-- that (e.g. placing a brainrot) permanently overwrites the saved data
	-- with an empty inventory.
	Players.CharacterAutoLoads = false

	if SlotManager.Start then task.spawn(function() SlotManager:Start() end) end
	Players.PlayerAdded:Connect(onPlayerAdded)
	Players.PlayerRemoving:Connect(onPlayerRemoving)
	for _, p in ipairs(Players:GetPlayers()) do task.spawn(onPlayerAdded, p) end
	game:BindToClose(function()
		PlayerController.isShuttingDown = true
		for _, p in ipairs(Players:GetPlayers()) do if profiles[p] then profiles[p].Data.LastSaveTime = os.time() end end
	end)
end

return PlayerController