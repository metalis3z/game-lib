-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local WrapGroupObject = require(Players.LocalPlayer.PlayerScripts.Modules.WrapGroupObject);
local u1 = setmetatable({}, WrapGroupObject);
u1.__index = u1;

function u1.new(...) -- Line: 8
    -- upvalues: WrapGroupObject (copy), u1 (copy)
    local v2 = WrapGroupObject.new(...);
    local v3 = setmetatable(v2, u1);
    v3._hearts1 = {};
    v3._hearts2 = {};
    v3:_Init();

    return v3;
end;

function u1.Update(p4, p5) -- Line: 23
    local v6 = workspace:GetServerTimeNow() / 4;

    for _, v in pairs(p4._hearts1) do
        v.OffsetStudsV = v6 % v.StudsPerTileV;
        v.OffsetStudsU = v6 / 3 % v.StudsPerTileU;
    end;

    for _, v in pairs(p4._hearts2) do
        v.OffsetStudsV = v6 / 2.5 % v.StudsPerTileV;
        v.OffsetStudsU = v6 / 7 % v.StudsPerTileU;
    end;
end;

function u1._Setup(p7) -- Line: 41
    for _, v in pairs(p7.ExtraObjects) do
        if v.Name == "Hearts" then
            table.insert(p7._hearts1, v);
        elseif v.Name == "Hearts2" then
            table.insert(p7._hearts2, v);
        end;
    end;
end;

function u1._Init(p8) -- Line: 51
    p8:_Setup();
end;

return u1;