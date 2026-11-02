-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local ServerOsTime = require(ReplicatedStorage.Modules.ServerOsTime);
local LobbyElement = require(Players.LocalPlayer.PlayerScripts.Modules.LobbyElement);
local u1 = setmetatable({}, LobbyElement);
u1.__index = u1;

function u1._new(...) -- Line: 11
    -- upvalues: LobbyElement (copy), u1 (copy)
    local v2 = LobbyElement.new(...);
    local v3 = setmetatable(v2, u1);
    v3._stored_objects = {};
    v3:_Init();

    return v3;
end;

function u1._CheckParent(u4, u5) -- Line: 31
    -- upvalues: ServerOsTime (copy)
    task.defer(function() -- Line: 32
        -- upvalues: ServerOsTime (ref), u4 (copy), u5 (copy)
        local v6 = ServerOsTime:Get();
        local v7 = u4._stored_objects[u5];
        local v8;

        if v7.StartTime <= v6 then
            v8 = v6 < v7.EndTime;
        else
            v8 = false;
        end;

        if v7.Inverse then
            v8 = not v8;
        end;

        local v9;

        if v8 then
            v9 = v7.OriginalParent;
        else
            v9 = nil;
        end;

        u5.Parent = v9;
    end);
end;

function u1._DelayedCheck(p10, p11, p12) -- Line: 43
    if p12 > 0 and p12 < (1 / 0) then
        task.delay(p12, p10._CheckParent, p10, p11);
    end;
end;

function u1._ObjectAdded(p13, p14) -- Line: 49
    -- upvalues: ServerOsTime (copy)
    if p13._stored_objects[p14] then
        return;
    end;

    local v15 = {
        OriginalParent = p14.Parent,
        StartTime = p14:GetAttribute("StartTime") or 0,
        EndTime = p14:GetAttribute("EndTime") or (1 / 0),
        Inverse = p14:GetAttribute("Inverse") or false
    };
    p13._stored_objects[p14] = v15;
    p13:_DelayedCheck(p14, v15.StartTime - ServerOsTime:Get());
    p13:_DelayedCheck(p14, v15.EndTime - ServerOsTime:Get());
    p13:_CheckParent(p14);
end;

function u1._Init(u16) -- Line: 68
    -- upvalues: CollectionService (copy)
    CollectionService:GetInstanceAddedSignal("LobbyOnlyAppearWhen"):Connect(function(p17) -- Line: 69
        -- upvalues: u16 (copy)
        u16:_ObjectAdded(p17);
    end);

    for _, v in pairs(CollectionService:GetTagged("LobbyOnlyAppearWhen")) do
        task.spawn(u16._ObjectAdded, u16, v);
    end;
end;

return u1._new();