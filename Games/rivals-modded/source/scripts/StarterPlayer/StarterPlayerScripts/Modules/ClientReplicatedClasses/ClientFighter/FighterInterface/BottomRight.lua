-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 4
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.FighterInterface = p2;
    v3.Frame = v3.FighterInterface.Frame:WaitForChild("BottomRight");
    v3.Container = v3.Frame:WaitForChild("Container");
    v3:_Init();

    return v3;
end;

function u1.SetVisible(p4, p5) -- Line: 20
    p4.Frame.Visible = p5;
end;

function u1.Destroy(p6) -- Line: 24
end;

function u1._Init(p7) -- Line: 32
end;

return u1;