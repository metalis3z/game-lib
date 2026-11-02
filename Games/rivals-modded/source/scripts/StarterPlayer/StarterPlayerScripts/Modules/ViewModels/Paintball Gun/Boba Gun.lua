-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local u1 = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels["Paintball Gun"]);
local Color3_fromRGB_ret = Color3.fromRGB(0, 0, 0);
local u2 = setmetatable({}, u1);
u2.__index = u2;

function u2.new(...) -- Line: 10
    -- upvalues: u1 (copy), u2 (copy)
    local v3 = u1.new(...);
    local v4 = setmetatable(v3, u2);
    v4._bobas_part = v4.ItemModel:WaitForChild("Body"):WaitForChild("Bobas");
    v4:_Init();

    return v4;
end;

function u2.GetPaintballColor(p5) -- Line: 24
    -- upvalues: Color3_fromRGB_ret (copy)
    return Color3_fromRGB_ret;
end;

function u2._UpdateAmmoVisual(p6) -- Line: 32
    if p6._destroyed then
        return;
    end;

    p6:_LocalTransparencyModifier(p6._bobas_part, "AmmoVisual", p6.ClientItem:Get("Ammo") <= 0 and 1 or 0);
end;

function u2._Init(u7) -- Line: 40
    u7.ClientItem:GetDataChangedSignal("Ammo"):Connect(function() -- Line: 41
        -- upvalues: u7 (copy)
        u7:_UpdateAmmoVisual();
    end);
    task.spawn(u7._UpdateAmmoVisual, u7);
end;

return u2;