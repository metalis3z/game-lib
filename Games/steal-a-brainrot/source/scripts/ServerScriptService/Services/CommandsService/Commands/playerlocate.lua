local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local MessagingService = game:GetService("MessagingService")

local Net = require(ReplicatedStorage.Packages.Net)
local Conch = require(ReplicatedStorage.Packages.Conch)

local NotificationEvent = Net:RemoteEvent("NotificationService/Notify")
local MSG_TYPE_REQUEST  = "PlayerLocate_Request"
local MSG_TYPE_RESPONSE = "PlayerLocate_Response"
local THIS_JOB_ID = game.JobId

-- Enregistrement des handlers MessagingHub
local function registerHandlers()
    if not _G.MessagingHub then return end

    -- Quand un autre serveur demande si un joueur est ici
    _G.MessagingHub.Register(MSG_TYPE_REQUEST, function(data)
        if not data or not data.TargetName or not data.RequestJobId then return end
        if data.RequestJobId == THIS_JOB_ID then return end -- c'est nous qui avons envoyé, skip

        local targetNameLower = string.lower(data.TargetName)
        local found = nil
        for _, player in ipairs(Players:GetPlayers()) do
            if string.lower(player.Name) == targetNameLower
            or string.lower(player.DisplayName) == targetNameLower then
                found = player
                break
            end
        end

        if found then
            -- Répondre au serveur qui cherche
            _G.MessagingHub.Publish(MSG_TYPE_RESPONSE, {
                RequestJobId  = data.RequestJobId,
                RequesterUserId = data.RequesterUserId,
                TargetName    = found.Name,
                TargetDisplay = found.DisplayName,
                FoundJobId    = THIS_JOB_ID,
                PlayerCount   = #Players:GetPlayers(),
            })
        end
    end)

    -- Quand on reçoit une réponse (un serveur a trouvé le joueur)
    _G.MessagingHub.Register(MSG_TYPE_RESPONSE, function(data)
        if not data or data.RequestJobId ~= THIS_JOB_ID then return end

        -- Trouver le joueur qui a demandé
        local requester = nil
        if data.RequesterUserId then
            requester = Players:GetPlayerByUserId(data.RequesterUserId)
        end

        local isSameServer = (data.FoundJobId == THIS_JOB_ID)
        local serverLabel = isSameServer
            and "<font color=\"#00FF88\">ce serveur</font>"
            or string.format("<font color=\"#FFD700\">un autre serveur</font> <font color=\"#888888\">(Job: ...%s)</font>",
                string.sub(tostring(data.FoundJobId), -6))

        local msg = string.format(
            "🔍 <b>%s</b> (<font color=\"#00BFFF\">@%s</font>) se trouve sur %s · <font color=\"#888888\">%d joueur(s)</font>",
            data.TargetDisplay or data.TargetName,
            data.TargetName,
            serverLabel,
            data.PlayerCount or 0
        )

        if requester then
            NotificationEvent:FireClient(requester, msg, 8, "Sounds.Sfx.Success", "Top")
        end
    end)
end

task.spawn(function()
    while not _G.MessagingHub do task.wait(0.5) end
    registerHandlers()
end)

local module = function(_, Config)
    Conch.register("playerlocate", {
        permissions = { Config.RequiredRole or "super-user" },
        arguments = function()
            return {
                kind = "argument",
                type = "string",
                name = "Pseudo du joueur",
            }
        end,
        callback = function(targetName)
            if not targetName or targetName == "" then
                return "❌ Tu dois entrer un pseudo !"
            end

            -- Récupérer l'exécuteur
            local requesterUserId = nil
            local requester = nil
            pcall(function()
                local ctx = Conch.get_command_context()
                if ctx and ctx.executor and ctx.executor.player then
                    requester = ctx.executor.player
                    requesterUserId = requester.UserId
                end
            end)

            local targetNameLower = string.lower(targetName)

            -- 1. Chercher sur CE serveur d'abord
            for _, player in ipairs(Players:GetPlayers()) do
                if string.lower(player.Name) == targetNameLower
                or string.lower(player.DisplayName) == targetNameLower then
                    local msg = string.format(
                        "🔍 <b>%s</b> (<font color=\"#00BFFF\">@%s</font>) est sur <font color=\"#00FF88\">ce serveur</font> · <font color=\"#888888\">%d joueur(s)</font>",
                        player.DisplayName, player.Name, #Players:GetPlayers()
                    )
                    if requester then
                        NotificationEvent:FireClient(requester, msg, 8, "Sounds.Sfx.Success", "Top")
                    end
                    return "✅ " .. player.Name .. " est sur ce serveur !"
                end
            end

            -- 2. Broadcaster aux autres serveurs
            if _G.MessagingHub then
                _G.MessagingHub.Publish(MSG_TYPE_REQUEST, {
                    TargetName      = targetName,
                    RequestJobId    = THIS_JOB_ID,
                    RequesterUserId = requesterUserId,
                })

                if requester then
                    NotificationEvent:FireClient(
                        requester,
                        string.format("🔍 Recherche de <b>%s</b> dans tous les serveurs...", targetName),
                        4, "Sounds.Sfx.Blop", "Top"
                    )
                end

                return "🔍 Recherche lancée dans tous les serveurs..."
            else
                return "❌ MessagingHub indisponible, impossible de chercher dans les autres serveurs."
            end
        end,
    })
end

return module
