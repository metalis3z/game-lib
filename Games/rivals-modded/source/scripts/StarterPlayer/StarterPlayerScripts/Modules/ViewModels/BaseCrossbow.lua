-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ClientViewModel = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ClientReplicatedClasses"):WaitForChild("ClientFighter"):WaitForChild("ClientItem"):WaitForChild("ClientViewModel"));
local u1 = setmetatable({}, ClientViewModel);
u1.__index = u1;

function u1.new(...) -- Line: 8
    -- upvalues: ClientViewModel (copy), u1 (copy)
    local v2 = ClientViewModel.new(...);
    local v3 = setmetatable(v2, u1);
    v3._registered_ammo_visuals = {};
    v3._visibility_delayed = nil;
    v3:_Init();

    return v3;
end;

function u1._UpdateAmmoVisual(p4) -- Line: 29
    if p4._destroyed then
        return;
    end;

    local v5 = p4.ClientItem:Get("Ammo") > 0 and true or p4:IsAnimationPlaying("Reload");

    if not v5 or p4._visibility_delayed then
        p4._visibility_delayed = nil;

        for i in pairs(p4._registered_ammo_visuals) do
            p4:_LocalTransparencyModifier(i, "AmmoVisual", v5 and 0 or 1);
        end;

        return;
    end;

    p4._visibility_delayed = true;
    wait(0.1);
    p4:_UpdateAmmoVisual();
end;

function u1._RegisterAmmoVisual(p6, p7) -- Line: 53
    p6._registered_ammo_visuals[p7] = true;
end;

function u1._Init(u8) -- Line: 57
    u8.ClientItem:GetDataChangedSignal("Ammo"):Connect(function() -- Line: 58
        -- upvalues: u8 (copy)
        u8:_UpdateAmmoVisual();
    end);
    u8.AnimationPlayed:Connect(function() -- Line: 62
        -- upvalues: u8 (copy)
        u8:_UpdateAmmoVisual();
    end);
    u8.AnimationStopped:Connect(function() -- Line: 66
        -- upvalues: u8 (copy)
        u8:_UpdateAmmoVisual();
    end);
    task.spawn(u8._UpdateAmmoVisual, u8);
end;

return u1;