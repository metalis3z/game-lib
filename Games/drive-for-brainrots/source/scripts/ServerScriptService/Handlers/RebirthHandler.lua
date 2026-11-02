--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DataManager = require(script.Parent.DataManager)
local Events      = ReplicatedStorage:WaitForChild("Events")
local RequestRebirth  = Events:WaitForChild("RequestRebirth")
local UpdateRebirthUI = Events:WaitForChild("UpdateRebirthUI")
local ShowNotification = Events:WaitForChild("ShowNotification")
local TriggerUIEffect  = Events:WaitForChild("TriggerUIEffect")

local function getRequired(rebirths: number): number return rebirths*10+10 end

RequestRebirth.OnServerEvent:Connect(function(player: Player)
    local data = DataManager.get(player)
    if not data then return end
    local rebirths = data.Rebirths or 0
    local required = getRequired(rebirths)
    local ztLevel  = DataManager.getUpgradeLevel(player, "ZoneTime")
    if ztLevel < required then
        ShowNotification:FireClient(player, "Need ZoneTime level "..required.." (have "..ztLevel..")", "Error")
        return
    end
    data.Rebirths = rebirths + 1
    data.Money    = 0
    DataManager.setUpgradeLevel(player, "ZoneTime", 0)
    DataManager.syncUpgradesData(player, "ZoneTime")
    -- sync leaderstats
    local ls = player:FindFirstChild("leaderstats")
    if ls then
        local rv = ls:FindFirstChild("Rebirths"); if rv then rv.Value = data.Rebirths end
        local mv = ls:FindFirstChild("Money");    if mv then mv.Value = 0 end
    end
    UpdateRebirthUI:FireClient(player, data.Rebirths)
    TriggerUIEffect:FireClient(player, "HighlightLight")
    ShowNotification:FireClient(player, "Rebirthed! x"..string.format("%.1f",1+data.Rebirths*0.5).." income!", "Success")
    print("[RebirthHandler]", player.Name, "rebirthed ->", data.Rebirths)
end)

print("[RebirthHandler] Active")
local RebirthHandler = {}
return RebirthHandler
