-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local Katana = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels.Katana);
local u1 = setmetatable({}, Katana);
u1.__index = u1;

function u1.new(...) -- Line: 10
    -- upvalues: Katana (copy), u1 (copy)
    local v2 = Katana.new(...);
    local v3 = setmetatable(v2, u1);
    v3._equip_effect_hash = 0;
    v3._blade = v3.ItemModel:WaitForChild("Body"):WaitForChild("Blade");
    v3:_Init();

    return v3;
end;

function u1.PlayDeflectHitSounds(p4) -- Line: 25
    p4:CreateSound("rbxassetid://17640978084", 1.75, 0.9 + 0.2 * math.random(), true, 5);
end;

function u1.Unequip(p5, ...) -- Line: 29
    -- upvalues: Katana (copy)
    p5._equip_effect_hash = p5._equip_effect_hash + 1;
    Katana.Unequip(p5, ...);
end;

function u1.Destroy(p6) -- Line: 34
    -- upvalues: Katana (copy)
    p6._equip_effect_hash = p6._equip_effect_hash + 1;
    Katana.Destroy(p6);
end;

function u1._EquipEffect(p7, p8) -- Line: 43
    p7._equip_effect_hash = p7._equip_effect_hash + 1;
    local _equip_effect_hash = p7._equip_effect_hash;
    p7:_LocalTransparencyModifier(p7._blade, "EquipEffect", 1);

    if not p8 then
        wait(0.4);
    end;

    if p7._equip_effect_hash ~= _equip_effect_hash then
        return;
    end;

    p7:CreateSound("rbxassetid://17641562119", 1.5, 1, true, 5);
    p7:_LocalTransparencyModifier(p7._blade, "EquipEffect", 0);
end;

function u1._Init(u9) -- Line: 61
    u9.Equipped:Connect(function(p10) -- Line: 62
        -- upvalues: u9 (copy)
        u9:_EquipEffect(p10);
    end);
end;

return u1;