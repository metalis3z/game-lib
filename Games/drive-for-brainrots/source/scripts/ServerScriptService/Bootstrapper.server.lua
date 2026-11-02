--!strict
-- LOCATION: ServerScriptService/Bootstrapper
-- Loads all server modules in dependency order.

local Players           = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

print("[Bootstrapper] Starting...")

-- Helper: require with error logging so one bad module doesn't kill the rest
local function safeRequire(modulePath: string)
    local mod = require(ServerScriptService:FindFirstChild(modulePath, true))
    return mod
end

local function tryRequire(path: Instance): any?
    local ok, result = pcall(function()
        return require(path)
    end)
    if not ok then
        warn("[Bootstrapper] Failed to load " .. path:GetFullName() .. ": " .. tostring(result))
        return nil
    end
    return result
end

-- ── 1. DataManager (no deps, must be first) ────────────────────────────────
local DataManager = tryRequire(ServerScriptService.Handlers.DataManager)

if DataManager then
    -- Wire up player lifecycle BEFORE anyone else connects
    Players.PlayerAdded:Connect(function(player: Player)
        DataManager.load(player)
        DataManager.buildLeaderstats(player)
        DataManager.buildUpgradesData(player)
    end)
    Players.PlayerRemoving:Connect(function(player: Player)
        DataManager.unload(player)
    end)
    -- Load data for players already in-game (Studio play mode)
    for _, player in ipairs(Players:GetPlayers()) do
        DataManager.load(player)
        DataManager.buildLeaderstats(player)
        DataManager.buildUpgradesData(player)
    end
else
    warn("[Bootstrapper] DataManager failed to load — critical!")
end

-- ── 2. SaveService (stub) ──────────────────────────────────────────────────
tryRequire(ServerScriptService.Modules.SaveService)

-- ── 3. ItemManager ────────────────────────────────────────────────────────
local ItemManager = tryRequire(ServerScriptService.Modules.ItemManager)

-- ── 4. SlotManager ────────────────────────────────────────────────────────
tryRequire(ServerScriptService.Handlers.SlotManager)

-- ── 5. PlotManager ────────────────────────────────────────────────────────
tryRequire(ServerScriptService.Handlers.PlotManager)

-- ── 5b. CarrySystem ──────────────────────────────────────────────────────
local CarrySystem = tryRequire(ServerScriptService.Modules.CarrySystem)
if CarrySystem then
    CarrySystem:Init()
    CarrySystem:Start()
end

-- ── 6. ZoneCarService ─────────────────────────────────────────────────────

-- ── 7. Game logic handlers ────────────────────────────────────────────────
tryRequire(ServerScriptService.Handlers.UpgradesHandler)
tryRequire(ServerScriptService.Handlers.RebirthHandler)
tryRequire(ServerScriptService.Handlers.SellHandler)
tryRequire(ServerScriptService.Handlers.SpinHandler)
tryRequire(ServerScriptService.Handlers.AdminHandler)
tryRequire(ServerScriptService.Handlers.GiftRewardHandler)

-- ── 8. Index remote function ──────────────────────────────────────────────
if DataManager then
    local GetIndexData = ReplicatedStorage.Events:FindFirstChild("GetIndexData")
    if GetIndexData and GetIndexData:IsA("RemoteFunction") then
        GetIndexData.OnServerInvoke = function(player: Player)
            local data = DataManager.get(player)
            return data and data.DiscoveredItems or {}
        end
    end
end

-- ── 9. Spawn all items ────────────────────────────────────────────────────
if ItemManager then
    task.delay(1, function()
        ItemManager.SpawnAllItems()
        print("[Bootstrapper] Items spawned")
    end)
else
    warn("[Bootstrapper] ItemManager not loaded — items will NOT spawn!")
end

print("[Bootstrapper] All systems loaded ✅")
