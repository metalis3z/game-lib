-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local Shotgun = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels.Shotgun);
local ColorSequence_new_ret = ColorSequence.new(Color3.fromRGB(255, 218, 155));
local u1 = setmetatable({}, Shotgun);
u1.__index = u1;

function u1.new(...) -- Line: 10
    -- upvalues: Shotgun (copy), u1 (copy)
    local v2 = Shotgun.new(...);
    local v3 = setmetatable(v2, u1);
    v3._ammo_visuals = {};
    v3:_Init();

    return v3;
end;

function u1.GetFriendlyTracerColor(p4) -- Line: 24
    -- upvalues: ColorSequence_new_ret (copy)
    return ColorSequence_new_ret;
end;

function u1._UpdateAmmoVisuals(p5) -- Line: 32
    local v6 = p5.ClientItem:Get("Ammo");

    for i, v in pairs(p5._ammo_visuals) do
        local v7;

        if i <= v6 then
            v7 = true;
        elseif i == 1 then
            v7 = p5:IsAnimationPlaying("EmptyReloadStart");
        else
            v7 = false;
        end;

        for _, v2 in pairs(v) do
            p5:_LocalTransparencyModifier(v2, "AmmoVisual", v7 and 0 or 1);
        end;
    end;

    task.defer(p5.ChangeInspectAnimation, p5, v6 <= 3 and "EmptyInspect" or "Inspect");
end;

function u1._Setup(p8) -- Line: 46
    for i = 1, 7 do
        p8._ammo_visuals[i] = { p8.ItemModel:WaitForChild("Shell" .. i):WaitForChild("Black"), p8.ItemModel:WaitForChild("Shell" .. i):WaitForChild("Metal") };
        local _ = i;
    end;
end;

function u1._Init(u9) -- Line: 52
    u9.ClientItem:GetDataChangedSignal("Ammo"):Connect(function() -- Line: 53
        -- upvalues: u9 (copy)
        u9:_UpdateAmmoVisuals();
    end);
    u9.AnimationPlayed:Connect(function() -- Line: 57
        -- upvalues: u9 (copy)
        u9:_UpdateAmmoVisuals();
    end);
    u9.AnimationStopped:Connect(function() -- Line: 61
        -- upvalues: u9 (copy)
        u9:_UpdateAmmoVisuals();
    end);
    u9:_Setup();
    task.defer(u9._UpdateAmmoVisuals, u9);
end;

return u1;