-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 7
    -- upvalues: u1 (copy)
    local v2 = setmetatable({}, u1);
    v2._connections = {};
    v2:_Init();

    return v2;
end;

function u1._ObjectRemoved(p3, p4) -- Line: 27
    if p3._connections[p4] then
        p3._connections[p4]:Disconnect();
        p3._connections[p4] = nil;
    end;
end;

function u1._ObjectAdded(p5, u6) -- Line: 34
    -- upvalues: ReplicatedStorage (copy)
    p5:_ObjectRemoved(u6);
    p5._connections[u6] = u6.Triggered:Connect(function() -- Line: 37
        -- upvalues: ReplicatedStorage (ref), u6 (copy)
        ReplicatedStorage.Remotes.Replication.Fighter.SnowballGrab:FireServer(u6);
    end);
end;

function u1._Init(u7) -- Line: 42
    -- upvalues: CollectionService (copy)
    CollectionService:GetInstanceAddedSignal("LobbySnowballSource"):Connect(function(p8) -- Line: 43
        -- upvalues: u7 (copy)
        u7:_ObjectAdded(p8);
    end);
    CollectionService:GetInstanceRemovedSignal("LobbySnowballSource"):Connect(function(p9) -- Line: 47
        -- upvalues: u7 (copy)
        u7:_ObjectRemoved(p9);
    end);

    for _, v in pairs(CollectionService:GetTagged("LobbySnowballSource")) do
        task.spawn(u7._ObjectAdded, u7, v);
    end;
end;

return u1._new();