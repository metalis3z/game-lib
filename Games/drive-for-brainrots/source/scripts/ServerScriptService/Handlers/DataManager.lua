--!strict
local Players = game:GetService("Players")
local UpgradesConfig = require(game:GetService("ReplicatedStorage").Modules.UpgradesConfiguration)

local DATA_TEMPLATE = {
    Money       = 0,
    Rebirths    = 0,
    BaseLevel   = 0,
    OnboardingStep = 0,
    DailySpins  = 3,
    LastSpinReset = 0,
    DiscoveredItems = {},
    OfflineData = { LastSeen = 0 },
    Upgrades    = {},
}

local function deepCopy(t: any): any
    local c = {}
    for k, v in pairs(t) do c[k] = type(v) == "table" and deepCopy(v) or v end
    return c
end

local store: {[Player]: any} = {}

local DataManager = {}

function DataManager.load(player: Player)
    store[player] = deepCopy(DATA_TEMPLATE)
    -- Initialise upgrade levels
    for k, cfg in pairs(UpgradesConfig.Upgrades) do
        if store[player].Upgrades[k] == nil then
            store[player].Upgrades[k] = cfg.DefaultValue or 0
        end
    end
    print("[DataManager] Loaded data for " .. player.Name)
end

function DataManager.unload(player: Player)
    store[player] = nil
end

function DataManager.get(player: Player): any
    return store[player]
end

function DataManager.getMoney(player: Player): number
    local d = store[player]
    return d and d.Money or 0
end

function DataManager.addMoney(player: Player, amount: number)
    local d = store[player]
    if not d then return end
    d.Money = math.max(0, d.Money + amount)
    -- Sync leaderstats
    local ls = player:FindFirstChild("leaderstats")
    if ls then
        local mv = ls:FindFirstChild("Money")
        if mv then mv.Value = d.Money end
    end
end

function DataManager.getUpgradeLevel(player: Player, name: string): number
    local d = store[player]
    return (d and d.Upgrades and d.Upgrades[name]) or 0
end

function DataManager.setUpgradeLevel(player: Player, name: string, level: number)
    local d = store[player]
    if not d then return end
    if not d.Upgrades then d.Upgrades = {} end
    d.Upgrades[name] = level
end

function DataManager.buildLeaderstats(player: Player)
    local d = store[player]
    if not d then return end
    local ls = Instance.new("Folder")
    ls.Name = "leaderstats"
    ls.Parent = player
    local moneyVal = Instance.new("NumberValue")
    moneyVal.Name = "Money"; moneyVal.Value = d.Money; moneyVal.Parent = ls
    local rebVal = Instance.new("NumberValue")
    rebVal.Name = "Rebirths"; rebVal.Value = d.Rebirths; rebVal.Parent = ls
end

function DataManager.buildUpgradesData(player: Player)
    local d = store[player]
    if not d then return end
    local ud = Instance.new("Folder")
    ud.Name = "UpgradesData"; ud.Parent = player
    for k, cfg in pairs(UpgradesConfig.Upgrades) do
        local nv = Instance.new("NumberValue")
        nv.Name = k; nv.Value = d.Upgrades[k] or cfg.DefaultValue or 0; nv.Parent = ud
    end
end

function DataManager.syncUpgradesData(player: Player, key: string?)
    local d = store[player]; if not d then return end
    local ud = player:FindFirstChild("UpgradesData"); if not ud then return end
    if key then
        local v = ud:FindFirstChild(key); if v then v.Value = d.Upgrades[key] or 0 end
    else
        for k in pairs(UpgradesConfig.Upgrades) do
            local v = ud:FindFirstChild(k); if v then v.Value = d.Upgrades[k] or 0 end
        end
    end
end

Players.PlayerRemoving:Connect(DataManager.unload)
return DataManager
