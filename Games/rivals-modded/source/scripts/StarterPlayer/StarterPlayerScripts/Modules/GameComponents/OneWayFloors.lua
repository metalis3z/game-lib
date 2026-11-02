-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local Players = game:GetService("Players");
local SpectateController = require(Players.LocalPlayer.PlayerScripts.Controllers.SpectateController);
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 9
    -- upvalues: u1 (copy)
    local v2 = setmetatable({}, u1);
    v2._one_way_floors = {};
    v2._enabled = false;
    v2:_Init();

    return v2;
end;

function u1.Update(p3, p4) -- Line: 24
    -- upvalues: SpectateController (copy)
    if not p3._enabled then
        return;
    end;

    local v5 = SpectateController.CurrentSubject and (SpectateController.CurrentSubject.Entity and SpectateController.CurrentSubject.Entity.RootPart) and SpectateController.CurrentSubject.Entity.RootPart.Position;

    for i in pairs(p3._one_way_floors) do
        local v6;

        if v5 then
            v6 = v5.Y < i.Position.Y + 2;
        else
            v6 = v5;
        end;

        i.LocalTransparencyModifier = v6 and 1 or 0;
        i.CanCollide = not v6;
    end;
end;

function u1._CheckEnabled(p7) -- Line: 43
    p7._enabled = next(p7._one_way_floors) ~= nil;
end;

function u1._ObjectRemoved(p8, p9) -- Line: 47
    p8._one_way_floors[p9] = nil;
    p8:_CheckEnabled();
end;

function u1._ObjectAdded(p10, p11) -- Line: 52
    p10._one_way_floors[p11] = true;
    p10:_CheckEnabled();
end;

function u1._Init(u12) -- Line: 57
    -- upvalues: CollectionService (copy)
    CollectionService:GetInstanceRemovedSignal("OneWayFloor"):Connect(function(p13) -- Line: 58
        -- upvalues: u12 (copy)
        u12:_ObjectRemoved(p13);
    end);
    CollectionService:GetInstanceAddedSignal("OneWayFloor"):Connect(function(p14) -- Line: 62
        -- upvalues: u12 (copy)
        u12:_ObjectAdded(p14);
    end);

    for _, v in pairs(CollectionService:GetTagged("OneWayFloor")) do
        task.spawn(u12._ObjectAdded, u12, v);
    end;
end;

return u1._new();