local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Net = require(ReplicatedStorage.Packages.Net)
local Conch = require(ReplicatedStorage.Packages.Conch)

local NotificationEvent = Net:RemoteEvent("NotificationService/Notify")
local MSG_TYPE = "GlobalPlayerAnnounce"
local THIS_JOB_ID = game.JobId

-- Handler : reçoit UNIQUEMENT les messages des AUTRES serveurs
local function registerHandler()
    if not _G.MessagingHub then return end
    _G.MessagingHub.Register(MSG_TYPE, function(data)
        if not data or not data.Text then return end
        -- Ignorer si c'est notre propre serveur (évite le double message)
        if data.jobId == THIS_JOB_ID then return end

        local formatted = string.format("<font color=\"#00BFFF\"><b>%s</b></font>: %s", data.DisplayName or "Admin", data.Text)
        for _, player in ipairs(Players:GetPlayers()) do
            NotificationEvent:FireClient(player, formatted, 6, "Sounds.Sfx.Blop", "Top")
        end
    end)
end

task.spawn(function()
    while not _G.MessagingHub do task.wait(0.5) end
    registerHandler()
end)

local module = function(_, Config)
    Conch.register("globalplayerannounce", {
        permissions = { Config.RequiredRole or "super-user" },
        arguments = function()
            return {
                kind = "argument",
                type = "string",
                name = "text",
            }
        end,
        callback = function(text)
            if not text or text == "" then
                return "Tu dois fournir un message !"
            end

            -- Récupérer l'exécuteur
            local displayName = "Admin"
            local userId = nil
            pcall(function()
                local ctx = Conch.get_command_context()
                if ctx and ctx.executor and ctx.executor.player then
                    local executor = ctx.executor.player
                    displayName = executor.DisplayName
                    userId = executor.UserId
                end
            end)

            local formatted = string.format("<font color=\"#00BFFF\"><b>%s</b></font>: %s", displayName, text)

            -- Envoyer sur CE serveur (une seule fois)
            -- Notify = FireClient(player, text, duration, sound, position)
            for _, player in ipairs(Players:GetPlayers()) do
                NotificationEvent:FireClient(player, formatted, 6, "Sounds.Sfx.Blop", "Top")
            end

            -- Broadcaster aux autres serveurs (avec jobId pour éviter le double)
            if _G.MessagingHub then
                _G.MessagingHub.Publish(MSG_TYPE, {
                    Text        = text,
                    DisplayName = displayName,
                    UserId      = userId,
                    jobId       = THIS_JOB_ID,
                })
            end

            return "✅ Annonce envoyée en tant que " .. displayName
        end,
    })
end

return module
