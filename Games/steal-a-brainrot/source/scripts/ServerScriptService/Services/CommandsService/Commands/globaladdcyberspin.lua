local module = function(Conch, Config)
    local RS      = game:GetService("ReplicatedStorage")
    local SS      = game:GetService("ServerScriptService")
    local Players = game:GetService("Players")
    local MS      = game:GetService("MessagingService")
    local TOPIC   = "GlobalCyberSpin_v3"

    local Synchronizer = require(RS.Packages.Synchronizer)
    local NotificationService = require(SS.Services.NotificationService)

    local function addSpins(player, amount)
        local ch = Synchronizer:Get(player)
        if not ch then
            warn("[globaladdcyberspin] Pas de channel pour", player.Name)
            return false
        end
        -- Toujours Increase: le channel gère le cas où la clé n'existe pas
        ch:Increase("CyberSpinWheel.Spins", amount)
        NotificationService.Notify(player,
            string.format('🎰 <font color="#00FFFF"><b>+%d Cyber Spin%s</b></font> offert par l\'admin!',
                amount, amount > 1 and "s" or ""),
            5, "Sounds.Sfx.Success")
        return true
    end

    -- Subscribe cross-serveur (une seule fois par serveur)
    if not _G._sub_globaladdcyberspin then
        _G._sub_globaladdcyberspin = true
        task.spawn(function()
            pcall(function()
                MS:SubscribeAsync(TOPIC, function(msg)
                    local d = msg.Data
                    if type(d) ~= "table" or d.jobId == game.JobId then return end
                    local amount = math.clamp(tonumber(d.amount) or 1, 1, 9999)
                    if d.playerName then
                        local p = Players:FindFirstChild(d.playerName)
                        if p then addSpins(p, amount) end
                    else
                        for _, p in ipairs(Players:GetPlayers()) do
                            addSpins(p, amount)
                        end
                    end
                end)
            end)
        end)
    end

    Conch.register("globaladdcyberspin", {
        description = "Ajoute des Cyber Spins à un joueur ou à tous sur TOUS les serveurs.",
        permissions = { Config.RequiredRole or "super-user" },
        arguments = function()
            return
                { kind="argument", type="number",  name="Quantité" },
                { kind="argument", type="Player",  name="Joueur (vide=tous)", optional=true }
        end,
        callback = function(amount, targetPlayer)
            amount = math.clamp(math.floor(tonumber(amount) or 1), 1, 9999)

            if targetPlayer then
                local p = typeof(targetPlayer) == "Instance" and targetPlayer:IsA("Player") and targetPlayer
                    or Players:FindFirstChild(tostring(targetPlayer))
                if not p then
                    return "❌ Joueur introuvable: " .. tostring(targetPlayer)
                end
                local ok = addSpins(p, amount)
                if not ok then
                    return "❌ Impossible d'ajouter les spins à " .. p.Name .. " (pas connecté au Synchronizer?)"
                end
                pcall(MS.PublishAsync, MS, TOPIC, {
                    jobId = game.JobId, amount = amount, playerName = p.Name
                })
                return string.format("✅ +%d Cyber Spin%s → %s (tous serveurs)",
                    amount, amount > 1 and "s" or "", p.Name)
            else
                local count = 0
                for _, p in ipairs(Players:GetPlayers()) do
                    if addSpins(p, amount) then count += 1 end
                end
                pcall(MS.PublishAsync, MS, TOPIC, {
                    jobId = game.JobId, amount = amount
                })
                return string.format("✅ +%d Cyber Spin%s → tous (%d local + tous serveurs)",
                    amount, amount > 1 and "s" or "", count)
            end
        end,
    })
end
return module
