local RS  = game:GetService("ReplicatedStorage")
local SS  = game:GetService("ServerScriptService")
local Players = game:GetService("Players")
local MS  = game:GetService("MessagingService")
local Net = require(RS.Packages.Net)

local MenuChoice = Net:RemoteEvent("CraftRefresh/MenuChoice")
local TOPIC = "CraftMachineRefresh_v2"

-- Recevoir les refresh des autres serveurs
if not _G._sub_craftrefresh_handler then
    _G._sub_craftrefresh_handler = true
    pcall(function()
        MS:SubscribeAsync(TOPIC, function(msg)
            local d = msg.Data
            if type(d) ~= "table" or d.jobId == game.JobId then return end
            local ok, CMS = pcall(require, SS.Services.CraftingMachineService)
            if not ok then return end
            if d.clearCustom then CMS.clearCustomRecipes() end
            CMS.forceRefresh(d.normalSeed or nil)
            -- Notification aux joueurs de ce serveur
            if d.notifyMsg then
                local ok2, NS = pcall(require, SS.Services.NotificationService)
                if ok2 then
                    for _, p in ipairs(Players:GetPlayers()) do
                        NS.Notify(p, d.notifyMsg, 5, RS.Sounds.Sfx.Success)
                    end
                end
            end
        end)
    end)
end

local ADMINS = {
    [7602834871]=true,[8461477399]=true,
    [3349554075]=true,[4843172682]=true,[4355115582]=true
}

MenuChoice.OnServerEvent:Connect(function(player, action)
    if not ADMINS[player.UserId] then return end
    local CMS = require(SS.Services.CraftingMachineService)
    local NS  = require(SS.Services.NotificationService)

    local clearCustom = action:find("clear") ~= nil
    local isGlobal    = action:find("global") ~= nil

    -- Appliquer localement
    if clearCustom then CMS.clearCustomRecipes() end
    CMS.forceRefresh()

    -- Broadcaster si global
    if isGlobal then
        pcall(MS.PublishAsync, MS, TOPIC, {
            jobId = game.JobId,
            clearCustom = clearCustom,
        })
    end

    -- Notification
    local msg = isGlobal
        and (clearCustom
            and '<font color="#00BFFF">🔄 <b>Craft Machine reset global!</b></font> Recettes custom effacées.'
            or  '<font color="#00BFFF">🔄 <b>Craft Machine refresh global!</b></font>')
        or  (clearCustom
            and '<font color="#90EE90">🔄 <b>Craft Machine reset local!</b></font> Recettes custom effacées.'
            or  '<font color="#90EE90">🔄 <b>Craft Machine refresh local!</b></font>')

    for _, p in ipairs(Players:GetPlayers()) do
        NS.Notify(p, msg, 5, RS.Sounds.Sfx.Success)
    end

    print("[CraftRefresh]", player.Name, "→", action)
end)

print("[CraftRefreshHandler] ✅ Actif")
