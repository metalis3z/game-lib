-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;

function u1.new(p2, p3) -- Line: 4
    -- upvalues: u1 (copy)
    local v4 = setmetatable({}, u1);
    v4.DisplayName = p2;
    v4.Image = p3;
    v4:_Init();

    return v4;
end;

function u1._Init(p5) -- Line: 25
end;

return u1;