-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local Signal = require(ReplicatedStorage.Modules.Signal);
local DuelController = require(Players.LocalPlayer.PlayerScripts.Controllers.DuelController);
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 13
    -- upvalues: u1 (copy), Signal (copy)
    local v2 = setmetatable({}, u1);
    v2.PartyChanged = Signal.new();
    v2.InviteRequestCooldownChanged = Signal.new();
    v2.CurrentParty = nil;
    v2._invite_cooldowns = {};
    v2:_Init();

    return v2;
end;

function u1.IsPartyLeader(p3) -- Line: 32
    -- upvalues: Players (copy)
    return not p3.CurrentParty or p3.CurrentParty[1] == Players.LocalPlayer;
end;

function u1.IsInParty(p4, p5) -- Line: 36
    local v6 = p4.CurrentParty and table.find(p4.CurrentParty, p5);

    return v6;
end;

function u1.IsInviteRequestOnCooldown(p7, p8) -- Line: 40
    return tick() < (p7._invite_cooldowns[p8] or 0);
end;

function u1.CanInvitePlayerToParty(p9, p10) -- Line: 44
    -- upvalues: Players (copy), CONSTANTS (copy), DuelController (copy)
    local v11 = p10 and ((p10 ~= Players.LocalPlayer or CONSTANTS.IS_STUDIO) and (p9:IsPartyLeader() and not p9:IsInParty(p10))) and not DuelController:GetDuel(p10);

    return v11;
end;

function u1.SendPartyInvite(p12, p13) -- Line: 52
    -- upvalues: ReplicatedStorage (copy)
    if not p12:CanInvitePlayerToParty(p13) or p12:IsInviteRequestOnCooldown(p13) then
        return;
    end;

    p12._invite_cooldowns[p13] = tick() + 15;
    p12.InviteRequestCooldownChanged:Fire();
    task.delay(15, p12.InviteRequestCooldownChanged.Fire, p12.InviteRequestCooldownChanged);
    ReplicatedStorage.Remotes.Matchmaking.SendPartyInvite:FireServer(p13);
end;

function u1._FetchParty(p14) -- Line: 68
    -- upvalues: ReplicatedStorage (copy)
    ReplicatedStorage.Remotes.Matchmaking.RequestOneTimePartyReplication:FireServer();
end;

function u1._Init(u15) -- Line: 72
    -- upvalues: ReplicatedStorage (copy)
    ReplicatedStorage.Remotes.Matchmaking.UpdateParty.OnClientEvent:Connect(function(p16) -- Line: 73
        -- upvalues: u15 (copy)
        u15.CurrentParty = p16;
        u15.PartyChanged:Fire();
    end);
    task.defer(u15._FetchParty, u15);
end;

return u1._new();