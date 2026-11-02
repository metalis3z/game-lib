-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 6
    -- upvalues: u1 (copy)
    local v2 = setmetatable({}, u1);
    v2._items = {};
    v2:_Init();

    return v2;
end;

function u1.AddItem(p3, p4, p5) -- Line: 20
    if p4 then
        p3._items[p4] = tick() + p5;
    end;
end;

function u1._Init(u6) -- Line: 30
    -- upvalues: RunService (copy)
    RunService.Heartbeat:Connect(function() -- Line: 31
        -- upvalues: u6 (copy)
        local v7 = {};

        for i, v in pairs(u6._items) do
            if v < tick() then
                i:Destroy();
                v7[i] = true;
            end;
        end;

        for i in pairs(v7) do
            u6._items[i] = nil;
        end;
    end);
end;

return u1._new();