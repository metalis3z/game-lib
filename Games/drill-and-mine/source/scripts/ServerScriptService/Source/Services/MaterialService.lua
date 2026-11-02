local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local PlayerDataService = require(ServerScriptService.Source.Services.PlayerDataService)
local GameConfig = require(ReplicatedStorage.Source.Configs.GameConfig)

local MaterialService = {}

local MATERIAL_ATTRIBUTE = "BridgeMaterial"
local MAX_PER_REQUEST = 50

local function getMaxStorageForPlayer(player)
	local data = PlayerDataService.GetPlayerData(player)
	local upg = GameConfig.Upgrades and GameConfig.Upgrades.Storage
	if data and upg then
		local level = math.max(0, math.floor(data.StorageLevel or 0))
		-- clamp to the config cap (old saves can hold levels past MaxLevel)
		if upg.MaxLevel then
			level = math.min(level, upg.MaxLevel)
		end
		return (upg.Base or 10) + level * (upg.PerLevel or 0)
	end
	return (GameConfig.Bridge and GameConfig.Bridge.MaxStorage) or 10
end

local function pushAttribute(player, value)
	player:SetAttribute(MATERIAL_ATTRIBUTE, value)
end

local function syncFromProfile(player)
	local data = PlayerDataService.GetPlayerData(player)
	if not data then
		return
	end
	local saved = math.max(0, data.BridgeMaterial or 0)
	data.BridgeMaterial = saved
	pushAttribute(player, saved)
end

local function handleAdd(player, delta)
	if typeof(delta) ~= "number" then
		return
	end
	if delta ~= delta or delta == math.huge or delta == -math.huge then
		return
	end
	delta = math.floor(delta)
	if delta <= 0 then
		return
	end
	if delta > MAX_PER_REQUEST then
		delta = MAX_PER_REQUEST
	end

	local data = PlayerDataService.GetPlayerData(player)
	if not data then
		return
	end

	local maxStorage = getMaxStorageForPlayer(player)
	local current = data.BridgeMaterial or 0
	if current >= maxStorage then
		return
	end
	local newVal = math.min(current + delta, maxStorage)
	if newVal == current then
		return
	end

	PlayerDataService.SetStat(player, "BridgeMaterial", newVal)
	pushAttribute(player, newVal)
	PlayerDataService.ScheduleSave(player)
end

local function handleSet(player, value)
	if typeof(value) ~= "number" then
		return
	end
	if value ~= value or value == math.huge or value == -math.huge then
		return
	end

	local data = PlayerDataService.GetPlayerData(player)
	if not data then
		return
	end

	-- SetMaterial is the legacy absolute-value SPEND path, kept for safety.
	-- New code (BridgeBuilderClient) uses SpendMaterial(delta) below, which is
	-- race-free against concurrent AddMaterial events. This handler must still
	-- only DECREASE BridgeMaterial so a stale absolute message can't bump
	-- wood back up.
	local current = data.BridgeMaterial or 0
	local floored = math.floor(value)
	if floored >= current then
		return
	end

	local newVal = math.max(0, floored)
	if data.BridgeMaterial == newVal then
		return
	end

	PlayerDataService.SetStat(player, "BridgeMaterial", newVal)
	pushAttribute(player, newVal)
	PlayerDataService.ScheduleSave(player)
end

-- SpendMaterial is the new DELTA-based spend protocol. Client fires a positive
-- integer ("how many planks did I just place") and the server decrements
-- BridgeMaterial by exactly that amount, clamped to 0. This avoids the race
-- where a tree-chop AddMaterial event lands between the client's local
-- prediction and the server processing an absolute SetMaterial -- under that
-- old protocol the server would overwrite the chopped wood with the stale
-- pre-chop client value. With deltas, chop and spend commute correctly.
local function handleSpend(player, amount)
	if typeof(amount) ~= "number" then
		return
	end
	if amount ~= amount or amount == math.huge or amount == -math.huge then
		return
	end
	amount = math.floor(amount)
	if amount <= 0 then
		return
	end
	if amount > MAX_PER_REQUEST then
		amount = MAX_PER_REQUEST
	end

	local data = PlayerDataService.GetPlayerData(player)
	if not data then
		return
	end

	local current = data.BridgeMaterial or 0
	if current <= 0 then
		return
	end

	local newVal = math.max(0, current - amount)
	if newVal == current then
		return
	end

	PlayerDataService.SetStat(player, "BridgeMaterial", newVal)
	pushAttribute(player, newVal)
	PlayerDataService.ScheduleSave(player)
end

-- Robux-purchased material bypasses the MaxStorage clamp — the player keeps
-- the overfilled amount until they chop it down. Normal tree chopping still
-- goes through handleAdd which respects MaxStorage and triggers the
-- "Upgrade storage!" notification, so once they're over cap they can't add
-- more by chopping until they spend down past MaxStorage.
function MaterialService.AddMaterialOverfill(player, amount)
	if typeof(amount) ~= "number" then
		return
	end
	if amount ~= amount or amount == math.huge or amount == -math.huge then
		return
	end
	amount = math.floor(amount)
	if amount <= 0 then
		return
	end

	local data = PlayerDataService.GetPlayerData(player)
	if not data then
		return
	end

	local current = data.BridgeMaterial or 0
	local newVal = current + amount

	PlayerDataService.SetStat(player, "BridgeMaterial", newVal)
	pushAttribute(player, newVal)
	PlayerDataService.ScheduleSave(player)
end

function MaterialService.ResetForRebirth(player)
	local data = PlayerDataService.GetPlayerData(player)
	if not data then
		return
	end
	if (data.BridgeMaterial or 0) == 0 then
		pushAttribute(player, 0)
		return
	end
	PlayerDataService.SetStat(player, "BridgeMaterial", 0)
	pushAttribute(player, 0)
	PlayerDataService.ScheduleSave(player)
end

function MaterialService.Init()
	local Remotes = ReplicatedStorage:WaitForChild("Remotes")
	local serviceFolder = Remotes:FindFirstChild("MaterialService")
	if not serviceFolder then
		serviceFolder = Instance.new("Folder")
		serviceFolder.Name = "MaterialService"
		serviceFolder.Parent = Remotes
	end

	local AddMaterial = serviceFolder:FindFirstChild("AddMaterial")
	if not AddMaterial then
		AddMaterial = Instance.new("RemoteEvent")
		AddMaterial.Name = "AddMaterial"
		AddMaterial.Parent = serviceFolder
	end

	local SetMaterial = serviceFolder:FindFirstChild("SetMaterial")
	if not SetMaterial then
		SetMaterial = Instance.new("RemoteEvent")
		SetMaterial.Name = "SetMaterial"
		SetMaterial.Parent = serviceFolder
	end

	local SpendMaterial = serviceFolder:FindFirstChild("SpendMaterial")
	if not SpendMaterial then
		SpendMaterial = Instance.new("RemoteEvent")
		SpendMaterial.Name = "SpendMaterial"
		SpendMaterial.Parent = serviceFolder
	end

	AddMaterial.OnServerEvent:Connect(handleAdd)
	SetMaterial.OnServerEvent:Connect(handleSet)
	SpendMaterial.OnServerEvent:Connect(handleSpend)

	PlayerDataService.ProfileLoaded.Event:Connect(syncFromProfile)

	for _, plr in ipairs(Players:GetPlayers()) do
		if PlayerDataService.GetPlayerData(plr) then
			syncFromProfile(plr)
		end
	end
end

return MaterialService
