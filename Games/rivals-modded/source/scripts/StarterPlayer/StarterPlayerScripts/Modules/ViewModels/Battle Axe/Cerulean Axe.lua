-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local Utility = require(ReplicatedStorage.Modules.Utility);
local u1 = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels["Battle Axe"]);
local u2 = setmetatable({}, u1);
u2.__index = u2;

function u2.new(...) -- Line: 13
    -- upvalues: u1 (copy), u2 (copy)
    local v3 = u1.new(...);
    local v4 = setmetatable(v3, u2);
    v4._equip_effect_hash = 0;
    v4._vfx_attachment = v4.ItemModel:WaitForChild("Body"):WaitForChild("Gem"):WaitForChild("VFX");
    v4._blade1 = v4.ItemModel:WaitForChild("Body"):WaitForChild("Blade1");
    v4._blade2 = v4.ItemModel:WaitForChild("Body"):WaitForChild("Blade2");
    v4:_Init();

    return v4;
end;

function u2.Unequip(p5, ...) -- Line: 30
    -- upvalues: u1 (copy)
    p5._equip_effect_hash = p5._equip_effect_hash + 1;
    u1.Unequip(p5, ...);
end;

function u2.Destroy(p6) -- Line: 35
    -- upvalues: u1 (copy)
    p6._equip_effect_hash = p6._equip_effect_hash + 1;
    u1.Destroy(p6);
end;

function u2._EquipEffect(p7, p8) -- Line: 44
    -- upvalues: Utility (copy)
    p7._equip_effect_hash = p7._equip_effect_hash + 1;
    local _equip_effect_hash = p7._equip_effect_hash;
    p7:_LocalTransparencyModifier(p7._blade1, "EquipEffect", 1);
    p7:_LocalTransparencyModifier(p7._blade2, "EquipEffect", 1);

    if not p8 then
        wait(0.55);
    end;

    if p7._equip_effect_hash ~= _equip_effect_hash then
        return;
    end;

    Utility:PlayParticles(p7._vfx_attachment);
    p7:CreateSound("rbxassetid://117746175185603", 0.5, 0.5 + 0.125 * math.random(), true, 0.3);

    if not p8 then
        wait(0.3);
    end;

    if p7._equip_effect_hash ~= _equip_effect_hash then
        return;
    end;

    p7:CreateSound("rbxassetid://75313977551180", 0.875, 1 + 0.2 * math.random(), true, 5);
    p7:CreateSound("rbxassetid://107162559513589", 0.875, 1 + 0.2 * math.random(), true, 5);
    p7:CreateSound("rbxassetid://115716079009988", 0.875, 1 + 0.2 * math.random(), true, 5);
    p7:_LocalTransparencyModifier(p7._blade1, "EquipEffect", 0);
    p7:_LocalTransparencyModifier(p7._blade2, "EquipEffect", 0);
end;

function u2._Init(u9) -- Line: 77
    u9.Equipped:Connect(function(p10) -- Line: 78
        -- upvalues: u9 (copy)
        u9:_EquipEffect(p10);
    end);
end;

return u2;