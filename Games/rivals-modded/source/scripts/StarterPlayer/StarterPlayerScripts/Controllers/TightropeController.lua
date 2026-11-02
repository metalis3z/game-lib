-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local Players = game:GetService("Players");
local FighterController = require(Players.LocalPlayer.PlayerScripts.Controllers.FighterController);
local Tightrope = require(Players.LocalPlayer.PlayerScripts.Modules.Tightrope);
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 10
    -- upvalues: u1 (copy)
    local v2 = setmetatable({}, u1);
    v2.Tightropes = {};
    v2:_Init();

    return v2;
end;

function u1.GetActiveTightrope(p3) -- Line: 24
    for _, v in pairs(p3.Tightropes) do
        if v.Active then
            return v;
        end;
    end;
end;

function u1.GetTightrope(p4, p5) -- Line: 32
    for i, v in pairs(p4.Tightropes) do
        if v.Part == p5 then
            return v, i;
        end;
    end;
end;

function u1.JumpOff(p6) -- Line: 40
    for _, v in pairs(p6.Tightropes) do
        v:JumpOff();
    end;
end;

function u1._ObjectAdded(p7, p8) -- Line: 50
    -- upvalues: Tightrope (copy)
    local v9 = Tightrope.new(p7, p8);
    table.insert(p7.Tightropes, v9);
end;

function u1._ObjectRemoved(p10, p11) -- Line: 55
    local Tightrope2, v12 = p10:GetTightrope(p11);

    if not Tightrope2 then
        return;
    end;

    Tightrope2:Destroy();
    table.remove(p10.Tightropes, v12);
end;

function u1._HookLocalFighter(u13) -- Line: 66
    -- upvalues: FighterController (copy)
    local v14 = FighterController:WaitForLocalFighter();

    local function entity_added(u15) -- Line: 69
        -- upvalues: u13 (copy)
        u15.AirborneChanged:Connect(function() -- Line: 70
            -- upvalues: u15 (copy), u13 (ref)
            if u15:IsAirborne() then
                u13:JumpOff();
            end;
        end);
        u15:GetDataChangedSignal("IsFrozen"):Connect(function() -- Line: 76
            -- upvalues: u15 (copy), u13 (ref)
            if u15:Get("IsFrozen") then
                u13:JumpOff();
            end;
        end);
    end;

    v14.EntityAdded:Connect(entity_added);

    if v14.Entity then
        entity_added(v14.Entity);
    end;
end;

function u1._Init(u16) -- Line: 90
    -- upvalues: CollectionService (copy)
    CollectionService:GetInstanceAddedSignal("Tightrope"):Connect(function(p17) -- Line: 91
        -- upvalues: u16 (copy)
        u16:_ObjectAdded(p17);
    end);
    CollectionService:GetInstanceRemovedSignal("Tightrope"):Connect(function(p18) -- Line: 95
        -- upvalues: u16 (copy)
        u16:_ObjectRemoved(p18);
    end);

    for _, v in pairs(CollectionService:GetTagged("Tightrope")) do
        task.defer(u16._ObjectAdded, u16, v);
    end;

    task.defer(u16._HookLocalFighter, u16);
end;

return u1._new();