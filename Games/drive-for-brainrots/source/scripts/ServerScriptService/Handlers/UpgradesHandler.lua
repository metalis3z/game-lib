--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DataManager    = require(script.Parent.DataManager)
local UpgradesConfig = require(ReplicatedStorage.Modules.UpgradesConfiguration)
local NumberFormatter = require(ReplicatedStorage.Modules.NumberFormatter)

local Events            = ReplicatedStorage:WaitForChild("Events")
local PurchaseUpgrade   = Events:WaitForChild("PurchaseUpgrade")
local UpdateUpgradesUI  = Events:WaitForChild("UpdateUpgradesUI")
local ShowNotification  = Events:WaitForChild("ShowNotification")
local TriggerUIEffect   = Events:WaitForChild("TriggerUIEffect")

-- Build the full state table the client needs: { upgradeName = { Current=, Cost= } }
local function buildUIState(player: Player): {[string]: any}
    local state = {}
    for upgName, cfg in pairs(UpgradesConfig.Upgrades) do
        local level = DataManager.getUpgradeLevel(player, upgName)
        local cost  = math.floor(cfg.BaseCost * (cfg.PriceMultiplier ^ level))
        state[upgName] = { Current = level, Cost = cost }
    end
    return state
end

-- Client requests initial state (fires with no args)
UpdateUpgradesUI.OnServerEvent:Connect(function(player: Player)
    UpdateUpgradesUI:FireClient(player, buildUIState(player))
end)

-- Purchase
PurchaseUpgrade.OnServerEvent:Connect(function(player: Player, upgradeName: string, qty: number?)
    if type(upgradeName) ~= "string" then return end
    local cfg = UpgradesConfig.Upgrades[upgradeName]
    if not cfg then return end
    local amount = math.max(1, math.floor(tonumber(qty) or 1))
    local currentLevel = DataManager.getUpgradeLevel(player, upgradeName)

    local totalCost = 0
    for i = 0, amount - 1 do
        totalCost += math.floor(cfg.BaseCost * (cfg.PriceMultiplier ^ (currentLevel + i)))
    end

    if DataManager.getMoney(player) < totalCost then
        ShowNotification:FireClient(player, "Need $" .. NumberFormatter.Format(totalCost), "Error")
        return
    end

    DataManager.addMoney(player, -totalCost)
    DataManager.setUpgradeLevel(player, upgradeName, currentLevel + amount)
    DataManager.syncUpgradesData(player, upgradeName)

    TriggerUIEffect:FireClient(player, "HighlightLight")
    -- Send full refreshed state so all labels update
    UpdateUpgradesUI:FireClient(player, buildUIState(player))
    print("[UpgradesHandler]", player.Name, upgradeName, "->", currentLevel + amount)
end)

print("[UpgradesHandler] Active")
local UpgradesHandler = {}
return UpgradesHandler
