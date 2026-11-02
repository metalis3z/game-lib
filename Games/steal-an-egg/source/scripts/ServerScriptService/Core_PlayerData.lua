--!strict
local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Network = require(script.Parent.Core_Network)

local Data = {}
Data.Loaded = Instance.new("BindableEvent")
Data.Changed = Instance.new("BindableEvent")

local DATASTORE_NAME = "StealAnEgg_Rebuilt_v1"
local AUTOSAVE_SECONDS = 60
local store = DataStoreService:GetDataStore(DATASTORE_NAME)
local profiles: {[Player]: {[any]: any}} = {}
local dirty: {[Player]: boolean} = {}
local loadedLogout: {[Player]: number} = {}
local started = false

local okTemplate, templateOrError = pcall(function()
	return require(ReplicatedStorage.Library.Modules.DefaultStats)
end)
local template = if okTemplate and typeof(templateOrError) == "table" then templateOrError else {
	Money = 10000,
	SpeedPower = 25,
	Inventory = {},
	EquippedAssets = {},
	EggInventory = {},
	Rebirth = 0,
	BaseUpgradeLevel = 0,
	TreadmillUpgradeLevel = 1,
	GuardTutorialProgress = {Completed = false, CurrentStepId = nil},
	Settings = {},
	CurrentAreaEggClaims = {Slots = {}},
	LastLogout = 0,
	HasPlacedFirstEgg = false,
}

local function deepCopy(value: any): any
	if typeof(value) ~= "table" then
		return value
	end
	local result = {}
	for key, child in pairs(value) do
		result[deepCopy(key)] = deepCopy(child)
	end
	return result
end

local function reconcile(target: {[any]: any}, defaults: {[any]: any})
	for key, defaultValue in pairs(defaults) do
		local current = target[key]
		if current == nil then
			target[key] = deepCopy(defaultValue)
		elseif typeof(current) == "table" and typeof(defaultValue) == "table" then
			reconcile(current, defaultValue)
		end
	end
end

local function updateMirrors(player: Player, changes: {[any]: any})
	local profile = profiles[player]
	if not profile then
		return
	end
	local leaderstats = player:FindFirstChild("leaderstats")
	if changes.Money ~= nil then
		player:SetAttribute("Money", profile.Money)
		local moneyValue = leaderstats and leaderstats:FindFirstChild("Money")
		if moneyValue and moneyValue:IsA("NumberValue") then
			moneyValue.Value = profile.Money
		end
	end
	if changes.SpeedPower ~= nil then
		player:SetAttribute("SpeedPower", profile.SpeedPower)
		local speedValue = leaderstats and leaderstats:FindFirstChild("Speed")
		if speedValue and speedValue:IsA("NumberValue") then
			speedValue.Value = profile.SpeedPower
		end
	end
end

local function save(player: Player, isLeaving: boolean)
	local profile = profiles[player]
	if not profile then
		return
	end
	if isLeaving then
		profile.LastLogout = os.time()
	end
	local snapshot = deepCopy(profile)
	local success, err = pcall(function()
		store:SetAsync("Player_" .. player.UserId, snapshot)
	end)
	if success then
		dirty[player] = nil
	elseif not isLeaving then
		warn(("[Data] Save failed for %s: %s"):format(player.Name, tostring(err)))
	end
end

local function createLeaderstats(player: Player, profile: {[any]: any})
	local existing = player:FindFirstChild("leaderstats")
	if existing then
		existing:Destroy()
	end
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = player

	local money = Instance.new("NumberValue")
	money.Name = "Money"
	money.Value = tonumber(profile.Money) or 0
	money.Parent = leaderstats

	local speed = Instance.new("NumberValue")
	speed.Name = "Speed"
	speed.Value = tonumber(profile.SpeedPower) or 10
	speed.Parent = leaderstats

	player:SetAttribute("Money", money.Value)
	player:SetAttribute("SpeedPower", speed.Value)
end

local function load(player: Player)
	local loaded
	local success, err = pcall(function()
		loaded = store:GetAsync("Player_" .. player.UserId)
	end)
	if not success then
		warn(("[Data] Load failed for %s; using a session profile: %s"):format(player.Name, tostring(err)))
	end
	local profile = if typeof(loaded) == "table" then loaded else deepCopy(template)
	reconcile(profile, template)
	profile.Money = math.max(0, tonumber(profile.Money) or 0)
	profile.SpeedPower = math.max(25, tonumber(profile.SpeedPower) or 25)
	loadedLogout[player] = tonumber(profile.LastLogout) or 0
	profiles[player] = profile
	createLeaderstats(player, profile)
	player:SetAttribute("DataLoaded", true)
	Data.Loaded:Fire(player, profile)
end

function Data.Get(player: Player): {[any]: any}?
	return profiles[player]
end

function Data.GetCopy(player: Player): {[any]: any}?
	local profile = profiles[player]
	return if profile then deepCopy(profile) else nil
end

function Data.GetLoadedLogout(player: Player): number
	return loadedLogout[player] or 0
end

function Data.Update(player: Player, changes: {[any]: any}, removals: {any}?): boolean
	local profile = profiles[player]
	if not profile or typeof(changes) ~= "table" then
		return false
	end
	for key, value in pairs(changes) do
		profile[key] = deepCopy(value)
	end
	local removalSet = {}
	if removals then
		for _, key in ipairs(removals) do
			if typeof(key) == "string" then
				profile[key] = nil
				removalSet[key] = true
			end
		end
	end
	dirty[player] = true
	updateMirrors(player, changes)
	Network.FireAll("New Stats", deepCopy(changes), removalSet, player)
	Data.Changed:Fire(player, changes, removalSet)
	return true
end

function Data.AddMoney(player: Player, amount: number): number?
	local profile = profiles[player]
	if not profile or amount ~= amount then
		return nil
	end
	local nextMoney = math.max(0, (tonumber(profile.Money) or 0) + amount)
	Data.Update(player, {Money = nextMoney})
	return nextMoney
end

function Data.SaveNow(player: Player)
	save(player, false)
end

function Data.Start()
	if started then
		return
	end
	started = true

	Network.BindFunction("Get Stats", function(player, target)
		local requested = if typeof(target) == "Instance" and target:IsA("Player") then target else player
		return Data.GetCopy(requested)
	end)

	Players.PlayerAdded:Connect(load)
	Players.PlayerRemoving:Connect(function(player)
		save(player, true)
		profiles[player] = nil
		dirty[player] = nil
		loadedLogout[player] = nil
	end)
	for _, player in ipairs(Players:GetPlayers()) do
		task.spawn(load, player)
	end

	task.spawn(function()
		while task.wait(AUTOSAVE_SECONDS) do
			for player in pairs(dirty) do
				if player.Parent == Players then
					task.spawn(save, player, false)
				end
			end
		end
	end)

	game:BindToClose(function()
		for _, player in ipairs(Players:GetPlayers()) do
			save(player, true)
		end
	end)
end

return Data
