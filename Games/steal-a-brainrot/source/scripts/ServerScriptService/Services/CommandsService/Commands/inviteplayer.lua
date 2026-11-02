local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local DataStoreService = game:GetService("DataStoreService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Net = require(ReplicatedStorage.Packages.Net)
local NotificationService = require(ServerScriptService.Services.NotificationService)

-- Utiliser le PlaceId actuel du jeu
local PLACE_ID = game.PlaceId

local InviteRemote   = Net:RemoteEvent("InviteSystem/Invite")
local ResponseRemote = Net:RemoteEvent("InviteSystem/Response")

local MSG_INVITE   = "InvitePlayer_Send"
local MSG_RESPONSE = "InvitePlayer_Response"

-- DataStore pour récupérer l'access code du serveur privé admin
local AdminServerStore = DataStoreService:GetDataStore("AdminSharedServer_v1")
local STORE_KEY = "SharedServerCode"
local JOBID_KEY = "SharedServerJobId"

local pendingInvites = {}

-- Récupérer l'access code VIP depuis AdminServerStore
local function getAdminServerCode()
    local ok, code = pcall(function()
        return AdminServerStore:GetAsync(STORE_KEY)
    end)
    return (ok and typeof(code) == "string" and code ~= "") and code or nil
end

local function getAdminServerJobId()
    local ok, jobId = pcall(function()
        return AdminServerStore:GetAsync(JOBID_KEY)
    end)
    return (ok and typeof(jobId) == "string" and jobId ~= "") and jobId or nil
end

local function registerHandlers()
    if not _G.MessagingHub then return end

    _G.MessagingHub.Register(MSG_INVITE, function(data)
        local targetPlayer = Players:GetPlayerByUserId(data.targetId)
        if not targetPlayer then return end
        InviteRemote:FireClient(targetPlayer, data)
    end)

    _G.MessagingHub.Register(MSG_RESPONSE, function(data)
        if data.adminJobId ~= game.JobId then return end
        local invite = pendingInvites[data.inviteId]
        if not invite then return end
        pendingInvites[data.inviteId] = nil
        local admin = Players:GetPlayerByUserId(invite.adminId)
        if not admin then return end
        if data.accepted then
            NotificationService.Success(admin,
                string.format("✅ <b>%s</b> a accepté ! Il arrive...", data.targetName or ""))
        else
            NotificationService.Error(admin,
                string.format("❌ <b>%s</b> a refusé.", data.targetName or ""))
        end
    end)
end

task.spawn(function()
    while not _G.MessagingHub do task.wait(0.5) end
    registerHandlers()
end)

-- Réponse du joueur LOCAL → TP vers le serveur admin
ResponseRemote.OnServerEvent:Connect(function(player, inviteId, accepted, adminJobId, accessCode)
    if _G.MessagingHub then
        _G.MessagingHub.Publish(MSG_RESPONSE, {
            inviteId   = inviteId,
            accepted   = accepted,
            targetId   = player.UserId,
            targetName = player.DisplayName,
            adminJobId = adminJobId,
        })
    end

    if not accepted then return end
    task.wait(0.3)

    -- Méthode 1: Si on a un access code VIP, utiliser TeleportToPrivateServer
    if accessCode and accessCode ~= "" then
        local ok, err = pcall(function()
            TeleportService:TeleportToPrivateServer(PLACE_ID, accessCode, {player})
        end)
        if ok then
            print("[InviteSystem] TP via TeleportToPrivateServer réussi ✅")
            return
        else
            warn("[InviteSystem] TeleportToPrivateServer échoué:", err)
        end
    end

    -- Méthode 2: Utiliser TeleportAsync avec ServerInstanceId (pour serveurs publics)
    if adminJobId and adminJobId ~= "" then
        local ok2, err2 = pcall(function()
            local opts = Instance.new("TeleportOptions")
            opts.ServerInstanceId = adminJobId
            TeleportService:TeleportAsync(PLACE_ID, {player}, opts)
        end)
        if ok2 then
            print("[InviteSystem] TP via TeleportAsync réussi ✅")
            return
        else
            warn("[InviteSystem] TeleportAsync échoué:", err2)
        end
    end

    -- Méthode 3: Fallback - TP vers le place sans JobId
    local ok3, err3 = pcall(function()
        TeleportService:Teleport(PLACE_ID, player)
    end)
    if not ok3 then
        warn("[InviteSystem] Tous les TP ont échoué:", err3)
    end
end)

-- Nettoyage
task.spawn(function()
    while true do
        task.wait(30)
        local now = os.clock()
        for id, inv in pairs(pendingInvites) do
            if now - inv.time > 60 then pendingInvites[id] = nil end
        end
    end
end)

local module = function(Conch, Config)
    Conch.register("inviteplayer", {
        permissions = { Config.RequiredRole or "super-user" },
        arguments = function()
            return { kind = "argument", type = "string", name = "Pseudo" }
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

            local inviteId = tostring(os.time()) .. "_" .. admin.UserId

            -- Récupérer l'access code et JobId du serveur privé admin
            local adminCode = getAdminServerCode()
            local adminJobId = getAdminServerJobId() or game.JobId

            local inviteData = {
                inviteId   = inviteId,
                adminName  = admin.DisplayName,
                adminId    = admin.UserId,
                adminJobId = adminJobId,
                accessCode = adminCode or "", -- code du serveur privé admin
            }

            -- Joueur dans CE serveur
            local targetLocal = nil
            for _, p in ipairs(Players:GetPlayers()) do
                if p.Name:lower() == pseudo:lower()
                or p.DisplayName:lower() == pseudo:lower() then
                    targetLocal = p; break
                end
            end

            if targetLocal then
                if targetLocal == admin then return false, "Tu ne peux pas t'inviter toi-même" end
                pendingInvites[inviteId] = {adminId=admin.UserId, time=os.clock()}
                InviteRemote:FireClient(targetLocal, inviteData)
                NotificationService.Success(admin,
                    string.format("📨 Invitation envoyée à <b>%s</b>", targetLocal.DisplayName))
                return "✅ Invitation → " .. targetLocal.DisplayName
            else
                -- Joueur dans un autre serveur
                local targetId
                local ok = pcall(function()
                    targetId = Players:GetUserIdFromNameAsync(pseudo)
                end)
                if not ok or not targetId then
                    return false, "Joueur '" .. pseudo .. "' introuvable"
                end
                pendingInvites[inviteId] = {adminId=admin.UserId, time=os.clock()}
                inviteData.targetId = targetId
                if _G.MessagingHub then
                    _G.MessagingHub.Publish(MSG_INVITE, inviteData)
                    NotificationService.Success(admin,
                        string.format("📨 Invitation envoyée à <b>%s</b>", pseudo))
                    return "✅ Invitation globale → " .. pseudo
                else
                    return false, "MessagingHub indisponible"
                end
            end
        end,
    })
end

return module
