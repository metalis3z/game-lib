-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local Uzi = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels.Uzi);
local ColorSequence_new_ret = ColorSequence.new(Color3.fromRGB(0, 255, 0));
local u1 = setmetatable({}, Uzi);
u1.__index = u1;

function u1.new(...) -- Line: 10
    -- upvalues: Uzi (copy), u1 (copy)
    local v2 = Uzi.new(...);
    local v3 = setmetatable(v2, u1);
    v3._body_money = v3.ItemModel:WaitForChild("Body"):WaitForChild("Money");
    v3._body_money_decal1 = v3._body_money:WaitForChild("Decal1");
    v3._body_money_decal2 = v3._body_money:WaitForChild("Decal2");
    v3._magazine_money = v3.ItemModel:WaitForChild("Magazine"):WaitForChild("Money");
    v3._magazine_money_decal1 = v3._magazine_money:WaitForChild("Decal1");
    v3._magazine_money_decal2 = v3._magazine_money:WaitForChild("Decal2");
    v3:_Init();

    return v3;
end;

function u1.GetFriendlyTracerColor(p4) -- Line: 29
    -- upvalues: ColorSequence_new_ret (copy)
    return ColorSequence_new_ret;
end;

function u1._UpdateAmmoVisual(p5) -- Line: 37
    if p5._destroyed then
        return;
    end;

    local v6 = p5.ClientItem:Get("Ammo");
    local v7 = v6 > 0 and 0 or 1;
    local v8 = (v6 > 1 or p5:IsAnimationPlaying("Reload")) and 0 or 1;
    p5:_LocalTransparencyModifier(p5._body_money, "AmmoVisual", v7);
    p5:_LocalTransparencyModifier(p5._body_money_decal1, "AmmoVisual", v7);
    p5:_LocalTransparencyModifier(p5._body_money_decal2, "AmmoVisual", v7);
    p5:_LocalTransparencyModifier(p5._magazine_money, "AmmoVisual", v8);
    p5:_LocalTransparencyModifier(p5._magazine_money_decal1, "AmmoVisual", v8);
    p5:_LocalTransparencyModifier(p5._magazine_money_decal2, "AmmoVisual", v8);
end;

function u1._Init(u9) -- Line: 55
    u9.ClientItem:GetDataChangedSignal("AmmoReserve"):Connect(function() -- Line: 56
        -- upvalues: u9 (copy)
        u9:_UpdateAmmoVisual();
    end);
    u9.ClientItem:GetDataChangedSignal("Ammo"):Connect(function() -- Line: 60
        -- upvalues: u9 (copy)
        u9:_UpdateAmmoVisual();
    end);
    u9.AnimationPlayed:Connect(function() -- Line: 64
        -- upvalues: u9 (copy)
        u9:_UpdateAmmoVisual();
    end);
    u9.AnimationStopped:Connect(function() -- Line: 68
        -- upvalues: u9 (copy)
        u9:_UpdateAmmoVisual();
    end);
    task.defer(u9._UpdateAmmoVisual, u9);
end;

return u1;