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
    v3._clouds1 = {};
    v3._clouds2 = {};
    v3._snow1 = {};
    v3._snow2 = {};
    v3:_Init();

    return v3;
end;

function u1.Update(p4, p5) -- Line: 25
    local ServerTimeNow = workspace:GetServerTimeNow();

    for _, v in pairs(p4._clouds1) do
        v.OffsetStudsU = v.StudsPerTileU - ServerTimeNow / 2 % v.StudsPerTileU;
        v.OffsetStudsV = v.StudsPerTileV - ServerTimeNow % v.StudsPerTileV;
    end;

    for _, v in pairs(p4._clouds2) do
        v.OffsetStudsU = ServerTimeNow / 2 % v.StudsPerTileU;
        v.OffsetStudsV = v.StudsPerTileV - ServerTimeNow % v.StudsPerTileV;
    end;

    for _, v in pairs(p4._snow1) do
        v.OffsetStudsU = v.StudsPerTileU - ServerTimeNow % v.StudsPerTileU;
        v.OffsetStudsV = v.StudsPerTileV - ServerTimeNow / 2 % v.StudsPerTileV;
    end;

    for _, v in pairs(p4._snow2) do
        v.OffsetStudsU = ServerTimeNow % v.StudsPerTileU;
        v.OffsetStudsV = v.StudsPerTileV - ServerTimeNow / 2 % v.StudsPerTileV;
    end;
end;

function u1._Setup(p6) -- Line: 53
    for _, v in pairs(p6.ExtraObjects) do
        if v.Name == "Clouds1" then
            table.insert(p6._clouds1, v);
        elseif v.Name == "Clouds2" then
            table.insert(p6._clouds2, v);
        elseif v.Name == "Snow1" then
            table.insert(p6._snow1, v);
        elseif v.Name == "Snow2" then
            table.insert(p6._snow2, v);
        end;
    end;
end;

function u1._Init(p7) -- Line: 67
    p7:_Setup();
end;

return u1;