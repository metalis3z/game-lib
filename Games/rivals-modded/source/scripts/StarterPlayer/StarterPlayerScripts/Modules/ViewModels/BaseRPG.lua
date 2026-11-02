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
    v3._visibility_delayed = nil;
    v3._registered_ammo_visuals = {};
    v3:_Init();

    return v3;
end;

function u1._UpdateRocket(p4) -- Line: 29
    if p4._destroyed then
        return;
    end;

    local v5 = p4.ClientItem:Get("Ammo") > 0 and true or p4:IsAnimationPlaying("Reload");

    if v5 and not p4._visibility_delayed then
        p4._visibility_delayed = true;
        wait(0.1);
        p4:_UpdateRocket();

        return;
    end;

    local v6 = v5 and 0 or 1;

    for _, v in pairs(p4._registered_ammo_visuals) do
        p4:_LocalTransparencyModifier(v, "AmmoVisual", v6);
    end;

    p4._visibility_delayed = nil;
end;

function u1._RegisterAmmoVisual(p7, p8) -- Line: 55
    table.insert(p7._registered_ammo_visuals, p8);
end;

function u1._Init(u9) -- Line: 59
    u9.ClientItem:GetDataChangedSignal("Ammo"):Connect(function() -- Line: 60
        -- upvalues: u9 (copy)
        u9:_UpdateRocket();
    end);
    u9.AnimationPlayed:Connect(function(p10) -- Line: 64
        -- upvalues: u9 (copy)
        if p10 == "Reload" then
            u9:_UpdateRocket();
        end;
    end);
    u9.AnimationStopped:Connect(function(p11) -- Line: 70
        -- upvalues: u9 (copy)
        if p11 == "Reload" then
            u9:_UpdateRocket();
        end;
    end);
    task.spawn(u9._UpdateRocket, u9);
end;

return u1;