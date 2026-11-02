-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local Players = game:GetService("Players");
local Utility = require(ReplicatedStorage.Modules.Utility);
local FighterController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("FighterController"));
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 13
    -- upvalues: u1 (copy)
    local v2 = setmetatable({}, u1);
    v2._objects = {};
    v2:_Init();

    return v2;
end;

function u1._ObjectAdded(p3, u4) -- Line: 33
    -- upvalues: FighterController (copy), Utility (copy)
    local Attribute = u4:GetAttribute("SoundID");
    local Attribute2 = u4:GetAttribute("Volume");
    local u5 = {
        Connections = {},
        Cooldowns = {}
    };
    table.insert(u5.Connections, u4.Touched:Connect(function(p6) -- Line: 42
        -- upvalues: FighterController (ref), u5 (copy), Utility (ref), Attribute (copy), Attribute2 (copy), u4 (copy)
        local v7 = p6.AssemblyRootPart or p6;
        local v8;

        if v7 then
            v8 = FighterController:GetFighter(v7.Parent);
        else
            v8 = v7;
        end;

        if not (v8 and (v8:IsAlive() and tick() >= (u5.Cooldowns[v7] or 0))) then
            return;
        end;

        u5.Cooldowns[v7] = tick() + 1;
        Utility:CreateSound(Attribute, Attribute2 or 1, 0.95 + 0.1 * math.random(), u4, true, 10);
    end));
    p3._objects[u4] = u5;
end;

function u1._ObjectRemoved(p9, p10) -- Line: 58
    local v11 = p9._objects[p10];

    if not v11 then
        return;
    end;

    for _, v in pairs(v11.Connections) do
        v:Disconnect();
    end;

    p9._objects[p10] = nil;
end;

function u1._Init(u12) -- Line: 72
    -- upvalues: CollectionService (copy)
    CollectionService:GetInstanceAddedSignal("SoundTrigger"):Connect(function(p13) -- Line: 73
        -- upvalues: u12 (copy)
        u12:_ObjectAdded(p13);
    end);
    CollectionService:GetInstanceRemovedSignal("SoundTrigger"):Connect(function(p14) -- Line: 77
        -- upvalues: u12 (copy)
        u12:_ObjectRemoved(p14);
    end);

    for _, v in pairs(CollectionService:GetTagged("SoundTrigger")) do
        task.defer(u12._ObjectAdded, u12, v);
    end;
end;

return u1._new();