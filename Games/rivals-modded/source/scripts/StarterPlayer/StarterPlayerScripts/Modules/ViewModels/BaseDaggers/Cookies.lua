-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local BaseDaggers = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels.BaseDaggers);
local u1 = setmetatable({}, BaseDaggers);
u1.__index = u1;

function u1.new(...) -- Line: 8
    -- upvalues: BaseDaggers (copy), u1 (copy)
    local v2 = BaseDaggers.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1._Init(p4) -- Line: 26
    for i, v in pairs({ "LeftBody", "RightBody" }) do
        local v5 = i;
        local v6 = v;

        for i2 = 1, 7 do
            p4:_RegisterAmmoVisual(p4.ItemModel:WaitForChild(v6):WaitForChild("MeshPart" .. i2), v5);
            local _ = i2;
        end;
    end;
end;

return u1;