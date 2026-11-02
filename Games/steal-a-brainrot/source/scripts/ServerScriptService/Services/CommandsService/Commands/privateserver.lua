local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local DataStoreService = game:GetService("DataStoreService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Net = require(ReplicatedStorage.Packages.Net)
local NotificationService = require(ServerScriptService.Services.NotificationService)

-- Utiliser le PlaceId actuel du jeu
-- NOTE: Si le jeu a plusieurs places, décommenter la ligne suivante et commenter la ligne PLACE_ID
-- local ServerData = require(ReplicatedStorage.Datas.ServerData)
-- local PLACE_ID = ServerData.RootPlaceId
local PLACE_ID = game.PlaceId

-- DataStore dédié au serveur privé partagé admin
local AdminServerStore = DataStoreService:GetDataStore("AdminSharedServer_v1")
local STORE_KEY = "SharedServerCode"
local JOBID_KEY = "SharedServerJobId"

local function getStoredCode()
    local ok, code = pcall(function()
        return AdminServerStore:GetAsync(STORE_KEY)
    end)
    return (ok and typeof(code) == "string" and code ~= "") and code or nil
end

local function storeCode(code)
    pcall(function()
        AdminServerStore:SetAsync(STORE_KEY, code)
    end)
end

local function storeJobId(jobId)
    pcall(function()
        AdminServerStore:SetAsync(JOBID_KEY, jobId)
    end)
end

local function getStoredJobId()
    local ok, jobId = pcall(function()
        return AdminServerStore:GetAsync(JOBID_KEY)
    end)
    return (ok and typeof(jobId) == "string" and jobId ~= "") and jobId or nil
end

local function tpToCode(player, code)
    local ok, err = pcall(function()
        TeleportService:TeleportToPrivateServer(PLACE_ID, code, {player})
    end)
    if not ok then
        warn("[PrivateServer] TP échoué:", err)
        NotificationService.Error(player, "❌ Erreur TP: " .. tostring(err))
    end
    return ok
end

local module = function(Conch, Config)
    -- Commande pour créer OU rejoindre le serveur privé partagé
    Conch.register("privateserver", {
        permissions = { Config.RequiredRole or "super-user" },
        arguments = function()
            return {
                kind = "argument",
                type = "string",
                name = "Action", -- "create", "join", "reset"
                optional = true,
            }
        end,
        callback = function(action)
            action = (action or "join"):lower()

            local admin = nil
            pcall(function()
                local ctx = Conch.get_command_context()
                if ctx and ctx.executor and ctx.executor.player then
                    admin = ctx.executor.player
                end
            end)
            if not admin then return false, "Admin introuvable" end

            if action == "create" or action == "reset" then
                -- Créer un nouveau serveur privé partagé
                local newCode
                local ok, err = pcall(function()
                    newCode = TeleportService:ReserveServer(PLACE_ID)
                end)
                if not ok or not newCode then
                    return false, "Impossible de créer le serveur: " .. tostring(err)
                end

                -- Sauvegarder le code
                storeCode(newCode)

                -- TP l'admin dedans
                task.delay(0.5, function()
                    tpToCode(admin, newCode)
                    -- Sauvegarder le JobId après un court délai (le temps que le serveur soit créé)
                    task.wait(2)
                    local currentJobId = game.JobId
                    if currentJobId and currentJobId ~= "" then
                        storeJobId(currentJobId)
                        print("[PrivateServer] JobId sauvegardé:", currentJobId)
                    end
                end)

                return "✅ Serveur privé partagé créé ! Tu vas être TP..."

            elseif action == "join" then
                -- Rejoindre le serveur existant
                local code = getStoredCode()
                if not code then
                    return false, "Aucun serveur privé partagé. Utilise 'privateserver create' d'abord."
                end

                task.delay(0.5, function()
                    tpToCode(admin, code)
                    -- Mettre à jour le JobId après rejoint
                    task.wait(2)
                    local currentJobId = game.JobId
                    if currentJobId and currentJobId ~= "" then
                        storeJobId(currentJobId)
                        print("[PrivateServer] JobId mis à jour:", currentJobId)
                    end
                end)

                return "✅ TP vers le serveur privé partagé..."

            else
                return false, "Actions: create, join, reset"
            end
        end,
    })

    -- Commande pour inviter un joueur dans le serveur privé partagé
    Conch.register("invitetoserver", {
        permissions = { Config.RequiredRole or "super-user" },
        arguments = function()
            return {
                kind = "argument",
                type = "string",
                name = "Pseudo",
            }
        end,
        callback = function(pseudo)
            if not pseudo or pseudo == "" then return false, "Donne un pseudo" end

            local admin = nil
            pcall(function()
                local ctx = Conch.get_command_context()
                if ctx and ctx.executor and ctx.executor.player then
                    admin = ctx.executor.player
                end
            end)
            if not admin then return false, "Admin introuvable" end

            -- Récupérer le code du serveur partagé
            local code = getStoredCode()
            if not code then
                return false, "Crée d'abord un serveur avec 'privateserver create'"
            end

            -- Chercher le joueur dans CE serveur
            local targetLocal = nil
            for _, p in ipairs(Players:GetPlayers()) do
                if p.Name:lower() == pseudo:lower()
                or p.DisplayName:lower() == pseudo:lower() then
                    targetLocal = p; break
                end
            end

            if targetLocal then
                -- TP direct
                task.delay(0.3, function()
                    local ok = tpToCode(targetLocal, code)
                    if ok then
                        NotificationService.Success(admin,
                            string.format("✅ <b>%s</b> est TP vers le serveur privé", targetLocal.DisplayName))
                    end
                end)
                return "✅ TP de " .. targetLocal.DisplayName .. " vers le serveur privé..."
            else
                -- Joueur dans un autre serveur → MessagingHub
                local targetId
                local ok = pcall(function()
                    targetId = Players:GetUserIdFromNameAsync(pseudo)
                end)
                if not ok or not targetId then
                    return false, "Joueur '" .. pseudo .. "' introuvable"
                end

                local storedJobId = getStoredJobId()
                if _G.MessagingHub then
                    _G.MessagingHub.Publish("PrivateServerInvite", {
                        targetId  = targetId,
                        code      = code,
                        adminName = admin.DisplayName,
                        adminJobId = storedJobId or game.JobId,
                    })
                    NotificationService.Success(admin,
                        string.format("📨 Invitation serveur privé envoyée à <b>%s</b>", pseudo))
                    return "✅ Invitation envoyée à " .. pseudo
                else
                    return false, "MessagingHub indisponible"
                end
            end
        end,
    })
end

return module
