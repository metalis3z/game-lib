local module = function(Conch, Config)
    local SS      = game:GetService("ServerScriptService")
    local RS      = game:GetService("ReplicatedStorage")
    local Players = game:GetService("Players")
    local MS      = game:GetService("MessagingService")
    local TOPIC   = "CraftMachineRefresh_v2"  -- même topic que CraftRefreshHandler

    Conch.register("refreshcraftmachine", {
        description = "Efface recettes custom + change recettes normales + broadcast global.",
        permissions = { Config.RequiredRole or "super-user" },
        arguments = function()
            return {}
        end,
        callback = function()
            local CMS = require(SS.Services.CraftingMachineService)
            local NS  = require(SS.Services.NotificationService)

            -- 1) Effacer les recettes custom localement
            CMS.clearCustomRecipes()

            -- 2) Régénérer les recettes normales + fire aux clients locaux
            CMS.forceRefresh(math.random(1, 2^28))

            -- Broadcaster aux AUTRES serveurs (clearCustom + refresh + notification)
            pcall(MS.PublishAsync, MS, TOPIC, {
                jobId = game.JobId,
                clearCustom = true,
                notifyMsg = '<font color="#00BFFF">🔄 <b>Craft Machine refresh!</b> Les limited on été enlevé!</font>',
            })

            -- 4) Message aux joueurs locaux
			local msg = '<font color="#00BFFF">🔄 <b>Craft Machine refresh!</b Les limited on été enlevé!</font>'
            for _, p in ipairs(Players:GetPlayers()) do
                NS.Notify(p, msg, 6, RS.Sounds.Sfx.Success)
            end

            return "✅ Craft Machine refresh global effectué"
        end,
    })
end
return module
