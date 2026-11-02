-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Signal = require(ReplicatedStorage.Modules.Signal);
local u1 = {};
u1.__index = u1;

function u1.new() -- Line: 8
    -- upvalues: u1 (copy), Signal (copy)
    local v2 = setmetatable({}, u1);
    v2.EnabledChanged = Signal.new();
    v2.IsEnabled = false;
    v2._original_pivots = {};
    v2:_Init();

    return v2;
end;

function u1.SetEnabled(p3, p4) -- Line: 26
    if p4 == p3.IsEnabled then
        return;
    end;

    p3.IsEnabled = p4;
    p3.EnabledChanged:Fire(p3.IsEnabled);
end;

function u1.Update(p5, p6) -- Line: 35
end;

function u1._GetOriginalPivot(p7, p8) -- Line: 43
    p7._original_pivots[p8] = p7._original_pivots[p8] or p8:GetPivot();

    return p7._original_pivots[p8];
end;

function u1._Init(p9) -- Line: 48
end;

return u1;