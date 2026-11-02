-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local BaseSpear = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels.BaseSpear);
local u1 = setmetatable({}, BaseSpear);
u1.__index = u1;

function u1.new(...) -- Line: 8
    -- upvalues: BaseSpear (copy), u1 (copy)
    local v2 = BaseSpear.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1._Setup(p4) -- Line: 26
    for i = 1, (1 / 0) do
        local v5 = p4.ItemModel:WaitForChild("Body"):FindFirstChild("MeshPart" .. i);

        if not v5 then
            break;
        end;

        p4:_RegisterAmmoVisual(v5, 1);
        local _ = i;
    end;
end;

function u1._Init(p6) -- Line: 38
    p6:_Setup();
end;

return u1;