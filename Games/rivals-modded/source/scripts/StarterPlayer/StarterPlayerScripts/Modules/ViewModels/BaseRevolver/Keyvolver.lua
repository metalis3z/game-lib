-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local BaseRevolver = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels.BaseRevolver);
local ColorSequence_new_ret = ColorSequence.new(Color3.fromRGB(255, 218, 155));
local u1 = setmetatable({}, BaseRevolver);
u1.__index = u1;

function u1.new(...) -- Line: 10
    -- upvalues: BaseRevolver (copy), u1 (copy)
    local v2 = BaseRevolver.new(...);
    local v3 = setmetatable(v2, u1);
    v3._is_empty = nil;
    v3._keyvolver_bullets = {};
    v3:_Init();

    return v3;
end;

function u1.GetFriendlyTracerColor(p4) -- Line: 25
    -- upvalues: ColorSequence_new_ret (copy)
    return ColorSequence_new_ret;
end;

function u1._UpdateAmmoContext(p5) -- Line: 33
    local v6 = p5.ClientItem:Get("Ammo");
    local v7 = p5.ClientItem:Get("AmmoReserve");

    for i, v in pairs(p5._keyvolver_bullets.Bullets) do
        p5:_LocalTransparencyModifier(v, "AmmoVisual", i <= v6 and 0 or 1);
    end;

    for i, v in pairs(p5._keyvolver_bullets.ReloadBullets) do
        p5:_LocalTransparencyModifier(v, "AmmoVisual", v6 < i and i <= v6 + v7 and 0 or 1);
    end;

    local v8 = v6 <= 0;

    if v8 == p5._is_empty then
        return;
    end;

    p5._is_empty = v8;
    local v9 = p5._is_empty and "Empty" or "";
    p5:ChangeEquipAnimation("Equip" .. v9);
    p5:ChangeIdleAnimation("Idle" .. v9);
    p5:ChangeSprintAnimation("Sprint" .. v9);
    p5:ChangeInspectAnimation("Inspect" .. v9);
end;

function u1._Setup(p10) -- Line: 60
    for _, v in pairs({ "Bullets", "ReloadBullets" }) do
        p10._keyvolver_bullets[v] = {};
        local v11 = v;

        for i = 1, 6 do
            p10._keyvolver_bullets[v11][i] = p10.ItemModel:WaitForChild(v11 .. i):WaitForChild("Bullet");
            local _ = i;
        end;
    end;
end;

function u1._Init(u12) -- Line: 70
    u12.ClientItem:GetDataChangedSignal("AmmoReserve"):Connect(function() -- Line: 71
        -- upvalues: u12 (copy)
        u12:_UpdateAmmoContext();
    end);
    u12.ClientItem:GetDataChangedSignal("Ammo"):Connect(function() -- Line: 75
        -- upvalues: u12 (copy)
        u12:_UpdateAmmoContext();
    end);
    u12:_Setup();
    u12:_UpdateAmmoContext();
end;

return u1;