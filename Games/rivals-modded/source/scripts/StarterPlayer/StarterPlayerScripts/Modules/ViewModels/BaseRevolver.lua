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
    v3._registered_ammo_visuals = {
        Bullets = {},
        ReloadBullets = {}
    };
    v3:_Init();

    return v3;
end;

function u1._UpdateAmmoVisual(p4) -- Line: 28
    if p4._destroyed then
        return;
    end;

    local v5 = p4:IsAnimationPlaying("Reload") or p4:IsAnimationPlaying("EmptyReload");
    local v6 = p4.ClientItem:Get("AmmoReserve");
    local v7 = p4.ClientItem:Get("Ammo");
    local v8 = v6 + v7;

    for i, v in pairs(p4._registered_ammo_visuals.Bullets) do
        local v9;

        if v5 then
            v9 = i <= v8 and 0 or 1;
        else
            v9 = i <= v7 and 0 or 1;
        end;

        p4:_LocalTransparencyModifier(v, "AmmoVisual", v9);
    end;

    for i, v in pairs(p4._registered_ammo_visuals.ReloadBullets) do
        p4:_LocalTransparencyModifier(v, "AmmoVisual", i <= v7 and 0 or 1);
    end;
end;

function u1._RegisterAmmoVisual(p10, p11, p12) -- Line: 47
    table.insert(p10._registered_ammo_visuals[p11], p12);
end;

function u1._RegisterDefaultAmmoVisuals(p13) -- Line: 51
    for _, v in pairs({ "ReloadBullets", "Bullets" }) do
        local v14 = p13.ItemModel:WaitForChild(v);
        local v15 = v;

        for i = 1, 6 do
            p13:_RegisterAmmoVisual(v15, v14:WaitForChild(i));
            local _ = i;
        end;
    end;
end;

function u1._Init(u16) -- Line: 61
    u16.ClientItem:GetDataChangedSignal("AmmoReserve"):Connect(function() -- Line: 62
        -- upvalues: u16 (copy)
        u16:_UpdateAmmoVisual();
    end);
    u16.ClientItem:GetDataChangedSignal("Ammo"):Connect(function() -- Line: 66
        -- upvalues: u16 (copy)
        u16:_UpdateAmmoVisual();
    end);
    u16.AnimationPlayed:Connect(function(p17) -- Line: 70
        -- upvalues: u16 (copy)
        if p17 == "Reload" or p17 == "EmptyReload" then
            u16:_UpdateAmmoVisual();
        end;
    end);
    u16.AnimationStopped:Connect(function(p18) -- Line: 76
        -- upvalues: u16 (copy)
        if p18 == "Reload" or p18 == "EmptyReload" then
            u16:_UpdateAmmoVisual();
        end;
    end);
    task.defer(u16._UpdateAmmoVisual, u16);
end;

return u1;