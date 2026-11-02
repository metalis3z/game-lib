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
    v3._charm_attachment_parent = v3._charm_pivot_attachment and v3._charm_pivot_attachment.Parent;
    v3:_Init();

    return v3;
end;

function u1._UpdateAmmoVisual(p4) -- Line: 29
    if p4._destroyed then
        return;
    end;

    for i, v in pairs(p4._registered_ammo_visuals) do
        local v5 = v <= p4.ClientItem:Get("Ammo") and true or p4:IsAnimationPlaying("Reload");
        p4:_LocalTransparencyModifier(i, "AmmoVisual", v5 and 0 or 1);

        if v == 1 and p4._charm_pivot_attachment then
            local v6;

            if v5 then
                v6 = p4._charm_attachment_parent or nil;
            else
                v6 = nil;
            end;

            p4._charm_pivot_attachment.Parent = v6;
        end;
    end;
end;

function u1._RegisterAmmoVisual(p7, p8, p9) -- Line: 45
    p7._registered_ammo_visuals[p8] = p9;
end;

function u1._Init(u10) -- Line: 49
    u10.ClientItem:GetDataChangedSignal("Ammo"):Connect(function() -- Line: 50
        -- upvalues: u10 (copy)
        u10:_UpdateAmmoVisual();
    end);
    u10.AnimationPlayed:Connect(function() -- Line: 54
        -- upvalues: u10 (copy)
        u10:_UpdateAmmoVisual();
    end);
    u10.AnimationStopped:Connect(function() -- Line: 58
        -- upvalues: u10 (copy)
        u10:_UpdateAmmoVisual();
    end);
    task.spawn(u10._UpdateAmmoVisual, u10);
end;

return u1;