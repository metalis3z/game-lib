-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local ReplicatedClass = require(ReplicatedStorage.Modules.ReplicatedClass);
local Signal = require(ReplicatedStorage.Modules.Signal);
local u1 = { "FreecamEnabled", "ArcadeCanPlayAllMaps" };
local u2 = setmetatable({}, ReplicatedClass);
u2.__index = u2;

function u2._new() -- Line: 14
    -- upvalues: ReplicatedClass (copy), u2 (copy), Signal (copy)
    local v3 = ReplicatedClass.new();
    local v4 = setmetatable(v3, u2);
    v4.BannedPlayersChanged = Signal.new();
    v4.BannedPlayers = {};
    v4:_Init();

    return v4;
end;

function u2.ServerKick(p5, p6) -- Line: 30
    -- upvalues: ReplicatedStorage (copy)
    ReplicatedStorage.Remotes.PrivateServer.KickPlayer:FireServer(p6);
end;

function u2.ServerBan(p7, p8) -- Line: 34
    -- upvalues: ReplicatedStorage (copy)
    ReplicatedStorage.Remotes.PrivateServer.BanPlayer:FireServer(p8);
end;

function u2._ObjectAdded(p9, p10) -- Line: 42
    -- upvalues: CONSTANTS (copy)
    if CONSTANTS.IS_PRIVATE_HUB_SERVER then
        return;
    end;

    task.defer(p10.Destroy, p10);
end;

function u2._SetBannedPlayers(p11, p12) -- Line: 50
    p11.BannedPlayers = p12;
    p11.BannedPlayersChanged:Fire();
end;

function u2._FetchBannedPlayers(p13) -- Line: 55
    -- upvalues: CONSTANTS (copy), Players (copy), ReplicatedStorage (copy)
    if not CONSTANTS.IS_PRIVATE_SERVER_OWNER(Players.LocalPlayer.UserId) then
        return;
    end;

    local success, result = pcall(ReplicatedStorage.Remotes.PrivateServer.FetchBannedPlayers.InvokeServer, ReplicatedStorage.Remotes.PrivateServer.FetchBannedPlayers);

    if not success then
        return;
    end;

    p13:_SetBannedPlayers(result);
end;

function u2._Setup(u14) -- Line: 69
    -- upvalues: u1 (copy)
    for _, v in pairs(u1) do
        workspace:GetAttributeChangedSignal(v):Connect(function() -- Line: 71, Name: update
            -- upvalues: u14 (copy), v (copy)
            u14:SetReplicate(v, workspace:GetAttribute(v));
        end);
        u14:SetReplicate(v, workspace:GetAttribute(v));
    end;
end;

function u2._Init(u15) -- Line: 80
    -- upvalues: ReplicatedStorage (copy), CollectionService (copy)
    ReplicatedStorage.Remotes.PrivateServer.ReplicateBannedPlayers.OnClientEvent:Connect(function(p16) -- Line: 81
        -- upvalues: u15 (copy)
        u15:_SetBannedPlayers(p16);
    end);
    CollectionService:GetInstanceAddedSignal("LobbyPrivateServerOnly"):Connect(function(p17) -- Line: 85
        -- upvalues: u15 (copy)
        u15:_ObjectAdded(p17);
    end);

    for _, v in pairs(CollectionService:GetTagged("LobbyPrivateServerOnly")) do
        task.defer(u15._ObjectAdded, u15, v);
    end;

    u15:_Setup();
    task.defer(u15._FetchBannedPlayers, u15);
end;

return u2._new();