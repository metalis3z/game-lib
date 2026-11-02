-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 8
    -- upvalues: u1 (copy)
    local v2 = setmetatable({}, u1);
    v2:_Init();

    return v2;
end;

function u1.Update(p3, p4) -- Line: 20
    -- upvalues: CollectionService (copy)
    for _, v in pairs(CollectionService:GetTagged("UILoadingDots")) do
        local v5 = v;

        for i = 1, 3 do
            local v6 = (tick() * -4 + i / 3 * 3.141592653589793 * 2 * 0.15) % 6.283185307179586;
            local math_sin_ret = math.sin(v6);
            local math_abs_ret = math.abs(math_sin_ret);
            local v7 = math.max(0.5, math_abs_ret) * 0.3333333333333333;
            v5[i].Size = UDim2.new(v7, 0, v7, 0);
            local _ = i;
        end;
    end;
end;

function u1._Init(p8) -- Line: 36
end;

return u1._new();