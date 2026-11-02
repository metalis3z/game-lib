-- Gère les invitations de serveur privé cross-server
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Net = require(ReplicatedStorage.Packages.Net)
local InviteRemote = Net:RemoteEvent("InviteSystem/Invite")

task.spawn(function()
    while not _G.MessagingHub do task.wait(0.5) end

    _G.MessagingHub.Register("PrivateServerInvite", function(data)
        if not data or not data.targetId or not data.code then return end

        local targetPlayer = Players:GetPlayerByUserId(data.targetId)
        if not targetPlayer then return end

        -- Envoyer une invitation GUI au joueur avec le code du serveur privé
        InviteRemote:FireClient(targetPlayer, {
            inviteId    = "ps_" .. tostring(os.time()),
            adminName   = data.adminName or "Admin",
            adminId     = 0,
            adminJobId  = data.adminJobId or "",
            accessCode  = data.code,
            isPrivateServerInvite = true, -- flag spécial pour le client
        })
    end)

    print("[PrivateServerInviteHandler] ✅ Handler actif")
end)
