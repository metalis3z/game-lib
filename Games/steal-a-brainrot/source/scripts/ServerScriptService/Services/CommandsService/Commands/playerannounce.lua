local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Players = game:GetService("Players")
local Net = require(ReplicatedStorage.Packages.Net)
local Conch = require(ReplicatedStorage.Packages.Conch)
local MS_TYPE = "PlayerAnnounce_v1"

-- Handler: recevoir le message et notifier si le joueur est dans CE serveur
if not _G._PA_sub then
    _G._PA_sub = true
    task.spawn(function()
        while not _G.MessagingHub do task.wait(0.5) end
        _G.MessagingHub.Register(MS_TYPE, function(data)
            if type(data) ~= "table" then return end
            local targetName = data.playerName
            local text = data.text
            if not targetName or not text then return end
            -- Chercher le joueur dans CE serveur
            local target = Players:FindFirstChild(targetName)
            if not target then return end
            -- Notifier uniquement ce joueur dans ce serveur
            local NS = require(ServerScriptService.Services.NotificationService)
            NS.Notify(target, text, 6, "Sounds.Sfx.Blop", "Top")
            print("[PlayerAnnounce] Message envoyé à", targetName, "dans ce serveur")
        end)
    end)
end

local module = function(_, Config)
    Conch.register("playerannounce", {
        permissions = { Config.RequiredRole or "super-user" },
        arguments = function()
            return
                { kind="argument", type="string", name="PlayerName" },
                { kind="argument", type="string", name="Message" }
        end,
        callback = function(playerName, text)
            if not playerName or playerName == "" then
                return false, "Pseudo du joueur requis"
            end
            if not text or text == "" then
                return false, "Message requis"
            end

            -- Chercher d'abord en local
            local localTarget = Players:FindFirstChild(playerName)
            if localTarget then
                local NS = require(ServerScriptService.Services.NotificationService)
                NS.Notify(localTarget, text, 6, "Sounds.Sfx.Blop", "Top")
                return "✅ Message envoyé à " .. playerName .. " (serveur local)"
            end

            -- Sinon broadcaster via MessagingHub (tous les serveurs)
            if not _G.MessagingHub then
                return false, "MessagingHub indisponible"
            end
            _G.MessagingHub.Publish(MS_TYPE, {
                playerName = playerName,
                text = text,
            })
            return "✅ Message broadcasté → serveur de " .. playerName
        end,
    })
end

return module