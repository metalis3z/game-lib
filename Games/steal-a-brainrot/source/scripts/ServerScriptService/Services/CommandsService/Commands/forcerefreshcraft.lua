local module = function(Conch, Config)
    local SS      = game:GetService("ServerScriptService")
    local RS      = game:GetService("ReplicatedStorage")
    local Players = game:GetService("Players")
    local MS      = game:GetService("MessagingService")
    local TOPIC   = "CraftForceRefresh_v1"

    Conch.register("forcerefreshcraft", {
        description = "Change les recettes du Craft Machine sur TOUS les serveurs.",
        permissions = { Config.RequiredRole or "super-user" },
        arguments = function() return end,
        callback = function()
            local CMS = require(SS.Services.CraftingMachineService)
            local NS  = require(SS.Services.NotificationService)

            CMS.forceRefresh(math.random(1, 2^28))
            pcall(MS.PublishAsync, MS, TOPIC, { jobId = game.JobId })

            local msg = '<font color="#FFD700">🔄 <b>Nouvelles recettes disponibles!</b></font>'
            for _, p in ipairs(Players:GetPlayers()) do
                NS.Notify(p, msg, 5, RS.Sounds.Sfx.Success)
            end
            return "✅ Craft Machine refresh global"
        end,
    })
end
return module
