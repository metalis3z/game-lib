local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Net = require(ReplicatedStorage.Packages.Net)
local Conch = require(ReplicatedStorage.Packages.Conch)

local NotificationEvent = Net:RemoteEvent("NotificationService/Notify")

local module = function(_, Config)
    Conch.register("playerannounce", {
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
            pcall(function()
                local ctx = Conch.get_command_context()
                if ctx and ctx.executor and ctx.executor.player then
                    displayName = ctx.executor.player.DisplayName
                end
            end)

            local formatted = string.format(
                '<font color="#FF4444"><b>%s</b></font>: %s',
                displayName, text
            )

            -- Envoyer uniquement sur CE serveur
            for _, player in ipairs(Players:GetPlayers()) do
                NotificationEvent:FireClient(player, formatted, 6, "Sounds.Sfx.Blop", "Top")
            end

            return "✅ Annonce locale envoyée en tant que " .. displayName
        end,
    })
end

return module
