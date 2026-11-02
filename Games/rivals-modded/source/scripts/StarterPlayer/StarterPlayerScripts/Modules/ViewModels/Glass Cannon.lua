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
    v3._hide_this_mesh = v3.ItemModel:WaitForChild("Body"):WaitForChild("MeshPart");
    v3:_Init();

    return v3;
end;

function u1._UpdateAmmoVisual(p4) -- Line: 28
    if p4._destroyed then
        return;
    end;

    local v5 = p4.ClientItem:Get("Ammo") > 0;
    p4._hide_this_mesh.Material = v5 and Enum.Material.Glass or Enum.Material.SmoothPlastic;
    p4:_LocalTransparencyModifier(p4._hide_this_mesh, "AmmoVisual", v5 and 0 or 1);
end;

function u1._Init(u6) -- Line: 39
    u6.ClientItem:GetDataChangedSignal("Ammo"):Connect(function() -- Line: 40
        -- upvalues: u6 (copy)
        u6:_UpdateAmmoVisual();
    end);
    task.spawn(u6._UpdateAmmoVisual, u6);
end;

return u1;