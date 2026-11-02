local MS      = game:GetService("MessagingService")
local SS      = game:GetService("ServerScriptService")
local RS      = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

-- Reçoit forceRefresh (depuis refreshcraftmachine et forcerefreshcraft)
pcall(function()
    MS:SubscribeAsync("CraftForceRefresh_v1", function(msg)
        local d = msg.Data
        if type(d) ~= "table" or d.jobId == game.JobId then return end
        local ok, CMS = pcall(require, SS.Services.CraftingMachineService)
        if not ok then return end
        -- Changer les recettes normales
        CMS.forceRefresh(math.random(1, 2^28))
        -- Notifier les joueurs
        local ok2, NS = pcall(require, SS.Services.NotificationService)
        if ok2 then
            local m = '<font color="#00BFFF">🔄 <b>Craft Machine refresh!</b></font> Les recettes ont changé!'
            for _, p in ipairs(Players:GetPlayers()) do
                NS.Notify(p, m, 6, RS.Sounds.Sfx.Success)
            end
        end
        print("[CraftRefreshListener] Refresh reçu")
    end)
end)

print("[CraftRefreshListener] ✅ Actif")
