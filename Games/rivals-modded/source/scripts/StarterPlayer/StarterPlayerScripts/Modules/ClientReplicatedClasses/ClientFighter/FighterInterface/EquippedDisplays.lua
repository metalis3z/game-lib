-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local EquippedDisplay = require(script:WaitForChild("EquippedDisplay"));
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 6
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.FighterInterface = p2;
    v3._equipped_displays = {};
    v3:_Init();

    return v3;
end;

function u1.UpdateVisibility(p4, ...) -- Line: 22
    for _, v in pairs(p4._equipped_displays) do
        v:UpdateVisibility(...);
    end;
end;

function u1.UpdateAmmo(p5, ...) -- Line: 28
    for _, v in pairs(p5._equipped_displays) do
        v:UpdateAmmo(...);
    end;
end;

function u1.UpdateVisuals(p6, ...) -- Line: 34
    for _, v in pairs(p6._equipped_displays) do
        v:UpdateVisuals(...);
    end;
end;

function u1.UpdateParents(p7, ...) -- Line: 40
    for _, v in pairs(p7._equipped_displays) do
        v:UpdateParent(...);
    end;
end;

function u1.ItemRemoved(p8, p9, p10) -- Line: 46
    local v11 = p8._equipped_displays[p9];

    if not v11 then
        return;
    end;

    v11:Destroy();
    p8._equipped_displays[p9] = nil;
end;

function u1.ItemAdded(p12, p13, p14) -- Line: 57
    -- upvalues: EquippedDisplay (copy)
    p12:ItemRemoved(p13, p14);
    local v15 = EquippedDisplay.new(p12, p13);
    p12._equipped_displays[p13] = v15;
end;

function u1.Update(p16, p17, p18) -- Line: 64
    for _, v in pairs(p16._equipped_displays) do
        v:Update(p17, p18);
    end;
end;

function u1.Destroy(p19) -- Line: 70
    for _, v in pairs(p19._equipped_displays) do
        v:Destroy();
    end;

    p19._equipped_displays = {};
end;

function u1._Init(p20) -- Line: 82
    for _, v in pairs(p20.FighterInterface.ClientFighter.Items) do
        p20:ItemAdded(v, true);
    end;

    p20:UpdateParents();
end;

return u1;