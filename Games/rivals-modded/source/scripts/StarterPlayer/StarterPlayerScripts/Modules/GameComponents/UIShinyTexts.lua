-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local Utility = require(ReplicatedStorage.Modules.Utility);
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 11
    -- upvalues: u1 (copy)
    local v2 = setmetatable({}, u1);
    v2._objects = {};
    v2:_Init();

    return v2;
end;

function u1.Update(p3, p4) -- Line: 25
    -- upvalues: Utility (copy)
    for i, v in pairs(p3._objects) do
        if Utility:IsUIElementVisible(i) then
            local v5;

            if v.IsDoubleFlash then
                v5 = tick() * 0.25 * 8 % 6;

                if v5 >= 1 then
                    v5 = v5 >= 2 and 0 or v5 - 1;
                end;
            else
                v5 = tick() * 0.25 % 1;
            end;

            local v6 = (math.sin(6.283185307179586 * (v5 - 0.5)) + 6.283185307179586 * (v5 - 0.5)) / 6.283185307179586 + 0.5;
            v.Gradient.Offset = Vector2.new((v6 - 0.5) * 2, 0);
        end;
    end;
end;

function u1._ObjectRemoved(p7, p8) -- Line: 57
    if not p7._objects[p8] then
        return;
    end;

    p7._objects[p8] = nil;
end;

function u1._ObjectAdded(p9, p10) -- Line: 65
    p9:_ObjectRemoved(p10);
    p9._objects[p10] = {
        Gradient = p10:WaitForChild("UIGradient"),
        IsDoubleFlash = p10:GetAttribute("IsDoubleFlash")
    };
end;

function u1._Init(u11) -- Line: 74
    -- upvalues: CollectionService (copy)
    CollectionService:GetInstanceRemovedSignal("UIShinyText"):Connect(function(p12) -- Line: 75
        -- upvalues: u11 (copy)
        u11:_ObjectRemoved(p12);
    end);
    CollectionService:GetInstanceAddedSignal("UIShinyText"):Connect(function(p13) -- Line: 79
        -- upvalues: u11 (copy)
        u11:_ObjectAdded(p13);
    end);

    for _, v in pairs(CollectionService:GetTagged("UIShinyText")) do
        task.spawn(u11._ObjectAdded, u11, v);
    end;
end;

return u1._new();