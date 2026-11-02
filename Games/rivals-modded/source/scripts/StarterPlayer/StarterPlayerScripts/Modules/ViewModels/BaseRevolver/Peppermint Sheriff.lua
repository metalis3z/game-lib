-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local BaseRevolver = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels.BaseRevolver);
local u1 = setmetatable({}, BaseRevolver);
u1.__index = u1;

function u1.new(...) -- Line: 8
    -- upvalues: BaseRevolver (copy), u1 (copy)
    local v2 = BaseRevolver.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1._Setup(p4) -- Line: 26
    for _, v in pairs({ "ReloadBullets", "Bullets" }) do
        local v5 = p4.ItemModel:WaitForChild(v);
        local v6 = v;

        for i = 1, 6 do
            local v7 = v5:WaitForChild(i);
            p4:_RegisterAmmoVisual(v6, v7:WaitForChild("Red"));
            p4:_RegisterAmmoVisual(v6, v7:WaitForChild("White"));
            local _ = i;
        end;
    end;
end;

function u1._Init(p8) -- Line: 39
    p8:_Setup();
end;

return u1;