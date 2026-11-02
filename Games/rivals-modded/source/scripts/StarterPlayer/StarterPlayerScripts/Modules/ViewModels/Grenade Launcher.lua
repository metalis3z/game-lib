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
    v3.ReloadBulletsModel = v3.ItemModel:WaitForChild("ReloadBullets");
    v3.BulletsModel = v3.ItemModel:WaitForChild("Bullets");
    v3._bullet_parts = {};
    v3:_Init();

    return v3;
end;

function u1._UpdateAmmoVisual(p4) -- Line: 31
    if p4._destroyed then
        return;
    end;

    local v5 = p4.ClientItem:Get("AmmoReserve");
    local v6 = p4.ClientItem:Get("Ammo");

    for i, v in pairs(p4._bullet_parts.BulletsModel) do
        local v7 = i;

        for _, child in pairs(v:GetChildren()) do
            p4:_LocalTransparencyModifier(child, "AmmoVisual", v7 <= v6 and 0 or 1);
        end;
    end;

    for i, v in pairs(p4._bullet_parts.ReloadBulletsModel) do
        local v8 = i;

        for _, child in pairs(v:GetChildren()) do
            p4:_LocalTransparencyModifier(child, "AmmoVisual", v8 <= v5 and 0 or 1);
        end;
    end;
end;

function u1._Setup(p9) -- Line: 52
    for _, v in pairs({ "ReloadBulletsModel", "BulletsModel" }) do
        p9._bullet_parts[v] = {};
        local v10 = v;

        for i = 1, 6 do
            p9._bullet_parts[v10][i] = p9[v10]:WaitForChild(i);
            local _ = i;
        end;
    end;
end;

function u1._Init(u11) -- Line: 62
    u11.ClientItem:GetDataChangedSignal("AmmoReserve"):Connect(function() -- Line: 63
        -- upvalues: u11 (copy)
        u11:_UpdateAmmoVisual();
    end);
    u11.ClientItem:GetDataChangedSignal("Ammo"):Connect(function() -- Line: 67
        -- upvalues: u11 (copy)
        u11:_UpdateAmmoVisual();
    end);
    u11:_Setup();
    task.spawn(u11._UpdateAmmoVisual, u11);
end;

return u1;